Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263146AbTEBUbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263160AbTEBUbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:31:23 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17036 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id S263146AbTEBUbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:31:20 -0400
Date: Fri, 2 May 2003 13:43:44 -0700
From: Bob Miller <rem@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH 2.5.68] Convert sbc_gxx to remove check_region().
Message-ID: <20030502204344.GD25713@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moved the request_region() call to replace check_region() and adds
release_region()'s in the error paths that occure before the old
call to request_region().

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

diff -Nru a/drivers/mtd/maps/sbc_gxx.c b/drivers/mtd/maps/sbc_gxx.c
--- a/drivers/mtd/maps/sbc_gxx.c	Fri May  2 09:52:22 2003
+++ b/drivers/mtd/maps/sbc_gxx.c	Fri May  2 09:52:22 2003
@@ -240,7 +240,7 @@
 
 int __init init_sbc_gxx(void)
 {
-	if (check_region(PAGE_IO,PAGE_IO_SIZE) != 0) {
+	if (!request_region(PAGE_IO,PAGE_IO_SIZE,"SBC-GXx flash")) {
 		printk( KERN_ERR"%s: IO ports 0x%x-0x%x in use\n",
 			sbc_gxx_map.name,
 			PAGE_IO, PAGE_IO+PAGE_IO_SIZE-1 );
@@ -250,10 +250,9 @@
 	if (!iomapadr) {
 		printk( KERN_ERR"%s: failed to ioremap memory region\n",
 			sbc_gxx_map.name );
+		release_region(PAGE_IO,PAGE_IO_SIZE);
 		return -EIO;
 	}
-	
-	request_region( PAGE_IO, PAGE_IO_SIZE, "SBC-GXx flash" );
 	
 	printk( KERN_INFO"%s: IO:0x%x-0x%x MEM:0x%x-0x%x\n",
 		sbc_gxx_map.name,
