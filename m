Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSFYXTx>; Tue, 25 Jun 2002 19:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316127AbSFYXTw>; Tue, 25 Jun 2002 19:19:52 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:2806 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S316088AbSFYXTt>; Tue, 25 Jun 2002 19:19:49 -0400
Date: Wed, 26 Jun 2002 00:19:45 +0100
From: Edmund GRIMLEY EVANS <edmundo@rano.org>
To: linux-kernel@vger.kernel.org
Subject: Re: lutime() for changing times of a symbolic link
Message-ID: <20020625231945.GA20548@rano.org>
References: <20020620201951.GA3853@rano.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620201951.GA3853@rano.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I asked:

> Is there any reason not to add an lutime() system call, analogously
> with chown and lchown?

There were no replies, so here's a patch for it (i386 only). I also
tried patching glibc and tar to make use of the new system call; see
http://rano.org/lutime/

A web search for lutime reveals that it is mentioned in passing in the
IEEE/POSIX standard and apparently some systems out there actually
have the function, but I don't know which.

Edmund


diff -ru linux-2.4.18/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.4.18/arch/i386/kernel/entry.S	Mon Feb 25 19:37:53 2002
+++ linux/arch/i386/kernel/entry.S	Tue Jun 25 08:46:15 2002
@@ -634,6 +634,7 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* 235 reserved for removexattr */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lremovexattr */
 	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fremovexattr */
+	.long SYMBOL_NAME(sys_lutime)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -ru linux-2.4.18/fs/open.c linux/fs/open.c
--- linux-2.4.18/fs/open.c	Fri Oct 12 21:48:42 2001
+++ linux/fs/open.c	Tue Jun 25 08:45:36 2002
@@ -229,21 +229,17 @@
  * must be owner or have write permission.
  * Else, update from *times, must be owner or super user.
  */
-asmlinkage long sys_utime(char * filename, struct utimbuf * times)
+static int utime_common(struct dentry * dentry, struct utimbuf * times)
 {
 	int error;
-	struct nameidata nd;
 	struct inode * inode;
 	struct iattr newattrs;
 
-	error = user_path_walk(filename, &nd);
-	if (error)
-		goto out;
-	inode = nd.dentry->d_inode;
+	inode = dentry->d_inode;
 
 	error = -EROFS;
 	if (IS_RDONLY(inode))
-		goto dput_and_out;
+		goto out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
@@ -252,43 +248,62 @@
 		if (!error) 
 			error = get_user(newattrs.ia_mtime, &times->modtime);
 		if (error)
-			goto dput_and_out;
+			goto out;
 
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
 		if (current->fsuid != inode->i_uid &&
 		    (error = permission(inode,MAY_WRITE)) != 0)
-			goto dput_and_out;
+			goto out;
 	}
-	error = notify_change(nd.dentry, &newattrs);
-dput_and_out:
-	path_release(&nd);
+	error = notify_change(dentry, &newattrs);
 out:
 	return error;
 }
 
+asmlinkage int sys_utime(char * filename, struct utimbuf * times)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk(filename, &nd);
+	if (!error) {
+		error = utime_common(nd.dentry, times);
+		path_release(&nd);
+	}
+	return error;
+}
+
+asmlinkage int sys_lutime(char * filename, struct utimbuf * times)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk_link(filename, &nd);
+	if (!error) {
+		error = utime_common(nd.dentry, times);
+		path_release(&nd);
+	}
+	return error;
+}
+
 #endif
 
 /* If times==NULL, set access and modification to current time,
  * must be owner or have write permission.
  * Else, update from *times, must be owner or super user.
  */
-asmlinkage long sys_utimes(char * filename, struct timeval * utimes)
+static int utimes_common(struct dentry * dentry, struct timeval * utimes)
 {
 	int error;
-	struct nameidata nd;
 	struct inode * inode;
 	struct iattr newattrs;
 
-	error = user_path_walk(filename, &nd);
-
-	if (error)
-		goto out;
-	inode = nd.dentry->d_inode;
+	inode = dentry->d_inode;
 
 	error = -EROFS;
 	if (IS_RDONLY(inode))
-		goto dput_and_out;
+		goto out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
@@ -296,18 +311,44 @@
 		struct timeval times[2];
 		error = -EFAULT;
 		if (copy_from_user(&times, utimes, sizeof(times)))
-			goto dput_and_out;
+			goto out;
 		newattrs.ia_atime = times[0].tv_sec;
 		newattrs.ia_mtime = times[1].tv_sec;
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
 		if ((error = permission(inode,MAY_WRITE)) != 0)
-			goto dput_and_out;
+			goto out;
 	}
-	error = notify_change(nd.dentry, &newattrs);
-dput_and_out:
-	path_release(&nd);
+	error = notify_change(dentry, &newattrs);
 out:
+	return error;
+}
+
+asmlinkage int sys_utimes(char * filename, struct timeval * utimes)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk(filename, &nd);
+
+	if (!error) {
+		error = utimes_common(nd.dentry, utimes);
+		path_release(&nd);
+	}
+	return error;
+}
+
+asmlinkage int sys_lutimes(char * filename, struct timeval * utimes)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk_link(filename, &nd);
+
+	if (!error) {
+		error = utimes_common(nd.dentry, utimes);
+		path_release(&nd);
+	}
 	return error;
 }
 
diff -ru linux-2.4.18/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-2.4.18/include/asm-i386/unistd.h	Mon Feb 25 19:38:12 2002
+++ linux/include/asm-i386/unistd.h	Tue Jun 25 08:45:36 2002
@@ -242,6 +242,7 @@
 #define __NR_removexattr	235
 #define __NR_lremovexattr	236
 #define __NR_fremovexattr	237
+#define __NR_lutime		238
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
