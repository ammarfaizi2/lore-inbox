Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTFOTso (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 15:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTFOTso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 15:48:44 -0400
Received: from thor.itep.ru ([194.85.69.254]:11194 "EHLO thor.itep.ru")
	by vger.kernel.org with ESMTP id S262827AbTFOTsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 15:48:42 -0400
Date: Mon, 16 Jun 2003 00:02:30 +0400
From: Roman Kagan <Roman.Kagan@itep.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] use tty_driver.name as default .devfs_name
Message-ID: <20030615200230.GA22240@panda.itep.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

In 2.5.71 with devfs enabled my USB modem appears as /dev/<NULL>0
instead of the usual /dev/usb/acm/0.  I tracked down this problem to be
due to 

ChangeSet@1.1215.98.11  2003-06-06 08:54:35-07:00  akpm@digeo.com

(originally "[PATCH] Fix tty devfs mess" from Christoph Hellwig
<hch@lst.de>)

where a new .devfs_name field was introduced in struct tty_driver.
However, many drivers (including cdc-acm) haven't been updated to define
it.  OTOH they seem to be quite happy using their .name for devfs as
well.  This patch makes .name the default .devfs_name.  Since
tty_{,un}register_device() appear to be the only users of .devfs_name,
there should be no side effects.  WFM.  Please consider applying.

  Roman.


--- linux-2.5.71/drivers/char/tty_io.c~	2003-06-14 23:18:23.000000000 +0400
+++ linux-2.5.71/drivers/char/tty_io.c	2003-06-15 22:20:51.000000000 +0400
@@ -2183,6 +2183,10 @@
 		return;
 	}
 
+	/* Use driver name for devfs as well */
+	if (!driver->devfs_name)
+		driver->devfs_name = driver->name;
+
 	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
 			"%s%d", driver->devfs_name, index + driver->name_base);
 
