Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262315AbREXVOk>; Thu, 24 May 2001 17:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbREXVOd>; Thu, 24 May 2001 17:14:33 -0400
Received: from munch-it.turbolinux.com ([38.170.88.129]:36083 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S262297AbREXVOC>;
	Thu, 24 May 2001 17:14:02 -0400
Date: Thu, 24 May 2001 14:13:51 -0700
From: Prasanna P Subash <psubash@turbolinux.com>
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon on 2.2.19 ?
Message-ID: <20010524141351.C3485@turbolinux.com>
In-Reply-To: <20010522182740.A3125@turbolinux.com> <E152toh-0004uo-00@the-village.bc.nu> <20010524123030.B3485@turbolinux.com> <20010524153653.A26439@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010524153653.A26439@sventech.com>; from Johannes Erdfelt on Thu, May 24, 2001 at 03:36:54PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without the patch below the boot up would hang right after it detected the ide devices.

After applying the patch it booted all the way but the keyboard would hang.

BTW I'm trying to port this patch back to the 2.2.18 TL-Kernel. Are there anymore changes I have to
look at ?

--- arch/i386/kernel/io_apic.c.old      Wed May 16 12:48:03 2001
+++ arch/i386/kernel/io_apic.c  Wed May 16 12:55:30 2001
@@ -204,6 +204,8 @@
 /*
  * We disable IO-APIC IRQs by setting their 'destination CPU mask' to
  * zero. Trick by Ramesh Nalluri.
+ * Not anymore. This causes problems on some IO-APIC's, notably AMD 760MP's
+ * So we do it a more 2.4 kind of way now which should be safer -jerdfelt
  */
 DO_ACTION( mask,    0, |= 0x00010000, io_apic_sync(entry->apic))/* mask = 1 */
 DO_ACTION( unmask,  0, &= 0xfffeffff, )                                /* mask = 0 */
@@ -646,8 +648,8 @@

                entry.delivery_mode = dest_LowestPrio;
                entry.dest_mode = 1;                    /* logical delivery */
-               entry.mask = 0;                         /* enable IRQ */
-               entry.dest.logical.logical_dest = 0xff; /* but no route */
+               entry.mask = 1;                         /* disable IRQ */
+               entry.dest.logical.logical_dest = 0xff;

                idx = find_irq_entry(apic,pin,mp_INT);
                if (idx == -1) {


On Thu, May 24, 2001 at 03:36:54PM -0400, Johannes Erdfelt wrote:
> On Thu, May 24, 2001, Prasanna P Subash <psubash@turbolinux.com> wrote:
> > I have a dual athlon on the 760MP chipset.
> > 2.2.20pre1 and 2 dont work. I got it to work partly after applying Johannes
> > Erdfel's 760MP patch in io_apic.c. Even after applying the patch, there
> > are messages like
> 
> 2.2.20pre1 and pre2 both have the patch I created already applied. If
> you had to apply them yourself then something is wrong.
> 
> > hdc: IRQ probe failed(0)
> > hdd: IRQ probe failed(0)
> > hde: IRQ probe failed(0)
> > 
> > hdc: lost interrupt
> > hdc: lost interrupt
> > 
> > and then the machine hangs randomly. I an guessing the io_apic does not
> > route the interrupts correctly.
> 
> That would be the problem.
> 
> Which patch of mine did you apply? Which motherboard are you doing your
> testing with?
> 
> JE

-- 
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | The only real advantage to punk music is
of a GNU generation   -o)  | that nobody can whistle it. 
Kernel 2.4.1          /\\  | 
on a i686            _\\_v | 
                           | 
------------------------------------------------------------------------
