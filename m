Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbUCPAEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUCPADr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:03:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:4271 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262876AbUCPAB7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:01:59 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913913301@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:31 -0800
Message-Id: <10793913911614@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.9, 2004/02/23 16:27:33-08:00, khali@linux-fr.org

[PATCH] I2C: fix mor rmmod oopses

> Oh nevermind, that's just a dumb driver.  It's doing a release_region
> on memory it didn't get.  Stupid, stupid, stupid...

While we're at it, what about fixing two other drivers that obviously
have the same problem?

(BTW I didn't get an oops as I tried reproducing the problem, only a
"Trying to free nonexistent resource" in dmesg.)


 drivers/i2c/busses/i2c-i801.c    |    2 +-
 drivers/i2c/busses/i2c-sis5595.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Mon Mar 15 14:37:14 2004
+++ b/drivers/i2c/busses/i2c-i801.c	Mon Mar 15 14:37:14 2004
@@ -608,6 +608,7 @@
 static void __devexit i801_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&i801_adapter);
+	release_region(i801_smba, (isich4 ? 16 : 8));
 }
 
 static struct pci_driver i801_driver = {
@@ -625,7 +626,6 @@
 static void __exit i2c_i801_exit(void)
 {
 	pci_unregister_driver(&i801_driver);
-	release_region(i801_smba, (isich4 ? 16 : 8));
 }
 
 MODULE_AUTHOR ("Frodo Looijaard <frodol@dds.nl>, "
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	Mon Mar 15 14:37:14 2004
+++ b/drivers/i2c/busses/i2c-sis5595.c	Mon Mar 15 14:37:14 2004
@@ -391,6 +391,7 @@
 static void __devexit sis5595_remove(struct pci_dev *dev)
 {
 	i2c_del_adapter(&sis5595_adapter);
+	release_region(sis5595_base + SMB_INDEX, 2);
 }
 
 static struct pci_driver sis5595_driver = {
@@ -408,7 +409,6 @@
 static void __exit i2c_sis5595_exit(void)
 {
 	pci_unregister_driver(&sis5595_driver);
-	release_region(sis5595_base + SMB_INDEX, 2);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");

