Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281268AbRKPKIO>; Fri, 16 Nov 2001 05:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281269AbRKPKIJ>; Fri, 16 Nov 2001 05:08:09 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:36509 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S281268AbRKPKH4>; Fri, 16 Nov 2001 05:07:56 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Fri, 16 Nov 2001 21:08:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15348.58752.207182.488419@notabene.cse.unsw.edu.au>
Subject: Devlinks.  Code.  (Dcache abuse?)
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I read in an interveiw recently:
  http://www.newsforge.com/article.pl?sid=01/11/07/1516223&mode=thread

that Alan Cox was quoted as saying:
-------
One of the big issues therefore is how you handle naming and finding
objects that can shuffle around over time and between boots. Linus
favours a more devfs like approach, I favour a real /dev file system
and creating nodes on the fly by a usermode daemon. This allows you to
remember file permissions and policy more easily. It also means you
need a way to describe a device (traditionally a major/minor
numbering) which Linus doesn't like.
--------

And I thought that it was really time that this was resolved.

Herewith is a proposal for "a real /dev file system" that still uses
a "devfs like approach" to naming and avoids the problems of "traditional
... major/minor numbering".

Some of you with good memories might remember my little treatise from
May last year titled "devfs - the missing link" where I introduced the
idea of a "devlink".  You can read it at:
   http://lwn.net/2000/0518/a/nb-devfs.html

Below is code that implements devlinks, though some
of the details are different to the original proposal.

To recap, the fundamental idea is:

   A device special file is a gateway between a user (admin)
   controlled name space (the filesystem) and a kernel imposed name
   space (major/minor numbers) that recognises and imposes access
   control (owner/group/permissions).

The (a) problem with this is that major/minor numbers are too limited,
even if we go to lots more bits.  Textual names are better.
So:

   A devlink is a gateway between a user (or admin) controlled name
   space (the filesystem) and a kernel imposed name space (the devfs
   names) that recognises and imposes access control
   (owner/group/permissions).

Notice that the only difference is that we now use names instead of
numbers.  This is (as I understand it) the important difference that
is needed.

==== The user-land perspective ====

A Devlink looks like a symlink with the "sticky" (S_ISVTX) bit set.
Indeed, that is how it is stored on a filesystem.

To use devlinks you must apply the patch below and compile with DEVFS
support and with CONFIG_DEVLINK.  You do not need to mount devfs at
all. 

To create a devlink, you use mknod on a pre-existing symlink.  The
mknod must request a device (block or char) with device number 0,0.
e.g.
    ln -s tty /dev/TTY
    mknod /dev/TTY b 0 0

This will create a devlink called "/dev/TTY" which points to the name
"tty" in devfs space.

    ls -l /dev/TTY

will show the devlink.

    ls -lL /dev/TTY

will show the traditional device special file.

Once you have turned a symlink into a devlink, chmod and chown will
work directly on the devlink so you can change the permissions and
ownership freely.  The ownership and permissions are automatically
imposed on everything that the devlink points to.

A devlink can point to anything in the devfs namespace, not just
devices. e.g

   ln -s ide /dev/ide
   mknod /dev/ide b 0 0

will make /dev/ide be a devlink the the ide tree within devfs.
Then
   cd /dev/ide
will work and allow you to move around the directory tree.  Everything
in the directory tree will have the same ownership and permissions as
the devlink has, except for the execute bits.   For directories, the
execute bits are copied from the read bits. For non-directories, the
execute bits are cleared. 

You cannot do

    ln -s '' /devices
    mknod /devices b 0 0

and get the full devfs namespace under /devices, but only because
of a shortcoming the the devfs code (that normally would never be
asked to do this anyway).  It could fairly easily be fixed but it
didn't seem worth the effort for this proof-of-concept.

When you 'cd' in a devlink tree, e.g.
    cd /dev/ide/host0

the path you get with "/bin/pwd" looks just like what you would
expect:  "/dev/ide/host0" in the example.  The subtree of the devfs
namespace appears to be beneath the devlink almost as if the devlink
itself were a directory.

The inodes in the devlink tree have a different device number than
that of the devlink as though it were a separately mounted filesystem,
but there is no mountpoint appearing in /proc/mounts.

When you use devlinks you do still see major and minor device numbers,
but getting rid of them completely would be too much of a departure
from the Unix that we know and love.  However once you use devlinks,
the actual numbers in use become much less important.  You can have a
"real" /dev tree with access policy set up, and the kernel can assign
different device numbers at each reboot, and everything will continue
to work.  Just the names need to stay the same.

=============Internal Perspective=======================

The objects that you reach when you follow a devlink are all
objects in a new filesystem, the "devlink" filesystem. 
The devlink filesystem is an FS_SINGLE|FS_NOMOUNT filesystem that
can never be mounted.

When vfs_follow_link is called on a symlink with the S_ISVTX bit set,
"devlink_find" is called which creates (if necessary) a dentry and
inode that reflect the target devfs object, and attaches this dentry 
underneath the devlink's dentry.  The dentry has a name of ".", though
this is hidden from user-space (a name of "" might be a better
choice).

For this to work, vfs_follow_link needs to know the dentry that is
being followed as well as the name and parent directory, so the patch
adds another argument to vfs_follow_link.

There is a new lookup flags: LOOKUP_DEVLINK which can accompany
LOOKUP_FOLLOW, and means "don't follow devlinks". 
This allows chmod to work directly on devlinks.

vfs_mknod is changed so that if a blk or chr device is requested, and
the name refers to a symlink, the S_ISVTX is forced on.  Any other 
chmod on a symlink is never allowed to change the S_ISVTX bit.

There is plenty of room for races with bits of devfs disappearing
underneath devlink.  This is largely due to the current nature of
devfs.  I think that the new devfs core that Richard is working on
will mean that these races can trivially be dealt with.

Probably the most ugly bits of the implementation are:
 1/ the fact that dentries are attached to a devlink (which is
    not a directory), and that these dentrys are in a different
    filesystem to the devlink.
 2/ the special casing to file the "." denties in follow_dotdot
    and __d_path.

1/ is very different from the way things are now, but the more I think
about it the more comfortable I feel with it.  There may be issues
about what happens when the devlink is unlinked, but they can be dealt
with I'm sure.
2/ is clearly ugly.  I would like to find a nicer solution but as yet,
noon has presented itself.  Possibly making the name "" instead of
"." would make it a bit less ugly, but not much.

Enough chatting.  Here is the code, against 2.4.15-pre5.  Comments
welcome. 

NeilBrown


--- ./fs/proc/base.c	2001/11/16 03:56:34	1.1
+++ ./fs/proc/base.c	2001/11/16 09:06:47	1.2
@@ -911,7 +911,7 @@
 {
 	char tmp[30];
 	sprintf(tmp, "%d", current->pid);
-	return vfs_follow_link(nd,tmp);
+	return vfs_follow_link(nd,tmp,dentry);
 }	
 
 static struct inode_operations proc_self_inode_operations = {
--- ./fs/proc/generic.c	2001/11/16 03:56:34	1.1
+++ ./fs/proc/generic.c	2001/11/16 09:06:48	1.2
@@ -219,7 +219,7 @@
 static int proc_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *s=((struct proc_dir_entry *)dentry->d_inode->u.generic_ip)->data;
-	return vfs_follow_link(nd, s);
+	return vfs_follow_link(nd, s, dentry);
 }
 
 static struct inode_operations proc_link_inode_operations = {
--- ./fs/nfs/symlink.c	2001/11/16 03:56:34	1.1
+++ ./fs/nfs/symlink.c	2001/11/16 09:06:48	1.2
@@ -93,7 +93,8 @@
 {
 	struct inode *inode = dentry->d_inode;
 	struct page *page = NULL;
-	int res = vfs_follow_link(nd, nfs_getlink(inode,&page));
+	int res = vfs_follow_link(nd, nfs_getlink(inode,&page),
+				  dentry);
 	if (page) {
 		kunmap(page);
 		page_cache_release(page);
--- ./fs/ext2/symlink.c	2001/11/16 03:56:34	1.1
+++ ./fs/ext2/symlink.c	2001/11/16 09:06:48	1.2
@@ -29,7 +29,7 @@
 static int ext2_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *s = (char *)dentry->d_inode->u.ext2_i.i_data;
-	return vfs_follow_link(nd, s);
+	return vfs_follow_link(nd, s, dentry);
 }
 
 struct inode_operations ext2_fast_symlink_inode_operations = {
--- ./fs/sysv/symlink.c	2001/11/16 03:56:34	1.1
+++ ./fs/sysv/symlink.c	2001/11/16 09:06:48	1.2
@@ -16,7 +16,7 @@
 static int sysv_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *s = (char *)dentry->d_inode->u.sysv_i.i_data;
-	return vfs_follow_link(nd, s);
+	return vfs_follow_link(nd, s,dentry);
 }
 
 struct inode_operations sysv_fast_symlink_inode_operations = {
--- ./fs/ufs/symlink.c	2001/11/16 03:56:34	1.1
+++ ./fs/ufs/symlink.c	2001/11/16 09:06:48	1.2
@@ -36,7 +36,7 @@
 static int ufs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *s = (char *)dentry->d_inode->u.ufs_i.i_u1.i_symlink;
-	return vfs_follow_link(nd, s);
+	return vfs_follow_link(nd, s, dentry);
 }
 
 struct inode_operations ufs_fast_symlink_inode_operations = {
--- ./fs/autofs/symlink.c	2001/11/16 03:56:34	1.1
+++ ./fs/autofs/symlink.c	2001/11/16 09:06:48	1.2
@@ -21,7 +21,7 @@
 static int autofs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *s=((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
-	return vfs_follow_link(nd, s);
+	return vfs_follow_link(nd, s, dentry);
 }
 
 struct inode_operations autofs_symlink_inode_operations = {
--- ./fs/devfs/base.c	2001/11/16 03:56:34	1.1
+++ ./fs/devfs/base.c	2001/11/16 09:06:48	1.2
@@ -3049,7 +3049,7 @@
     up_read (&symlink_rwsem);
     if (copy)
     {
-	err = vfs_follow_link (nd, copy);
+	err = vfs_follow_link (nd, copy, dentry);
 	kfree (copy);
     }
     else err = -ENOMEM;
--- ./fs/autofs4/symlink.c	2001/11/16 03:56:35	1.1
+++ ./fs/autofs4/symlink.c	2001/11/16 09:06:48	1.2
@@ -23,7 +23,7 @@
 {
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
-	return vfs_follow_link(nd, ino->u.symlink);
+	return vfs_follow_link(nd, ino->u.symlink, dentry);
 }
 
 struct inode_operations autofs4_symlink_inode_operations = {
--- ./fs/freevxfs/vxfs_immed.c	2001/11/16 03:56:35	1.1
+++ ./fs/freevxfs/vxfs_immed.c	2001/11/16 09:06:48	1.2
@@ -101,7 +101,7 @@
 {
 	struct vxfs_inode_info		*vip = VXFS_INO(dp->d_inode);
 
-	return (vfs_follow_link(np, vip->vii_immed.vi_immed));
+	return (vfs_follow_link(np, vip->vii_immed.vi_immed, dentry));
 }
 
 /**
--- ./fs/jffs2/symlink.c	2001/11/16 03:56:35	1.1
+++ ./fs/jffs2/symlink.c	2001/11/16 09:06:48	1.2
@@ -99,7 +99,7 @@
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ret = vfs_follow_link(nd, buf);
+	ret = vfs_follow_link(nd, buf, dentry);
 	kfree(buf);
 	return ret;
 }
--- ./fs/ext3/symlink.c	2001/11/16 04:32:20	1.1
+++ ./fs/ext3/symlink.c	2001/11/16 09:06:48	1.2
@@ -30,7 +30,7 @@
 static int ext3_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	char *s = (char *)dentry->d_inode->u.ext3_i.i_data;
-	return vfs_follow_link(nd, s);
+	return vfs_follow_link(nd, s, dentry);
 }
 
 struct inode_operations ext3_fast_symlink_inode_operations = {
--- ./fs/attr.c	2001/11/16 03:56:35	1.1
+++ ./fs/attr.c	2001/11/16 09:06:48	1.2
@@ -80,6 +80,13 @@
 	if (ia_valid & ATTR_CTIME)
 		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
+		if (S_ISLNK(inode->i_mode) && 
+		    ! (ia_valid&ATTR_FORCE)) {
+			if (inode->i_mode & S_ISVTX)
+				attr->ia_mode |= S_ISVTX;
+			else
+				attr->ia_mode &= ~S_ISVTX;
+		}
 		inode->i_mode = attr->ia_mode;
 		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
 			inode->i_mode &= ~S_ISGID;
--- ./fs/open.c	2001/11/16 03:56:35	1.1
+++ ./fs/open.c	2001/11/16 09:06:50	1.2
@@ -236,7 +236,7 @@
 	struct inode * inode;
 	struct iattr newattrs;
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_devlink(filename, &nd);
 	if (error)
 		goto out;
 	inode = nd.dentry->d_inode;
@@ -280,7 +280,7 @@
 	struct inode * inode;
 	struct iattr newattrs;
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_devlink(filename, &nd);
 
 	if (error)
 		goto out;
@@ -491,7 +491,7 @@
 	int error;
 	struct iattr newattrs;
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_devlink(filename, &nd);
 	if (error)
 		goto out;
 	inode = nd.dentry->d_inode;
@@ -581,7 +581,7 @@
 	struct nameidata nd;
 	int error;
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_devlink(filename, &nd);
 	if (!error) {
 		error = chown_common(nd.dentry, user, group);
 		path_release(&nd);
--- ./fs/namei.c	2001/11/16 03:56:35	1.1
+++ ./fs/namei.c	2001/11/16 09:06:50	1.2
@@ -419,6 +419,13 @@
 			spin_unlock(&dcache_lock);
 			dput(nd->dentry);
 			nd->dentry = dentry;
+#ifdef CONFIG_DEVLINK
+			/* Can't leave the current directory
+			 * as a devlink ...
+			 */
+			if (S_ISLNK(dentry->d_inode->i_mode))
+				continue;
+#endif
 			break;
 		}
 		parent=nd->mnt->mnt_parent;
@@ -591,7 +598,9 @@
 			;
 		inode = dentry->d_inode;
 		if ((lookup_flags & LOOKUP_FOLLOW)
-		    && inode && inode->i_op && inode->i_op->follow_link) {
+		    && inode && inode->i_op && inode->i_op->follow_link
+		    && ((inode->i_mode&S_ISVTX)==0 || (lookup_flags& LOOKUP_DEVLINK)==0)
+			) {
 			err = do_follow_link(dentry, nd);
 			dput(dentry);
 			if (err)
@@ -1215,6 +1224,20 @@
 	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
 		goto exit_lock;
 
+#ifdef CONFIG_DEVLINK
+	if ((S_ISCHR(mode) || S_ISBLK(mode))
+	    && dev == MKDEV(0,0)
+	    && dentry->d_inode
+	    && S_ISLNK(dentry->d_inode->i_mode)) {
+		struct iattr attr;
+		attr.ia_valid = ATTR_MODE | ATTR_FORCE;
+		attr.ia_mode = (dentry->d_inode->i_mode & S_IFMT)
+			| (mode & S_IRWXUGO)
+			| S_ISVTX;
+		error = notify_change(dentry, &attr);
+		goto exit_lock;
+	}
+#endif
 	error = may_create(dir, dentry);
 	if (error)
 		goto exit_lock;
@@ -1943,13 +1966,32 @@
 }
 
 static inline int
-__vfs_follow_link(struct nameidata *nd, const char *link)
+__vfs_follow_link(struct nameidata *nd, const char *link, struct dentry *dentry)
 {
 	int res = 0;
 	char *name;
 	if (IS_ERR(link))
 		goto fail;
 
+#ifdef CONFIG_DEVLINK
+	/* If dentry->d_inode is a symlink with sticky bit set, then
+	 * this is a devlink.  That means that we lookup "link"
+	 * in devfs and make a dentry+inode in the devlink filesystem
+	 * and then attach the dentry just under this dentry
+	 * Kind-a gross I know...
+	 */
+	if (!(nd->mnt->mnt_flags & MNT_NODEV)
+	    && dentry->d_inode
+	    && (dentry->d_inode->i_mode & S_ISVTX)) {
+		dentry = devlink_find(dentry, link);
+		if (IS_ERR(dentry))
+			return PTR_ERR(dentry);
+		dput(nd->dentry);
+		nd->dentry = dentry;
+		nd->last_type = LAST_BIND;
+		return 0;
+	}
+#endif
 	if (*link == '/') {
 		path_release(nd);
 		if (!walk_init_root(link, nd))
@@ -1976,9 +2018,9 @@
 	return PTR_ERR(link);
 }
 
-int vfs_follow_link(struct nameidata *nd, const char *link)
+int vfs_follow_link(struct nameidata *nd, const char *link, struct dentry *dentry)
 {
-	return __vfs_follow_link(nd, link);
+	return __vfs_follow_link(nd, link, dentry);
 }
 
 /* get the link contents into pagecache */
@@ -2020,7 +2062,7 @@
 {
 	struct page *page = NULL;
 	char *s = page_getlink(dentry, &page);
-	int res = __vfs_follow_link(nd, s);
+	int res = __vfs_follow_link(nd, s, dentry);
 	if (page) {
 		kunmap(page);
 		page_cache_release(page);
--- ./fs/devlink.c	2001/11/16 03:56:35	1.1
+++ ./fs/devlink.c	2001/11/16 09:06:50	1.2
@@ -0,0 +1,493 @@
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/devfs_fs.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/sem.h>
+#include <linux/stat.h>
+
+/*
+ * devlink filesystem
+ * this filesystem present the devfs_entry tree
+ * as a filesystem.
+ * All permissions are inherited from a devlink "mountpoint",
+ * which is really an attachment point.
+ *
+ * Directories appear as directories
+ * char/block specials as those char/block specials
+ * symlinks as .... devlinks?
+ *
+ * dentry trees are attached under devlinks, entirely contravening any
+ * sense of taste
+ */
+
+#define DEVLINK_MAGIC 0xde5501ec
+
+/* ------------------------------------------------------------------*/
+/* Following extracted from devfs/base.c */
+
+struct directory_type
+{
+    struct devfs_entry *first;
+    struct devfs_entry *last;
+    unsigned int num_removable;
+};
+
+struct file_type
+{
+    unsigned long size;
+};
+
+struct device_type
+{
+    unsigned short major;
+    unsigned short minor;
+};
+
+struct fcb_type  /*  File, char, block type  */
+{
+    uid_t default_uid;
+    gid_t default_gid;
+    void *ops;
+    union 
+    {
+	struct file_type file;
+	struct device_type device;
+    }
+    u;
+    unsigned char auto_owner:1;
+    unsigned char aopen_notify:1;
+    unsigned char removable:1;  /*  Belongs in device_type, but save space   */
+    unsigned char open:1;       /*  Not entirely correct                     */
+    unsigned char autogen:1;    /*  Belongs in device_type, but save space   */
+};
+
+struct symlink_type
+{
+    unsigned int length;         /*  Not including the NULL-termimator       */
+    char *linkname;              /*  This is NULL-terminated                 */
+};
+
+struct fifo_type
+{
+    uid_t uid;
+    gid_t gid;
+};
+
+struct devfs_inode  /*  This structure is for "persistent" inode storage  */
+{
+    time_t atime;
+    time_t mtime;
+    time_t ctime;
+    unsigned int ino;          /*  Inode number as seen in the VFS  */
+    struct dentry *dentry;
+    umode_t mode;
+    uid_t uid;
+    gid_t gid;
+};
+
+struct devfs_entry
+{
+    void *info;
+    union 
+    {
+	struct directory_type dir;
+	struct fcb_type fcb;
+	struct symlink_type symlink;
+	struct fifo_type fifo;
+    }
+    u;
+    struct devfs_entry *prev;    /*  Previous entry in the parent directory  */
+    struct devfs_entry *next;    /*  Next entry in the parent directory      */
+    struct devfs_entry *parent;  /*  The parent directory                    */
+    struct devfs_entry *slave;   /*  Another entry to unregister             */
+    struct devfs_inode inode;
+    umode_t mode;
+    unsigned short namelen;  /*  I think 64k+ filenames are a way off...  */
+    unsigned char registered:1;
+    unsigned char hide:1;
+    unsigned char no_persistence:1;
+    char name[1];            /*  This is just a dummy: the allocated array is
+				 bigger. This is NULL-terminated  */
+};
+
+/* ---------------------------------------------------------- */
+
+static inline devfs_handle_t i2d(struct inode *i)
+{
+	return (devfs_handle_t)(i->u.generic_ip);
+}
+static inline void set_de(struct inode *i, devfs_handle_t de)
+{
+	i->u.generic_ip = de;
+}
+
+static struct inode *devlink_inode(devfs_handle_t de);
+static int dl_setattr(struct dentry *dentry, struct iattr *attr);
+struct super_block *devlink_sb;
+
+static struct inode_operations devlink_dir_ops;
+static struct file_operations devlink_dir_fops;
+static struct inode_operations devlink_dev_ops;
+static struct inode_operations devlink_link_ops;
+static struct dentry_operations devlink_dops;	
+static struct super_operations devlink_sops;
+
+
+struct dentry *devlink_find(struct dentry *ldentry, const char *link)
+{
+	/*
+	 * here we find or create a dentry and matching inode
+	 * for the devfs thing pointed to by "link"
+	 * The dentry gets attached under ldentry with the
+	 * name ".".
+	 * If there is already a dentry we check if it
+	 * has the right de.  If it does we just use that
+	 * If it has the wrong de, we unhash it first.
+	 *
+	 */
+
+	struct qstr dot = { ".", 1, 0 };
+	struct dentry *dentry = d_lookup(ldentry, &dot);
+	struct inode *inode;
+	int err;
+	devfs_handle_t de =
+		devfs_find_handle(NULL, link, 0, 0, 0, 0);
+
+	down(&ldentry->d_inode->i_sem);
+	if (dentry) {
+		if (!dentry->d_inode) {
+			if (de == NULL)
+				goto out;
+		} else {
+			if (i2d(dentry->d_inode) == de)
+				goto out;
+		}
+
+		d_drop(dentry);
+		dput(dentry);
+	}
+	/* We need to allocate a new dentry...*/
+	err = -ENOMEM;
+	dentry = d_alloc(ldentry, &dot);
+	if (!dentry)
+		goto err;
+	if (!de) {
+		d_add(dentry, NULL);
+		goto out;
+	}
+	/* looks like we need an inode too */
+	inode = devlink_inode(de);
+	if (!inode)
+		goto err;
+	d_add(dentry, inode);
+	dl_setattr(dentry, NULL);
+
+ out:
+	up(&ldentry->d_inode->i_sem);
+	return dentry;
+
+ err:
+	up(&ldentry->d_inode->i_sem);
+	return ERR_PTR(err);
+}
+
+static int dl_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	/* We don't allow any attribute setting
+	 * but whenever anyone tries, we make sure that
+	 * our attributes match our parent
+	 */
+	struct inode *inode, *parent;
+	inode = dentry->d_inode;
+
+	/* find the dentry for the devlink */
+	do {
+		dentry = dentry->d_parent;
+	} while (dentry != dentry->d_parent
+		 && ! S_ISLNK(dentry->d_inode->i_mode));
+	parent = dentry->d_inode;
+
+	if (inode) {
+		inode->i_uid = parent->i_uid;
+		inode->i_gid = parent->i_gid;
+		inode->i_mode =
+			(inode->i_mode & (S_IFMT|S_ISVTX))
+			| (parent->i_mode & (S_IRUGO|S_IWUGO));
+
+		/* copy Read to eXecute for directories */
+		if (S_ISDIR(inode->i_mode))
+			inode->i_mode |= (parent->i_mode & S_IRUGO)>>2;
+	}
+	return 0;
+}
+
+/* devlink_inode creates a new inode for a given
+ * devfs entry.
+ *
+ */
+static struct inode *devlink_inode(devfs_handle_t de)
+{
+	struct inode *inode;
+	int mode;
+
+	if (de == NULL)
+		return NULL;
+	if (!de->registered)
+		return NULL;
+	if (S_ISDIR(de->mode))
+		mode = S_IFDIR;
+	else if (S_ISCHR(de->mode))
+		mode = S_IFCHR;
+	else if (S_ISBLK(de->mode))
+		mode = S_IFBLK;
+	else if (S_ISLNK(de->mode))
+		mode = S_IFLNK|S_ISVTX;
+	else
+		return NULL;
+	inode = get_empty_inode();
+	if (inode) {
+		inode->i_sb = devlink_sb;
+		inode->i_ino = de->inode.ino;
+		inode->i_dev = devlink_sb->s_dev;
+		
+		inode->i_mode= mode;
+		inode->i_nlink=1;
+		inode->i_uid = inode->i_gid = 0;
+		inode->i_size = 0;
+		inode->i_atime = inode->i_mtime = inode->i_ctime =
+			CURRENT_TIME;
+		inode->i_blocks = 0;
+		switch(mode) {
+		case S_IFCHR:
+		case S_IFBLK:
+			init_special_inode(inode, mode,
+					   MKDEV (de->u.fcb.u.device.major,
+						  de->u.fcb.u.device.minor));
+			inode->i_op = &devlink_dev_ops;
+			break;
+		case S_IFDIR:
+			inode->i_op = &devlink_dir_ops;
+			inode->i_fop = &devlink_dir_fops;
+			break;
+		case S_IFLNK|S_ISVTX:
+			inode->i_op = &devlink_link_ops;
+		}
+		set_de(inode, de);
+	}
+	return inode;
+}
+static struct dentry *dl_lookup(struct inode *dir, struct dentry *dentry)
+{
+	devfs_handle_t de = i2d(dir);
+	devfs_handle_t d2 = devfs_find_handle(de,
+				       dentry->d_name.name,
+				       0, 0, 0, 0);
+	struct inode *inode;
+	
+	dentry->d_op = &devlink_dops;
+
+	inode = devlink_inode(d2);
+	d_add(dentry, inode);
+	dl_setattr(dentry, NULL);
+	return NULL;
+}
+
+static int dl_readdir(struct file *file, void *cookie, filldir_t func)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	devfs_handle_t parent = i2d(inode);
+	devfs_handle_t de;
+	int i=0;
+	int err=0;
+	int stored=0;
+	long pos = file->f_pos;
+	
+	switch(pos) {
+	case 0:
+		err = func(cookie, ".", 1, 0, inode->i_ino, DT_DIR);
+		if (err<0) break;
+		stored++;
+		pos++;
+		/* FALLTHROUGH */
+	case 1:
+		err = func(cookie, "..", 2, 1, file->f_dentry->d_parent->d_inode->i_ino,
+			   DT_DIR);
+		if (err < 0) break;
+		stored++;
+		pos++;
+		/* FALLTHROUGH */
+	default:
+		i=1;
+		for (de = parent->u.dir.first; de != NULL; de=de->next) {
+			if (!de->registered)
+				continue;
+			i++;
+			if (i<pos)
+				continue;
+			err = func(cookie, de->name, de->namelen,
+				   pos, de->inode.ino,
+				   de->mode >> 12);
+			if (err < 0) break;
+			pos++;
+			stored++;
+		}
+	}
+	file->f_pos = pos;
+	if (err < 0 && err != -EINVAL)
+		return err;
+	return stored;
+}
+
+static int dl_readlink(struct dentry *dentry, char *buf, int bufsiz)
+{
+
+	devfs_handle_t de = i2d(dentry->d_inode);
+	char *link = de->u.symlink.linkname;
+	if (link && de->registered)
+		/* WARNING bad race here */
+		return vfs_readlink(dentry, buf, bufsiz, link);
+
+	return -ENODEV;
+}
+
+static int dl_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	devfs_handle_t de = i2d(dentry->d_inode);
+	char *link = de->u.symlink.linkname;
+	if (link && de->registered) {
+		/* WARNING bad race here */
+		struct dentry *d = devlink_find(dentry, link);
+		dput(nd->dentry);
+		nd->dentry = d;
+		return 0;
+	} else
+		return -ENODEV;
+}
+
+static int dl_revalidate(struct dentry *dentry, int flags)
+{
+	devfs_handle_t de;
+
+	if (dentry->d_inode == NULL) {
+		/* negative dentry.
+		 * For a re-lookup
+		 */
+		return 0;
+	}
+	dl_setattr(dentry, NULL); /* update attributes */
+	de = i2d(dentry->d_inode);
+	if (de->registered)
+		return 1;
+	d_drop(dentry); /* extreme prejudice... */
+	return 0;
+}
+
+static int dl_i_revalidate(struct dentry *dentry)
+{
+	if (dl_revalidate(dentry, 0))
+		return 0;	
+	else
+		return -ENODEV;
+}
+
+static void dl_put_inode(struct inode *inode)
+{
+/*	devfs_handle_t de = i2d(inode); */
+	/* I would really like to drop the reference count
+	 * on de, but there isn't one...
+	 */
+}
+
+static struct vfsmount *devlink_mnt;
+
+static struct super_block *dl_read_super(struct super_block *sb,
+					 void *data, int silent)
+{
+	/* I wonder what I really need here ...
+	 * just copy some stuff from pipefs for now
+	 */
+	struct inode *root = new_inode(sb);
+	if (!root)
+		return NULL;
+	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
+	root->i_uid = root->i_gid = 0;
+	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
+	sb->s_blocksize = 1024;
+	sb->s_blocksize_bits = 10;
+	sb->s_magic = DEVLINK_MAGIC;
+	sb->s_op	= &devlink_sops;
+	sb->s_root = d_alloc(NULL, &(const struct qstr) { "devlink:", 8, 0 });
+	if (!sb->s_root) {
+		iput(root);
+		return NULL;
+	}
+	sb->s_root->d_sb = sb;
+	sb->s_root->d_parent = sb->s_root;
+	d_instantiate(sb->s_root, root);
+	devlink_sb = sb;
+	return sb;
+
+}
+
+static struct inode_operations devlink_dir_ops = {
+	lookup:		dl_lookup,
+	setattr: 	dl_setattr,
+	revalidate:	dl_i_revalidate,
+};
+
+static struct file_operations devlink_dir_fops = {
+	readdir:	dl_readdir,
+};
+static struct inode_operations devlink_dev_ops = {
+	setattr: 	dl_setattr,
+	revalidate:	dl_i_revalidate,
+};
+
+static struct inode_operations devlink_link_ops = {
+	readlink:	dl_readlink,
+	follow_link:	dl_follow_link,
+	setattr:	dl_setattr,
+	revalidate:	dl_i_revalidate,
+};
+
+static struct dentry_operations devlink_dops = {
+	d_revalidate:	dl_revalidate,
+};
+	
+static struct super_operations devlink_sops = {
+	put_inode:	dl_put_inode,
+};
+
+
+static DECLARE_FSTYPE(dl_fs_type, "devlink", dl_read_super, FS_SINGLE|FS_NOMOUNT);
+
+static int __init init_dl_fs(void)
+{
+	int err = register_filesystem(&dl_fs_type);
+	if (!err) {
+		devlink_mnt = kern_mount(&dl_fs_type);
+		err = PTR_ERR(devlink_mnt);
+		if (IS_ERR(devlink_mnt))
+			unregister_filesystem(&dl_fs_type);
+		else
+			err = 0;
+	}
+	return err;
+}
+
+static void __exit exit_dl_fs(void)
+{
+	unregister_filesystem(&dl_fs_type);
+	mntput(devlink_mnt);
+}
+
+module_init(init_dl_fs)
+module_exit(exit_dl_fs)
+
+
+
+
--- ./fs/Makefile	2001/11/16 03:56:35	1.1
+++ ./fs/Makefile	2001/11/16 09:06:50	1.2
@@ -25,6 +25,8 @@
 subdir-$(CONFIG_PROC_FS)	+= proc
 subdir-y			+= partitions
 
+obj-$(CONFIG_DEVLINK)		+= devlink.o
+
 # Do not add any filesystems before this line
 subdir-$(CONFIG_EXT3_FS)	+= ext3    # Before ext2 so root fs can be ext3
 subdir-$(CONFIG_JBD)		+= jbd
--- ./fs/Config.in	2001/11/16 03:56:35	1.1
+++ ./fs/Config.in	2001/11/16 09:06:50	1.2
@@ -64,6 +64,7 @@
 dep_bool '/dev file system support (EXPERIMENTAL)' CONFIG_DEVFS_FS $CONFIG_EXPERIMENTAL
 dep_bool '  Automatically mount at boot' CONFIG_DEVFS_MOUNT $CONFIG_DEVFS_FS
 dep_bool '  Debug devfs' CONFIG_DEVFS_DEBUG $CONFIG_DEVFS_FS
+dep_bool ' Devlink support (VeryExperimental)' CONFIG_DEVLINK $CONFIG_DEVFS_FS
 
 # It compiles as a module for testing only.  It should not be used
 # as a module in general.  If we make this "tristate", a bunch of people
--- ./fs/dcache.c	2001/11/16 03:59:12	1.1
+++ ./fs/dcache.c	2001/11/16 09:06:50	1.2
@@ -976,6 +976,13 @@
 		}
 		parent = dentry->d_parent;
 		namelen = dentry->d_name.len;
+#ifdef CONFIG_DEVLINK
+		/* avoid /./ appearing in paths beneath devlinks */
+		if (namelen == 1 && dentry->d_name.name[0] == '.') {
+			dentry = parent;
+			continue;
+		}
+#endif
 		buflen -= namelen + 1;
 		if (buflen < 0)
 			break;
--- ./mm/shmem.c	2001/11/16 03:56:35	1.1
+++ ./mm/shmem.c	2001/11/16 09:06:51	1.2
@@ -1150,7 +1150,7 @@
 
 static int shmem_follow_link_inline(struct dentry *dentry, struct nameidata *nd)
 {
-	return vfs_follow_link(nd, (const char *)SHMEM_I(dentry->d_inode));
+	return vfs_follow_link(nd, (const char *)SHMEM_I(dentry->d_inode), dentry);
 }
 
 static int shmem_readlink(struct dentry *dentry, char *buffer, int buflen)
@@ -1174,7 +1174,7 @@
 	if (res)
 		return res;
 
-	res = vfs_follow_link(nd, kmap(page));
+	res = vfs_follow_link(nd, kmap(page), dentry);
 	kunmap(page);
 	page_cache_release(page);
 	return res;
--- ./include/linux/fs.h	2001/11/16 03:56:09	1.2
+++ ./include/linux/fs.h	2001/11/16 09:06:51	1.3
@@ -313,8 +313,6 @@
 #include <linux/proc_fs_i.h>
 #include <linux/usbdev_fs_i.h>
 #include <linux/jffs2_fs_i.h>
-#include <linux/cramfs_fs_sb.h>
-
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -1258,6 +1256,11 @@
 #define LOOKUP_POSITIVE		(8)
 #define LOOKUP_PARENT		(16)
 #define LOOKUP_NOALT		(32)
+#ifdef CONFIG_DEVLINK
+#define	LOOKUP_DEVLINK		(64)	/* Don't follow devlinks at end of path */
+#else
+#define LOOKUP_DEVLINK (0)
+#endif
 /*
  * Type of the last component on LOOKUP_PARENT
  */
@@ -1295,6 +1298,8 @@
 extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
 #define user_path_walk(name,nd)	 __user_walk(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, nd)
 #define user_path_walk_link(name,nd) __user_walk(name, LOOKUP_POSITIVE, nd)
+#define	user_path_walk_devlink(name,nd) __user_walk(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE|LOOKUP_DEVLINK, nd)
+extern struct dentry *devlink_find(struct dentry *ldentry, const char *link);
 
 extern void iput(struct inode *);
 extern void force_delete(struct inode *);
@@ -1387,7 +1392,7 @@
 extern struct file_operations generic_ro_fops;
 
 extern int vfs_readlink(struct dentry *, char *, int, const char *);
-extern int vfs_follow_link(struct nameidata *, const char *);
+extern int vfs_follow_link(struct nameidata *, const char *, struct dentry *);
 extern int page_readlink(struct dentry *, char *, int);
 extern int page_follow_link(struct dentry *, struct nameidata *);
 extern struct inode_operations page_symlink_inode_operations;
--- ./Documentation/Configure.help	2001/11/16 03:56:35	1.1
+++ ./Documentation/Configure.help	2001/11/16 09:06:51	1.2
@@ -14114,6 +14114,23 @@
 
   If unsure, say N.
 
+devlink support (Rather Experimental)
+CONFIG_DEVLINK
+  This provides support for devlinks, which are a cross between symlinks
+  and device special files.
+      ln -s /dev/path/to/device/in/devfs  /dev/myname
+      mknod /dev/myname b 0 0
+  which create a devlink which looks like a symlink, but has the sticky
+  bit set.  Chmod and chown on devlinks affect the link, not the
+  the thing pointed to (at least not directly).
+  When you access a devlink, it provides you with an image of the 
+  thing named in devfs, but with the same owner/group/perm as the 
+  devlink has.
+  You don't need to have devfs mounted for this to work, but it must
+  be compiled in.
+
+  This code has lots of potential races. Don't use it in production.
+
 NFS file system support
 CONFIG_NFS_FS
   If you are connected to some other (usually local) Unix computer
