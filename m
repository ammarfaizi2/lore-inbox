Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbREOGl5>; Tue, 15 May 2001 02:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262657AbREOGlh>; Tue, 15 May 2001 02:41:37 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:63616 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S262653AbREOGl0>; Tue, 15 May 2001 02:41:26 -0400
From: "Victor Wong" <victor.wong@stanford.edu>
To: <dhinds@users.sourceforge.net>, <torvalds@transmeta.com>,
        <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] pcmcia/rsrc_mgr.c
Date: Mon, 14 May 2001 23:40:58 -0700
Message-ID: <NDBBLHPAGLNBKNHFNOOGCEHECKAA.victor.wong@stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following is a patch to the pcmcia code in which a kmalloc failure could
cause the code to crash since the pointer is dereferenced. I've instead
allocated the fixed sized array on the stack. The patch was made against
v2.4.4 of the kernel and result from some errors found during checker runs
against the kernel source.

Victor Wong
victor.wong@stanford.edu

--- drivers/pcmcia/rsrc_mgr.c.orig	Mon May  7 00:39:20 2001
+++ drivers/pcmcia/rsrc_mgr.c	Mon May  7 00:40:29 2001
@@ -182,13 +182,12 @@
 {

     ioaddr_t i, j, bad, any;
-    u_char *b, hole, most;
+    u_char b[256], hole, most;

     printk(KERN_INFO "cs: IO port probe 0x%04x-0x%04x:",
 	   base, base+num-1);

     /* First, what does a floating port look like? */
-    b = kmalloc(256, GFP_KERNEL);
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
 	if (check_io_resource(i, 8))
@@ -200,7 +199,6 @@
 	    most = hole;
 	if (b[most] == 127) break;
     }
-    kfree(b);

     bad = any = 0;
     for (i = base; i < base+num; i += 8) {

