Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUDGSvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUDGSvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:51:00 -0400
Received: from main.gmane.org ([80.91.224.249]:54740 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264137AbUDGSuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:50:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: linchuan@cse.ogi.edu (Chuan-kai Lin)
Subject: Re: PROBLEM: ide-cs kernel panic on ThinkPad X30
Date: Wed, 7 Apr 2004 18:10:50 +0000 (UTC)
Message-ID: <c51g78$st3$1@sea.gmane.org>
References: <20030911151915.GA816@rho>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: rho.cse.ogi.edu
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuan-kai Lin <b86506063@ntu.edu.tw> wrote:
> Aug 31 19:14:17 rho kernel: hde: Transcend, CFA DISK drive
> Aug 31 19:14:17 rho kernel: PM: Adding info for No Bus:ide2
> Aug 31 19:14:17 rho kernel: hdf: probing with STATUS(0x50)
>  instead of ALTSTATUS(0x0a)
> Aug 31 19:14:17 rho kernel: hdf: H, ATA DISK drive
> Aug 31 19:14:17 rho kernel: ide2 at 0x100-0x107,0x10e on irq 3
> Aug 31 19:14:17 rho kernel: PM: Adding info for ide:2.0
> Aug 31 19:14:17 rho kernel: PM: Adding info for ide:2.1
> Aug 31 19:14:17 rho kernel: hde: max request size: 128KiB
> Aug 31 19:14:17 rho kernel: hde: 1006992 sectors (515 MB) w/0KiB Cache,
>  CHS=999/16/63
> Aug 31 19:14:17 rho kernel:  /dev/ide/host2/bus0/target0/lun0: p1
> Aug 31 19:14:17 rho kernel: hdf: max request size: 128KiB
> Aug 31 19:14:17 rho kernel: hdf: 0 sectors (0 MB) w/9216KiB Cache,
>  CHS=18432/0/0
> Aug 31 19:14:17 rho kernel: hdf: INVALID GEOMETRY: 0 PHYSICAL HEADS?
> Aug 31 19:14:17 rho kernel: ide-default: hdf: Failed to register the
>  driver with ide.c
> Aug 31 19:14:17 rho kernel: Kernel panic: ide: default attach failed
> 
> And the machine promptly froze.  The problem, obviously, is that hdf
> does not exist at all, so naturally the IDE driver had problem
> extracting any reasonable information concerned about it.  I have tried
> using both hdf=noprobe or hdf=none at the LILO prompt, but neither seems
> to have any effect on this problem.

I finally managed to track down the problem.  In 2.6.5, ide-probe.c
line 291 there is this piece of code:

    if ((a ^ s) & ~INDEX_STAT) {
        printk(KERN_INFO "%s: probing with STATUS(0x%02x) instead of "
                "ALTSTATUS(0x%02x)\n", drive->name, s, a);
        /* ancient Seagate drives, broken interfaces */
       hd_status = IDE_STATUS_REG;

This alternative probing mechanism caused the kernel to conclude that
the device hdf does exist, and disabling this ancient Seagate drive
probing functionality fixed my problem (but obviously breaks the
probing of the said ancient drives).

What would be a good way to resolve this problem?

-- 
Chuan-kai Lin
http://www.cse.ogi.edu/~linchuan/

