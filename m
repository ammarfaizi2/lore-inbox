Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263051AbTDFS2j (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 14:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbTDFS2j (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 14:28:39 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:27574
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263051AbTDFS2f (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 14:28:35 -0400
Message-ID: <3E90746A.2010300@redhat.com>
Date: Sun, 06 Apr 2003 11:39:38 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030406
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] new syscall: flink
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB04ADB0645C246407B04E58C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB04ADB0645C246407B04E58C
Content-Type: multipart/mixed;
 boundary="------------090707040202090203010700"

This is a multi-part message in MIME format.
--------------090707040202090203010700
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I got a couple of requests for a function which isn't support on Linux
so far.  Also not supportable, i.e., cannot be emulated at userlevel.
It has some history in other systems (QNX I think), though, and helps
with some security issues.  It really not adding much new functionality
and I hope I got it right with my "monkey see, monkey do" technique of
looking up other places doing similar things.

The syscall I mean is

  int flink (int fd, const char *newname)

Similar to link(), but the first parameter is a file decsriptor.  Using
the file descriptor helps to avoid races in some situation.  Look at
this code bit (this is constructed and just a little test case):

#include <errno.h>
#define EE(a,x) {int e = a;if (e!=x)printf("%s = %d (%m)\n", #a, errno);}
#define E(a) EE(a,0)
int
main()
{
  printf("uid = %d, euid = %d, gid = %d, egid = %d\n", getuid(),
geteuid(), getgid(), getegid());
  E(setfsuid(getuid()));
  E(setfsgid(getgid()));
  char buf[] = "aaXXXXXX";
  int fd = mkstemp (buf);
  EE(setfsuid(0),getuid());
  EE(setfsgid(0),getgid());
  E(fchown(fd,48,48));
  E(setfsuid(getuid()));
  E(setfsgid(getgid()));
  E(syscall(268,fd,"aa"));
  E(unlink(buf));
  return 0;
}

This is for a SUID/SGID root application.  A temporary file is created
carefully using the permissions of the user running the program.  If the
syscall 268 (flink) line would be

  link(buf,"aa)

instead, somebody with limited priviledges could in theory have unlinked
the temporary file and created a new one.  With flink() this isn't
possible.  And the best is: the unlink() line can be moved right below
the mkstemp() call.  This means no temporary files are around if
something goes wrong before the unlink().  (For me this is at least as
important as the security issue, it simplifies temp file handling and
reduces the number of bugs == leftover fiels).

The patch itself is very minimal.  The impact on the link() syscall is
not measurable and the extra code for sys_flink is only a few bytes.

Is this acceptable?  Shall I add more syscall definitions for platforms
!= x86 (I'd think the port maintainers want to do this themselves)?

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

--------------090707040202090203010700
Content-Type: text/plain;
 name="d-kernel-flink"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d-kernel-flink"

--- linux-2.5/arch/i386/kernel/entry.S-flink	2003-03-21 23:09:32.000000000 -0800
+++ linux-2.5/arch/i386/kernel/entry.S	2003-04-06 10:32:27.000000000 -0700
@@ -852,6 +852,7 @@ ENTRY(sys_call_table)
  	.long sys_clock_gettime		/* 265 */
  	.long sys_clock_getres
  	.long sys_clock_nanosleep
+	.long sys_flink
  
  
 nr_syscalls=(.-sys_call_table)/4
--- linux-2.5/fs/namei.c-flink	2003-04-03 10:04:03.000000000 -0800
+++ linux-2.5/fs/namei.c	2003-04-06 11:20:41.000000000 -0700
@@ -16,6 +16,7 @@
 
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/quotaops.h>
@@ -1796,10 +1797,10 @@ int vfs_link(struct dentry *old_dentry, 
  * with linux 2.0, and to avoid hard-linking to directories
  * and other special files.  --ADM
  */
-asmlinkage long sys_link(const char * oldname, const char * newname)
+static long link_common(struct vfsmount *old_mnt, struct dentry *old_dentry, const char *newname)
 {
 	struct dentry *new_dentry;
-	struct nameidata nd, old_nd;
+	struct nameidata nd;
 	int error;
 	char * to;
 
@@ -1807,32 +1808,53 @@ asmlinkage long sys_link(const char * ol
 	if (IS_ERR(to))
 		return PTR_ERR(to);
 
-	error = __user_walk(oldname, 0, &old_nd);
-	if (error)
-		goto exit;
 	error = path_lookup(to, LOOKUP_PARENT, &nd);
 	if (error)
-		goto out;
+		goto exit;
 	error = -EXDEV;
-	if (old_nd.mnt != nd.mnt)
+	if (old_mnt != nd.mnt)
 		goto out_release;
 	new_dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(new_dentry);
 	if (!IS_ERR(new_dentry)) {
-		error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
+		error = vfs_link(old_dentry, nd.dentry->d_inode, new_dentry);
 		dput(new_dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
 out_release:
 	path_release(&nd);
-out:
-	path_release(&old_nd);
 exit:
 	putname(to);
 
 	return error;
 }
 
+asmlinkage long sys_link(const char *oldname, const char *newname)
+{
+	struct nameidata old_nd;
+	int error;
+
+	error = __user_walk(oldname, 0, &old_nd);
+	if (!error) {
+		error = link_common(old_nd.mnt, old_nd.dentry, newname);
+		path_release(&old_nd);
+	}
+	return error;
+}
+
+asmlinkage long sys_flink(unsigned int fd, const char *newname)
+{
+	struct file *file;
+	int error = -EBADF;
+
+	file = fget(fd);
+	if (file) {
+		error = link_common(file->f_vfsmnt, file->f_dentry, newname);
+		fput(file);
+	}
+	return error;
+}
+
 /*
  * The worst of all namespace operations - renaming directory. "Perverted"
  * doesn't even start to describe it. Somebody in UCB had a heck of a trip...
--- linux-2.5/include/asm-i386/unistd.h-flink	2003-02-19 21:41:59.000000000 -0800
+++ linux-2.5/include/asm-i386/unistd.h	2003-04-06 10:30:08.000000000 -0700
@@ -273,8 +273,9 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_flink		268
 
-#define NR_syscalls 268
+#define NR_syscalls 269
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 

--------------090707040202090203010700--

--------------enigB04ADB0645C246407B04E58C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+kHRu2ijCOnn/RHQRAqQhAJ4xcFZctekSYSj4nl9U0oMqJ8gaiACgv+RW
j12hvCQGKCv8SSlZFZP10F4=
=z7oF
-----END PGP SIGNATURE-----

--------------enigB04ADB0645C246407B04E58C--

