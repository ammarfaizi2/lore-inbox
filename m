Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266907AbTBQHId>; Mon, 17 Feb 2003 02:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266908AbTBQHId>; Mon, 17 Feb 2003 02:08:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:32331 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266907AbTBQHIb>; Mon, 17 Feb 2003 02:08:31 -0500
To: Corey Minyard <minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>,
       Werner Almesberger <wa@almesberger.net>,
       Zwane Mwaikambo <zwane@holomorphy.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org>
	<3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org>
	<3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net>
	<3E4CFB11.1080209@mvista.com> <20030214151001.F2092@almesberger.net>
	<3E4D3419.1070207@mvista.com>
	<Pine.LNX.4.50.0302141420220.3518-100000@montezuma.mastecende.com>
	<20030214164436.H2092@almesberger.net> <3E4D4ADF.3070109@mvista.com>
	<m17kc26pxs.fsf@frodo.biederman.org> <3E4FBAD0.4040808@acm.org>
	<m1y94f6gnp.fsf@frodo.biederman.org> <3E506460.3010400@acm.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Feb 2003 00:18:21 -0700
In-Reply-To: <3E506460.3010400@acm.org>
Message-ID: <m1wujz2x4y.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> writes:

> An orderly shutdown will:
> 
> ~    * claim locks and block as necessary
> ~    * free memory associated with the device
> ~    * flush device queues
> ~    * Fully shut down the device

Most of this is in required before a module is removed, but quite
a bit of this does not belong in the shutdown method.  As user space,
and higher level code can down interfaces and remount hardware read
only.  

So by the time it gets to the device driver for the final shutdown you
get:

- Locks are irrelevant because there are no other users (by
  definition).

- Queues are irrelevant as the device driver is not responsible for
  those.  Someone needs to call sync, down the network interface,
  or the equivalent to push the last of the data through the device.

- Freeing memory is only needed if the kernel will persist, on a
  reboot or a halt that is not the case.
 
> An orderly shutdown should make sure the system remains sane after it
> finishes and the data on the device is correct.

But there are multiple layers to how that should be accomplished.
 
> A panic shutdown should only disable DMA with as little code as possible
> without locking, blocking, etc.  No effort should be taken to keep the
> system sane (beyond clobbering memory), since it's not sane to begin with :-).
> 
> You may want to say that this shutdown will be the panic shutdown and not be
> an orderly shutdown.  That's fine, although I would suggest a name change.
> I couldn't find any documentation on what the shutdown call was supposed to do.

Currently the shutdown method is supposed to do the minimal amount needed to
place a device in a quiescent state before a reboot or a halt.  And it
should optionally place the device in a state from which it can be
reinitialized by the driver later.

Essentially that is turning off DMA.  And setting a few registers 
so that the device can be restarted later.  It explicitly does
not included freeing resources.   

There may be some blocking waiting for the device, but I do not see
blocking waiting for other users of the device as correct.  By
definition all other users are gone, so any locks in that code protect
nothing.

So I do not see how that differs, in any significant way from what you
figure the panic handler should do.  Though I do admit I have
questions if the code would be reliable in a panic situation.

> |Because the kernel to handle the panic only initializes those devices
> |it can reliably initialize from any state.   And it is living in an
> |area of memory the old kernel did not allow DMA to.
> |

> Are you sure this will be ok?  I'm not sure either way.  How much memory does
> a kernel take to boot up and operate for this?  If it's a few meg, it's probably
> 
> livable.
> If it's a lot of memory, it's probably not going to be acceptable.

Somewhere from 2-8Meg I would guess is sufficient on x86.  It
primarily depends on the size of the dump kernel, and the user space.
8Meg used to be enough to run X. 

> Plus, perhaps you would want to protect the output of the kernel dump somehow.
> That's going to be a lot more memory than you can reserve.  And if you can shut
> off DMA, none of this should matter anyway.

Protect it?  It does not need to be generated until after the new
kernel takes over.  So the dump never needs to live in ram.

As for turning off DMA on a panic.  It has already been shown that DMA
can not be reliably turned off in device independent way.  Something
is definitely broken, and the odds are it is a driver.  If there is
special panic code in a driver it likely to be the least tested code
path, if it exists at all.  And with so many random devices out there
I do not see how it can be shown that they all have correct panic code.

I do not see shutting down all DMA as feasible, which is why I am
attempting to avoid the issue.   With a reserved area of memory,
the only thing I am left to worry about is the unlikely case some
device doing DMA to an incorrect location that just happens to be
where the recovery kernel sits. 

> The rest of what you said, about the panic kernel only taking the core dump and
> then rebooting, makes sense to me.

Good.

Eric

