Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268979AbUIQUjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268979AbUIQUjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 16:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268981AbUIQUik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:38:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:10509 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268979AbUIQUgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:36:42 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Date: Fri, 17 Sep 2004 23:36:25 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Larry McVoy <lm@bitmover.com>, viro@parcelfarce.linux.theplanet.co.uk
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409171532.58898.vda@port.imtp.ilyichevsk.odessa.ua> <20040917133330.GR9106@holomorphy.com>
In-Reply-To: <20040917133330.GR9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409172336.25695.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Sep 17, 2004 at 03:34:59PM +0300, Denis Vlasenko wrote:
> > I have profile=2. Profiles were collected with this script:
> > ./openclose100000
> > readprofile -m System.map -r
> > ./openclose100000
> > ./openclose100000
> > ./openclose100000
> > ./openclose100000
> > readprofile -m System.map | sort -r
>
> Excellent!
>
> On Fri, Sep 17, 2004 at 03:34:59PM +0300, Denis Vlasenko wrote:
> > 2.4:
> >   2994 total                                      0.0013
> >    620 link_path_walk                             0.2892
> >    285 d_lookup                                   1.2076
> >    156 dput                                       0.4815
> >    118 kmem_cache_free                            0.7564
> >    109 system_call                                1.9464
> >    106 kmem_cache_alloc                           0.5096
> >    103 strncpy_from_user                          1.2875
>
> [...]
>
> > 2.6:
> >   3200 total                                      0.0013
> >    790 link_path_walk                             0.2759
> >    287 __d_lookup                                 1.2756
> >    277 get_empty_filp                             1.4503
> >    146 strncpy_from_user                          1.8250
> >    110 dput                                       0.3254
> >    109 system_call                                2.4773
>
> Very odd that get_empty_filp() and strncpy_from_user() should be so
> high on your profiles. They're not tremendously different between 2.4
> and 2.6. It may be the case that 2.6 makes some inappropriate choice of
> algorithms for usercopying on systems of your vintage. get_empty_filp()
> is more mysterious still.
>
> What was the relative performance of 2.4 vs. 2.6? e.g. 2.6 completed
> some percentage of the number of operations as 2.4 in the given time?

Test merely did 4x100000 open()/close() syscalls.

2.4: 2994 total -> took ~29.9 secs
2.6: 3200 total -> 32.0 secs

There is no reason to believe that link_path_walk was called more
frequently in 2.6 than in 2.4. So, it must be taking more time to execute.

These are the diffs (2.4.27-pre3, not -rc3, because I dont have rc3
handy at home):

strncpy_from_user:

--- linux-2.4.27-pre3/arch/i386/lib/usercopy.c  Fri Jun 13 17:51:29 2003
+++ linux-2.6.9-rc2.src/arch/i386/lib/usercopy.c        Mon Sep 13 22:33:12 2004
@@ -70,6 +31,7 @@ __generic_copy_from_user(void *to, const
 #define __do_strncpy_from_user(dst,src,count,res)                         \
 do {                                                                      \
        int __d0, __d1, __d2;                                              \
+       might_sleep();                                                     \
        __asm__ __volatile__(                                              \
                "       testl %1,%1\n"                                     \
                "       jz 2f\n"                                           \
@@ -116,7 +78,7 @@ do {                                                                    \
  * and returns @count.
  */
 long
-__strncpy_from_user(char *dst, const char *src, long count)
+__strncpy_from_user(char *dst, const char __user *src, long count)
 {
        long res;
        __do_strncpy_from_user(dst, src, count, res);
@@ -142,7 +104,7 @@ __strncpy_from_user(char *dst, const cha
  * and returns @count.
  */
 long
-strncpy_from_user(char *dst, const char *src, long count)
+strncpy_from_user(char *dst, const char __user *src, long count)
 {
        long res = -EFAULT;
        if (access_ok(VERIFY_READ, src, 1))
@@ -158,6 +120,7 @@ strncpy_from_user(char *dst, const char
 #define __do_clear_user(addr,size)                                     \
 do {                                                                   \
        int __d0;                                                       \
+       might_sleep();                                                  \
        __asm__ __volatile__(                                           \
                "0:     rep; stosl\n"                                   \
                "       movl %2,%0\n"                                   \

Aha! Maybe it's just a might_sleep() overhead?


link_path_walk:

--- linux-2.4.27-pre3/fs/namei.c	Mon Aug 25 14:44:43 2003
+++ linux-2.6.9-rc2.src/fs/namei.c	Mon Sep 13 22:33:30 2004
@@ -447,20 +654,20 @@ static inline void follow_dotdot(struct 
  *
  * We expect 'base' to be positive and a directory.
  */
-int link_path_walk(const char * name, struct nameidata *nd)
+int fastcall link_path_walk(const char * name, struct nameidata *nd)
 {
-	struct dentry *dentry;
+	struct path next;
 	struct inode *inode;
 	int err;
 	unsigned int lookup_flags = nd->flags;
-
+	
 	while (*name=='/')
 		name++;
 	if (!*name)
 		goto return_reval;
 
 	inode = nd->dentry->d_inode;
-	if (current->link_count)
+	if (nd->depth)
 		lookup_flags = LOOKUP_FOLLOW;
 
 	/* At this point we know we have a real path component. */
@@ -469,8 +676,10 @@ int link_path_walk(const char * name, st
 		struct qstr this;
 		unsigned int c;
 
-		err = permission(inode, MAY_EXEC);
-		dentry = ERR_PTR(err);
+		err = exec_permission_lite(inode, nd);
+		if (err == -EAGAIN) { 
+			err = permission(inode, MAY_EXEC, nd);
+		}
  		if (err)
 			break;
 
@@ -504,7 +713,7 @@ int link_path_walk(const char * name, st
 			case 2:	
 				if (this.name[1] != '.')
 					break;
-				follow_dotdot(nd);
+				follow_dotdot(&nd->mnt, &nd->dentry);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
@@ -519,20 +728,16 @@ int link_path_walk(const char * name, st
 			if (err < 0)
 				break;
 		}
+		nd->flags |= LOOKUP_CONTINUE;
 		/* This does the actual lookups.. */
-		dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
-		if (!dentry) {
-			dentry = real_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
-			err = PTR_ERR(dentry);
-			if (IS_ERR(dentry))
-				break;
-		}
+		err = do_lookup(nd, &this, &next);
+		if (err)
+			break;
 		/* Check mountpoints.. */
-		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
-			;
+		follow_mount(&next.mnt, &next.dentry);
 
 		err = -ENOENT;
-		inode = dentry->d_inode;
+		inode = next.dentry->d_inode;
 		if (!inode)
 			goto out_dput;
 		err = -ENOTDIR; 
@@ -540,8 +745,10 @@ int link_path_walk(const char * name, st
 			goto out_dput;
 
 		if (inode->i_op->follow_link) {
-			err = do_follow_link(dentry, nd);
-			dput(dentry);
+			mntget(next.mnt);
+			err = do_follow_link(next.dentry, nd);
+			dput(next.dentry);
+			mntput(next.mnt);
 			if (err)
 				goto return_err;
 			err = -ENOENT;
@@ -553,7 +760,8 @@ int link_path_walk(const char * name, st
 				break;
 		} else {
 			dput(nd->dentry);
-			nd->dentry = dentry;
+			nd->mnt = next.mnt;
+			nd->dentry = next.dentry;
 		}
 		err = -ENOTDIR; 
 		if (!inode->i_op->lookup)
@@ -564,6 +772,7 @@ int link_path_walk(const char * name, st
 last_with_slashes:
 		lookup_flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 last_component:
+		nd->flags &= ~LOOKUP_CONTINUE;
 		if (lookup_flags & LOOKUP_PARENT)
 			goto lookup_parent;
 		if (this.name[0] == '.') switch (this.len) {
@@ -572,7 +781,7 @@ last_component:
 			case 2:	
 				if (this.name[1] != '.')
 					break;
-				follow_dotdot(nd);
+				follow_dotdot(&nd->mnt, &nd->dentry);
 				inode = nd->dentry->d_inode;
 				/* fallthrough */
 			case 1:
@@ -583,41 +792,34 @@ last_component:
 			if (err < 0)
 				break;
 		}
-		dentry = cached_lookup(nd->dentry, &this, 0);
-		if (!dentry) {
-			dentry = real_lookup(nd->dentry, &this, 0);
-			err = PTR_ERR(dentry);
-			if (IS_ERR(dentry))
-				break;
-		}
-		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
-			;
-		inode = dentry->d_inode;
+		err = do_lookup(nd, &this, &next);
+		if (err)
+			break;
+		follow_mount(&next.mnt, &next.dentry);
+		inode = next.dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
-			err = do_follow_link(dentry, nd);
-			dput(dentry);
+			mntget(next.mnt);
+			err = do_follow_link(next.dentry, nd);
+			dput(next.dentry);
+			mntput(next.mnt);
 			if (err)
 				goto return_err;
 			inode = nd->dentry->d_inode;
 		} else {
 			dput(nd->dentry);
-			nd->dentry = dentry;
+			nd->mnt = next.mnt;
+			nd->dentry = next.dentry;
 		}
 		err = -ENOENT;
 		if (!inode)
-			goto no_inode;
+			break;
 		if (lookup_flags & LOOKUP_DIRECTORY) {
 			err = -ENOTDIR; 
 			if (!inode->i_op || !inode->i_op->lookup)
 				break;
 		}
 		goto return_base;
-no_inode:
-		err = -ENOENT;
-		if (lookup_flags & (LOOKUP_POSITIVE|LOOKUP_DIRECTORY))
-			break;
-		goto return_base;
 lookup_parent:
 		nd->last = this;
 		nd->last_type = LAST_NORM;
@@ -632,20 +834,19 @@ lookup_parent:
 return_reval:
 		/*
 		 * We bypassed the ordinary revalidation routines.
-		 * Check the cached dentry for staleness.
+		 * We may need to check the cached dentry for staleness.
 		 */
-		dentry = nd->dentry;
-		if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
+		if (nd->dentry && nd->dentry->d_sb &&
+		    (nd->dentry->d_sb->s_type->fs_flags & FS_REVAL_DOT)) {
 			err = -ESTALE;
-			if (!dentry->d_op->d_revalidate(dentry, 0)) {
-				d_invalidate(dentry);
+			/* Note: we do not d_invalidate() */
+			if (!nd->dentry->d_op->d_revalidate(nd->dentry, nd))
 				break;
-			}
 		}
 return_base:
 		return 0;
 out_dput:
-		dput(dentry);
+		dput(next.dentry);
 		break;
 	}
 	path_release(nd);
@@ -653,7 +854,7 @@ return_err:
 	return err;
 }


Nothing obvious stands out...
CC'ing Al, maybe he can spot something.
--
vda

