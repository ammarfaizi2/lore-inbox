Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVCHDi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVCHDi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVCGUWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:22:24 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:13192 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261546AbVCGTnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:43:33 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [BUG: UML 2.6.11-rc4-bk-latest] sleeping function called from invalid context and segmentation fault
Date: Sat, 5 Mar 2005 19:07:41 +0100
User-Agent: KMail/1.7.2
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Jeff Dike <jdike@addtoit.com>,
       lkml <linux-kernel@vger.kernel.org>, Gerd Knorr <kraxel@bytesex.org>
References: <1108381733.10703.5.camel@imp.csi.cam.ac.uk> <1108740823.6713.28.camel@imp.csi.cam.ac.uk> <200502222141.54891.blaisorblade@yahoo.it>
In-Reply-To: <200502222141.54891.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200503051907.41787.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 February 2005 21:41, Blaisorblade wrote:
> On Friday 18 February 2005 16:33, Anton Altaparmakov wrote:
> > On Wed, 2005-02-16 at 19:35 +0100, Blaisorblade wrote:
> > > On Monday 14 February 2005 12:48, Anton Altaparmakov wrote:
> > > > Hi,
> > > >
> > > > I get a few Debug messages of the form from UML:
> > > >
> > > > Debug: sleeping function called from invalid context at
> > > > include/asm/arch/semaphore.h:107
> > > > in_atomic():0, irqs_disabled():1
> > > > Call Trace:
> > > > 087d77b0:  [<0809aaa5>] __might_sleep+0x135/0x180
> > > > 087d77d8:  [<084d377f>] mcount+0xf/0x20
> > > > 087d77e0:  [<0807cc13>] uml_console_write+0x33/0x80
> > > >
> > > > Most are coming via uml_console_write.
> > >
> > > The problem is that the UML tty drivers use a semaphore instead of a
> > > spinlock for the locking, which also causes some other problems.
> > >
> > > The attached patch should fix this, but I've not yet made sure it is
> > > not deadlock-prone (I didn't hit any during some very limited testing).
> > >
> > > So it's not yet ready for 2.6.11.
> >
> > Trying with the above patch in now only get two "sleeping function
> > called from invalid context" warnings during boot and none during
> > running.
>
> I'll look at whether I can produce them... if it's no problem, post their
> traces anyway, please.
I'm not able... I *did* enable CONFIG_DEBUG_SPINLOCK and 
CONFIG_DEBUG_SPINLOCK_SLEEP, but still I don't get them.

Maybe I have not an interesting enough test case (or kobject debugging is 
flooding the dmesg ring buffer, which is doing too).

> > However I get a lot of those errors:
> >
> > arch/um/drivers/line.c:262: spin_lock(arch/um/drivers/line.c:085b5900)
> > already locked by arch/um/drivers/line.c/262
>
> Ok, I'll be looking into them ASAP (which infortunately means not very
> soon, sorry).

> At a quick look, I see that line 262 is a "spin_lock" called by
> line_write_interrupt. I used spin_lock_irqsave everywhere else... but
> actually the interrupt must explicitly disable interrupts (I forgot) so,
> the simple answer seems to be using spin_lock_irqsave() would fix it.
I've done this in the patch I'm working on. I've various stuff on the press, 
however it should go in for 2.6.12-rc1, I hope.
> I 
> cannot make a patch now.
>
> > Also both before and after the patch I see a lot of messages like:
> >
> > kernel: line_write_room: tty2: no room left in buffer

> I've never seen them... 
Ok, correction, I've seen a lot of these...
> Anyway, I'm not sure this is a needed warning:
>
> in include/linux/tty_driver.h, the .write_room member must tell the
> available space... it's reasonable that the TTY layer will call a
> flush_buffers function. However, looking at stdio_console, I'm seeing that,
> in fact, there is no flush_chars function(!!). I'll provide one ASAP.
I've not yet removed the warning in the patch, just to be a bit too careful. 
I'm providing a flush_chars and flush_buffers method.

That said, there must be something else going on... it is easy to get the 
"repeated chars" problem (cat a file is enough), which I thought linked to 
this: it's when some data is printed and re-printed many times...

, and everybody started noticing it just around 2.6.9 / 2.6.10. I'm not sure, 
but maybe something else is causing the problem...

I'm going to work on the ring-buffer handling too, so that I make sure the 
unusual code paths are also correct (which code paths are usual and which are 
unusual could have changed).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


