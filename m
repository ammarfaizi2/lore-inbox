Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265149AbRFZXeT>; Tue, 26 Jun 2001 19:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265155AbRFZXeJ>; Tue, 26 Jun 2001 19:34:09 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:2960 "HELO
	mail.lysator.liu.se") by vger.kernel.org with SMTP
	id <S265149AbRFZXd4>; Tue, 26 Jun 2001 19:33:56 -0400
Date: Wed, 27 Jun 2001 01:45:34 +0200
From: Jorgen Cederlof <jc@lysator.liu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] User chroot
Message-ID: <20010627014534.B2654@ondska>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.18i
X-eric-conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Have you ever wondered why normal users are not allowed to chroot?

I have. The reasons I can figure out are:

* Changing root makes it trivial to trick suid/sgid binaries to do
  nasty things.

* If root calls chroot and changes uid, he expects that the process
  can not escape to the old root by calling chroot again.

If we only allow user chroots for processes that have never been
chrooted before, and if the suid/sgid bits won't have any effect under
the new root, it should be perfectly safe to allow any user to chroot.

Example:

user:~$ /usr/sbin/traceroute 127.1
traceroute to 127.1 (127.0.0.1), 30 hops max, 38 byte packets
 1  localhost (127.0.0.1)  6.658 ms  0.764 ms  0.613 ms
user:~$ /usr/sbin/chroot /
user:/$ /usr/sbin/traceroute 127.1
traceroute: icmp socket: Operation not permitted
user:/$ /usr/sbin/chroot /
/usr/sbin/chroot: cannot change root directory to /: Operation not permitted
user:/$ 

Is there any reason why this could not be the default behavior for the
official kernel?

             Jörgen


diff -urN -X dontdiff linux-2.4.6-pre5-vanilla/CREDITS linux-2.4.6-pre5-devel/CREDITS
--- linux-2.4.6-pre5-vanilla/CREDITS	Sat Jun 23 02:00:54 2001
+++ linux-2.4.6-pre5-devel/CREDITS	Sat Jun 23 02:04:31 2001
@@ -497,6 +497,13 @@
 S: Fremont, California 94539
 S: USA
 
+N: Jörgen Cederlöf
+E: jc@lysator.liu.se
+D: User capabilities, user chroot
+S: Rydsvägen 258 A.36
+S: 584 34 Linköping
+S: Sweden
+
 N: Gordon Chaffee
 E: chaffee@cs.berkeley.edu
 W: http://bmrc.berkeley.edu/people/chaffee/
diff -urN -X dontdiff linux-2.4.6-pre5-vanilla/fs/exec.c linux-2.4.6-pre5-devel/fs/exec.c
--- linux-2.4.6-pre5-vanilla/fs/exec.c	Thu Apr 26 23:11:29 2001
+++ linux-2.4.6-pre5-devel/fs/exec.c	Sat Jun 23 02:04:31 2001
@@ -617,7 +617,7 @@
 
 	if(!IS_NOSUID(inode)) {
 		/* Set-uid? */
-		if (mode & S_ISUID)
+		if (mode & S_ISUID && capable(CAP_EXECSUID))
 			bprm->e_uid = inode->i_uid;
 
 		/* Set-gid? */
@@ -626,14 +626,15 @@
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)
+		    && capable(CAP_EXECSGID))
 			bprm->e_gid = inode->i_gid;
 	}
 
 	/* We don't have VFS support for capabilities yet */
-	cap_clear(bprm->cap_inheritable);
+	cap_clear_set_user(bprm->cap_inheritable);
 	cap_clear(bprm->cap_permitted);
-	cap_clear(bprm->cap_effective);
+	cap_clear_set_user(bprm->cap_effective);
 
 	/*  To support inheritance of root-permissions and suid-root
          *  executables under compatibility mode, we raise all three
diff -urN -X dontdiff linux-2.4.6-pre5-vanilla/fs/open.c linux-2.4.6-pre5-devel/fs/open.c
--- linux-2.4.6-pre5-vanilla/fs/open.c	Fri Feb  9 20:29:44 2001
+++ linux-2.4.6-pre5-devel/fs/open.c	Sat Jun 23 02:04:32 2001
@@ -421,9 +421,22 @@
 		goto dput_and_out;
 
 	error = -EPERM;
-	if (!capable(CAP_SYS_CHROOT))
+	if (!capable(CAP_SYS_CHROOT) && !capable(CAP_USER_CHROOT))
 		goto dput_and_out;
 
+	if (!capable(CAP_SYS_CHROOT)) {
+		cap_lower(current->cap_effective,   CAP_EXECSUID);
+		cap_lower(current->cap_permitted,   CAP_EXECSUID);
+		cap_lower(current->cap_inheritable, CAP_EXECSUID);
+		cap_lower(current->cap_effective,   CAP_EXECSGID);
+		cap_lower(current->cap_permitted,   CAP_EXECSGID);
+		cap_lower(current->cap_inheritable, CAP_EXECSGID);
+	}
+
+	cap_lower(current->cap_effective,   CAP_USER_CHROOT);
+	cap_lower(current->cap_permitted,   CAP_USER_CHROOT);
+	cap_lower(current->cap_inheritable, CAP_USER_CHROOT);
+	
 	set_fs_root(current->fs, nd.mnt, nd.dentry);
 	set_fs_altroot();
 	error = 0;
diff -urN -X dontdiff linux-2.4.6-pre5-vanilla/include/linux/capability.h linux-2.4.6-pre5-devel/include/linux/capability.h
--- linux-2.4.6-pre5-vanilla/include/linux/capability.h	Sat May 26 03:01:28 2001
+++ linux-2.4.6-pre5-devel/include/linux/capability.h	Sat Jun 23 02:04:32 2001
@@ -3,7 +3,7 @@
  *
  * Andrew G. Morgan <morgan@transmeta.com>
  * Alexander Kjeldaas <astor@guardian.no>
- * with help from Aleph1, Roland Buresund and Andrew Main.
+ * with help from Aleph1, Roland Buresund, Andrew Main and Jörgen Cederlöf.
  *
  * See here for the libcap library ("POSIX draft" compliance):
  *
@@ -277,6 +277,36 @@
 
 #define CAP_LEASE            28
 
+
+/**
+ ** Capabilities used by normal user processes
+ **
+ ** They are handled somewhat different from other capabilities -
+ ** they are not cleared unless you drop them by hand, and using them
+ ** doesn't set PF_SUPERPRIV.
+ **/
+
+/* Allow the suid bit on executables to have effect */
+
+#define CAP_EXECSUID         29
+
+/* Allow the sgid bit on executables to have effect */
+
+#define CAP_EXECSGID         30
+
+/* Allow user chroots. This should have no negative impact on system
+   security - using it drops CAP_EXECS{U,G}ID and CAP_USER_CHROOT.
+   CAP_USER_CHROOT is also dropped if you make a normal chroot, to
+   prevent a process with changed UID from breaking out. */
+
+#define CAP_USER_CHROOT      31
+
+
+#define CAP_USER_MASK (CAP_TO_MASK( CAP_EXECSUID ) | \
+                       CAP_TO_MASK( CAP_EXECSGID ) | \
+                       CAP_TO_MASK( CAP_USER_CHROOT ) )
+
+
 #ifdef __KERNEL__
 /* 
  * Bounding set
@@ -302,7 +332,7 @@
 #define CAP_EMPTY_SET       to_cap_t(0)
 #define CAP_FULL_SET        to_cap_t(~0)
 #define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
-#define CAP_INIT_INH_SET    to_cap_t(0)
+#define CAP_INIT_INH_SET    to_cap_t(CAP_USER_MASK)
 
 #define CAP_TO_MASK(x) (1 << (x))
 #define cap_raise(c, flag)   (cap_t(c) |=  CAP_TO_MASK(flag))
@@ -337,12 +367,13 @@
      return dest;
 }
 
-#define cap_isclear(c)       (!cap_t(c))
+#define cap_isclear(c)       (!(cap_t(c) & ~CAP_USER_MASK))
 #define cap_issubset(a,set)  (!(cap_t(a) & ~cap_t(set)))
 
-#define cap_clear(c)         do { cap_t(c) =  0; } while(0)
-#define cap_set_full(c)      do { cap_t(c) = ~0; } while(0)
-#define cap_mask(c,mask)     do { cap_t(c) &= cap_t(mask); } while(0)
+#define cap_clear(c)          do { cap_t(c) &= CAP_USER_MASK; } while(0)
+#define cap_set_full(c)       do { cap_t(c) = ~0; } while(0)
+#define cap_mask(c,mask)      do { cap_t(c) &= cap_t(mask); } while(0)
+#define cap_clear_set_user(c) do { cap_t(c) = CAP_USER_MASK; } while(0)
 
 #define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
 
diff -urN -X dontdiff linux-2.4.6-pre5-vanilla/include/linux/sched.h linux-2.4.6-pre5-devel/include/linux/sched.h
--- linux-2.4.6-pre5-vanilla/include/linux/sched.h	Sat May 26 03:01:28 2001
+++ linux-2.4.6-pre5-devel/include/linux/sched.h	Sat Jun 23 02:04:32 2001
@@ -701,7 +701,8 @@
 	if (cap_is_fs_cap(cap) ? current->fsuid == 0 : current->euid == 0)
 #endif
 	{
-		current->flags |= PF_SUPERPRIV;
+		if (!(CAP_TO_MASK(cap) & CAP_USER_MASK))
+			current->flags |= PF_SUPERPRIV;
 		return 1;
 	}
 	return 0;

