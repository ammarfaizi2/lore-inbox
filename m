Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWH3CCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWH3CCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 22:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWH3CCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 22:02:38 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:51490 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751312AbWH3CCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 22:02:36 -0400
X-BigFish: V
Message-ID: <44F4F1B9.9060605@am.sony.com>
Date: Tue, 29 Aug 2006 19:02:33 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linas@austin.ibm.com
Subject: [PATCH] mem driver: fix conditional on isa i/o support
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Aug 2006 02:02:33.0623 (UTC) FILETIME=[5B90D270:01C6CBD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change corrects the logic on the preprocessor conditionals
that include support for ISA port i/o (/dev/ioports) into
the mem character driver.

This fixes the following error when building for powerpc
platforms with CONFIG_PCI=n.

  drivers/built-in.o: undefined reference to `pci_io_base'


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

I've only tested this on powerpc (cell) build.  Testing
on other arch's would be welcome.

-Geoff

Index: cell--common--4/drivers/char/mem.c
===================================================================
--- cell--common--4.orig/drivers/char/mem.c
+++ cell--common--4/drivers/char/mem.c
@@ -522,7 +522,7 @@
  	return virtr + wrote;
 }
 
-#if defined(CONFIG_ISA) || !defined(__mc68000__)
+#if (defined(CONFIG_ISA) || defined(CONFIG_PCI)) && !defined(__mc68000__)
 static ssize_t read_port(struct file * file, char __user * buf,
 			 size_t count, loff_t *ppos)
 {
@@ -799,7 +799,7 @@
 	.splice_write	= splice_write_null,
 };
 
-#if defined(CONFIG_ISA) || !defined(__mc68000__)
+#if (defined(CONFIG_ISA) || defined(CONFIG_PCI)) && !defined(__mc68000__)
 static const struct file_operations port_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_port,
@@ -869,7 +869,7 @@
 		case 3:
 			filp->f_op = &null_fops;
 			break;
-#if defined(CONFIG_ISA) || !defined(__mc68000__)
+#if (defined(CONFIG_ISA) || defined(CONFIG_PCI)) && !defined(__mc68000__)
 		case 4:
 			filp->f_op = &port_fops;
 			break;
@@ -916,7 +916,7 @@
 	{1, "mem",     S_IRUSR | S_IWUSR | S_IRGRP, &mem_fops},
 	{2, "kmem",    S_IRUSR | S_IWUSR | S_IRGRP, &kmem_fops},
 	{3, "null",    S_IRUGO | S_IWUGO,           &null_fops},
-#if defined(CONFIG_ISA) || !defined(__mc68000__)
+#if (defined(CONFIG_ISA) || defined(CONFIG_PCI)) && !defined(__mc68000__)
 	{4, "port",    S_IRUSR | S_IWUSR | S_IRGRP, &port_fops},
 #endif
 	{5, "zero",    S_IRUGO | S_IWUGO,           &zero_fops},


