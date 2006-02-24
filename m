Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWBXUrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWBXUrd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWBXUrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:47:33 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:2267 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751104AbWBXUr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:47:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=o537ybWiMoHxii3pLyndRK9FbEMpA83qRWv+gXIJeZz8yvk4CSQDrVrI4F7sXkflDPxZ8QZP6quLX4wWQKLg8CiXfL0k4Xkg11ig5XtkyUhPg6p4jyxZICG4KDNTDzc+QDVuF9YMaQqKbS7o+AOw1Kd7eQvNQwDv9ECABSxjmSg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 05/13] request_region fixes for ppc prep_request_io
Date: Fri, 24 Feb 2006 21:47:42 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cort@cs.nmt.edu, hozer@drgw.net, paulus@samba.org,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200602242147.43197.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


request_region fixes for ppc prep_request_io.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/ppc/platforms/prep_setup.c |   51 ++++++++++++++++++++++++++++++++++------
 1 files changed, 44 insertions(+), 7 deletions(-)

--- linux-2.6.16-rc4-mm2-orig/arch/ppc/platforms/prep_setup.c	2006-02-24 19:25:30.000000000 +0100
+++ linux-2.6.16-rc4-mm2/arch/ppc/platforms/prep_setup.c	2006-02-24 21:22:33.000000000 +0100
@@ -1064,20 +1064,57 @@ prep_map_io(void)
 	io_block_mapping(0xf0000000, PREP_ISA_MEM_BASE, 0x08000000, _PAGE_IO);
 }
 
+static inline int
+prep_request_region(unsigned long start, unsigned long n, const char *name)
+{
+	struct resource *region;
+	
+	region = request_region(start, n, name);
+	if (!region) {
+		printk(KERN_WARNING "prep_request_io: could not allocate "
+				    "%s region\n", name);
+		return 0;
+	}
+	return 1;
+}
+
 static int __init
 prep_request_io(void)
 {
-	if (_machine == _MACH_prep) {
+	int tmp;
+
+	if (_machine != _MACH_prep)
+		return 0;
+
 #ifdef CONFIG_NVRAM
-		request_region(PREP_NVRAM_AS0, 0x8, "nvram");
+	tmp = prep_request_region(PREP_NVRAM_AS0, 0x8, "nvram");
+	if (!tmp)
+		goto out_nvram;
 #endif
-		request_region(0x00,0x20,"dma1");
-		request_region(0x40,0x20,"timer");
-		request_region(0x80,0x10,"dma page reg");
-		request_region(0xc0,0x20,"dma2");
-	}
+	tmp = prep_request_region(0x00,0x20,"dma1");
+	if (!tmp)
+		goto out_dma1;
+	tmp = prep_request_region(0x40,0x20,"timer");
+	if (!tmp)
+		goto out_timer;
+	tmp = prep_request_region(0x80,0x10,"dma page reg");
+	if (!tmp)
+		goto out_dma_page;
+	tmp = prep_request_region(0xc0,0x20,"dma2");
+	if (!tmp)
+		goto out_dma2;
 
 	return 0;
+ out_dma2:
+ 	release_region(0x80,0x10);
+ out_dma_page:
+ 	release_region(0x40,0x20);
+ out_timer:
+ 	release_region(0x00,0x20);
+ out_dma1:
+ 	release_region(PREP_NVRAM_AS0, 0x8);
+ out_nvram:
+	return -EBUSY;
 }
 
 device_initcall(prep_request_io);



