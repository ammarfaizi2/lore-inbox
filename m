Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUENXga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUENXga (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264529AbUENX2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:28:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:17858 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263015AbUENX0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:26:45 -0400
Date: Fri, 14 May 2004 16:29:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, Henrik.Seidel@gmx.de
Subject: Re: sysfs warning + spinlock BUG in typhoon radio
Message-Id: <20040514162919.143c0d6c.akpm@osdl.org>
In-Reply-To: <20040514113804.1964105f.rddunlap@osdl.org>
References: <20040514113804.1964105f.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Calling initcall 0xc10bc558: typhoon_init+0x0/0x12a()
> Typhoon Radio Card driver v0.1
> CLASS: registering class device: ID = 'radio2'
> class_hotplug - name = radio2
> videodev: "Typhoon Radio" has no release callback. Please fix your driver for proper sysfs support, see http://lwn.net/Articles/36850/
> radio-typhoon: port 0x316.
> radio-typhoon: mute frequency is 87500 kHz.
> eip: c0b946cc
> ------------[ cut here ]------------
> kernel BUG at include/asm/spinlock.h:120!

Does this fix?


diff -puN drivers/media/radio/radio-typhoon.c~typhoon-locking-fix drivers/media/radio/radio-typhoon.c
--- 25/drivers/media/radio/radio-typhoon.c~typhoon-locking-fix	Fri May 14 16:26:46 2004
+++ 25-akpm/drivers/media/radio/radio-typhoon.c	Fri May 14 16:28:29 2004
@@ -326,7 +326,6 @@ static int __init typhoon_init(void)
 		return -EINVAL;
 	}
 	typhoon_unit.iobase = io;
-	init_MUTEX(&typhoon_unit.lock);
 
 	if (mutefreq < 87000 || mutefreq > 108500) {
 		printk(KERN_ERR "radio-typhoon: You must set a frequency (in kHz) used when muting the card,\n");
@@ -337,6 +336,7 @@ static int __init typhoon_init(void)
 #endif /* MODULE */
 
 	printk(KERN_INFO BANNER);
+	init_MUTEX(&typhoon_unit.lock);
 	io = typhoon_unit.iobase;
 	if (!request_region(io, 8, "typhoon")) {
 		printk(KERN_ERR "radio-typhoon: port 0x%x already in use\n",

_

