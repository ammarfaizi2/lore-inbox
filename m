Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263287AbTHXKdl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 06:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263433AbTHXKdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 06:33:41 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:7951 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S263287AbTHXKdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 06:33:38 -0400
Subject: [PATCH] 2.6.0-test4 (#7) - correct name field breakage in zoran
	driver
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: multipart/mixed; boundary="=-c94iRkHGvDQXtgorAPX/"
Message-Id: <1061722346.4303.377.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 24 Aug 2003 12:52:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c94iRkHGvDQXtgorAPX/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey,

I suddenly noticed that 2.6.0-test4 seems to have removed the struct
device->name field, apparently for memory consumption reasons. Linus
changed this to pci_name((zr)->pci_dev) in my driver, and that's almost
correct, except that it is the PCI device ID, and I'm not supposed to
touch it. Also, since it's only 4 bytes, all my device names now show
like 'DC1' (this should be 'DC10plus') and alike.

The attached patch fixes this by going back to the behaviour that we
used in 2.4.x: we use a separate name field in our private driver
struct.

I promise I won't send in more patches after this one for today. :).

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

--=-c94iRkHGvDQXtgorAPX/
Content-Disposition: attachment; filename=20030824_name.diff
Content-Type: text/plain; name=20030824_name.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test4-old/drivers/media/video/zoran.h	Sun Aug 24 01:42:57 2003
+++ linux-2.6.0-test4/drivers/media/video/zoran.h	Sun Aug 24 12:35:59 2003
@@ -146,7 +146,7 @@
 
 #define ZORAN_NAME    "ZORAN"	/* name of the device */
 
-#define ZR_DEVNAME(zr) pci_name((zr)->pci_dev)
+#define ZR_DEVNAME(zr) ((zr)->name)
 
 #define   BUZ_MAX_WIDTH   (zr->timing->Wa)
 #define   BUZ_MAX_HEIGHT  (zr->timing->Ha)
@@ -403,9 +403,7 @@
 	struct tvnorm *timing;
 
 	unsigned short id;	/* number of this device */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 	char name[32];		/* name of this device */
-#endif
 	struct pci_dev *pci_dev;	/* PCI device */
 	unsigned char revision;	/* revision of zr36057 */
 	unsigned int zr36057_adr;	/* bus address of IO mem returned by PCI BIOS */

--=-c94iRkHGvDQXtgorAPX/--

