Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUBUFfH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 00:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbUBUFfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 00:35:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:217 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261496AbUBUFfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 00:35:00 -0500
Date: Fri, 20 Feb 2004 21:31:57 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: macka@adixein.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
Message-Id: <20040220213157.7da96979.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As enumerated below:
| Calling initcall 0xc03f7e19 pcibios_init
| Calling initcall 0xc03f819c netdev_init
| Calling initcall 0xc03f1e7c chr_dev_init
| Calling initcall 0xc03e7084 i8259_init_sysfs
| Calling initcall 0xc03e7101 init_timer_sysfs
| Calling initcall 0xc03e90e2 sbf_init


I still don't see how USB enters into it, but please try the patch
below to see if I'm on the right track or not.
It looks like sbf_init() is finding an invalid ACPI RSDT length field.
This patch will telll us if that's the case or not.

--
~Randy


// Linux 2.6.3
// handle a garbage RSDT length field;

diffstat:=
 arch/i386/kernel/bootflag.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)


diff -Naurp ./arch/i386/kernel/bootflag.c~sbfinit ./arch/i386/kernel/bootflag.c
--- ./arch/i386/kernel/bootflag.c~sbfinit	2004-02-17 19:59:06.000000000 -0800
+++ ./arch/i386/kernel/bootflag.c	2004-02-20 21:26:51.000000000 -0800
@@ -193,7 +193,8 @@ static int __init sbf_init(void)
 	if(i>0xFFFE0)
 		return 0;
 		
-		
+	printk(KERN_ERR "SBF: remap rsdt to 0x%x, len=0x%x\n",
+			rsdtbase, rsdtlen);
 	rsdt = ioremap(rsdtbase, rsdtlen);
 	if(rsdt == 0)
 		return 0;
@@ -208,6 +209,11 @@ static int __init sbf_init(void)
 	{
 		rsdtlen = i;
 		iounmap(rsdt);
+		if (rsdtlen > 0x1000) {	/* arbitrary for now */
+			printk(KERN_ERR "SBF: invalid rsdtlen = 0x%x\n",
+					rsdtlen);
+			return 0;
+		}
 		rsdt = ioremap(rsdtbase, rsdtlen);
 		if(rsdt == 0)
 			return 0;
