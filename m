Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268210AbUIKRnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268210AbUIKRnM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268234AbUIKRnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:43:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:7401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268210AbUIKRmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:42:19 -0400
Date: Sat, 11 Sep 2004 10:41:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
In-Reply-To: <9e473391040911101331a584ec@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0409111016270.2341@ppc970.osdl.org>
References: <9e47339104090919015b5b5a4d@mail.gmail.com> 
 <9e4733910409100937126dc0e7@mail.gmail.com>  <1094832031.17883.1.camel@localhost.localdomain>
  <9e47339104091010221f03ec06@mail.gmail.com>  <1094835846.17932.11.camel@localhost.localdomain>
  <9e47339104091011402e8341d0@mail.gmail.com>  <Pine.LNX.4.58.0409102254250.13921@skynet>
  <20040911132727.A1783@infradead.org>  <9e47339104091109111c46db54@mail.gmail.com>
  <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org> <9e473391040911101331a584ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Sep 2004, Jon Smirl wrote:
>
> Coprocessor 3D mode is deeply pipelined
> 2D mode is immediate

Now it is _you_ who confuse "3D mode" and "2D mode".

THERE IS NO SUCH THING.

There is only hardware.

> How can you build a system that process swaps between these two modes?

You don't switch between the two non-existent modes. You serialize on 
hardware accesses.

If the 2D graphics driver uses the accelerator, it takes the accelerator 
lock.

If the 2D graphics just uses the framebufferm it takes the framebuffer 
lock.

If there are hardware dependencies on the accelerator and the framebuffer, 
then the two lock pointers point to the same lock.

The locks themselves need to have a release mechanism, of course, the same 
way we already have "stateful" locks for X interactions where something 
needs to be done when a lock is given to another person. So the locks 
can't just be regular spinlocks or semaphores, they need to be slightly 
more complicated things where each user has an "ID" cookie.

This way:
 - the hardware-independent part really _is_ hardware-independent. It 
   literally hass _no_ clue what the different users do.
 - the hardware-independent part makes no policy at all. It just has a set 
   of lock pointers, and a generic locking mechanism which basically looks 
   something like

	/*
	 * Generic "release lock"
	 */
	typedef struct release_lock_struct {
		struct semaphore sem;
		void *cookie;
		void (*releasefn)(release_lock_t *, void *);
	} release_lock_t;

	/*
	 * get a lock. Return 1 if the resource had been owned by
	 * somebody else in the meantime. We may need to re-initialize
	 * hw state if so..
	 *
	 * Otherwise, just return 0, to let the caller know that it
	 * didn't have anybody else screw with its state in between.
	 *
	 * (The caller could just keep this information by tracking
	 * it's "releasefn()" calls, of course, since if another
	 * locker came in, we would have asked it to release the
	 * info. The return value is just a convenient interface).
	 */
	int get_lock(release_lock_t *lock, void *cookie,
		     void (*releasefn)(release_lock_t *, void *))
	{
		down(lock->sem);

		/* Same old owner? Coolio.. */
		if (lock->cookie == cookie)
			return 0;

		/* Tell the previous lock owner to clean up */
		lock->releasefn(lock, lock->cookie);

		/* We now have a new owner */
		lock->releasefn = releasefn;
		lock->cookie = cookie;
		return 1;
	}
		

	/*
	 * Release the lock
	 */
	void put_lock(release_lock_t *lock, void *cookie)
	{
		/*
		 * People screw up all the time. Only let the owner
		 * release the lock. Complain loudly when somebody gets
		 * mixed up.
		 */
		BUG_ON(lock->cookie != cookie);
		up(lock->sem);
	}

Notice? There's _zero_ hardware knowledge here. This can work for 
video-cards, but it can work for anything else too.

And yes, maybe you need more complicated locks than the above, but hey,
they probably don't need to be _much_ more complicated.

So how would you use the above? Just combine it with the "graphics 
subsystem" specific list of locks, which you attach to each device some 
way (so that each driver that _shares_ the hardware device can find it):

	struct gfx_lock_ptr {
		release_lock_t *accelerator;
		release_lock_t *framebuffer;
		release_lock_t *memorymanager;
		..
	};

	struct gfx_data {
		struct gfx_lock_ptr ptr;
		release_lock_t locks[MAXLOCKS];
	};

and then the code just does

 - hw-independent gfx code initializes the locks to defaults:

	gfx_data->ptr.accelerator = gfx_data->locks + 0;
	gfx_data->ptr.framebuffer = gfx_data->locks + 1;
	gfx_data->ptr.memorymanager = gfx_data->locks + 2;
	...
	dev->gfx_data = gfx_data;

 - the _low_level_ drivers at their initialization will know what hardware 
   structures are shared, so they do (when _they_ init, and notice how 
   this doesn't actually matter in which order they loaded - they can both
   do this thing without knowing about each other):

	/* This chip can't access the frame buffer when the accelerator is busy */
	gfx_data->ptr.accelerator = gfx_data->ptr.framebuffer;

 - then the low-level drivers just do

	/* execute command */
	if (get_lock(gfx_data->ptr.accelerator, mydev, myrelease)) {
		/*
		 * Somebody else used the accelerator earlier, need to
		 * re-load my cached pointers:
		 */
		mydev->offset = readl(command_buffer + CMD_OFFSET);
	}
	WRITE_RING(mydev, cmd);
	WRITE_RING(mydev, arg);
	put_lock(gfx_data->ptr.accelerator, mydev);

 - and then the "myrelease" function just does whatever writer-side 
   synchronization needed (wait for commands to flush, for example).

Do I know what the hell I'm talking abut? No. You should see the above as 
a very quick "this _kind_ of approach should work", and work out the 
details. But I really think something like the above would be quite 
doable. No?

And yes, it requires changes to _both_ DRM and to fbcon, but the changes
are hopefully fairly independent, and it doesn't really require that they
share any fundamental code - it only requires a fbcon driver and a DRM
driver for the same hardware to agree on an use some _very_ simple
serialization.

			Linus
