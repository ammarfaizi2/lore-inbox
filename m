Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTEBUah (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbTEBUah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:30:37 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16268 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id S262731AbTEBUad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:30:33 -0400
Date: Fri, 2 May 2003 13:42:57 -0700
From: Bob Miller <rem@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH 2.5.68] Convert octagon-5066 to remove check_region().
Message-ID: <20030502204257.GC25713@doc.pdx.osdl.net>
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

diff -Nru a/drivers/mtd/maps/octagon-5066.c b/drivers/mtd/maps/octagon-5066.c
--- a/drivers/mtd/maps/octagon-5066.c	Fri May  2 09:52:22 2003
+++ b/drivers/mtd/maps/octagon-5066.c	Fri May  2 09:52:22 2003
@@ -231,7 +231,7 @@
 	int i;
 	
 	// Do an autoprobe sequence
-	if (check_region(PAGE_IO,1) != 0)
+	if (!request_region(PAGE_IO,1,"Octagon SSD"))
 		{
 			printk("5066: Page Register in Use\n");
 			return -EAGAIN;
@@ -239,16 +239,16 @@
 	iomapadr = (unsigned long)ioremap(WINDOW_START, WINDOW_LENGTH);
 	if (!iomapadr) {
 		printk("Failed to ioremap memory region\n");
+		release_region(PAGE_IO,1);
 		return -EIO;
 	}
 	if (OctProbe() != 0)
 		{
 			printk("5066: Octagon Probe Failed, is this an Octagon 5066 SBC?\n");
 			iounmap((void *)iomapadr);
+			release_region(PAGE_IO,1);
 			return -EAGAIN;
 		}
-	
-	request_region(PAGE_IO,1,"Octagon SSD");
 	
 	// Print out our little header..
 	printk("Octagon 5066 SSD IO:0x%x MEM:0x%x-0x%x\n",PAGE_IO,WINDOW_START,

