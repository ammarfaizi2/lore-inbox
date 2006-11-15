Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030741AbWKORiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030741AbWKORiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030761AbWKORiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:38:50 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:13228 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030741AbWKORiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:38:50 -0500
Date: Wed, 15 Nov 2006 18:39:23 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [Patch -mm 2/5] driver core: Introduce device_move(): move a
 device to a new parent.
Message-ID: <20061115183923.198f296a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20061115111136.3542aca3@gondolin.boeblingen.de.ibm.com>
References: <20061114113208.74ec12c4@gondolin.boeblingen.de.ibm.com>
	<20061115065052.GC23810@kroah.com>
	<20061115082856.195ca0ab@gondolin.boeblingen.de.ibm.com>
	<3ae72650611150044y8e0b57k681c478dca5c6cbf@mail.gmail.com>
	<20061115102409.6e6e5dc0@gondolin.boeblingen.de.ibm.com>
	<1163583119.4244.6.camel@pim.off.vrfy.org>
	<20061115111136.3542aca3@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 11:11:36 +0100,
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Wed, 15 Nov 2006 10:31:59 +0100,
> Kay Sievers <kay.sievers@vrfy.org> wrote:
> 
> > We need the old DEVPATH in the environment (or something similar),
> > otherwise we can't connect the event with the new device location to the
> > current device. :)
> 
> Duh. I've attached another completely untested patch below.

And this one may have an actual chance of doing something useful :/

---
 include/linux/kobject.h |    6 ++++++
 lib/kobject.c           |   17 +++++++++++++++++
 lib/kobject_uevent.c    |   40 ++++++++++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 8 deletions(-)

--- linux-2.6-CH.orig/include/linux/kobject.h
+++ linux-2.6-CH/include/linux/kobject.h
@@ -47,6 +47,7 @@ enum kobject_action {
 	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices (broken) */
 	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* device offline */
 	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* device online */
+	KOBJ_MOVE	= (__force kobject_action_t) 0x08,	/* device move */
 };
 
 struct kobject {
@@ -265,6 +266,8 @@ extern int __must_check subsys_create_fi
 
 #if defined(CONFIG_HOTPLUG)
 void kobject_uevent(struct kobject *kobj, enum kobject_action action);
+void kobject_uevent_extended(struct kobject *kobj, enum kobject_action action,
+			     const char *string);
 
 int add_uevent_var(char **envp, int num_envp, int *cur_index,
 			char *buffer, int buffer_size, int *cur_len,
@@ -272,6 +275,9 @@ int add_uevent_var(char **envp, int num_
 	__attribute__((format (printf, 7, 8)));
 #else
 static inline void kobject_uevent(struct kobject *kobj, enum kobject_action action) { }
+static inline void kobject_uevent_extended(struct kobject *kobj,
+					   enum kobject_action action,
+					   const char *string) { }
 
 static inline int add_uevent_var(char **envp, int num_envp, int *cur_index,
 				      char *buffer, int buffer_size, int *cur_len, 
--- linux-2.6-CH.orig/lib/kobject.c
+++ linux-2.6-CH/lib/kobject.c
@@ -364,6 +364,8 @@ int kobject_move(struct kobject *kobj, s
 {
 	int error;
 	struct kobject *old_parent;
+	const char *devpath = NULL;
+	char *devpath_string = NULL;
 
 	kobj = kobject_get(kobj);
 	if (!kobj)
@@ -373,14 +375,29 @@ int kobject_move(struct kobject *kobj, s
 		error = -EINVAL;
 		goto out;
 	}
+	/* old object path */
+	devpath = kobject_get_path(kobj, GFP_KERNEL);
+	if (!devpath) {
+		error = -ENOMEM;
+		goto out;
+	}
+	devpath_string = kmalloc(strlen(devpath) + 15, GFP_KERNEL);
+	if (!devpath_string) {
+		error = -ENOMEM;
+		goto out;
+	}
+	sprintf(devpath_string, "OLD_DEVPATH=%s", devpath);
 	error = sysfs_move_dir(kobj, new_parent);
 	if (error)
 		goto out;
 	old_parent = kobj->parent;
 	kobj->parent = new_parent;
 	kobject_put(old_parent);
+	kobject_uevent_extended(kobj, KOBJ_MOVE, devpath);
 out:
 	kobject_put(kobj);
+	kfree(devpath_string);
+	kfree(devpath);
 	return error;
 }
 
--- linux-2.6-CH.orig/lib/kobject_uevent.c
+++ linux-2.6-CH/lib/kobject_uevent.c
@@ -50,18 +50,15 @@ static char *action_to_string(enum kobje
 		return "offline";
 	case KOBJ_ONLINE:
 		return "online";
+	case KOBJ_MOVE:
+		return "move";
 	default:
 		return NULL;
 	}
 }
 
-/**
- * kobject_uevent - notify userspace by ending an uevent
- *
- * @action: action that is happening (usually KOBJ_ADD and KOBJ_REMOVE)
- * @kobj: struct kobject that the action is happening to
- */
-void kobject_uevent(struct kobject *kobj, enum kobject_action action)
+static void do_kobject_uevent(struct kobject *kobj, enum kobject_action action,
+			      const char *string)
 {
 	char **envp;
 	char *buffer;
@@ -134,7 +131,10 @@ void kobject_uevent(struct kobject *kobj
 	scratch += sprintf (scratch, "DEVPATH=%s", devpath) + 1;
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SUBSYSTEM=%s", subsystem) + 1;
-
+	if (string != NULL) {
+		envp [i++] = scratch;
+		scratch += sprintf(scratch, "%s", string) + 1;
+	}
 	/* just reserve the space, overwrite it after kset call has returned */
 	envp[i++] = seq_buff = scratch;
 	scratch += strlen("SEQNUM=18446744073709551616") + 1;
@@ -200,9 +200,33 @@ exit:
 	kfree(envp);
 	return;
 }
+
+/**
+ * kobject_uevent - notify userspace by ending an uevent
+ *
+ * @action: action that is happening (usually KOBJ_ADD and KOBJ_REMOVE)
+ * @kobj: struct kobject that the action is happening to
+ */
+void kobject_uevent(struct kobject *kobj, enum kobject_action action)
+{
+	do_kobject_uevent(kobj, action, NULL);
+}
 EXPORT_SYMBOL_GPL(kobject_uevent);
 
 /**
+ * kobject_uevent_extended - send an uevent with extended data
+ *
+ * @action: action that is happening (usually KOBJ_MOVE)
+ * @kobj: struct kobject that the action is happening to
+ * @string: string containing additional data
+ */
+void kobject_uevent_extended(struct kobject *kobj, enum kobject_action action,
+			     const char *string)
+{
+	do_kobject_uevent(kobj, action, string);
+}
+
+/**
  * add_uevent_var - helper for creating event variables
  * @envp: Pointer to table of environment variables, as passed into
  * uevent() method.
