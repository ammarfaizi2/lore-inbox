Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274970AbTHLBnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 21:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274971AbTHLBnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 21:43:35 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:56973 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S274970AbTHLBnc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 21:43:32 -0400
Date: Tue, 12 Aug 2003 03:43:28 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] more documentation for request_firmware()
Message-ID: <20030812014328.GA31438@ranty.pantax.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ChangeLog:
	
	Add some higher level docs to Documentation/firmware_class/README.


 README |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+)


diff --exclude=CVS -urN linux-2.5.orig/Documentation/firmware_class/README linux-2.5.mine/Documentation/firmware_class/README
--- linux-2.5.orig/Documentation/firmware_class/README	2003-08-12 03:34:05.000000000 +0200
+++ linux-2.5.mine/Documentation/firmware_class/README	2003-08-12 03:31:55.000000000 +0200
@@ -15,6 +15,71 @@
   3) Some people, like the Debian crowd, don't consider some firmware free
      enough and remove entire drivers (e.g.: keyspan).
 
+ High level behavior (mixed):
+ ============================
+
+ kernel(driver): calls request_firmware(&fw_entry, $FIRMWARE, device)
+ 
+ userspace:
+ 	- /sys/class/firmware/xxx/{loading,data} appear.
+	- hotplug gets called with a firmware identifier in $FIRMWARE
+	  and the usual hotplug environment.
+		- hotplug: echo 1 > /sys/class/firmware/xxx/loading
+
+ kernel: Discard any previous partial load.
+
+ userspace:
+		- hotplug: cat appropriate_firmware_image > \
+					/sys/class/firmware/xxx/data
+					
+ kernel: grows a buffer in PAGE_SIZE increments to hold the image as it
+	 comes in.
+ 
+ userspace:
+		- hotplug: echo 0 > /sys/class/firmware/xxx/loading
+
+ kernel: request_firmware() returns and the driver has the firmware
+	 image in fw_entry->{data,size}. If something went wrong
+	 request_firmware() returns non-zero and fw_entry is set to
+	 NULL.
+
+ kernel(driver): Driver code calls release_firmware(fw_entry) releasing
+		 the firmware image and any related resource.
+
+ High level behavior (driver code):
+ ==================================
+
+	 if(request_firmware(&fw_entry, $FIRMWARE, device) == 0)
+	 	copy_fw_to_device(fw_entry->data, fw_entry->size);
+	 release(fw_entry);
+
+ Sample/simple hotplug script:
+ ============================
+
+	# Both $DEVPATH and $FIRMWARE are already provided in the environment.
+
+	HOTPLUG_FW_DIR=/usr/lib/hotplug/firmware/
+
+	echo 1 > /sysfs/$DEVPATH/loading
+	cat $HOTPLUG_FW_DIR/$FIRMWARE > /sysfs/$DEVPATH/data
+	echo 0 > /sysfs/$DEVPATH/loading
+
+ Random notes:
+ ============
+
+ - "echo -1 > /sys/class/firmware/xxx/loading" will cancel the load at
+   once and make request_firmware() return with error.
+
+ - firmware_data_read() and firmware_loading_show() are just provided
+   for testing and completeness, they are not called in normal use.
+
+ - There is also /sys/class/firmware/timeout which holds a timeout in
+   seconds for the whole load operation.
+
+ - request_firmware_nowait() is also provided for convenience in
+   non-user contexts.
+
+
  about in-kernel persistence:
  ---------------------------
  Under some circumstances, as explained below, it would be interesting to keep
@@ -56,3 +121,4 @@
 
 	Note: If persistence is implemented on top of initramfs,
 	register_firmware() may not be appropriate.
+

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
