Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314798AbSD2FQN>; Mon, 29 Apr 2002 01:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314799AbSD2FQM>; Mon, 29 Apr 2002 01:16:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:5364 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314798AbSD2FQK>;
	Mon, 29 Apr 2002 01:16:10 -0400
Date: Mon, 29 Apr 2002 10:49:33 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Paul Menage <pmenage@ensim.com>
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [RFC] link_path_walk cleanup
Message-ID: <20020429104933.O31039@in.ibm.com>
Reply-To: maneesh@in.ibm.com
In-Reply-To: <E171DGU-0003m7-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 02:28:26PM -0700, Paul Menage wrote:
> 
> Hi Maneesh,
> 
> The handling of '/' in path_walk() and vfs_follow_link() is broken - if
> the pathname consists entirely of  '/' characters, then lookup_parent
> returns the base immediately without setting nd->last. If there's more
> than one '/', then the check for looking up '/' won't be triggered, and
> walk_one() will be called with an undefined nd->last.
> [..]

Hi Paul,

Thanks for pointing it. The corrected patch is appended. 

Regards,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html


diff -urN linux-2.5.10/fs/namei.c linux-2.5.10-lpw/fs/namei.c
--- linux-2.5.10/fs/namei.c	Wed Apr 24 12:45:16 2002
+++ linux-2.5.10-lpw/fs/namei.c	Mon Apr 29 08:42:05 2002
@@ -442,6 +442,95 @@
 		;
 }
 
+	
+/* Big routine.. not supposed to be inlined but stack usage has to be limited
+ * no other choice
+ */
+static inline int walk_one(struct nameidata *nd)
+{
+	int err = 0;
+	struct dentry * dentry;
+	struct inode * inode;
+	
+	/*
+	 * "." and ".." are special - ".." especially so because it has
+	 * to be able to know about the current root directory and
+	 * parent relationships.
+	 */
+	if (nd->last.name[0] == '.') switch (nd->last.len) {
+		default:
+			break;
+		case 2:	
+			if (nd->last.name[1] != '.')
+				break;
+			follow_dotdot(nd);
+			inode = nd->dentry->d_inode;
+			/* fallthrough */
+		case 1:
+			return 0;
+	}
+	/*
+	 * See if the low-level filesystem might want
+	 * to use its own hash..
+	 */
+	if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
+		err = nd->dentry->d_op->d_hash(nd->dentry, &nd->last);
+		if (err < 0) 
+			goto out_path_release;
+	}
+
+	/* This does the actual lookups.. */
+	dentry = cached_lookup(nd->dentry, &nd->last, 
+			(nd->flags & LOOKUP_LAST) ? 0 : LOOKUP_CONTINUE);
+	if (!dentry) {
+		dentry = real_lookup(nd->dentry, &nd->last, 
+			    (nd->flags & LOOKUP_LAST) ? 0 : LOOKUP_CONTINUE);
+		err = PTR_ERR(dentry);
+		if (IS_ERR(dentry)) 
+			goto out_path_release;
+	}
+	/* Check mountpoints.. */
+	while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
+		;
+
+	inode = dentry->d_inode;
+	if ((nd->flags & LOOKUP_LAST) && !(nd->flags & LOOKUP_FOLLOW)) {
+		dput(nd->dentry);
+		nd->dentry = dentry;
+		goto do_not_follow;
+	}
+
+	if (inode && inode->i_op && inode->i_op->follow_link) {
+		err = do_follow_link(dentry, nd);
+		dput(dentry);
+		if (err)
+			return err;
+		inode = nd->dentry->d_inode;
+	} else {
+		dput(nd->dentry);
+		nd->dentry = dentry;
+	}
+
+do_not_follow:
+	err = -ENOENT;
+	if (!inode) 
+		goto out_path_release;
+
+	if ((nd->flags & LOOKUP_LAST) && !(nd->flags & LOOKUP_DIRECTORY))
+			return 0;
+
+	err = -ENOTDIR; 
+	if (!inode->i_op || !inode->i_op->lookup) 
+		goto out_path_release;
+
+	return 0;
+
+out_path_release:
+	path_release(nd);
+
+	return err;
+}
+
 /*
  * Name resolution.
  *
@@ -450,21 +539,22 @@
  *
  * We expect 'base' to be positive and a directory.
  */
-int link_path_walk(const char * name, struct nameidata *nd)
+int lookup_parent(const char * name, struct nameidata *nd)
 {
 	struct dentry *dentry;
 	struct inode *inode;
-	int err;
-	unsigned int lookup_flags = nd->flags;
+	int err = 0;
 
 	while (*name=='/')
 		name++;
-	if (!*name)
+	if (!*name) {
+		nd->last = (struct qstr) { name : ".", len : 1, hash : 0 };
 		goto return_base;
+	}
 
 	inode = nd->dentry->d_inode;
 	if (current->link_count)
-		lookup_flags = LOOKUP_FOLLOW;
+		nd->flags = LOOKUP_FOLLOW;
 
 	/* At this point we know we have a real path component. */
 	for(;;) {
@@ -488,7 +578,8 @@
 		} while (c && (c != '/'));
 		this.len = name - (const char *) this.name;
 		this.hash = end_name_hash(hash);
-
+		
+		nd->last = this;
 		/* remove trailing slashes? */
 		if (!c)
 			goto last_component;
@@ -496,150 +587,49 @@
 		if (!*name)
 			goto last_with_slashes;
 
-		/*
-		 * "." and ".." are special - ".." especially so because it has
-		 * to be able to know about the current root directory and
-		 * parent relationships.
-		 */
-		if (this.name[0] == '.') switch (this.len) {
-			default:
-				break;
-			case 2:	
-				if (this.name[1] != '.')
-					break;
-				follow_dotdot(nd);
-				inode = nd->dentry->d_inode;
-				/* fallthrough */
-			case 1:
-				continue;
-		}
-		/*
-		 * See if the low-level filesystem might want
-		 * to use its own hash..
-		 */
-		if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
-			err = nd->dentry->d_op->d_hash(nd->dentry, &this);
-			if (err < 0)
-				break;
-		}
-		/* This does the actual lookups.. */
-		dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
-		if (!dentry) {
-			dentry = real_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
-			err = PTR_ERR(dentry);
-			if (IS_ERR(dentry))
-				break;
-		}
-		/* Check mountpoints.. */
-		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
-			;
-
-		err = -ENOENT;
-		inode = dentry->d_inode;
-		if (!inode)
-			goto out_dput;
-		err = -ENOTDIR; 
-		if (!inode->i_op)
-			goto out_dput;
+		if ((err = walk_one(nd)) < 0)
+			return err;
 
-		if (inode->i_op->follow_link) {
-			err = do_follow_link(dentry, nd);
-			dput(dentry);
-			if (err)
-				goto return_err;
-			err = -ENOENT;
-			inode = nd->dentry->d_inode;
-			if (!inode)
-				break;
-			err = -ENOTDIR; 
-			if (!inode->i_op)
-				break;
-		} else {
-			dput(nd->dentry);
-			nd->dentry = dentry;
-		}
-		err = -ENOTDIR; 
-		if (!inode->i_op->lookup)
-			break;
-		continue;
+		inode = nd->dentry->d_inode;
+
+		continue; 
 		/* here ends the main loop */
 
 last_with_slashes:
-		lookup_flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
+		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 last_component:
-		if (lookup_flags & LOOKUP_PARENT)
-			goto lookup_parent;
-		if (this.name[0] == '.') switch (this.len) {
-			default:
-				break;
-			case 2:	
-				if (this.name[1] != '.')
-					break;
-				follow_dotdot(nd);
-				inode = nd->dentry->d_inode;
-				/* fallthrough */
-			case 1:
+		nd->flags |= LOOKUP_LAST;
+		
+		if (nd->flags & LOOKUP_PARENT) {
+		
+			/* stop at parent of the last component */
+			nd->last_type = LAST_NORM;
+			if (this.name[0] != '.')
 				goto return_base;
+			if (this.len == 1)
+				nd->last_type = LAST_DOT;
+			else if (this.len == 2 && this.name[1] == '.')
+				nd->last_type = LAST_DOTDOT;
 		}
-		if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
-			err = nd->dentry->d_op->d_hash(nd->dentry, &this);
-			if (err < 0)
-				break;
-		}
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
-		if ((lookup_flags & LOOKUP_FOLLOW)
-		    && inode && inode->i_op && inode->i_op->follow_link) {
-			err = do_follow_link(dentry, nd);
-			dput(dentry);
-			if (err)
-				goto return_err;
-			inode = nd->dentry->d_inode;
-		} else {
-			dput(nd->dentry);
-			nd->dentry = dentry;
-		}
-		err = -ENOENT;
-		if (!inode)
-			break;
-		if (lookup_flags & LOOKUP_DIRECTORY) {
-			err = -ENOTDIR; 
-			if (!inode->i_op || !inode->i_op->lookup)
-				break;
-		}
-		goto return_base;
-lookup_parent:
-		nd->last = this;
-		nd->last_type = LAST_NORM;
-		if (this.name[0] != '.')
-			goto return_base;
-		if (this.len == 1)
-			nd->last_type = LAST_DOT;
-		else if (this.len == 2 && this.name[1] == '.')
-			nd->last_type = LAST_DOTDOT;
 return_base:
 		return 0;
-out_dput:
-		dput(dentry);
-		break;
 	}
 	path_release(nd);
-return_err:
 	return err;
 }
 
 int path_walk(const char * name, struct nameidata *nd)
 {
+	int err;
+	
 	current->total_link_count = 0;
-	return link_path_walk(name, nd);
+	err = lookup_parent(name, nd);
+
+	/* handle last component if needed */
+	if (!err && !(nd->flags & LOOKUP_PARENT)) 
+		err = walk_one(nd); 
+
+	return err;
 }
 
 /* SMP-safe */
@@ -1922,7 +1912,13 @@
 			/* weird __emul_prefix() stuff did it */
 			goto out;
 	}
-	res = link_path_walk(link, nd);
+
+	res = lookup_parent(link, nd);
+
+	/* handle last component if needed */
+	if (!res && !(nd->flags & LOOKUP_PARENT))
+		res = walk_one(nd);
+
 out:
 	if (current->link_count || res || nd->last_type!=LAST_NORM)
 		return res;
diff -urN linux-2.5.10/include/linux/fs.h linux-2.5.10-lpw/include/linux/fs.h
--- linux-2.5.10/include/linux/fs.h	Fri Apr 26 17:12:19 2002
+++ linux-2.5.10-lpw/include/linux/fs.h	Fri Apr 26 16:48:48 2002
@@ -1392,6 +1392,7 @@
 #define LOOKUP_CONTINUE		(4)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
+#define LOOKUP_LAST		(64)
 /*
  * Type of the last component on LOOKUP_PARENT
  */
