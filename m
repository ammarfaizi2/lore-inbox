Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWEQWOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWEQWOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWEQWMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:12:49 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:21632 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751258AbWEQWMN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:12:13 -0400
Message-Id: <20060517221408.810930000@sous-sol.org>
References: <20060517221312.227391000@sous-sol.org>
Date: Wed, 17 May 2006 00:00:14 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@gnumonks.org>,
       Harald Welte <laforge@netfilter.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 14/22] [PATCH] [Cardman 40x0] Fix udev device creation
Content-Disposition: inline; filename=Cardman-40x0-Fix-udev-device-creation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This patch corrects the order of the calls to register_chrdev() and
pcmcia_register_driver().  Now udev correctly creates userspace device
files /dev/cmmN and /dev/cmxN respectively.

Based on an earlier patch by Jan Niehusmann <jan@gondor.com>.

Signed-off-by: Harald Welte <laforge@netfilter.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/char/pcmcia/cm4000_cs.c |   10 ++++++----
 drivers/char/pcmcia/cm4040_cs.c |   11 +++++++----
 2 files changed, 13 insertions(+), 8 deletions(-)

--- linux-2.6.16.16.orig/drivers/char/pcmcia/cm4000_cs.c
+++ linux-2.6.16.16/drivers/char/pcmcia/cm4000_cs.c
@@ -2010,10 +2010,6 @@ static int __init cmm_init(void)
 	if (!cmm_class)
 		return -1;
 
-	rc = pcmcia_register_driver(&cm4000_driver);
-	if (rc < 0)
-		return rc;
-
 	major = register_chrdev(0, DEVICE_NAME, &cm4000_fops);
 	if (major < 0) {
 		printk(KERN_WARNING MODULE_NAME
@@ -2021,6 +2017,12 @@ static int __init cmm_init(void)
 		return -1;
 	}
 
+	rc = pcmcia_register_driver(&cm4000_driver);
+	if (rc < 0) {
+		unregister_chrdev(major, DEVICE_NAME);
+		return rc;
+	}
+
 	return 0;
 }
 
--- linux-2.6.16.16.orig/drivers/char/pcmcia/cm4040_cs.c
+++ linux-2.6.16.16/drivers/char/pcmcia/cm4040_cs.c
@@ -769,16 +769,19 @@ static int __init cm4040_init(void)
 	if (!cmx_class)
 		return -1;
 
-	rc = pcmcia_register_driver(&reader_driver);
-	if (rc < 0)
-		return rc;
-
 	major = register_chrdev(0, DEVICE_NAME, &reader_fops);
 	if (major < 0) {
 		printk(KERN_WARNING MODULE_NAME
 			": could not get major number\n");
 		return -1;
 	}
+
+	rc = pcmcia_register_driver(&reader_driver);
+	if (rc < 0) {
+		unregister_chrdev(major, DEVICE_NAME);
+		return rc;
+	}
+
 	return 0;
 }
 

--
