Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUIFAVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUIFAVd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 20:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUIFAVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 20:21:32 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:19086 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267356AbUIFAVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 20:21:23 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Mon, 6 Sep 2004 10:21:15 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16699.44411.361938.856856@cse.unsw.edu.au>
Subject: [PATCH - EXPERIMENTAL] files with forks in the VFS
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As a followup to the multi-branching threads about reiser4, I would
like to present this patch for discussion and exploration.
It implements files with fork (which are quite different to files that
provide different views via a subdirectory structure).

See Documentation/filesystems/forks.txt (after applying the patch) for more detail.

This is not "how it should be done" but rather "how it could be done",
and is intended primarily to provide a base for experimentation and
exploration. 

Below is a sample of what can be done, and then the patch.

NeilBrown


neilb@adams:/tmp$ ls -l
total 724
drws------    2 neilb    neilb        4096 Sep  6 10:07 echo
-rw-------    1 neilb    neilb      732560 Sep  6 10:05 portrait.jpg
neilb@adams:/tmp$ ./echo hello there
hello there
neilb@adams:/tmp$ cat echo/man
Here is some doco
neilb@adams:/tmp$ file portrait.jpg 
portrait.jpg: JPEG image data, JFIF standard 1.01, "CREATOR: XV version 3.10a-jumbo"
neilb@adams:/tmp$ file portrait.jpg/thumbnail
portrait.jpg/thumbnail: Netpbm PGM "rawbits" image data
neilb@adams:/tmp$ pnmfile portrait.jpg/thumbnail
portrait.jpg/thumbnail: PGM raw, 121 by 167  maxval 255
neilb@adams:/tmp$ ls -la echo 
total 24
drws------    2 neilb    neilb        4096 Sep  6 10:07 .
drwxrwxrwt    7 root     root         4096 Sep  6 10:05 ..
-rwx------    1 neilb    neilb       12216 Sep  6 10:05 ...
-rw-------    1 neilb    neilb          18 Sep  6 10:07 man
neilb@adams:/tmp$ ls -la portrait.jpg 
-rw-------    1 neilb    neilb      732560 Sep  6 10:05 portrait.jpg
neilb@adams:/tmp$ ls -la portrait.jpg/ 
total 748
drws--S---    2 neilb    neilb        4096 Sep  6 10:07 .
drwxrwxrwt    7 root     root         4096 Sep  6 10:05 ..
-rw-------    1 neilb    neilb      732560 Sep  6 10:05 ...
-rw-------    1 neilb    neilb       20347 Sep  6 10:07 thumbnail
neilb@adams:/tmp$ 

.....

neilb@adams:/tmp$ ls -la emacs
total 28
drws------    2 neilb    neilb        4096 Sep  6 10:16 .
drwxrwxrwt    8 root     root         4096 Sep  6 10:17 ..
lrwx------    1 neilb    neilb          14 Sep  6 10:16 ... -> /usr/bin/emacs
-rw-------    1 neilb    neilb       20347 Sep  6 10:16 icon
neilb@adams:/tmp$ ./emacs
  ... emacs runs ...
neilb@adams:/tmp$ 

Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>

### Diffstat output
 ./Documentation/filesystems/forks.txt |   49 +++++++++++++++++++++
 ./fs/namei.c                          |   79 ++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)

diff ./Documentation/filesystems/forks.txt~current~ ./Documentation/filesystems/forks.txt
--- ./Documentation/filesystems/forks.txt~current~	2004-09-06 09:21:57.000000000 +1000
+++ ./Documentation/filesystems/forks.txt	2004-09-06 10:19:05.000000000 +1000
@@ -0,0 +1,49 @@
+Files with Forks.
+
+
+This kernel contains experimental support for files with forks.
+
+A "file with forks" is a directory which contains a number of files,
+one of which is a distinguished file.  If the directory is opened as a
+file, the distinguished file is returned.  If it is opened as a
+directory, then the real directory is returned.
+
+The behaviour when the directory is "stat"ed is configurable.  Either
+the information about the actual directory or the distinguished file
+can be returned.  This allows the behaviour of various programs and
+tools to be tested with the different behaviours to see what works
+best.
+
+A directory is flagged as being a "file with forks" by
+  1/ setting the setuid bit (chmod u+s)
+  2/ creating a file or symlink within the directory called
+      "..."
+
+Once this is done, any attempt to open the directory without
+O_DIRECTORY will result in "..." being openned.  This works for
+   cat directoryname
+   exec directoryname
+   echo hello > directoryname # ... must already exist
+as examples.
+
+"stat" calls, such as "ls -l" will still show the directory.
+
+If the setgid bit is also set
+   chmod ug+s
+then stat calls will show the distinguished file.  This can be
+more confusing to some programs (rm won't like it), but less confusing
+to others (smart editors won't try to list the directory).
+
+  cd directoryname
+will always change into the actual directory, and accessing any path
+name with "." as the last component will always show the directory,
+not the distinguished file.
+
+The functionality is provided for experimentation and discussion
+only.  It is not presented as "the right way to do it" but as "an
+interesting experiment to explore".
+
+Note: if "..." is a directory, then it may not be very useful.  If it
+is a relative symlink and g+s is set, then it can be confusing.
+
+NeilBrown Sept2004

diff ./fs/namei.c~current~ ./fs/namei.c
--- ./fs/namei.c~current~	2004-09-03 14:18:08.000000000 +1000
+++ ./fs/namei.c	2004-09-06 09:21:20.000000000 +1000
@@ -818,6 +818,50 @@ last_component:
 			err = -ENOTDIR; 
 			if (!inode->i_op || !inode->i_op->lookup)
 				break;
+		} else if ( (inode->i_mode & S_ISUID) &&
+			    ((inode->i_mode & S_ISGID) || (lookup_flags & LOOKUP_OPEN)) &&
+			    inode->i_op && inode->i_op->lookup) {
+			/* opening a setuid directory as a file, open '...'
+			 * within it
+			 */
+			this.name = "...";
+			this.len = 3;
+			hash = init_name_hash();
+			hash = partial_name_hash('.', hash);
+			hash = partial_name_hash('.', hash);
+			hash = partial_name_hash('.', hash);
+			this.hash = end_name_hash(hash);
+
+			if (nd->dentry->d_op && nd->dentry->d_op->d_hash) {
+				err = nd->dentry->d_op->d_hash(nd->dentry, &this);
+				if (err < 0)
+					break;
+			}
+			err = do_lookup(nd, &this, &next);
+			if (!err && next.dentry->d_inode == NULL) {
+				dput(next.dentry);
+				/* abort "..." lookup as no entry */
+			} else {
+				follow_mount(&next.mnt, &next.dentry);
+				inode = next.dentry->d_inode;
+				if ((lookup_flags & LOOKUP_FOLLOW)
+				    && inode->i_op && inode->i_op->follow_link) {
+					mntget(next.mnt);
+					err = do_follow_link(next.dentry, nd);
+					dput(next.dentry);
+					mntput(next.mnt);
+					if (err)
+						goto return_err;
+					inode = nd->dentry->d_inode;
+				} else {
+					dput(nd->dentry);
+					nd->mnt = next.mnt;
+					nd->dentry = next.dentry;
+				}
+				err = -ENOENT;
+				if (!inode)
+					break;
+			}
 		}
 		goto return_base;
 lookup_parent:
@@ -1413,6 +1457,41 @@ do_last:
 	error = -ENOENT;
 	if (!dentry->d_inode)
 		goto exit_dput;
+	if ((dentry->d_inode->i_mode & S_ISUID) && 
+	    dentry->d_inode->i_op && dentry->d_inode->i_op->lookup) {
+		struct path next;
+		int err;
+		struct qstr this;
+		unsigned long hash;
+		this.name = "...";
+		this.len = 3;
+		hash = init_name_hash();
+		hash = partial_name_hash('.', hash);
+		hash = partial_name_hash('.', hash);
+		hash = partial_name_hash('.', hash);
+		this.hash = end_name_hash(hash);
+
+		err = 0;
+		if (dentry->d_op && dentry->d_op->d_hash) {
+			err = dentry->d_op->d_hash(nd->dentry, &this);
+		}
+		if (err >= 0) {
+			struct dentry *tmp = nd->dentry;
+			nd->dentry = dentry;
+			err = do_lookup(nd, &this, &next);
+			if (err) {
+				nd->dentry = tmp;
+			} else if (next.dentry->d_inode == NULL) {
+				dput(next.dentry);
+				nd->dentry = tmp;
+				/* abort "..." lookup as no entry */
+			} else if (!err) {
+				dput(tmp);
+				dentry = next.dentry;
+			}
+		}
+	}
+
 	if (dentry->d_inode->i_op && dentry->d_inode->i_op->follow_link)
 		goto do_link;
 
