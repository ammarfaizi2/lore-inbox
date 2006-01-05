Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWAEAvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWAEAvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWAEAuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:50:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:60601 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750964AbWAEAtw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:49:52 -0500
Cc: kay.sievers@suse.de
Subject: [PATCH] merge kobject_uevent and kobject_hotplug
In-Reply-To: <1136422169486@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jan 2006 16:49:29 -0800
Message-Id: <11364221692333@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] merge kobject_uevent and kobject_hotplug

The distinction between hotplug and uevent does not make sense these
days, netlink events are the default.

udev depends entirely on netlink uevents. Only during early boot and
in initramfs, /sbin/hotplug is needed. So merge the two functions and
provide only one interface without all the options.

The netlink layer got a nice generic interface with named slots
recently, which is probably a better facility to plug events for
subsystem specific events.
Also the new poll() interface to /proc/mounts is a nicer way to
notify about changes than sending events through the core.
The uevents should only be used for driver core related requests to
userspace now.

Signed-off-by: Kay Sievers <kay.sievers@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5f123fbd80f4f788554636f02bf73e40f914e0d6
tree dbb7db4c62fa8130a393ce772cf819fcffe2606b
parent 033b96fd30db52a710d97b06f87d16fc59fee0f1
author Kay Sievers <kay.sievers@suse.de> Fri, 11 Nov 2005 14:43:07 +0100
committer Greg Kroah-Hartman <gregkh@suse.de> Wed, 04 Jan 2006 16:18:07 -0800

 drivers/scsi/ipr.c      |    2 
 include/linux/kobject.h |   27 +---
 lib/kobject_uevent.c    |  283 ++++++++++++++++-------------------------------
 3 files changed, 104 insertions(+), 208 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index fa2cb35..bf44a40 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -2132,7 +2132,7 @@ restart:
 	}
 
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-	kobject_uevent(&ioa_cfg->host->shost_classdev.kobj, KOBJ_CHANGE, NULL);
+	kobject_hotplug(&ioa_cfg->host->shost_classdev.kobj, KOBJ_CHANGE);
 	LEAVE;
 }
 
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index e6926b3..5b08248 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -39,11 +39,11 @@ extern u64 hotplug_seqnum;
 /* the actions here must match the proper string in lib/kobject_uevent.c */
 typedef int __bitwise kobject_action_t;
 enum kobject_action {
-	KOBJ_ADD	= (__force kobject_action_t) 0x01,	/* add event, for hotplug */
-	KOBJ_REMOVE	= (__force kobject_action_t) 0x02,	/* remove event, for hotplug */
-	KOBJ_CHANGE	= (__force kobject_action_t) 0x03,	/* a sysfs attribute file has changed */
-	KOBJ_OFFLINE	= (__force kobject_action_t) 0x04,	/* offline event for hotplug devices */
-	KOBJ_ONLINE	= (__force kobject_action_t) 0x05,	/* online event for hotplug devices */
+	KOBJ_ADD	= (__force kobject_action_t) 0x01,	/* exclusive to core */
+	KOBJ_REMOVE	= (__force kobject_action_t) 0x02,	/* exclusive to core */
+	KOBJ_CHANGE	= (__force kobject_action_t) 0x03,	/* device state change */
+	KOBJ_OFFLINE	= (__force kobject_action_t) 0x04,	/* device offline */
+	KOBJ_ONLINE	= (__force kobject_action_t) 0x05,	/* device online */
 };
 
 struct kobject {
@@ -262,28 +262,13 @@ int add_hotplug_env_var(char **envp, int
 			char *buffer, int buffer_size, int *cur_len,
 			const char *format, ...)
 	__attribute__((format (printf, 7, 8)));
-
-int kobject_uevent(struct kobject *kobj,
-		   enum kobject_action action,
-		   struct attribute *attr);
-int kobject_uevent_atomic(struct kobject *kobj,
-			  enum kobject_action action,
-			  struct attribute *attr);
-
 #else
 static inline void kobject_hotplug(struct kobject *kobj, enum kobject_action action) { }
+
 static inline int add_hotplug_env_var(char **envp, int num_envp, int *cur_index, 
 				      char *buffer, int buffer_size, int *cur_len, 
 				      const char *format, ...)
 { return 0; }
-int kobject_uevent(struct kobject *kobj,
-		   enum kobject_action action,
-		   struct attribute *attr)
-{ return 0; }
-int kobject_uevent_atomic(struct kobject *kobj,
-			  enum kobject_action action,
-			  struct attribute *attr)
-{ return 0; }
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 845bf67..dd061da 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -29,6 +29,7 @@
 char hotplug_path[HOTPLUG_PATH_LEN] = "/sbin/hotplug";
 u64 hotplug_seqnum;
 static DEFINE_SPINLOCK(sequence_lock);
+static struct sock *uevent_sock;
 
 static char *action_to_string(enum kobject_action action)
 {
@@ -48,123 +49,6 @@ static char *action_to_string(enum kobje
 	}
 }
 
-static struct sock *uevent_sock;
-
-/**
- * send_uevent - notify userspace by sending event through netlink socket
- *
- * @signal: signal name
- * @obj: object path (kobject)
- * @envp: possible hotplug environment to pass with the message
- * @gfp_mask:
- */
-static int send_uevent(const char *signal, const char *obj,
-		       char **envp, gfp_t gfp_mask)
-{
-	struct sk_buff *skb;
-	char *pos;
-	int len;
-
-	if (!uevent_sock)
-		return -EIO;
-
-	len = strlen(signal) + 1;
-	len += strlen(obj) + 1;
-
-	/* allocate buffer with the maximum possible message size */
-	skb = alloc_skb(len + BUFFER_SIZE, gfp_mask);
-	if (!skb)
-		return -ENOMEM;
-
-	pos = skb_put(skb, len);
-	sprintf(pos, "%s@%s", signal, obj);
-
-	/* copy the environment key by key to our continuous buffer */
-	if (envp) {
-		int i;
-
-		for (i = 2; envp[i]; i++) {
-			len = strlen(envp[i]) + 1;
-			pos = skb_put(skb, len);
-			strcpy(pos, envp[i]);
-		}
-	}
-
-	NETLINK_CB(skb).dst_group = 1;
-	return netlink_broadcast(uevent_sock, skb, 0, 1, gfp_mask);
-}
-
-static int do_kobject_uevent(struct kobject *kobj, enum kobject_action action, 
-			     struct attribute *attr, gfp_t gfp_mask)
-{
-	char *path;
-	char *attrpath;
-	char *signal;
-	int len;
-	int rc = -ENOMEM;
-
-	path = kobject_get_path(kobj, gfp_mask);
-	if (!path)
-		return -ENOMEM;
-
-	signal = action_to_string(action);
-	if (!signal)
-		return -EINVAL;
-
-	if (attr) {
-		len = strlen(path);
-		len += strlen(attr->name) + 2;
-		attrpath = kmalloc(len, gfp_mask);
-		if (!attrpath)
-			goto exit;
-		sprintf(attrpath, "%s/%s", path, attr->name);
-		rc = send_uevent(signal, attrpath, NULL, gfp_mask);
-		kfree(attrpath);
-	} else
-		rc = send_uevent(signal, path, NULL, gfp_mask);
-
-exit:
-	kfree(path);
-	return rc;
-}
-
-/**
- * kobject_uevent - notify userspace by sending event through netlink socket
- * 
- * @signal: signal name
- * @kobj: struct kobject that the event is happening to
- * @attr: optional struct attribute the event belongs to
- */
-int kobject_uevent(struct kobject *kobj, enum kobject_action action,
-		   struct attribute *attr)
-{
-	return do_kobject_uevent(kobj, action, attr, GFP_KERNEL);
-}
-EXPORT_SYMBOL_GPL(kobject_uevent);
-
-int kobject_uevent_atomic(struct kobject *kobj, enum kobject_action action,
-			  struct attribute *attr)
-{
-	return do_kobject_uevent(kobj, action, attr, GFP_ATOMIC);
-}
-EXPORT_SYMBOL_GPL(kobject_uevent_atomic);
-
-static int __init kobject_uevent_init(void)
-{
-	uevent_sock = netlink_kernel_create(NETLINK_KOBJECT_UEVENT, 1, NULL,
-					    THIS_MODULE);
-
-	if (!uevent_sock) {
-		printk(KERN_ERR
-		       "kobject_uevent: unable to create netlink socket!\n");
-		return -ENODEV;
-	}
-
-	return 0;
-}
-
-postcore_initcall(kobject_uevent_init);
-
 /**
  * kobject_hotplug - notify userspace by executing /sbin/hotplug
  *
@@ -173,95 +57,84 @@ postcore_initcall(kobject_uevent_init);
  */
 void kobject_hotplug(struct kobject *kobj, enum kobject_action action)
 {
-	char *argv [3];
-	char **envp = NULL;
-	char *buffer = NULL;
-	char *seq_buff;
+	char **envp;
+	char *buffer;
 	char *scratch;
+	const char *action_string;
+	const char *devpath = NULL;
+	const char *subsystem;
+	struct kobject *top_kobj;
+	struct kset *kset;
+	struct kset_hotplug_ops *hotplug_ops;
+	u64 seq;
+	char *seq_buff;
 	int i = 0;
 	int retval;
-	char *kobj_path = NULL;
-	const char *name = NULL;
-	char *action_string;
-	u64 seq;
-	struct kobject *top_kobj = kobj;
-	struct kset *kset;
-	static struct kset_hotplug_ops null_hotplug_ops;
-	struct kset_hotplug_ops *hotplug_ops = &null_hotplug_ops;
 
-	/* If this kobj does not belong to a kset,
-	   try to find a parent that does. */
+	pr_debug("%s\n", __FUNCTION__);
+
+	action_string = action_to_string(action);
+	if (!action_string)
+		return;
+
+	/* search the kset we belong to */
+	top_kobj = kobj;
 	if (!top_kobj->kset && top_kobj->parent) {
 		do {
 			top_kobj = top_kobj->parent;
 		} while (!top_kobj->kset && top_kobj->parent);
 	}
-
-	if (top_kobj->kset)
-		kset = top_kobj->kset;
-	else
+	if (!top_kobj->kset)
 		return;
 
-	if (kset->hotplug_ops)
-		hotplug_ops = kset->hotplug_ops;
+	kset = top_kobj->kset;
+	hotplug_ops = kset->hotplug_ops;
 
-	/* If the kset has a filter operation, call it.
-	   Skip the event, if the filter returns zero. */
-	if (hotplug_ops->filter) {
+	/*  skip the event, if the filter returns zero. */
+	if (hotplug_ops && hotplug_ops->filter)
 		if (!hotplug_ops->filter(kset, kobj))
 			return;
-	}
-
-	pr_debug ("%s\n", __FUNCTION__);
-
-	action_string = action_to_string(action);
-	if (!action_string)
-		return;
 
-	envp = kmalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
+	/* environment index */
+	envp = kzalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
 	if (!envp)
 		return;
-	memset (envp, 0x00, NUM_ENVP * sizeof (char *));
 
+	/* environment values */
 	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
 	if (!buffer)
 		goto exit;
 
-	if (hotplug_ops->name)
-		name = hotplug_ops->name(kset, kobj);
-	if (name == NULL)
-		name = kobject_name(&kset->kobj);
-
-	argv [0] = hotplug_path;
-	argv [1] = (char *)name; /* won't be changed but 'const' has to go */
-	argv [2] = NULL;
-
-	/* minimal command environment */
-	envp [i++] = "HOME=/";
-	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	/* complete object path */
+	devpath = kobject_get_path(kobj, GFP_KERNEL);
+	if (!devpath)
+		goto exit;
 
-	scratch = buffer;
+	/* originating subsystem */
+	if (hotplug_ops && hotplug_ops->name)
+		subsystem = hotplug_ops->name(kset, kobj);
+	else
+		subsystem = kobject_name(&kset->kobj);
 
+	/* event environemnt for helper process only */
+	envp[i++] = "HOME=/";
+	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+
+	/* default keys */
+	scratch = buffer;
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "ACTION=%s", action_string) + 1;
-
-	kobj_path = kobject_get_path(kobj, GFP_KERNEL);
-	if (!kobj_path)
-		goto exit;
-
 	envp [i++] = scratch;
-	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
-
+	scratch += sprintf (scratch, "DEVPATH=%s", devpath) + 1;
 	envp [i++] = scratch;
-	scratch += sprintf(scratch, "SUBSYSTEM=%s", name) + 1;
+	scratch += sprintf(scratch, "SUBSYSTEM=%s", subsystem) + 1;
 
-	/* reserve space for the sequence,
-	 * put the real one in after the hotplug call */
+	/* just reserve the space, overwrite it after kset call has returned */
 	envp[i++] = seq_buff = scratch;
 	scratch += strlen("SEQNUM=18446744073709551616") + 1;
 
-	if (hotplug_ops->hotplug) {
-		/* have the kset specific function add its stuff */
+	/* let the kset specific function add its stuff */
+	if (hotplug_ops && hotplug_ops->hotplug) {
 		retval = hotplug_ops->hotplug (kset, kobj,
 				  &envp[i], NUM_ENVP - i, scratch,
 				  BUFFER_SIZE - (scratch - buffer));
@@ -272,27 +145,49 @@ void kobject_hotplug(struct kobject *kob
 		}
 	}
 
+	/* we will send an event, request a new sequence number */
 	spin_lock(&sequence_lock);
 	seq = ++hotplug_seqnum;
 	spin_unlock(&sequence_lock);
 	sprintf(seq_buff, "SEQNUM=%llu", (unsigned long long)seq);
 
-	pr_debug ("%s: %s %s seq=%llu %s %s %s %s %s\n",
-		  __FUNCTION__, argv[0], argv[1], (unsigned long long)seq,
-		  envp[0], envp[1], envp[2], envp[3], envp[4]);
+	/* send netlink message */
+	if (uevent_sock) {
+		struct sk_buff *skb;
+		size_t len;
+
+		/* allocate message with the maximum possible size */
+		len = strlen(action_string) + strlen(devpath) + 2;
+		skb = alloc_skb(len + BUFFER_SIZE, GFP_KERNEL);
+		if (skb) {
+			/* add header */
+			scratch = skb_put(skb, len);
+			sprintf(scratch, "%s@%s", action_string, devpath);
+
+			/* copy keys to our continuous event payload buffer */
+			for (i = 2; envp[i]; i++) {
+				len = strlen(envp[i]) + 1;
+				scratch = skb_put(skb, len);
+				strcpy(scratch, envp[i]);
+			}
 
-	send_uevent(action_string, kobj_path, envp, GFP_KERNEL);
-
-	if (!hotplug_path[0])
-		goto exit;
+			NETLINK_CB(skb).dst_group = 1;
+			netlink_broadcast(uevent_sock, skb, 0, 1, GFP_KERNEL);
+		}
+	}
 
-	retval = call_usermodehelper (argv[0], argv, envp, 0);
-	if (retval)
-		pr_debug ("%s - call_usermodehelper returned %d\n",
-			  __FUNCTION__, retval);
+	/* call uevent_helper, usually only enabled during early boot */
+	if (hotplug_path[0]) {
+		char *argv [3];
+
+		argv [0] = hotplug_path;
+		argv [1] = (char *)subsystem;
+		argv [2] = NULL;
+		call_usermodehelper (argv[0], argv, envp, 0);
+	}
 
 exit:
-	kfree(kobj_path);
+	kfree(devpath);
 	kfree(buffer);
 	kfree(envp);
 	return;
@@ -350,4 +245,20 @@ int add_hotplug_env_var(char **envp, int
 }
 EXPORT_SYMBOL(add_hotplug_env_var);
 
+static int __init kobject_uevent_init(void)
+{
+	uevent_sock = netlink_kernel_create(NETLINK_KOBJECT_UEVENT, 1, NULL,
+					    THIS_MODULE);
+
+	if (!uevent_sock) {
+		printk(KERN_ERR
+		       "kobject_uevent: unable to create netlink socket!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+postcore_initcall(kobject_uevent_init);
+
 #endif /* CONFIG_HOTPLUG */

