Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUCLJum (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 04:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbUCLJum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 04:50:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55941 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262065AbUCLJub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 04:50:31 -0500
Date: Fri, 12 Mar 2004 09:49:51 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Mickael Marchand <marchand@kde.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040312094951.GP18345@reti>
References: <1ysXv-wm-11@gated-at.bofh.it> <1yxuq-6y6-13@gated-at.bofh.it> <m3hdwnawfi.fsf@averell.firstfloor.org> <200403111445.35075.marchand@kde.org> <20040311144829.GA22284@colin2.muc.de> <20040311214354.GM18345@reti> <20040311233720.GB46488@colin2.muc.de> <20040312082214.GO18345@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312082214.GO18345@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 08:22:14AM +0000, Joe Thornber wrote:
> name len == 128, uuid_len == 129, so is the uuid_len being rounded up
> to the nearest 64bit boundary on x86-64 and only 32bit boundary on
> x86-32 ?  (Sounds likely)

In which case the following ugly patch should fix things.  Mickael,
any chance you could test this please ?

- Joe


Fix ioctl breakage on x86-64.
--- diff/include/linux/dm-ioctl.h	2004-03-11 10:20:28.000000000 +0000
+++ source/include/linux/dm-ioctl.h	2004-03-12 09:44:58.000000000 +0000
@@ -187,23 +187,37 @@ enum {
 	DM_TABLE_STATUS_CMD,
 };
 
+/*
+ * The dm_ioctl struct passed into the ioctl is just the header
+ * on a larger chunk of memory.  On x86-64 the dm-ioctl struct
+ * will be padded to an 8 byte boundary so the size will be
+ * different, which would change the ioctl code - yes I really
+ * messed up.  This hack forces x86-64 to have the correct ioctl
+ * code.
+ */
+#ifdef CONFIG_X86_64
+typedef char ioctl_struct[308];
+#else
+typedef struct dm_ioctl ioctl_struct;
+#endif
+
 #define DM_IOCTL 0xfd
 
-#define DM_VERSION       _IOWR(DM_IOCTL, DM_VERSION_CMD, struct dm_ioctl)
-#define DM_REMOVE_ALL    _IOWR(DM_IOCTL, DM_REMOVE_ALL_CMD, struct dm_ioctl)
-#define DM_LIST_DEVICES  _IOWR(DM_IOCTL, DM_LIST_DEVICES_CMD, struct dm_ioctl)
-
-#define DM_DEV_CREATE    _IOWR(DM_IOCTL, DM_DEV_CREATE_CMD, struct dm_ioctl)
-#define DM_DEV_REMOVE    _IOWR(DM_IOCTL, DM_DEV_REMOVE_CMD, struct dm_ioctl)
-#define DM_DEV_RENAME    _IOWR(DM_IOCTL, DM_DEV_RENAME_CMD, struct dm_ioctl)
-#define DM_DEV_SUSPEND   _IOWR(DM_IOCTL, DM_DEV_SUSPEND_CMD, struct dm_ioctl)
-#define DM_DEV_STATUS    _IOWR(DM_IOCTL, DM_DEV_STATUS_CMD, struct dm_ioctl)
-#define DM_DEV_WAIT      _IOWR(DM_IOCTL, DM_DEV_WAIT_CMD, struct dm_ioctl)
-
-#define DM_TABLE_LOAD    _IOWR(DM_IOCTL, DM_TABLE_LOAD_CMD, struct dm_ioctl)
-#define DM_TABLE_CLEAR   _IOWR(DM_IOCTL, DM_TABLE_CLEAR_CMD, struct dm_ioctl)
-#define DM_TABLE_DEPS    _IOWR(DM_IOCTL, DM_TABLE_DEPS_CMD, struct dm_ioctl)
-#define DM_TABLE_STATUS  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, struct dm_ioctl)
+#define DM_VERSION       _IOWR(DM_IOCTL, DM_VERSION_CMD, ioctl_struct)
+#define DM_REMOVE_ALL    _IOWR(DM_IOCTL, DM_REMOVE_ALL_CMD, ioctl_struct)
+#define DM_LIST_DEVICES  _IOWR(DM_IOCTL, DM_LIST_DEVICES_CMD, ioctl_struct)
+
+#define DM_DEV_CREATE    _IOWR(DM_IOCTL, DM_DEV_CREATE_CMD, ioctl_struct)
+#define DM_DEV_REMOVE    _IOWR(DM_IOCTL, DM_DEV_REMOVE_CMD, ioctl_struct)
+#define DM_DEV_RENAME    _IOWR(DM_IOCTL, DM_DEV_RENAME_CMD, ioctl_struct)
+#define DM_DEV_SUSPEND   _IOWR(DM_IOCTL, DM_DEV_SUSPEND_CMD, ioctl_struct)
+#define DM_DEV_STATUS    _IOWR(DM_IOCTL, DM_DEV_STATUS_CMD, ioctl_struct)
+#define DM_DEV_WAIT      _IOWR(DM_IOCTL, DM_DEV_WAIT_CMD, ioctl_struct)
+
+#define DM_TABLE_LOAD    _IOWR(DM_IOCTL, DM_TABLE_LOAD_CMD, ioctl_struct)
+#define DM_TABLE_CLEAR   _IOWR(DM_IOCTL, DM_TABLE_CLEAR_CMD, ioctl_struct)
+#define DM_TABLE_DEPS    _IOWR(DM_IOCTL, DM_TABLE_DEPS_CMD, ioctl_struct)
+#define DM_TABLE_STATUS  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, ioctl_struct)
 
 #define DM_VERSION_MAJOR	4
 #define DM_VERSION_MINOR	0
