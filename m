Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263162AbTDBVdy>; Wed, 2 Apr 2003 16:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263163AbTDBVdy>; Wed, 2 Apr 2003 16:33:54 -0500
Received: from air-2.osdl.org ([65.172.181.6]:62084 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263162AbTDBVdv>;
	Wed, 2 Apr 2003 16:33:51 -0500
Date: Wed, 2 Apr 2003 13:45:11 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mtd@infradead.org
Subject: [PATCH 2.5.66] Convert sbc_gxx to to remove check_region().
Message-ID: <20030402214511.GC17147@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moved the request_region() call to replace check_region() and adds
release_region()'s in the error paths that occure before the old
call to request_region().

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17


diff -Nru a/drivers/mtd/maps/sbc_gxx.c b/drivers/mtd/maps/sbc_gxx.c
--- a/drivers/mtd/maps/sbc_gxx.c	Wed Apr  2 10:57:40 2003
+++ b/drivers/mtd/maps/sbc_gxx.c	Wed Apr  2 10:57:40 2003
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
