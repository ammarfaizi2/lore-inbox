Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263825AbVBEKup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263825AbVBEKup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 05:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbVBEKum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 05:50:42 -0500
Received: from zork.zork.net ([64.81.246.102]:20967 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266619AbVBEKs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:48:56 -0500
From: Sean Neakums <sneakums@zork.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc3-mm1
References: <20050204103350.241a907a.akpm@osdl.org>
	<6ud5vgezqx.fsf@zork.zork.net> <1107561472.2363.125.camel@gaston>
	<6u7jlng9b0.fsf@zork.zork.net> <1107562609.2363.134.camel@gaston>
	<58cb370e05020416546e0d6b0e@mail.gmail.com>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Benjamin
	Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton
	<akpm@osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
Date: Sat, 05 Feb 2005 10:48:38 +0000
In-Reply-To: <58cb370e05020416546e0d6b0e@mail.gmail.com> (Bartlomiej
	Zolnierkiewicz's message of "Sat, 5 Feb 2005 01:54:56 +0100")
Message-ID: <6u3bwbffjt.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> writes:

> On Sat, 05 Feb 2005 11:16:49 +1100, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> 
>> > I tried it two or three times, same result each time.  I'll give it a
>> > lash with USB disabled.
>> 
>> Also, can you try editing arch/ppc/syslib/open_pic.c, in function
>> openpic_resume(), comment out the call to openpic_reset() and let me
>> know if that helps...
>
> Well, maybe I'm to blame this time...
>
> I've introduced bug in ATAPI Power Management handling,
> idedisk_pm_idle shouldn't be done for ATAPI devices.
>
> Sorry for that, fix attached.

With this patch alone and with USB configured out, suspend/resume works.

I said earlier that USB didn't seem to be giving problems.  When I was
trying out the openpic_reset()-removal, I got an Oops on suspend,
reproduced below.  I then received Bartlomiej's patch, which I applied
to a clean 2.6.11-rc3-mm1 tree.  Same USB Oops, no suspend.  Then I
disabled USB, and suspend/resume worked.  I can still try the
openpic_reset()-removal in a clean tree with USB disabled if you wish.


Oops: kernel access of bad area, sig: 11 [#1]
NIP: C01FFD2C LR: C01D7A6C SP: EFBB1D80 REGS: efbb1cd0 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000C54, DSISR: 40000000
TASK = efb01830[1067] 'pmud' THREAD: efbb0000
Last syscall: 54 
GPR00: C01D7A6C EFBB1D80 EFB01830 C114ACC0 00000003 00000000 FFFFFFB9 C0480000 
GPR08: 00000000 00000000 C114ACD8 C03F3B2C 22044484 1001E4DC 10010000 10000000 
GPR16: 10000000 C03F0000 C042A6F0 C03F0000 C042A6E8 C0430000 00000003 00100100 
GPR24: 00200200 C042A6E0 C0430000 C0430000 00000003 C114ACC0 C114ACD8 C114AD68 
NIP [c01ffd2c] hid_suspend+0x1c/0x40
LR [c01d7a6c] usb_generic_suspend+0x88/0x98
Call trace:
 [c01d7a6c] usb_generic_suspend+0x88/0x98
 [c018bb48] suspend_device+0x54/0x5c
 [c018bc24] device_suspend+0xd4/0x2ac
 [c04687c8] 0xc04687c8
 [c0468cec] 0xc0468cec
 [c0469710] 0xc0469710
 [c00772ac] do_ioctl+0x68/0x8c
 [c00774fc] vfs_ioctl+0x88/0x2a8
 [c0077760] sys_ioctl+0x44/0x78
 [c0004290] ret_from_syscall+0x0/0x4c


