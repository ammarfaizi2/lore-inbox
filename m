Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423130AbWJQGZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423130AbWJQGZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423141AbWJQGZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:25:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:34472 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423130AbWJQGZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:25:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=HRTEOmfQUvVeVbgOQzK3S5gazGykfAKIri+9RBjnFHvKp5BA88awI7NS5mr/WGigZaLwxem1JhoPqJDa4dAn/fTUmIGxZdJLgcH1o3iLA4nuVyQOqxRM5AfFidI+/fgljMUoAB9SYRdlLPHAabq9NpMbIepgxM+foG0fOZt+nhY=
Date: Tue, 17 Oct 2006 15:25:59 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Harald Welte <laforge@gnumonks.org>
Subject: [PATCH] cm4000_cs: fix return value check
Message-ID: <20061017062559.GB13100@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of class_create() need to be checked with IS_ERR().
And register_chrdev() returns errno on failure.
This patch includes these fixes for cm4000_cs and cm4040_cs.

Cc: Harald Welte <laforge@gnumonks.org>
Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

 drivers/char/pcmcia/cm4000_cs.c |    6 +++---
 drivers/char/pcmcia/cm4040_cs.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: 2.6-rc/drivers/char/pcmcia/cm4000_cs.c
===================================================================
--- 2.6-rc.orig/drivers/char/pcmcia/cm4000_cs.c
+++ 2.6-rc/drivers/char/pcmcia/cm4000_cs.c
@@ -1973,14 +1973,14 @@ static int __init cmm_init(void)
 	printk(KERN_INFO "%s\n", version);
 
 	cmm_class = class_create(THIS_MODULE, "cardman_4000");
-	if (!cmm_class)
-		return -1;
+	if (IS_ERR(cmm_class))
+		return PTR_ERR(cmm_class);
 
 	major = register_chrdev(0, DEVICE_NAME, &cm4000_fops);
 	if (major < 0) {
 		printk(KERN_WARNING MODULE_NAME
 			": could not get major number\n");
-		return -1;
+		return major;
 	}
 
 	rc = pcmcia_register_driver(&cm4000_driver);
Index: 2.6-rc/drivers/char/pcmcia/cm4040_cs.c
===================================================================
--- 2.6-rc.orig/drivers/char/pcmcia/cm4040_cs.c
+++ 2.6-rc/drivers/char/pcmcia/cm4040_cs.c
@@ -721,14 +721,14 @@ static int __init cm4040_init(void)
 
 	printk(KERN_INFO "%s\n", version);
 	cmx_class = class_create(THIS_MODULE, "cardman_4040");
-	if (!cmx_class)
-		return -1;
+	if (IS_ERR(cmx_class))
+		return PTR_ERR(cmx_class);
 
 	major = register_chrdev(0, DEVICE_NAME, &reader_fops);
 	if (major < 0) {
 		printk(KERN_WARNING MODULE_NAME
 			": could not get major number\n");
-		return -1;
+		return major;
 	}
 
 	rc = pcmcia_register_driver(&reader_driver);
