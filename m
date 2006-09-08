Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWIHSWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWIHSWJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWIHSWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:22:04 -0400
Received: from nef2.ens.fr ([129.199.96.40]:25358 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751087AbWIHSV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:21:59 -0400
Date: Fri, 8 Sep 2006 20:21:57 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: [PATCH 1/4] security: capabilities patch (version 0.4.3), part 1/4: enlarge capability sets
Message-ID: <20060908182157.GA2659@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 08 Sep 2006 20:21:57 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Increase the size of capability sets to 64 bits:

 * bits 32-47 are "regular", i.e., present by default on non-root
   processes;

 * maintain compatibility with former kernel interface for capset()
   and capget().

See <URL: http://www.madore.org/~david/linux/newcaps/ > for more
detailed explanations.

Signed-off-by: David A. Madore <david.madore@ens.fr>

---
 fs/open.c                  |    3 ++-
 fs/proc/array.c            |    6 +++---
 include/linux/capability.h |   30 ++++++++++++++++++-----------
 kernel/capability.c        |   46 +++++++++++++++++++++++++++++++++++---------
 security/commoncap.c       |   16 +++++++++++----
 security/dummy.c           |    6 +++---
 6 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 303f06d..e58a525 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -515,7 +515,8 @@ asmlinkage long sys_faccessat(int dfd, c
 	 * but we cannot because user_path_walk can sleep.
 	 */
 	if (current->uid)
-		cap_clear(current->cap_effective);
+		current->cap_effective = cap_intersect(current->cap_effective,
+						       CAP_REGULAR_SET);
 	else
 		current->cap_effective = current->cap_permitted;
 
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 0b615d6..6724fc2 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -285,9 +285,9 @@ static inline char * task_sig(struct tas
 
 static inline char *task_cap(struct task_struct *p, char *buffer)
 {
-    return buffer + sprintf(buffer, "CapInh:\t%016x\n"
-			    "CapPrm:\t%016x\n"
-			    "CapEff:\t%016x\n",
+    return buffer + sprintf(buffer, "CapInh:\t%016llx\n"
+			    "CapPrm:\t%016llx\n"
+			    "CapEff:\t%016llx\n",
 			    cap_t(p->cap_inheritable),
 			    cap_t(p->cap_permitted),
 			    cap_t(p->cap_effective));
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 6548b35..aa00b60 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -27,7 +27,8 @@ #include <linux/compiler.h>
    library since the draft standard requires the use of malloc/free
    etc.. */
  
-#define _LINUX_CAPABILITY_VERSION  0x19980330
+#define _LINUX_CAPABILITY_VERSION  0x20060903
+#define _LINUX_CAPABILITY_OLD_VERSION  0x19980330
 
 typedef struct __user_cap_header_struct {
 	__u32 version;
@@ -35,10 +36,16 @@ typedef struct __user_cap_header_struct 
 } __user *cap_user_header_t;
  
 typedef struct __user_cap_data_struct {
+        __u64 effective;
+        __u64 permitted;
+        __u64 inheritable;
+} __user *cap_user_data_t;
+ 
+typedef struct __user_cap_data_old_struct {
         __u32 effective;
         __u32 permitted;
         __u32 inheritable;
-} __user *cap_user_data_t;
+} __user *cap_user_data_old_t;
   
 #ifdef __KERNEL__
 
@@ -50,12 +57,12 @@ #include <asm/current.h>
 #ifdef STRICT_CAP_T_TYPECHECKS
 
 typedef struct kernel_cap_struct {
-	__u32 cap;
+	__u64 cap;
 } kernel_cap_t;
 
 #else
 
-typedef __u32 kernel_cap_t;
+typedef __u64 kernel_cap_t;
 
 #endif
   
@@ -310,12 +317,13 @@ #define cap_t(x) (x)
 
 #endif
 
-#define CAP_EMPTY_SET       to_cap_t(0)
-#define CAP_FULL_SET        to_cap_t(~0)
-#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
-#define CAP_INIT_INH_SET    to_cap_t(0)
+#define CAP_EMPTY_SET       to_cap_t(0ULL)
+#define CAP_FULL_SET        to_cap_t(~0ULL)
+#define CAP_REGULAR_SET     to_cap_t(0x0000ffff00000000ULL)
+#define CAP_INIT_EFF_SET    to_cap_t(~0ULL)
+#define CAP_INIT_INH_SET    to_cap_t(~0ULL)
 
-#define CAP_TO_MASK(x) (1 << (x))
+#define CAP_TO_MASK(x) (1ULL << (x))
 #define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))
 #define cap_lower(c, flag)   (cap_t(c) &= ~CAP_TO_MASK(flag))
 #define cap_raised(c, flag)  (cap_t(c) & CAP_TO_MASK(flag))
@@ -351,8 +359,8 @@ static inline kernel_cap_t cap_invert(ke
 #define cap_isclear(c)       (!cap_t(c))
 #define cap_issubset(a,set)  (!(cap_t(a) & ~cap_t(set)))
 
-#define cap_clear(c)         do { cap_t(c) =  0; } while(0)
-#define cap_set_full(c)      do { cap_t(c) = ~0; } while(0)
+#define cap_clear(c)         do { cap_t(c) =  0ULL; } while(0)
+#define cap_set_full(c)      do { cap_t(c) = ~0ULL; } while(0)
 #define cap_mask(c,mask)     do { cap_t(c) &= cap_t(mask); } while(0)
 
 #define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
diff --git a/kernel/capability.c b/kernel/capability.c
index c7685ad..32b2521 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -52,7 +52,8 @@ asmlinkage long sys_capget(cap_user_head
      if (get_user(version, &header->version))
 	     return -EFAULT;
 
-     if (version != _LINUX_CAPABILITY_VERSION) {
+     if (version != _LINUX_CAPABILITY_VERSION
+	 && version != _LINUX_CAPABILITY_OLD_VERSION) {
 	     if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
 		     return -EFAULT; 
              return -EINVAL;
@@ -82,8 +83,18 @@ out:
      read_unlock(&tasklist_lock); 
      spin_unlock(&task_capability_lock);
 
-     if (!ret && copy_to_user(dataptr, &data, sizeof data))
-          return -EFAULT; 
+     if (!ret) {
+	     if (version == _LINUX_CAPABILITY_OLD_VERSION) {
+		     struct __user_cap_data_old_struct data_old;
+		     data_old.effective = data_old.effective & 0xffffffffULL;
+		     data_old.permitted = data_old.permitted & 0xffffffffULL;
+		     data_old.inheritable = data_old.inheritable & 0xffffffffULL;
+		     if (copy_to_user(dataptr, &data_old, sizeof data_old))
+			     return -EFAULT;
+	     } else
+		     if (copy_to_user(dataptr, &data, sizeof data))
+			     return -EFAULT;
+     }
 
      return ret;
 }
@@ -179,7 +190,8 @@ asmlinkage long sys_capset(cap_user_head
      if (get_user(version, &header->version))
 	     return -EFAULT; 
 
-     if (version != _LINUX_CAPABILITY_VERSION) {
+     if (version != _LINUX_CAPABILITY_VERSION
+	 && version != _LINUX_CAPABILITY_OLD_VERSION) {
 	     if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
 		     return -EFAULT; 
              return -EINVAL;
@@ -191,10 +203,25 @@ asmlinkage long sys_capset(cap_user_head
      if (pid && pid != current->pid && !capable(CAP_SETPCAP))
              return -EPERM;
 
-     if (copy_from_user(&effective, &data->effective, sizeof(effective)) ||
-	 copy_from_user(&inheritable, &data->inheritable, sizeof(inheritable)) ||
-	 copy_from_user(&permitted, &data->permitted, sizeof(permitted)))
-	     return -EFAULT; 
+     if (version == _LINUX_CAPABILITY_OLD_VERSION) {
+	     const cap_user_data_old_t data2 = (void *)data;
+	     __u32 w;
+	     /* Assume caller wants to keep all regular caps and clear
+	      * all unknown additional caps.  Is this right? */
+	     if (copy_from_user(&w, &data2->effective, sizeof(w)))
+		     return -EFAULT;
+	     effective = (__u64)w | CAP_REGULAR_SET;
+	     if (copy_from_user(&w, &data2->inheritable, sizeof(w)))
+		     return -EFAULT;
+	     inheritable = (__u64)w | CAP_REGULAR_SET;
+	     if (copy_from_user(&w, &data2->permitted, sizeof(w)))
+		     return -EFAULT;
+	     permitted = (__u64)w | CAP_REGULAR_SET;
+     } else
+	     if (copy_from_user(&effective, &data->effective, sizeof(effective)) ||
+		 copy_from_user(&inheritable, &data->inheritable, sizeof(inheritable)) ||
+		 copy_from_user(&permitted, &data->permitted, sizeof(permitted)))
+		     return -EFAULT; 
 
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock);
@@ -237,7 +264,8 @@ out:
 int __capable(struct task_struct *t, int cap)
 {
 	if (security_capable(t, cap) == 0) {
-		t->flags |= PF_SUPERPRIV;
+		if (!cap_raised(CAP_REGULAR_SET, cap))
+			t->flags |= PF_SUPERPRIV;
 		return 1;
 	}
 	return 0;
diff --git a/security/commoncap.c b/security/commoncap.c
index f50fc29..91dc53d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -244,13 +244,19 @@ static inline void cap_emulate_setxuid (
 					int old_suid)
 {
 	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
-	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
-	    !current->keep_capabilities) {
-		cap_clear (current->cap_permitted);
-		cap_clear (current->cap_effective);
+	    (current->uid != 0 && current->euid != 0 && current->suid != 0)) {
+		if (!current->keep_capabilities) {
+			current->cap_permitted
+				= cap_intersect (current->cap_permitted,
+						 CAP_REGULAR_SET);
+			current->cap_effective
+				= cap_intersect (current->cap_effective,
+						 CAP_REGULAR_SET);
+		}
 	}
 	if (old_euid == 0 && current->euid != 0) {
-		cap_clear (current->cap_effective);
+		current->cap_effective = cap_intersect (current->cap_effective,
+							CAP_REGULAR_SET);
 	}
 	if (old_euid != 0 && current->euid == 0) {
 		current->cap_effective = current->cap_permitted;
diff --git a/security/dummy.c b/security/dummy.c
index 58c6d39..572a15b 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -37,11 +37,11 @@ static int dummy_ptrace (struct task_str
 static int dummy_capget (struct task_struct *target, kernel_cap_t * effective,
 			 kernel_cap_t * inheritable, kernel_cap_t * permitted)
 {
-	*effective = *inheritable = *permitted = 0;
+	*effective = *inheritable = *permitted = CAP_REGULAR_SET;
 	if (!issecure(SECURE_NOROOT)) {
 		if (target->euid == 0) {
-			*permitted |= (~0 & ~CAP_FS_MASK);
-			*effective |= (~0 & ~CAP_TO_MASK(CAP_SETPCAP) & ~CAP_FS_MASK);
+			*permitted |= (CAP_FULL_SET & ~CAP_FS_MASK);
+			*effective |= (CAP_FULL_SET & ~CAP_TO_MASK(CAP_SETPCAP) & ~CAP_FS_MASK);
 		}
 		if (target->fsuid == 0) {
 			*permitted |= CAP_FS_MASK;
