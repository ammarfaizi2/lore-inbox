Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbUJ0JXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbUJ0JXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbUJ0JXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:23:30 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:38122 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S262344AbUJ0JWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:22:37 -0400
From: Tor Lillqvist <tml@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: NFS negative dentry caching problem in 2.4.21, and patch
Message-Id: <20041027092235.63D5A524@kuori.saunalahti.fi>
Date: Wed, 27 Oct 2004 12:22:35 +0300 (EEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have had a support request open for over a month at Red Hat for
this, and I even came up with a suggested patch, but Red Hat support
seems to be ignoring us. No comments from there. So what do people
here think? Yes, I realize that most gurus probably are knee-deep in
2.6 and couldn't care less about 2.4.21... but anyway, could you
please have a look?

Below is a description of the problem and a suggested patch. Note that
I have tested the patch on Red Hat's 2.4.21-20.EL only, but I don't
see why the same issue wouldn't occur also on a stock 2.4.21 (if
somebody is running such), or later. This is copy-pasted from the Red
Hat support request, so when it says "RHEL3", think "Linux 2.4.21".

Thanks in advance for any comments. 

--tml

  We have a big problem with how the NFS client code in RHEL3
  works. The problem led to a huge unexpected increase in disk usage
  for us after we moved an application from Solaris to RHEL3. We have
  now been forced to move it partially back to Solaris servers.

  The problem occurs when using a distributed application (ClearCase)
  where applications on several client machines (RHEL or Solaris) talk
  to each other using RPC and access the same files that are located on
  an NFS server. It can easily be reproduced without having ClearCase,
  though.

  The scenario is as follows: Let's say we have two NFS client machines,
  A and B. A runs RHEL3, B runs any Unix. They both mount a file system
  from an NFS server (doesn't matter what kind, we have reproduced the
  problem with EMC Celerra, NetApp and Solaris NFS servers).

  What happens is this: 

  0) Let F be a filename on the NFS file system. Initially this file
  does not exist.

  1) The application on the RHEL3 machine A does a stat() on F. The NFS
  client in the kernel sends a LOOKUP request to the NFS server, which
  obviously returns failure. The stat() fails with ENOENT. OK so far.

  2) Immediately afterwards (a few seconds max), the application on
  machine B creates the file F. No problems so far.

  3) When B is done with F, a few seconds later the application on
  machine A does an unlink() on F. Because of the negative dentry
  caching in the Linux kernel, it doesn't even bother to send an NFS
  REMOVE request to the NFS server, as (it thinks) it knows for sure the
  file doesn't exist. It lets the unlink() fail with ENOENT. But the
  file definitely exists.

  The application now thinks that the file F doesn't exist any longer,
  and loses track of it. This means ever increasing disk usage as the
  above scenario happens all the time when we run ClearCase builds for
  our (large) software.

  After we moved our view servers from Solaris to RHEL3, the disk usage
  of our ClearCase view storage doubled in a few months from 150 GB to
  close to 300 GB!  This was a mystery to us until we found that the
  view storage file system was full of stranded files that weren't
  supposed to be left there, and that the application didn't know of and
  thus couldn't clean out itself.

  (In case you wonder why the applications work like that, well, that's
  how ClearCase works. A is a view server, B is a build server where
  clearmake jobs (compilations) are run, and the file F is a
  view-private file created and removed during the clearmake run. The
  view server first checks if F exists, then B actually creates it,
  writes to it, then when it isn't needed any longer the view server is
  supposed to remove it.)

  It is very easy to demonstrate the problem without ClearCase: Just
  mount a file system from a NFS server on two RHEL3 boxes. Let's call
  the file system /data, and the machines A and B:

  on machine A: ls /data/foobar 
  ls: /data/foobar: No such file or directory 

  on machine B: touch /data/foobar 
  OK. 

  on machine A: rm /data/foobar 
  rm: cannot lstat `foobar': No such file or directory 

  But the file *does* exist. 

  A workaround is to mount the file system with acdirmin=0 and
  acdirmax=0. Then the nfs_neg_need_reval() function in fs/nfs/dir.c
  always returns true, meaning the nfs code never trusts negative
  dentries, and always does a fresh LOOKUP.  But this then affects all
  system calls, not just unlink(). And it hurts NFS performance a
  lot. Why the heck would it need to do a LOOKUP at all when unlinking a
  file is beyond me...

  It seems to me that the correct thing for the kernel to do would be to
  *always* just send a NFS REMOVE request for unlink() of NFS
  files. (Well, as long as the parent directory path is OK.) The nfs
  client code should never trust that it thinks is knows the file
  doesn't exist. It shouldn't care whether the file exists or not. Just
  tell the NFS server to remove it. At least, this should be a mount
  option. [Alas, that's not what my patch then does, see below.]

  It seems that not even the latest 2.6 kernel does this correctly. It
  does pass around intents in nameidata structs, but there doesn't seem
  to be any LOOKUP_* flag for unlink intent, just for open, create and
  access. At least that's what I understand from looking at the code, I
  haven't actually run any 2.6 kernel yet.

Then I did some debugging and came up with a patch:

  The below patch should be pretty self-evident, but anyway: 

  I add a new "LOOKUP" flag in include/linux/fs.h, LOOKUP_UNLINK. 

  I rename lookup_hash() in fs/namei.c to lookup_hash_with_intent(), and
  add a new "flags" parameter to it. This parameter is passed on to the
  cached_lookup () function instead of always passing a zero. Of course
  I still need to provide a lookup_hash() with identical prototype as
  the old one in order not to break the kernel API, so that is now then
  just a one-liner that calls lookup_hash_with_intent() with zero
  intent.

  The only place where I change a call to lookup_hash() to call
  lookup_hash_with_intent() instead is in sys_unlink(), and here
  LOOKUP_UNLINK is passed as the "flags" parameter.

  In fs/nfs/dir.c, I add a flags parameter to the nfs_neg_need_reval()
  function.  If flags has LOOKUP_UNLINK set, the function always returns
  1. The call to nfs_neg_needs_reval() from nfs_lookup_revalidate() now
  passes its flags parameter on to nfs_neg_need_reval().

  Simple, but works. I have no idea whether anything like this is
  necessary for 2.6. There isn't any LOOKUP_UNLINK intent flag there,
  although they have added LOOKUP_OPEN, LOOKUP_CREATE and LOOKUP_ACCESS
  flag bits. But the code is different anyway so it's hard to say
  whether the same issue arises there without adding debug printouts and
  tracing what happens, and I don't have time for that right now.

Here's the patch, against a stock 2.4.21:

diff -ru linux-2.4.21.orig/fs/namei.c linux-2.4.21/fs/namei.c
--- linux-2.4.21.orig/fs/namei.c	2003-06-13 17:51:37.000000000 +0300
+++ linux-2.4.21/fs/namei.c	2004-10-27 11:54:51.000000000 +0300
@@ -767,7 +767,7 @@
  * needs parent already locked. Doesn't follow mounts.
  * SMP-safe.
  */
-struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
+struct dentry * lookup_hash_with_intent(struct qstr *name, struct dentry * base, int flags)
 {
 	struct dentry * dentry;
 	struct inode *inode;
@@ -790,7 +790,7 @@
 			goto out;
 	}
 
-	dentry = cached_lookup(base, name, 0);
+	dentry = cached_lookup(base, name, flags);
 	if (!dentry) {
 		struct dentry *new = d_alloc(base, name);
 		dentry = ERR_PTR(-ENOMEM);
@@ -808,6 +808,11 @@
 	return dentry;
 }
 
+struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
+{
+  return lookup_hash_with_intent (name, base, 0);
+}
+
 /* SMP-safe */
 struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
 {
@@ -1511,7 +1516,7 @@
 	if (nd.last_type != LAST_NORM)
 		goto exit1;
 	down(&nd.dentry->d_inode->i_sem);
-	dentry = lookup_hash(&nd.last, nd.dentry);
+	dentry = lookup_hash_with_intent(&nd.last, nd.dentry, LOOKUP_UNLINK);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		/* Why not before? Because we want correct error value */
diff -ru linux-2.4.21.orig/fs/nfs/dir.c linux-2.4.21/fs/nfs/dir.c
--- linux-2.4.21.orig/fs/nfs/dir.c	2002-11-29 01:53:15.000000000 +0200
+++ linux-2.4.21/fs/nfs/dir.c	2004-10-27 11:54:51.000000000 +0300
@@ -450,13 +450,19 @@
  * We judge how long we want to trust negative
  * dentries by looking at the parent inode mtime.
  *
- * If parent mtime has changed, we revalidate, else we wait for a
- * period corresponding to the parent's attribute cache timeout value.
+ * If parent mtime has changed, we revalidate.
+ * 
+ * Else, if we are doing this as part of an unlink(), we revalidate.
+ *
+ * Else, we wait for a period corresponding to the parent's attribute
+ * cache timeout value.
  */
-static inline int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry)
+static inline int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry, int flags)
 {
 	if (!nfs_check_verifier(dir, dentry))
 		return 1;
+	if (flags & LOOKUP_UNLINK)
+		return 1;
 	return time_after(jiffies, dentry->d_time + NFS_ATTRTIMEO(dir));
 }
 
@@ -484,7 +490,7 @@
 	inode = dentry->d_inode;
 
 	if (!inode) {
-		if (nfs_neg_need_reval(dir, dentry))
+		if (nfs_neg_need_reval(dir, dentry, flags))
 			goto out_bad;
 		goto out_valid;
 	}
diff -ru linux-2.4.21.orig/include/linux/fs.h linux-2.4.21/include/linux/fs.h
--- linux-2.4.21.orig/include/linux/fs.h	2003-06-13 17:51:38.000000000 +0300
+++ linux-2.4.21/include/linux/fs.h	2004-10-27 11:55:43.000000000 +0300
@@ -1333,6 +1333,9 @@
 #define LOOKUP_POSITIVE		(8)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
+
+#define LOOKUP_UNLINK		(0x800)
+
 /*
  * Type of the last component on LOOKUP_PARENT
  */


