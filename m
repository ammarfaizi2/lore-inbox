Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265552AbSJSIE6>; Sat, 19 Oct 2002 04:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265553AbSJSIE6>; Sat, 19 Oct 2002 04:04:58 -0400
Received: from chunk.voxel.net ([207.99.115.133]:57269 "EHLO chunk.voxel.net")
	by vger.kernel.org with ESMTP id <S265552AbSJSIE5>;
	Sat, 19 Oct 2002 04:04:57 -0400
Date: Sat, 19 Oct 2002 04:11:01 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.44 Fix uninitialized device struct w/ add_disk()
Message-ID: <20021019081101.GA5149@chunk.voxel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux chunk 2.4.18-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This occurs w/ 2.5 device-mapper; add_disk() is called (w/ a possibly
invalid gendisk).  add_disk() calls register_disk(), which constructs
the device struct (gendisk::disk_dev).  First, the bus_id field is
initialized, and then device_add() is called.  However, device_add()
does no initialization of the device struct.  So, since the
gendisk::disk_dev::parent list is NULL, the gendisk::disk_dev::node
field is never initialized.  Later on in device_add(), if an error has
occurred, list_del_init(&dev->node) is called; dev->node is {NULL,NULL},
and an oops occurs.

Instead of calling device_add(), my patch makes register_disk() call
device_register().  This appear to do the same thing as device_add(),
but initializes the device struct before calling device_add().



-- 
It's not denial.  I'm just selective about the reality I accept.
	-- Bill Watterson

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="check.c.diff"

--- a/fs/partitions/check.c	2002-10-19 03:56:00.000000000 -0400
+++ a/fs/partitions/check.c	2002-10-19 03:56:10.000000000 -0400
@@ -455,7 +455,7 @@
 	s = strchr(dev->bus_id, '/');
 	if (s)
 		*s = '!';
-	device_add(dev);
+	device_register(dev);
 	device_create_file(dev, &disk_attr_dev);
 	device_create_file(dev, &disk_attr_range);
 	device_create_file(dev, &disk_attr_size);

--Kj7319i9nmIyA2yE--
