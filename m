Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273769AbRIQXvw>; Mon, 17 Sep 2001 19:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273770AbRIQXvm>; Mon, 17 Sep 2001 19:51:42 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:14056 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S273768AbRIQXv3>;
	Mon, 17 Sep 2001 19:51:29 -0400
Date: Mon, 17 Sep 2001 16:51:11 -0700
Message-Id: <200109172351.QAA29928@napali.hpl.hp.com>
From: David Mosberger <davidm@hpl.hp.com>
To: viro@math.psu.edu, torvalds@transmeta.com, linux@arm.linux.org.uk,
        ralf@gnu.ai.mit.edu
cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: __emul_prefix() problem
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been toying with __emul_prefix() on ia64 linux as a means to
deal with x86 programs that use absolute paths when loading shared
objects (such as PAM or the GTK themes).  This works quite well, but
it breaks the traditional UNIX way of translating a relative path
into an absolute path.  The OpenOffice installer does this, for
example.  What happens precisely is that the installer attempts to
create an absolute path by stat()ing "/." and then walking the parent
directory chain until it finds the directory entry with a matching
i-node number.  This doesn't work because if an x86 binary stat()s
this path, it will get the i-node number of /emul/ia32-linux/ (in the
ia64 linux case) and things quickly go downhill from there.

I'm not sure there is a clean fix to this, but one proposal is
attached below: it causes __emul_lookup_dentry() to ignore the
alternate root for paths that resolve to a directory.  This obviously
could create other problems, but I suspect there is no solution that
works 100% in all cases (the fundamental being that we now have two
different root nodes...).

Comments?

	--david

PS: I cc'd all the platform maintainers that use a non-NULL
    emul_prefix, except for Dave Miller who in private mail indicated
    that he doesn't care about this problem

--- fs/namei.c~	Sat Jul 21 20:20:40 2001
+++ fs/namei.c	Mon Sep 17 15:10:20 2001
@@ -604,10 +604,14 @@
 static int __emul_lookup_dentry(const char *name, struct nameidata *nd)
 {
 	if (path_walk(name, nd))
-		return 0;
+		return 0;		/* something went wrong... */
 
-	if (!nd->dentry->d_inode) {
+	if (!nd->dentry->d_inode || S_ISDIR(nd->dentry->d_inode->i_mode)) {
 		struct nameidata nd_root;
+		/*
+		 * NAME was not found in alternate root or it's a directory.  Try to find
+		 * it in the normal root:
+		 */
 		nd_root.last_type = LAST_ROOT;
 		nd_root.flags = nd->flags;
 		read_lock(&current->fs->lock);

