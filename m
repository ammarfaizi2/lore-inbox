Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWIOHlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWIOHlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 03:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWIOHlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 03:41:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48834 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751260AbWIOHlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 03:41:02 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Tejun Heo <htejun@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: Linux v2.6.18-rc5
In-reply-to: Your message of "Sun, 03 Sep 2006 15:10:44 +0900."
             <44FA71E4.70408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Sep 2006 17:40:19 +1000
Message-ID: <869.1158306019@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo (on Sun, 03 Sep 2006 15:10:44 +0900) wrote:
>Keith Owens wrote:
>>>> (2) I have seen the same intermittent bug on ICH7 SATA but
>>>>     PIIX_FLAG_IGNORE_PCS is only set for ich5 and i6300esb_sata.  It
>>>>     probably needs to be set for ich7 as well.
>>> No, ICH7 up to this point has been believed to have well-behaving PCS.
>>> If you report PCS problem, you'll be the first.
>
>Hmm... Can you try the attached patch and see what happens?  ATM, I'm on
>the road and can't test the patch, so it's only compile-tested.  This
>patch basically reverts some of the effects of the following commit and
>makes PCS update a little bit more aggressive iff necessary.
>
>ea35d29e2fa8b3d766a2ce8fbcce599dce8d2734
>[libata] ata_piix: Consolidate PCS register writing
>
>If this works for you ich7m, can you please test this on your formerly
>problematic ich5 with force_pcs=2 specified?  I initially thought that
>the ich5 problem was caused by exact PCS map change and thus added
>IGNORE_PCS as workaround but if the same problem occurs on ich7 and is
>fixed by the attached patch, it's due to conservative PCS update change
>and thus the original IGNORE_PCS fix on ich5 might not be necessary.
>just doesn't work quite as ata_piix developers expect.

Tested the patch on my ich7 (actually ich6m) laptop, on top of
2.6.18-rc7.  It failed after about 6 reboots.  Hand copied portion of
the boot log (no serial port on this laptop).

  ata_piix 0000:00:1f.2: MA{ [ P0 P2 IDE IDE ]
  ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 18
  ata: 0x170 IDE port busy
  ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
  scsi0: ata_piix
  ata1: failed to update PCS after 10 tries, old=0x0 cur=0x0 new=0x5

I also booted my problem ich5 system with this patch on 2.6.18-rc7 with
ata_piix.force_pcs=2.  It gets the 'force honoring PCS' message and so
far it has not failed.  95 reboots later, and every single one detected
the disk in 0 tries.  Go figure.

Remember that adding the kdb patch and turning on kdb debugging makes
this problem more likely to occur.  I can reproduce the problem on both
machines using 2.6.18-rc5 without kdb, so kdb is not the cause.

Also remember that the ich5 box is actually a 64 bit system.  I have
only ever seen this problem when running in i386 mode, in x86_64 mode
pcs always just works.

Maybe we are looking at a timing race or a memory mapping problem?

