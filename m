Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278381AbRJWXc2>; Tue, 23 Oct 2001 19:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278383AbRJWXcT>; Tue, 23 Oct 2001 19:32:19 -0400
Received: from [193.252.19.44] ([193.252.19.44]:12428 "EHLO
	mel-rti19.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S278381AbRJWXcI>; Tue, 23 Oct 2001 19:32:08 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pete Chown <Pete.Chown@skygate.co.uk>
Cc: Kristian Hogsberg <hogsberg@users.sourceforge.net>,
        <linux1394-devel@lists.sourceforge.net>,
        <linux-usb-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Spinlock problem in sbp2.c (and usb storage)
Date: Wed, 24 Oct 2001 01:32:15 +0200
Message-Id: <20011023233215.21183@smtp.wanadoo.fr>
In-Reply-To: <3BD5E92A.5050001@skygate.co.uk>
In-Reply-To: <3BD5E92A.5050001@skygate.co.uk>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I'm using the one from 2.4.12.  You are right -- sbp2.c doesn't contain 
>any references to io_request_lock until you apply my patch.
>
>It's possible that introducing a reference to io_request_lock is a 
>suboptimal solution to the problem which is occurring.  I don't know the 
>kernel well enough to judge.  I simply traced all the things that were 
>going on with spinlocks and found that io_request_lock was getting 
>released when it wasn't locked.  Then immediately afterwards it was 
>locked twice in 

(Please, don't cross post replies to all lists, I just wanted
to seek for advice on a broad audience, not start a cross posting
nightmare...)

After looking more closely at the kernel scsi code and other SCSI host
drivers, I noticed that the queuecommand() callback of a host controller
will be called with io_request_lock held. It seems that the done()
callback has to be called with that lock held (and interrupts disabled).
It also cause potential problems with driver's own locking (implemented,
for example, in preparation of the disappearance of io_request_lock), as the
driver's own locks and io_request_lock will probably deadlock together due
to ordering issues.

However, if the host has the use_new_eh_code in it's host template, the
scsi_done() routine will just mark a bottom half... while leads me to
another problem with... usb storage ;) It might concern sbp2 as well
depending on how we want to fix the above problem.

I noticed that usb storage does 2 things that might be problematic
with the scsi scheme:

  - It looks like it does a down() in it's queuecommand callback,
while it has a spinlock and interrupts disabled (io_request_locK).
That's a deadlock cause on SMP (at least the spinlock part).

  - usb storage does set use_new_eh_code to 1. That means calls to
scsi_done() will end up doing a simple mark_bh() (letting the scsi
layer do bh management).
However, it's my understanding that it does this from what can be
non-interrupt context. I _think_ that the new softirq implementation
can't guarantee that a bh will actually be scheduled immediately
when not marked from a real interrupt as the do_softirq() only happens
at the exit of the interrupt path (or did I miss something ?).
That means that since usb-storage calls scsi_done possibly from
a thread context, the actual bh processing might end up beeing delayed
until the next interrupt happens on the system.

Of course, I might have missed some important points hrere, the
SCSI layer isn't that easy to figure out...

Ben.


