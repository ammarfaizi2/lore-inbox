Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbTEBU3x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTEBU3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:29:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:15500 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id S263021AbTEBU3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:29:46 -0400
Date: Fri, 2 May 2003 13:42:07 -0700
From: Bob Miller <rem@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH 2.5.68] Convert elan-104nc to remove check_region().
Message-ID: <20030502204207.GB25713@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moved the request_region() call to replace check_region() and adds
release_region()'s in the error paths that occure before the old
call to request_region().  NOTE: This patch just updates comments.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -Nru a/drivers/mtd/maps/elan-104nc.c b/drivers/mtd/maps/elan-104nc.c
--- a/drivers/mtd/maps/elan-104nc.c	Fri May  2 09:52:22 2003
+++ b/drivers/mtd/maps/elan-104nc.c	Fri May  2 09:52:22 2003
@@ -30,8 +30,8 @@
 The single flash device is divided into 3 partition which appear as separate
 MTD devices.
 
-Linux thinks that the I/O port is used by the PIC and hence check_region() will
-always fail.  So we don't do it.  I just hope it doesn't break anything.
+Linux thinks that the I/O port is used by the PIC and hence request_region()
+will always fail.  So we don't do it.  I just hope it doesn't break anything.
 */
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -227,14 +227,14 @@
 	}
 
 	iounmap((void *)iomapadr);
-	release_region(PAGE_IO,PAGE_IO_SIZE);
+	/* release_region(PAGE_IO,PAGE_IO_SIZE); */
 }
 
 int __init init_elan_104nc(void)
 {
 	/* Urg! We use I/O port 0x22 without request_region()ing it */
 	/*
-	if (check_region(PAGE_IO,PAGE_IO_SIZE) != 0) {
+	if (!request_region(PAGE_IO,PAGE_IO_SIZE, "ELAN-104NC flash")) {
 		printk( KERN_ERR"%s: IO ports 0x%x-0x%x in use\n",
 			elan_104nc_map.name,
 			PAGE_IO, PAGE_IO+PAGE_IO_SIZE-1 );
@@ -245,12 +245,11 @@
 	if (!iomapadr) {
 		printk( KERN_ERR"%s: failed to ioremap memory region\n",
 			elan_104nc_map.name );
+		/*
+		release_region(PAGE_IO,PAGE_IO_SIZE);
+		*/
 		return -EIO;
 	}
-
-	/*
-	request_region( PAGE_IO, PAGE_IO_SIZE, "ELAN-104NC flash" );
-	*/
 
 	printk( KERN_INFO"%s: IO:0x%x-0x%x MEM:0x%x-0x%x\n",
 		elan_104nc_map.name,

