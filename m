Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbUBZADO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUBZADO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:03:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:32163 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261522AbUBZADG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:03:06 -0500
Date: Wed, 25 Feb 2004 16:03:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Elliot Mackenzie" <macka@adixein.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
Message-Id: <20040225160309.10d15433.rddunlap@osdl.org>
In-Reply-To: <001201c3f93b$bbd94170$4301a8c0@waverunner>
References: <20040220213157.7da96979.rddunlap@osdl.org>
	<001201c3f93b$bbd94170$4301a8c0@waverunner>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Feb 2004 22:02:22 +1000 Elliot Mackenzie wrote:

| Randy:
| 
| This issue just got a lot weirder but I have some more information.  
| 
| This is the weird part:
| I applied the patch you suggested, and the system stopped panicking at
| that point.  Instead, it just hung for about 10 minutes, eventually
| kicking off again and finishing bootup.  To be sure, I then removed the
| code and recompiled (clean), and now the original code started doing
| that too (without your patch).  To my knowledge I changed nothing (not
| even in BIOS), but I rebuilt the kernel again from the raw 2.6.3 source
| to be sure - same result.

During the 10 minutes or so, does the keyboard work?
Can you do Alt-SysRq-T, or just Alt-SysRq-P multiple times to see
what code is executing?

| The interesting part (more information):
| If we bypass the bootflag.c code (simply by putting "return 0;" as the
| first line), the system will boot normally.  On shutdown we seem to be
| getting a system jumping to maintenance mode, but I am not sure if its
| related.  It appears you are right in assuming that the problem is
| related to the bios sbf rather than the usb.  Doug pointed out to me
| that looking through the stack trace, sbf_init is giving an rsdt_length
| of something in the order of 1GB, and somehow the checks are not picking
| it up.

There wasn't any checking for an invalid RSDT length at all.
There should be IMO.

| Since it is now relevant, the BIOS is flashed to the most recent stable
| BIOS for the ASUS P4SGX-MX motherboard (1005).
| 
| This is the tricky part:
| When we bypass the bootflag code, and boot the "working" kernel, I am
| able to capture a serial transcript.  However, I have been unsuccessful
| in establishing a serial console for the broken 2.6.3 kernel to date.
| It's possible I have done something strange while building one of the
| kernels, but I am just trying to verify that now.  Are there
| alternatives?

The "magic sysrq" keys...

| Currently the text on screen comes up way to quickly for me to capture,
| and since I don't have a working serial console for the broken kernel
| yet, I am not able to capture a transcript.  Previously I could just
| type to you what I saw, but the kernel is now booting to the same point,
| hanging 10 minutes then continuing.

Maybe just add more printk()s to bootflag.c to see what code it is
executing...?

--
~Randy

Oh, your other email didn't help me any.


| Kind regards,
| Elliot.
| 
| -----Original Message-----
| From: Randy.Dunlap [mailto:rddunlap@osdl.org] 
| Sent: Saturday, 21 February 2004 3:32 PM
| To: macka@adixein.com
| Cc: lkml
| Subject: RE: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
| 
| 
| As enumerated below:
| | Calling initcall 0xc03f7e19 pcibios_init
| | Calling initcall 0xc03f819c netdev_init
| | Calling initcall 0xc03f1e7c chr_dev_init
| | Calling initcall 0xc03e7084 i8259_init_sysfs
| | Calling initcall 0xc03e7101 init_timer_sysfs
| | Calling initcall 0xc03e90e2 sbf_init
| 
| 
| I still don't see how USB enters into it, but please try the patch
| below to see if I'm on the right track or not.
| It looks like sbf_init() is finding an invalid ACPI RSDT length field.
| This patch will telll us if that's the case or not.
