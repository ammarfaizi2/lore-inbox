Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUBUHT5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 02:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUBUHT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 02:19:56 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:37388 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261520AbUBUHTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 02:19:54 -0500
Date: Sat, 21 Feb 2004 08:19:53 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: Re: 2.6.3rc4 ali1535 i2c driver rmmod oops.
Message-Id: <20040221081953.60fe4165.khali@linux-fr.org>
In-Reply-To: <20040218040153.GB6729@kroah.com>
References: <20040218031544.GB26304@redhat.com>
	<20040218040153.GB6729@kroah.com>
Reply-To: sensors@stimpy.netroedge.com
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh nevermind, that's just a dumb driver.  It's doing a release_region
> on memory it didn't get.  Stupid, stupid, stupid...

While we're at it, what about fixing two other drivers that obviously
have the same problem?

(BTW I didn't get an oops as I tried reproducing the problem, only a
"Trying to free nonexistent resource" in dmesg.)

I'm backporting these fixes to the lm_sensors2 CVS repository at the
moment, thanks for pointing them out.

--- linux-2.6.3/drivers/i2c/busses/i2c-i801.c.orig	Thu Feb  5 22:24:55 2004
+++ linux-2.6.3/drivers/i2c/busses/i2c-i801.c	Sat Feb 21 08:03:28 2004
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


--- linux-2.6.3/drivers/i2c/busses/i2c-sis5595.c.orig	Thu Feb  5 22:24:55 2004
+++ linux-2.6.3/drivers/i2c/busses/i2c-sis5595.c	Sat Feb 21 08:03:11 2004
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

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
