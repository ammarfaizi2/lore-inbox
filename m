Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUDLOST (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUDLOSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:18:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9904 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262906AbUDLOSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:18:15 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Device-Mapper 1/9
Date: Mon, 12 Apr 2004 09:18:04 -0500
User-Agent: KMail/1.6
References: <200404120912.45870.kevcorry@us.ibm.com>
In-Reply-To: <200404120912.45870.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404120918.04115.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 64/32 bit ioctl problems.

--- diff/include/linux/compat_ioctl.h	2004-04-03 21:38:19.000000000 -0600
+++ source/include/linux/compat_ioctl.h	2004-04-09 09:41:45.000000000 -0500
@@ -123,6 +123,19 @@
 COMPATIBLE_IOCTL(STOP_ARRAY_RO)
 COMPATIBLE_IOCTL(RESTART_ARRAY_RW)
 /* DM */
+COMPATIBLE_IOCTL(DM_VERSION_32)
+COMPATIBLE_IOCTL(DM_LIST_DEVICES_32)
+COMPATIBLE_IOCTL(DM_DEV_CREATE_32)
+COMPATIBLE_IOCTL(DM_DEV_REMOVE_32)
+COMPATIBLE_IOCTL(DM_DEV_RENAME_32)
+COMPATIBLE_IOCTL(DM_DEV_SUSPEND_32)
+COMPATIBLE_IOCTL(DM_DEV_STATUS_32)
+COMPATIBLE_IOCTL(DM_DEV_WAIT_32)
+COMPATIBLE_IOCTL(DM_TABLE_LOAD_32)
+COMPATIBLE_IOCTL(DM_TABLE_CLEAR_32)
+COMPATIBLE_IOCTL(DM_TABLE_DEPS_32)
+COMPATIBLE_IOCTL(DM_TABLE_STATUS_32)
+COMPATIBLE_IOCTL(DM_LIST_VERSIONS_32)
 COMPATIBLE_IOCTL(DM_VERSION)
 COMPATIBLE_IOCTL(DM_LIST_DEVICES)
 COMPATIBLE_IOCTL(DM_DEV_CREATE)
--- diff/include/linux/dm-ioctl.h	2004-04-03 21:36:13.000000000 -0600
+++ source/include/linux/dm-ioctl.h	2004-04-09 09:41:45.000000000 -0500
@@ -200,6 +200,34 @@
 	DM_LIST_VERSIONS_CMD,
 };
 
+/*
+ * The dm_ioctl struct passed into the ioctl is just the header
+ * on a larger chunk of memory.  On x86-64 and other
+ * architectures the dm-ioctl struct will be padded to an 8 byte
+ * boundary so the size will be different, which would change the
+ * ioctl code - yes I really messed up.  This hack forces these
+ * architectures to have the correct ioctl code.
+ */
+#ifdef CONFIG_COMPAT
+typedef char ioctl_struct[308];
+#define DM_VERSION_32       _IOWR(DM_IOCTL, DM_VERSION_CMD, ioctl_struct)
+#define DM_REMOVE_ALL_32    _IOWR(DM_IOCTL, DM_REMOVE_ALL_CMD, ioctl_struct)
+#define DM_LIST_DEVICES_32  _IOWR(DM_IOCTL, DM_LIST_DEVICES_CMD, ioctl_struct)
+
+#define DM_DEV_CREATE_32    _IOWR(DM_IOCTL, DM_DEV_CREATE_CMD, ioctl_struct)
+#define DM_DEV_REMOVE_32    _IOWR(DM_IOCTL, DM_DEV_REMOVE_CMD, ioctl_struct)
+#define DM_DEV_RENAME_32    _IOWR(DM_IOCTL, DM_DEV_RENAME_CMD, ioctl_struct)
+#define DM_DEV_SUSPEND_32   _IOWR(DM_IOCTL, DM_DEV_SUSPEND_CMD, ioctl_struct)
+#define DM_DEV_STATUS_32    _IOWR(DM_IOCTL, DM_DEV_STATUS_CMD, ioctl_struct)
+#define DM_DEV_WAIT_32      _IOWR(DM_IOCTL, DM_DEV_WAIT_CMD, ioctl_struct)
+
+#define DM_TABLE_LOAD_32    _IOWR(DM_IOCTL, DM_TABLE_LOAD_CMD, ioctl_struct)
+#define DM_TABLE_CLEAR_32   _IOWR(DM_IOCTL, DM_TABLE_CLEAR_CMD, ioctl_struct)
+#define DM_TABLE_DEPS_32    _IOWR(DM_IOCTL, DM_TABLE_DEPS_CMD, ioctl_struct)
+#define DM_TABLE_STATUS_32  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, ioctl_struct)
+#define DM_LIST_VERSIONS_32 _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, ioctl_struct)
+#endif
+
 #define DM_IOCTL 0xfd
 
 #define DM_VERSION       _IOWR(DM_IOCTL, DM_VERSION_CMD, struct dm_ioctl)
