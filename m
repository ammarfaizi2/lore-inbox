Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVAVCJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVAVCJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 21:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVAVCJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 21:09:44 -0500
Received: from mailfe07.swip.net ([212.247.154.193]:3577 "EHLO
	mailfe07.swip.net") by vger.kernel.org with ESMTP id S262436AbVAVCJH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 21:09:07 -0500
X-T2-Posting-ID: 2Ngqim/wGkXHuU4sHkFYGQ==
Subject: [RFC][PATCH] Thoughts about capabilities and prototype patch for
	user-capabilities
From: Alexander Nyberg <alexn@dsv.su.se>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 22 Jan 2005 03:08:43 +0100
Message-Id: <1106359723.702.42.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I recently had an idea of having something similar
to /etc/user_capabilites which would consist of
username:CAP_CHOWN,CAP_SOMETHING,CAP_SOMETHING2

This could very well be loaded into linux at the time of an application
doing sys_setuid, sys_setreuid and the likes by hooking into glibc. The
kernel also requires a small patch which I'll inline below for comments.
I sure would use some of these capabilities on my user. And they could
be used to solve things like a certain program/user needs to use
real-time scheduling (just something like CAP_SCHED allowing arbitray
scheduling or CAP_MEMLOCK allowing a user to lock memory. This would
solve some of the old problems).

I haven't looked into making capability bits for certain files, mostly
cause I don't know vfs much and also I don't see this colliding with it,
I think both should exist. 

I don't know what the plans are for capabilities in the future but there
are quite some shortcomings in the current implementation. I think it at
least should allow to set/get capabilites of process ids, user ids and
group ids. These are the things that come to my mind directly. I also
see that 28 of the 32 currently possible slots are taken which will be a
problem if capabilities are ever gonna get serious.

While looking at it today I noticed user-space over here doesn't even
seem to have macros/functions to set/test/clear bits in the blackboxed
types which means anyone want to use it will be exposed to the raw
structure.

So I'm curious of what the thoughts are for capabilities, are they gonna
go away some day in the future? I hope not, I think the idea is simple
and good but something needs to be done about the implementation to
allow it to be of full use. And yes, I volunteer, but I'm not all sure
about which direction has been discussed and where this is going.

Below you will find a test program and at the bottom a patch which allows
a priviledged user to set the capabilities of another user (i386 only). 
Setting capabilities on groups does not work, it requires some more code
(I don't think much though).
Unfortunately the patch has to introduce two system calls and a new
data structure not to break any backward-compatiblity. But if something is
to be done in the future it looks like either compatibility has to be broken
completely (2.7 maybe? if ever?) or new syscalls must be introduced. I guess it
depends on how many programs actually uses capabilities, does anyone know?




#undef _POSIX_SOURCE
#include <linux/capability.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <linux/unistd.h>


#define __NR_sys_id_capget	289
#define __NR_sys_id_capset	290

typedef struct __user_cap_id_header_struct {
        __u32 version;
        uid_t uid;
        gid_t gid;
} *cap_id_header_t;

inline _syscall3(int, sys_id_capget, int, type, void *, head, void *, data);
inline _syscall3(int, sys_id_capset, int, type, void *, head, void *, data);

/* 
 * Had to steal these from kernel header...
*/
#define cap_t(x) (x)
#define CAP_TO_MASK(x) (1 << (x))
#define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))
#define cap_clear(c)         do { cap_t(c) =  0; } while(0)
#define cap_raised(c, flag)  (cap_t(c) & CAP_TO_MASK(flag))
#define cap_isclear(c)       (!cap_t(c))

#define CAP_TYPE_UID    1
#define CAP_TYPE_GID    2


/* 
 * Silly program that sets UID 1000 to have CAP_CHOWN
 * and tests that it returns a cap_user_data_t with
 * CAP_CHOWN set.
*/
int main()
{
	int ret;
	cap_id_header_t head = malloc(sizeof(*head));
	cap_user_data_t data = malloc(sizeof(*data));


	head->version = _LINUX_CAPABILITY_VERSION;
	head->gid = 0;
	head->uid = 1000;

	cap_clear(data->effective);
	cap_clear(data->permitted);
	cap_clear(data->inheritable);
	
	cap_raise(data->effective, CAP_CHOWN);
	ret = sys_id_capset(CAP_TYPE_UID, head, data);
	if (ret) {
		perror("capset: ");
	}

	cap_clear(data->effective);
	cap_clear(data->permitted);
	cap_clear(data->inheritable);
	ret = sys_id_capget(CAP_TYPE_UID, head, data);
	if (ret)
		perror("capget: ");

	if (cap_raised(data->effective, CAP_CHOWN))
		printf("yay!\n");

			
	return 0;
}





===== arch/i386/kernel/entry.S 1.89 vs edited =====
--- 1.89/arch/i386/kernel/entry.S	2005-01-08 06:44:02 +01:00
+++ edited/arch/i386/kernel/entry.S	2005-01-22 00:11:38 +01:00
@@ -864,5 +864,7 @@ ENTRY(sys_call_table)
 	.long sys_add_key
 	.long sys_request_key
 	.long sys_keyctl
+	.long sys_id_capget
+	.long sys_id_capset		/* 290 */
 
 syscall_table_size=(.-sys_call_table)
===== include/linux/capability.h 1.6 vs edited =====
--- 1.6/include/linux/capability.h	2003-05-12 23:35:19 +02:00
+++ edited/include/linux/capability.h	2005-01-22 02:08:34 +01:00
@@ -34,6 +34,12 @@ typedef struct __user_cap_header_struct 
 	int pid;
 } __user *cap_user_header_t;
  
+typedef struct __user_cap_id_header_struct {
+	__u32 version;
+	uid_t uid;
+	gid_t gid;
+} __user *cap_id_header_t;
+
 typedef struct __user_cap_data_struct {
         __u32 effective;
         __u32 permitted;
@@ -65,6 +71,13 @@ typedef __u32 kernel_cap_t;
 
 #endif
 
+/* 
+ * These are types on which the capabilities operate, ie.
+ * processes, users or groups.
+*/
+#define CAP_TYPE_UID	1
+#define CAP_TYPE_GID	2
+
 
 /**
  ** POSIX-draft defined capabilities. 
@@ -350,6 +363,7 @@ static inline kernel_cap_t cap_invert(ke
 #define cap_clear(c)         do { cap_t(c) =  0; } while(0)
 #define cap_set_full(c)      do { cap_t(c) = ~0; } while(0)
 #define cap_mask(c,mask)     do { cap_t(c) &= cap_t(mask); } while(0)
+#define cap_dup(c, d)        do { cap_t(d) = cap_t(c); } while(0)
 
 #define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
 
===== include/linux/sched.h 1.291 vs edited =====
--- 1.291/include/linux/sched.h	2005-01-12 01:42:57 +01:00
+++ edited/include/linux/sched.h	2005-01-22 00:11:39 +01:00
@@ -380,6 +380,7 @@ struct user_struct {
 	/* Hash table maintenance information */
 	struct list_head uidhash_list;
 	uid_t uid;
+	kernel_cap_t cap_effective, cap_permitted, cap_inheritable;
 };
 
 extern struct user_struct *find_user(uid_t);
@@ -497,6 +498,7 @@ struct group_info {
 	gid_t small_block[NGROUPS_SMALL];
 	int nblocks;
 	gid_t *blocks[0];
+	kernel_cap_t cap_effective, cap_permitted, cap_inheritable;
 };
 
 /*
@@ -901,6 +903,11 @@ extern int capable(int cap);
 static inline int capable(int cap)
 {
 	if (cap_raised(current->cap_effective, cap)) {
+		current->flags |= PF_SUPERPRIV;
+		return 1;
+	}
+
+	if (cap_raised(current->user->cap_effective, cap)) {
 		current->flags |= PF_SUPERPRIV;
 		return 1;
 	}
===== include/linux/syscalls.h 1.18 vs edited =====
--- 1.18/include/linux/syscalls.h	2005-01-05 03:48:14 +01:00
+++ edited/include/linux/syscalls.h	2005-01-22 02:06:34 +01:00
@@ -506,4 +506,8 @@ asmlinkage long sys_request_key(const ch
 asmlinkage long sys_keyctl(int cmd, unsigned long arg2, unsigned long arg3,
 			   unsigned long arg4, unsigned long arg5);
 
+asmlinkage int sys_id_capset(int type, cap_id_header_t header, const cap_user_data_t dataptr);
+asmlinkage int sys_id_capget(int type, cap_id_header_t header, cap_user_data_t dataptr);
+	
+
 #endif
===== kernel/capability.c 1.16 vs edited =====
--- 1.16/kernel/capability.c	2005-01-08 06:44:13 +01:00
+++ edited/kernel/capability.c	2005-01-22 02:24:07 +01:00
@@ -218,3 +218,132 @@ out:
 
      return ret;
 }
+
+/*
+ * sys_id_capget - get the capabilities of a given uid/gid
+ */
+asmlinkage int sys_id_capget(int type, cap_id_header_t header, cap_user_data_t dataptr)
+{
+	int ret = 0;
+	__u32 version;
+	gid_t gid;
+	struct __user_cap_data_struct data;
+
+	if (get_user(version, &header->version))
+		return -EFAULT;
+
+	if (version != _LINUX_CAPABILITY_VERSION) {
+		if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
+			return -EFAULT; 
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case CAP_TYPE_UID:
+	{
+		uid_t uid;
+		struct user_struct *user;
+		
+		if (get_user(uid, &header->uid))
+			return -EFAULT;
+
+		if (uid < 0)
+			return -EINVAL;
+
+		user = find_user(uid);
+		if (!user)
+			return -EINVAL;
+	
+		spin_lock(&task_capability_lock);
+		cap_dup(user->cap_effective, data.effective);
+		cap_dup(user->cap_permitted, data.permitted);
+		cap_dup(user->cap_inheritable, data.inheritable);
+		spin_unlock(&task_capability_lock);
+	
+		free_uid(user);
+		break;
+	}
+	case CAP_TYPE_GID:
+	{
+		if (get_user(gid, &header->gid))
+			return -EFAULT;
+
+		if (gid < 0)
+			return -EINVAL;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	/* security_id_capget() ... */
+	
+	if (copy_to_user(dataptr, &data, sizeof(data)))
+		return -EFAULT; 
+		
+	return ret;
+}
+
+/*
+ * sys_id_capset - set the capabilities of a given uid/gid
+ */
+asmlinkage int sys_id_capset(int type, cap_id_header_t header, const cap_user_data_t dataptr)
+{
+	__u32 version;
+	int ret = 0;
+	struct __user_cap_data_struct data;
+
+	if (get_user(version, &header->version))
+		return -EFAULT; 
+
+	if (version != _LINUX_CAPABILITY_VERSION) {
+		if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
+			return -EFAULT; 
+		return -EINVAL;
+	}
+	
+	if (current->uid && !capable(CAP_SETPCAP))
+		return -EPERM;
+
+	if (copy_from_user(&data, dataptr, sizeof(data)))
+		return -EFAULT;
+		
+	/* security_id_capset() ... */
+
+	switch (type) {
+	case CAP_TYPE_UID:
+	{
+		uid_t uid;
+		struct user_struct *user;
+		
+		if (get_user(uid, &header->uid))
+			return -EFAULT;
+
+		user = find_user(uid);
+		if (!user)
+			return -EINVAL;
+		
+		spin_lock(&task_capability_lock);
+		cap_dup(data.effective, user->cap_effective);
+		cap_dup(data.permitted, user->cap_permitted);
+		cap_dup(data.inheritable, user->cap_inheritable);
+		spin_unlock(&task_capability_lock);
+		
+		free_uid(user);
+		break;
+	}
+	case CAP_TYPE_GID:
+	{
+		gid_t gid;
+		struct group_info *group;
+
+		if (get_user(gid, &header->gid))
+			return -EFAULT;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+	
+	return ret;
+}
===== kernel/user.c 1.15 vs edited =====
--- 1.15/kernel/user.c	2005-01-08 06:44:13 +01:00
+++ edited/kernel/user.c	2005-01-22 00:11:42 +01:00
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/key.h>
+#include <linux/capability.h>
 
 /*
  * UID task count cache, to get fast user lookup in "alloc_uid"
@@ -122,6 +123,9 @@ struct user_struct * alloc_uid(uid_t uid
 
 		new->mq_bytes = 0;
 		new->locked_shm = 0;
+		cap_clear(new->cap_effective);
+		cap_clear(new->cap_permitted);
+		cap_clear(new->cap_inheritable);
 
 		if (alloc_uid_keyring(new) < 0) {
 			kmem_cache_free(uid_cachep, new);


