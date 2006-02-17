Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWBQHCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWBQHCN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWBQHBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:01:44 -0500
Received: from 203-59-85-100.dyn.iinet.net.au ([203.59.85.100]:57729 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S932568AbWBQHBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:01:33 -0500
Date: Fri, 17 Feb 2006 15:01:18 +0800
Message-Id: <200602170701.k1H71Irp004035@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [RFC:PATCH 4/4] autofs4 - add new packet type for v5 communications
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch define a new autofs packet for autofs v5 and updates
the waitq.c functions to handle the additional packet type.

Signed-off-by: Ian Kent <raven@themaw.net>


--- linux-2.6.16-rc2-mm1/include/linux/auto_fs4.h.v5-packet-proto	2006-02-09 20:11:00.000000000 +0800
+++ linux-2.6.16-rc2-mm1/include/linux/auto_fs4.h	2006-02-09 20:38:30.000000000 +0800
@@ -19,18 +19,37 @@
 #undef AUTOFS_MIN_PROTO_VERSION
 #undef AUTOFS_MAX_PROTO_VERSION
 
-#define AUTOFS_PROTO_VERSION		4
+#define AUTOFS_PROTO_VERSION		5
 #define AUTOFS_MIN_PROTO_VERSION	3
-#define AUTOFS_MAX_PROTO_VERSION	4
+#define AUTOFS_MAX_PROTO_VERSION	5
 
-#define AUTOFS_PROTO_SUBVERSION		10
+#define AUTOFS_PROTO_SUBVERSION		0
 
 /* Mask for expire behaviour */
 #define AUTOFS_EXP_IMMEDIATE		1
 #define AUTOFS_EXP_LEAVES		2
 
-/* New message type */
-#define autofs_ptype_expire_multi	2	/* Expire entry (umount request) */
+/* Daemon notification packet types */
+enum autofs_notify {
+	NFY_NONE,
+	NFY_MOUNT,
+	NFY_EXPIRE
+};
+
+/* Kernel protocol version 4 packet types */
+
+/* Expire entry (umount request) */
+#define autofs_ptype_expire_multi	2
+
+/* Kernel protocol version 5 packet types */
+
+/* Indirect mount missing and expire requests. */
+#define autofs_ptype_missing_indirect	3
+#define autofs_ptype_expire_indirect	4
+
+/* Direct mount missing and expire requests */
+#define autofs_ptype_missing_direct	5
+#define autofs_ptype_expire_direct	6
 
 /* v4 multi expire (via pipe) */
 struct autofs_packet_expire_multi {
@@ -40,14 +59,36 @@ struct autofs_packet_expire_multi {
 	char name[NAME_MAX+1];
 };
 
+/* autofs v5 common packet struct */
+struct autofs_v5_packet {
+	struct autofs_packet_hdr hdr;
+	autofs_wqt_t wait_queue_token;
+	__u32 dev;
+	__u64 ino;
+	uid_t uid;
+	gid_t gid;
+	pid_t pid;
+	pid_t tgid;
+	int len;
+	char name[NAME_MAX+1];
+};
+
+typedef struct autofs_v5_packet autofs_packet_missing_indirect_t;
+typedef struct autofs_v5_packet autofs_packet_expire_indirect_t;
+typedef struct autofs_v5_packet autofs_packet_missing_direct_t;
+typedef struct autofs_v5_packet autofs_packet_expire_direct_t;
+
 union autofs_packet_union {
 	struct autofs_packet_hdr hdr;
 	struct autofs_packet_missing missing;
 	struct autofs_packet_expire expire;
 	struct autofs_packet_expire_multi expire_multi;
+	struct autofs_v5_packet v5_packet;
 };
 
 #define AUTOFS_IOC_EXPIRE_MULTI		_IOW(0x93,0x66,int)
+#define AUTOFS_IOC_EXPIRE_INDIRECT	AUTOFS_IOC_EXPIRE_MULTI
+#define AUTOFS_IOC_EXPIRE_DIRECT	AUTOFS_IOC_EXPIRE_MULTI
 #define AUTOFS_IOC_PROTOSUBVER		_IOR(0x93,0x67,int)
 #define AUTOFS_IOC_ASKREGHOST           _IOR(0x93,0x68,int)
 #define AUTOFS_IOC_TOGGLEREGHOST        _IOR(0x93,0x69,int)
--- linux-2.6.16-rc2-mm1/fs/autofs4/autofs_i.h.v5-packet-proto	2006-02-09 20:33:15.000000000 +0800
+++ linux-2.6.16-rc2-mm1/fs/autofs4/autofs_i.h	2006-02-09 20:38:30.000000000 +0800
@@ -77,6 +77,12 @@ struct autofs_wait_queue {
 	int hash;
 	int len;
 	char *name;
+	u32 dev;
+	u64 ino;
+	uid_t uid;
+	gid_t gid;
+	pid_t pid;
+	pid_t tgid;
 	/* This is for status reporting upon return */
 	int status;
 	atomic_t notified;
@@ -179,13 +185,6 @@ struct autofs_info *autofs4_init_ino(str
 
 /* Queue management functions */
 
-enum autofs_notify
-{
-	NFY_NONE,
-	NFY_MOUNT,
-	NFY_EXPIRE
-};
-
 int autofs4_wait(struct autofs_sb_info *,struct dentry *, enum autofs_notify);
 int autofs4_wait_release(struct autofs_sb_info *,autofs_wqt_t,int);
 void autofs4_catatonic_mode(struct autofs_sb_info *);
@@ -203,6 +202,16 @@ static inline int autofs4_follow_mount(s
 	return res;
 }
 
+static inline u32 autofs4_get_dev(struct autofs_sb_info *sbi)
+{
+	return new_encode_dev(sbi->sb->s_dev);
+}
+
+static inline u64 autofs4_get_ino(struct autofs_sb_info *sbi)
+{
+	return sbi->sb->s_root->d_inode->i_ino;
+}
+
 static inline int simple_positive(struct dentry *dentry)
 {
 	return dentry->d_inode && !d_unhashed(dentry);
--- linux-2.6.16-rc2-mm1/fs/autofs4/waitq.c.v5-packet-proto	2006-02-09 20:10:11.000000000 +0800
+++ linux-2.6.16-rc2-mm1/fs/autofs4/waitq.c	2006-02-09 20:38:53.000000000 +0800
@@ -3,7 +3,7 @@
  * linux/fs/autofs/waitq.c
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
- *  Copyright 2001-2003 Ian Kent <raven@themaw.net>
+ *  Copyright 2001-2006 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -97,7 +97,10 @@ static void autofs4_notify_daemon(struct
 
 	pkt.hdr.proto_version = sbi->version;
 	pkt.hdr.type = type;
-	if (type == autofs_ptype_missing) {
+	switch (type) {
+	/* Kernel protocol v4 missing and expire packets */
+	case autofs_ptype_missing:
+	{
 		struct autofs_packet_missing *mp = &pkt.missing;
 
 		pktsz = sizeof(*mp);
@@ -106,7 +109,10 @@ static void autofs4_notify_daemon(struct
 		mp->len = wq->len;
 		memcpy(mp->name, wq->name, wq->len);
 		mp->name[wq->len] = '\0';
-	} else if (type == autofs_ptype_expire_multi) {
+		break;
+	}
+	case autofs_ptype_expire_multi:
+	{
 		struct autofs_packet_expire_multi *ep = &pkt.expire_multi;
 
 		pktsz = sizeof(*ep);
@@ -115,7 +121,34 @@ static void autofs4_notify_daemon(struct
 		ep->len = wq->len;
 		memcpy(ep->name, wq->name, wq->len);
 		ep->name[wq->len] = '\0';
-	} else {
+		break;
+	}
+	/*
+	 * Kernel protocol v5 packet for handling indirect and direct
+	 * mount missing and expire requests
+	 */
+	case autofs_ptype_missing_indirect:
+	case autofs_ptype_expire_indirect:
+	case autofs_ptype_missing_direct:
+	case autofs_ptype_expire_direct:
+	{
+		struct autofs_v5_packet *packet = &pkt.v5_packet;
+
+		pktsz = sizeof(*packet);
+
+		packet->wait_queue_token = wq->wait_queue_token;
+		packet->len = wq->len;
+		memcpy(packet->name, wq->name, wq->len);
+		packet->name[wq->len] = '\0';
+		packet->dev = wq->dev;
+		packet->ino = wq->ino;
+		packet->uid = wq->uid;
+		packet->gid = wq->gid;
+		packet->pid = wq->pid;
+		packet->tgid = wq->tgid;
+		break;
+	}
+	default:
 		printk("autofs4_notify_daemon: bad type %d!\n", type);
 		return;
 	}
@@ -161,7 +194,9 @@ int autofs4_wait(struct autofs_sb_info *
 {
 	struct autofs_wait_queue *wq;
 	char *name;
-	int len, status;
+	unsigned int len = 0;
+	unsigned int hash = 0;
+	int status;
 
 	/* In catatonic mode, we don't wait for nobody */
 	if (sbi->catatonic)
@@ -171,11 +206,17 @@ int autofs4_wait(struct autofs_sb_info *
 	if (!name)
 		return -ENOMEM;
 
-	len = autofs4_getpath(sbi, dentry, &name);
-	if (!len) {
-		kfree(name);
-		return -ENOENT;
+	/* If this is a direct mount request create a dummy name */
+	if (IS_ROOT(dentry) && (sbi->type & AUTOFS_TYP_DIRECT))
+		len = sprintf(name, "%p", dentry);
+	else {
+		len = autofs4_getpath(sbi, dentry, &name);
+		if (!len) {
+			kfree(name);
+			return -ENOENT;
+		}
 	}
+	hash = full_name_hash(name, len);
 
 	if (mutex_lock_interruptible(&sbi->wq_mutex)) {
 		kfree(name);
@@ -211,9 +252,15 @@ int autofs4_wait(struct autofs_sb_info *
 		wq->next = sbi->queues;
 		sbi->queues = wq;
 		init_waitqueue_head(&wq->queue);
-		wq->hash = dentry->d_name.hash;
+		wq->hash = hash;
 		wq->name = name;
 		wq->len = len;
+		wq->dev = autofs4_get_dev(sbi);
+		wq->ino = autofs4_get_ino(sbi);
+		wq->uid = current->uid;
+		wq->gid = current->gid;
+		wq->pid = current->pid;
+		wq->tgid = current->tgid;
 		wq->status = -EINTR; /* Status return if interrupted */
 		atomic_set(&wq->wait_ctr, 2);
 		atomic_set(&wq->notified, 1);
@@ -227,8 +274,23 @@ int autofs4_wait(struct autofs_sb_info *
 	}
 
 	if (notify != NFY_NONE && atomic_dec_and_test(&wq->notified)) {
-		int type = (notify == NFY_MOUNT ?
-			autofs_ptype_missing : autofs_ptype_expire_multi);
+		int type;
+
+		if (sbi->version < 5) {
+			if (notify == NFY_MOUNT)
+				type = autofs_ptype_missing;
+			else
+				type = autofs_ptype_expire_multi;
+		} else {
+			if (notify == NFY_MOUNT)
+				type = (sbi->type & AUTOFS_TYP_DIRECT) ?
+					autofs_ptype_missing_direct :
+					 autofs_ptype_missing_indirect;
+			else
+				type = (sbi->type & AUTOFS_TYP_DIRECT) ?
+					autofs_ptype_expire_direct :
+					autofs_ptype_expire_indirect;
+		}
 
 		DPRINTK("new wait id = 0x%08lx, name = %.*s, nfy=%d\n",
 			(unsigned long) wq->wait_queue_token, wq->len, wq->name, notify);
