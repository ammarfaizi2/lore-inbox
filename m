Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWIEV0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWIEV0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWIEV0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:26:50 -0400
Received: from nef2.ens.fr ([129.199.96.40]:28422 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751419AbWIEV0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:26:45 -0400
Date: Tue, 5 Sep 2006 23:26:43 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060905212643.GA13613@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Tue, 05 Sep 2006 23:26:43 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi.

As we all know, capabilities under Linux are currently crippled to the
point of being useless.  Attached is a patch (against 2.6.18-rc6)
which attempts to make them work in a reasonably useful way and at the
same time not break anything.  On top of the "additional" capabilities
that lead up to root, it also adds "regular" capabilities which all
processes have by default and which can be removed from specifically
untrusted programs.

All the gory details as to what it does are explained on this page:
<URL: http://www.madore.org/~david/linux/newcaps/newcaps.html >

In short: currently (i.e., prior to applying this patch), Linux has
capabilities, but they are (deliberately) crippled, and thus,
essentially useless, because nobody could agree on coherent semantics
for them; this patch uncripples them and attempts to give them
reasonable semantics that will, hopefully, neither break legacy Unix
programs nor those that use the current capabilies system
(essentially, Bind9); basically, capabilities are currently useless
because they are never inheritable (=preserved across execve()) and
this patch makes them so (but carefully enough so as not to confuse
existing programs).  Furthermore, whereas the current Linux
capabilities are only "additional" capabilities (meaning that normal,
non-root, processes, have none, and adding capabilities leads up to
root), the patch also suggests (and, to some extent, implements) a new
bunch of "regular" capabilites, which are present on all normal
processes and can be removed so as to provide some measure of
fault-containment for partially untrusted or potentially buggy
programs (thus, these new capabilities can be said to lead down).

Note: Although I believe that this patch will not break anything, it
is still little tested and should be considered alpha quality: it
should on no account be applied on security-critical systems or on a
system were local users are not to be trusted: the security
implications are quite complex and I could quite possibly be wrong in
thinking that it doesn't open any local root hole.

I'd be glad if some people could review this and check my reasoning
attempting to prove that it won't open any security holes (or, on the
contrary, exhibit some).

I'd also be glad if someone had a test suite that could be used to
check that traditional Unix behavior isn't broken after applying the
patch.

Comments are welcome,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="caps-0.3.1-linux-2.6.18-rc6.patch"

diff --git a/fs/exec.c b/fs/exec.c
index 54135df..1cb5e34 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -925,10 +925,13 @@ int prepare_binprm(struct linux_binprm *
 
 	bprm->e_uid = current->euid;
 	bprm->e_gid = current->egid;
+	bprm->is_suid = 0;
+	bprm->is_sgid = 0;
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
-		if (mode & S_ISUID) {
+		if (mode & S_ISUID && capable(CAP_REG_SXID)) {
+			bprm->is_suid = 1;
 			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_uid = inode->i_uid;
 		}
@@ -939,7 +942,9 @@ int prepare_binprm(struct linux_binprm *
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)
+		    && capable(CAP_REG_SXID)) {
+			bprm->is_sgid = 1;
 			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_gid = inode->i_gid;
 		}
@@ -1133,6 +1138,8 @@ int do_execve(char * filename,
 	int retval;
 	int i;
 
+	if (!capable(CAP_REG_EXEC))
+		return -EPERM;
 	retval = -ENOMEM;
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
 	if (!bprm)
diff --git a/fs/open.c b/fs/open.c
index 303f06d..3d1fc1c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1104,7 +1104,10 @@ asmlinkage long sys_open(const char __us
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
 
-	ret = do_sys_open(AT_FDCWD, filename, flags, mode);
+	if (capable(CAP_REG_OPEN))
+		ret = do_sys_open(AT_FDCWD, filename, flags, mode);
+	else
+		ret = -EPERM;
 	/* avoid REGPARM breakage on x86: */
 	prevent_tail_call(ret);
 	return ret;
@@ -1119,7 +1122,10 @@ asmlinkage long sys_openat(int dfd, cons
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
 
-	ret = do_sys_open(dfd, filename, flags, mode);
+	if (capable(CAP_REG_OPEN))
+		ret = do_sys_open(dfd, filename, flags, mode);
+	else
+		ret = -EPERM;
 	/* avoid REGPARM breakage on x86: */
 	prevent_tail_call(ret);
 	return ret;
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
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index c1e82c5..c7fb183 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -29,6 +29,7 @@ struct linux_binprm{
 	struct file * file;
 	int e_uid, e_gid;
 	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
+	char is_suid, is_sgid;
 	void *security;
 	int argc, envc;
 	char * filename;	/* Name of binary as seen by procps */
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 6548b35..b3a3b27 100644
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
   
@@ -288,6 +295,23 @@ #define CAP_AUDIT_WRITE      29
 
 #define CAP_AUDIT_CONTROL    30
 
+
+/**
+ ** Regular capabilities (normally possessed by all processes).
+ **/
+
+/* Can fork() */
+#define CAP_REG_FORK         32
+
+/* Can open() */
+#define CAP_REG_OPEN         33
+
+/* Can exec() */
+#define CAP_REG_EXEC         34
+
+/* Might gain permissions on exec() */
+#define CAP_REG_SXID         35
+
 #ifdef __KERNEL__
 /* 
  * Bounding set
@@ -310,12 +334,13 @@ #define cap_t(x) (x)
 
 #endif
 
-#define CAP_EMPTY_SET       to_cap_t(0)
-#define CAP_FULL_SET        to_cap_t(~0)
-#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
-#define CAP_INIT_INH_SET    to_cap_t(0)
+#define CAP_EMPTY_SET       to_cap_t(0ULL)
+#define CAP_FULL_SET        to_cap_t(~0ULL)
+#define CAP_REGULAR_SET     to_cap_t(0xffffffff00000000ULL)
+#define CAP_INIT_EFF_SET    to_cap_t(~0ULL)
+#define CAP_INIT_INH_SET    to_cap_t(~0ULL)
 
-#define CAP_TO_MASK(x) (1 << (x))
+#define CAP_TO_MASK(x) (1ULL << (x))
 #define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))
 #define cap_lower(c, flag)   (cap_t(c) &= ~CAP_TO_MASK(flag))
 #define cap_raised(c, flag)  (cap_t(c) & CAP_TO_MASK(flag))
@@ -351,8 +376,8 @@ static inline kernel_cap_t cap_invert(ke
 #define cap_isclear(c)       (!cap_t(c))
 #define cap_issubset(a,set)  (!(cap_t(a) & ~cap_t(set)))
 
-#define cap_clear(c)         do { cap_t(c) =  0; } while(0)
-#define cap_set_full(c)      do { cap_t(c) = ~0; } while(0)
+#define cap_clear(c)         do { cap_t(c) =  0ULL; } while(0)
+#define cap_set_full(c)      do { cap_t(c) = ~0ULL; } while(0)
 #define cap_mask(c,mask)     do { cap_t(c) &= cap_t(mask); } while(0)
 
 #define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
diff --git a/kernel/capability.c b/kernel/capability.c
index c7685ad..c090570 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -15,7 +15,7 @@ #include <linux/syscalls.h>
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
-kernel_cap_t cap_bset = CAP_INIT_EFF_SET;
+kernel_cap_t cap_bset = CAP_INIT_INH_SET;
 
 EXPORT_SYMBOL(securebits);
 EXPORT_SYMBOL(cap_bset);
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
@@ -191,10 +203,23 @@ asmlinkage long sys_capset(cap_user_head
      if (pid && pid != current->pid && !capable(CAP_SETPCAP))
              return -EPERM;
 
-     if (copy_from_user(&effective, &data->effective, sizeof(effective)) ||
-	 copy_from_user(&inheritable, &data->inheritable, sizeof(inheritable)) ||
-	 copy_from_user(&permitted, &data->permitted, sizeof(permitted)))
-	     return -EFAULT; 
+     if (version == _LINUX_CAPABILITY_OLD_VERSION) {
+	     const cap_user_data_old_t data2 = (void *)data;
+	     __u32 w;
+	     if (copy_from_user(&w, &data2->effective, sizeof(w)))
+		     return -EFAULT;
+	     effective = (__u64)w | 0xffffffff00000000ULL;
+	     if (copy_from_user(&w, &data2->inheritable, sizeof(w)))
+		     return -EFAULT;
+	     inheritable = (__u64)w | 0xffffffff00000000ULL;
+	     if (copy_from_user(&w, &data2->permitted, sizeof(w)))
+		     return -EFAULT;
+	     permitted = (__u64)w | 0xffffffff00000000ULL;
+     } else
+	     if (copy_from_user(&effective, &data->effective, sizeof(effective)) ||
+		 copy_from_user(&inheritable, &data->inheritable, sizeof(inheritable)) ||
+		 copy_from_user(&permitted, &data->permitted, sizeof(permitted)))
+		     return -EFAULT; 
 
      spin_lock(&task_capability_lock);
      read_lock(&tasklist_lock);
diff --git a/kernel/fork.c b/kernel/fork.c
index f9b014e..20f559f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1347,6 +1347,8 @@ long do_fork(unsigned long clone_flags,
 	struct pid *pid = alloc_pid();
 	long nr;
 
+	if (!capable(CAP_REG_FORK))
+		return -EPERM;
 	if (!pid)
 		return -EAGAIN;
 	nr = pid->nr;
diff --git a/security/commoncap.c b/security/commoncap.c
index f50fc29..39596b4 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -97,6 +97,8 @@ int cap_capset_check (struct task_struct
 	if (!cap_issubset (*effective, *permitted)) {
 		return -EPERM;
 	}
+	/* we allow Inheritable not to be a subset of Permitted:
+	 * cap_capset_set will intersect them anyway */
 
 	return 0;
 }
@@ -105,7 +107,7 @@ void cap_capset_set (struct task_struct 
 		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	target->cap_effective = *effective;
-	target->cap_inheritable = *inheritable;
+	target->cap_inheritable = cap_intersect (*effective, *inheritable);
 	target->cap_permitted = *permitted;
 }
 
@@ -114,25 +116,20 @@ int cap_bprm_set_security (struct linux_
 	/* Copied from fs/exec.c:prepare_binprm. */
 
 	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
+	cap_set_full (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
+	cap_set_full (bprm->cap_effective);
 
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
 	 *  capability sets for the file.
-	 *
-	 *  If only the real uid is 0, we only raise the inheritable
-	 *  and permitted sets of the executable file.
 	 */
-
 	if (!issecure (SECURE_NOROOT)) {
-		if (bprm->e_uid == 0 || current->uid == 0) {
+		if (bprm->is_suid && bprm->e_uid == 0) {
 			cap_set_full (bprm->cap_inheritable);
 			cap_set_full (bprm->cap_permitted);
-		}
-		if (bprm->e_uid == 0)
 			cap_set_full (bprm->cap_effective);
+		}
 	}
 	return 0;
 }
@@ -140,13 +137,25 @@ int cap_bprm_set_security (struct linux_
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
 {
 	/* Derived from fs/exec.c:compute_creds. */
-	kernel_cap_t new_permitted, working;
+	kernel_cap_t new_permitted, new_effective, working;
+	uid_t old_ruid, old_euid, old_suid;
 
+	/* P'(per) = (P(inh) & F(inh)) | (F(per) & bset) */
 	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
 	working = cap_intersect (bprm->cap_inheritable,
 				 current->cap_inheritable);
 	new_permitted = cap_combine (new_permitted, working);
 
+	/* P'(eff) = (P(inh) & P(eff) & F(inh)) | (F(per) & F(eff) & bset) */
+	new_effective = cap_intersect (bprm->cap_permitted, bprm->cap_effective);
+	new_effective = cap_intersect (new_effective, cap_bset);
+	working = cap_intersect (bprm->cap_inheritable,
+				 current->cap_effective);
+	working = cap_intersect (working, current->cap_inheritable);
+	new_effective = cap_combine (new_effective, working);
+
+	/* P'(inh) = P'(per) */
+
 	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
 	    !cap_issubset (new_permitted, current->cap_permitted)) {
 		current->mm->dumpable = suid_dumpable;
@@ -159,25 +168,27 @@ void cap_bprm_apply_creds (struct linux_
 			if (!capable (CAP_SETPCAP)) {
 				new_permitted = cap_intersect (new_permitted,
 							current->cap_permitted);
+				new_effective = cap_intersect (new_permitted,
+							       new_effective);
 			}
 		}
 	}
 
+	old_ruid = current->uid;
+	old_euid = current->euid;
+	old_suid = current->suid;
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
 
-	/* For init, we want to retain the capabilities set
-	 * in the init_task struct. Thus we skip the usual
-	 * capability rules */
-	if (current->pid != 1) {
-		current->cap_permitted = new_permitted;
-		current->cap_effective =
-		    cap_intersect (new_permitted, bprm->cap_effective);
-	}
-
-	/* AUD: Audit candidate if current->cap_effective is set */
+	current->cap_permitted = new_permitted;
+	current->cap_effective = new_effective;
+	current->cap_inheritable = new_permitted;
 
 	current->keep_capabilities = 0;
+	/* Make sure we drop capabilities if required by suid. */
+	cap_task_post_setuid (old_ruid, old_euid, old_suid, LSM_SETID_RES);
+
+	/* AUD: Audit candidate if current->cap_effective is set */
 }
 
 int cap_bprm_secureexec (struct linux_binprm *bprm)
@@ -187,8 +198,8 @@ int cap_bprm_secureexec (struct linux_bi
 	   test between the old and new capability sets.  For now,
 	   it simply preserves the legacy decision algorithm used by
 	   the old userland. */
-	return (current->euid != current->uid ||
-		current->egid != current->gid);
+	return ((bprm->is_suid || bprm->is_sgid)
+		&& !cap_issubset (cap_bset, current->cap_permitted));
 }
 
 int cap_inode_setxattr(struct dentry *dentry, char *name, void *value,
@@ -244,15 +255,24 @@ static inline void cap_emulate_setxuid (
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
+		current->cap_inheritable
+			= cap_intersect (current->cap_inheritable,
+					 CAP_REGULAR_SET);
 	}
-	if (old_euid == 0 && current->euid != 0) {
-		cap_clear (current->cap_effective);
+	if (old_euid == 0 && current->euid != 0 && !current->keep_capabilities) {
+		current->cap_effective = cap_intersect (current->cap_effective,
+							CAP_REGULAR_SET);
 	}
-	if (old_euid != 0 && current->euid == 0) {
+	if (old_euid != 0 && current->euid == 0 && !current->keep_capabilities) {
 		current->cap_effective = current->cap_permitted;
 	}
 }
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

--bp/iNruPH9dso1Pn--
