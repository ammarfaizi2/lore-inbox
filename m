Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932625AbWCXBS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625AbWCXBS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWCXBSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:18:25 -0500
Received: from smtpauth07.mail.atl.earthlink.net ([209.86.89.67]:51940 "EHLO
	smtpauth07.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S932624AbWCXBSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:18:24 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Wed, 22 Mar 2006 12:58:36 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417DFC@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Thu, 23 Mar 2006 20:17:48 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FMaw0-00011t-5p@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478a122c03f3aaf2a2016d0c5663a8e369542d34dc3d1ab7802350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So perhaps I should bisect in _SST and put in the debug lines there?
>> Here's another idea, which is a terrible hack.  But there are lots of
>> lines in the DSDT like
>>    If (LOr (SPS, WNTF))
>> which I imagine is saying "If something or if WinNT".  So,
>> what if Linux
>> pretends to be WinNT (or W98F -- which is another common
>> test), at least
>> for the 600x?  Maybe those code paths are known to work.
>> 

> Yes, you can try that.

I tried the patch below.  

It went to sleep fine.  It wouldn't wake up with the Fn key or
closing/opening the lid (both methods wake up Linux sleep).  But the
power switch did the trick, and it made it through most of the wakeup.
But the screen came back toofull of garbage and not taking keyboard
input (at least not to X), and it might have been stuck in PCI0._INI.
That was the last Execute Method on the serial console, and after that
line it was just printing dots one at a time: .......

So I had to power it down (by holding the power switch until it turned
off) and could never try the second sleep.

-Sanjoy


summary:     Pretend to be Windows 98 in DSDT.

diff -r bf1b330b9a7f -r 8109ef6f6d19 dsdt/600x.dsl
--- a/dsdt/600x.dsl	Tue Mar 21 12:11:19 2006 -0500
+++ b/dsdt/600x.dsl	Thu Mar 23 19:49:10 2006 -0500
@@ -1090,7 +1090,7 @@ DefinitionBlock ("DSDT.aml", "DSDT", 1, 
             })
             Method (_INI, 0, NotSerialized)
             {
-                If (LEqual (SCMP (\_OS, "Microsoft Windows"), Zero))
+                If (One) /* LEqual (SCMP (\_OS, "Microsoft Windows"), Zero)) */
                 {
                     Store (One, W98F)
                 }




