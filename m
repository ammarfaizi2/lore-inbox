Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269633AbRHCWBR>; Fri, 3 Aug 2001 18:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269637AbRHCWBJ>; Fri, 3 Aug 2001 18:01:09 -0400
Received: from weta.f00f.org ([203.167.249.89]:912 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269633AbRHCWBB>;
	Fri, 3 Aug 2001 18:01:01 -0400
Date: Sat, 4 Aug 2001 10:01:43 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Chris Mason <mason@suse.com>
Subject: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804100143.A17774@weta.f00f.org>
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <9keqr6$egl$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 03, 2001 at 06:34:14PM +0000, Linus Torvalds wrote:

    	fsync(int fd)
    	{
    		dentry = fdget(fd);
    		do_fsync(dentry);
    		for (;;) {
    			tmp = dentry;
    			dentry = dentry->d_parent;
    			if (dentry == tmp)
    				break;
    			do_fdatasync(dentry);
    		}
    	}

I really like this idea. Can people please try out the attached patch?

Please note, it contains a couple of things that need not be there in
the final version.

Note, there is also a reiserfs fix in here because we can call
f_op->fsync on a directory and without this fix it will BUG!  Chris,
perhaps you can suggest a better fix?


Linus, one more thing --- the first argument to ->fsync is struct file*
and nothing uses it, I'd like to blow it away or would you prefer we
wait to 2.5.x as its essentially and API change and will break XFS,
JFS, etc.



   --cw

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.8-pre3_fsync-entire-path.patch"

diff -Nur --exclude=*.o --exclude=*~ linux-2.4.8-pre3/fs/buffer.c linux-2.4.8-pre3+expt/fs/buffer.c
--- linux-2.4.8-pre3/fs/buffer.c	Wed Jul 25 19:03:05 2001
+++ linux-2.4.8-pre3+expt/fs/buffer.c	Sat Aug  4 10:53:07 2001
@@ -379,33 +379,45 @@
 
 asmlinkage long sys_fsync(unsigned int fd)
 {
-	struct file * file;
-	struct dentry * dentry;
-	struct inode * inode;
+	struct file *file;
+	struct dentry *dentry;
+	struct inode *inode;
 	int err;
 
 	err = -EBADF;
 	file = fget(fd);
 	if (!file)
 		goto out;
-
-	dentry = file->f_dentry;
-	inode = dentry->d_inode;
-
 	err = -EINVAL;
 	if (!file->f_op || !file->f_op->fsync)
 		goto out_putf;
 
-	/* We need to protect against concurrent writers.. */
-	down(&inode->i_sem);
-	filemap_fdatasync(inode->i_mapping);
-	err = file->f_op->fsync(file, dentry, 0);
-	filemap_fdatawait(inode->i_mapping);
-	up(&inode->i_sem);
+	/* walk the path (dentry chain) fsync'ing everything along
+	   it. This algorithm to do "do what the user _expects_ you to
+	   do" was suggested by Linus. --cw */
+	dentry = file->f_dentry;
+	do {
+		inode = dentry->d_inode;
+		/* We need to protect against concurrent writers.. */
+		down(&inode->i_sem);
+		filemap_fdatasync(inode->i_mapping);
+		err = -EINVAL;
+		if (!file->f_op || !file->f_op->fsync)
+			goto out_putf;
+		err = file->f_op->fsync(file, dentry, 0);
+		filemap_fdatawait(inode->i_mapping);
+		up(&inode->i_sem);
+
+		/* stop at root of fs */
+		if(dentry == dentry->d_parent)
+			break;
+
+		dentry = dentry->d_parent;
+	} while(dentry && !err);
 
-out_putf:
+ out_putf:
 	fput(file);
-out:
+ out:
 	return err;
 }
 
diff -Nur --exclude=*.o --exclude=*~ linux-2.4.8-pre3/fs/reiserfs/file.c linux-2.4.8-pre3+expt/fs/reiserfs/file.c
--- linux-2.4.8-pre3/fs/reiserfs/file.c	Fri Jul 20 20:37:09 2001
+++ linux-2.4.8-pre3+expt/fs/reiserfs/file.c	Sat Aug  4 09:06:14 2001
@@ -90,6 +90,9 @@
 
   lock_kernel() ;
 
+  if (S_ISDIR(p_s_inode->i_mode))
+          return reiserfs_dir_fsync(p_s_filp, p_s_dentry, datasync);
+
   if (!S_ISREG(p_s_inode->i_mode))
       BUG ();
 

--uAKRQypu60I7Lcqm--
