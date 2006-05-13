Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWEMWdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWEMWdb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 18:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWEMWdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 18:33:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:50392 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932381AbWEMWda convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 18:33:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Date: Sun, 14 May 2006 00:32:55 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, pavel@suse.cz
References: <200605021200.37424.rjw@sisk.pl> <200605111520.30203.rjw@sisk.pl> <200605120945.52477.ncunningham@cyclades.com>
In-Reply-To: <200605120945.52477.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605140032.56407.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the slow response, I've had a lot of work to do recently.

On Friday 12 May 2006 01:45, Nigel Cunningham wrote:
> On Thursday 11 May 2006 23:20, Rafael J. Wysocki wrote:
> > On Thursday 11 May 2006 02:11, Nigel Cunningham wrote:
> > > On Thursday 11 May 2006 09:38, Andrew Morton wrote:
> > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > On Wednesday 10 May 2006 00:27, Andrew Morton wrote:
> > > > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > > > Now if the mapped pages that are not mapped by the
> > > > > > >  current task are considered, it turns out that they would change
> > > > > > > only if they were reclaimed by try_to_free_pages().  Thus if we
> > > > > > > take them out of reach of try_to_free_pages(), for example by
> > > > > > > (temporarily) moving them out of their respective LRU lists after
> > > > > > > creating the image, we will be able to include them in the image
> > > > > > > without copying.
> > > > > >
> > > > > > I'm a bit curious about how this is true.  There are all sorts of
> > > > > > way in which there could be activity against these pages -
> > > > > > interrupt-time asynchronous network Tx completion, async
> > > > > > interrupt-time direct-io completion, tasklets, schedule_work(),
> > > > > > etc, etc.
> > > > >
> > > > > AFAIK, many of these things are waited for uninterruptibly, and
> > > > > uninterruptible tasks cannot be frozen.
> > > >
> > > > There can be situations where we won't be waiting on this IO at all.
> > > > Network zero-copy transmit, for example.
> > > >
> > > > Or maybe there's some async writeback going on against pagecache -
> > > > we'll end up looking at the page's LRU state within interrupt context
> > > > at IO completion.  (A sync would prevent this from happening).
> > >
> > > I believe more than a sync is needed in at least some cases. I've seen
> > > XFS continue to submit I/O (presumably on the sb or such like) after
> > > everything else has been frozen and data has been synced. Freezing bdevs
> > > addressed this.

Do you know any other examples?

> > > > One possibly problematic scenario is where task A is doing a direct-IO
> > > > read and task B truncates the same file - here, the page will be
> > > > actually removed from the LRU and freed in interrupt context.  The
> > > > direct-IO read process will be waiting on the IO in D state though.  It
> > > > it was a synchronous read - if it was an AIO read then it won't be
> > > > waiting on the IO.  Something else might save us here, but it's
> > > > fragile.

In this particular case we are saved by the fact that the snapshotted kernel
memory reflects the state from before the operation, so the kernel will
perform it again after resume.  However if the suspend failed we'd add the
freed page to the LRU which would be a mistake (I think it might be prevented
by checking the page's refcount before putting in back on the LRU).

> > > Bdev freezing helps here too, right?
> >
> > Well, I'm not sure.  How exactly?
> 
> I believe it will ensure that both operations will be completed and the waiter 
> woken.

We're talking about the situation in which no one waits on the I/O that's
completed asynchronously in interrupt context.

I assume that the freezing of bdevs makes this impossible with respect to
filesystems, but there are other types of I/O, like the networking, which are
independent of that.  Also, if someone uses a block device or a partition
directly, will the freezing of bdevs save us?

> > > > >  Theoretically we may have a problem if there's an
> > > > > interruptible task that waits for the completion of an operation that
> > > > > gets finished after snapshotting the system.  However that would have
> > > > > to survive the syncing of filesystems, freezing of kernel threads,
> > > > > freeing of memory as well as suspending and resuming all devices. 
> > > > > [In which case it would be starving to death. :-)]
> > >
> > > (For Rafael/Pavel): The swsusp version of the refrigerator signals these
> > > processes to enter the freezer too, just in case the uninterruptible task
> > > does continue, right?
> >
> > Uninterruptible tasks are not freezable with the swsusp's freezer at all.
> > The other tasks are signaled to enter the refrigerator - first user space,
> > then we sync filesystems and finally we freeze kernel threads.
> 
> Oooh. It would probably be good if you signalled them to enter the freezer, 
> just in case, and had the freezer code handle a process entering the path 
> when we no longer want to freeze.

Could you please explain why you think so?  We just fail the suspend if there
still are any uninterruptible tasks after the timeout, so I don't see the
reason why these tasks should enter the refrigerator.

Greetings,
Rafael

