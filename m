Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277603AbRJRFGG>; Thu, 18 Oct 2001 01:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277599AbRJRFF7>; Thu, 18 Oct 2001 01:05:59 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:22233 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277598AbRJRFFn>; Thu, 18 Oct 2001 01:05:43 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Oct 2001 15:06:06 +1000 (EST)
Message-ID: <15310.25406.789271.793284@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: RFC - tree quotas for Linux (2.4.12, ext2)
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 In my ongoing effort to provide centralised file storage that I can
 be proud of, I have put together some code to implement tree quotas.

 The idea of a tree quota is that the block and inode usage of a file
 is charged to the (owner of the root of the) tree rather than the
 owner (or group owner) of the file.
 This will (I hope) make life easier for me.  There are several
 reasons that I have documented (see URL below) but a good one is that
 they are transparent and predictable.  du -s $HOME should *always*
 match your usage according to "quota".

 I have written a patch which is included below, but also is at
    htttp://www.cse.unsw.edu.au/~neilb/patches/linux/

 which defines a third type of quotas for Linux, named "treequotas".
 The patch supports these quotas for ext2 by borrowing (or is that
 stealing) i_reserved2 from the on-disc inode to store the "tid",
 which is the uid of the ultimate non-root parent of the file.

 There are obvious issues with hardlinks between trees with different
 tree-ids, but they can be easily restricted to root who should know
 better.

 The patch introduces the concept of a "Treeid" or "tid" which is
 inherited from the parent, if not zero, or set from the uid
 otherwise.
 Thus if root creates a directory near the top of a filesystem and
 chowns it to someone, all files created beneath that directory,
 independant of ownership, get charged to the someone (for the purpose
 of treequotaing).

 More notes can be found at:

   http://www.cse.unsw.edu.au/~neilb/wiki/?TreeQuotas

 Comments more than welcome.

 I should admit that I haven't actually tried this verison of the
 patch.  I got a working version.  Did some testing.  Realised some
 problems.  Updated the patch.  Checked that it compiled.  But haven't
 tested it yet.  But I'm most interested in comments from people
 reading it, not people running it, at this stage.

 Patches are required to the user-space tools to allow them to see
 treequotas.  I don't have any such patches and have no immediate
 plans as I use my own quota tools.  However I might do it at some
 stage and would certainly be happy to host such patches if someone
 else did them.

NeilBrown



--- ./fs/ext2/inode.c	2001/10/15 22:51:39	1.1
+++ ./fs/ext2/inode.c	2001/10/18 04:34:27	1.2
@@ -928,6 +928,7 @@
 	inode->i_mode = le16_to_cpu(raw_inode->i_mode);
 	inode->i_uid = (uid_t)le16_to_cpu(raw_inode->i_uid_low);
 	inode->i_gid = (gid_t)le16_to_cpu(raw_inode->i_gid_low);
+	inode->i_tid = (uid_t)le32_to_cpu(raw_inode->i_e2_tid);
 	if(!(test_opt (inode->i_sb, NO_UID32))) {
 		inode->i_uid |= le16_to_cpu(raw_inode->i_uid_high) << 16;
 		inode->i_gid |= le16_to_cpu(raw_inode->i_gid_high) << 16;
@@ -1088,6 +1089,7 @@
 		raw_inode->i_uid_high = 0;
 		raw_inode->i_gid_high = 0;
 	}
+	raw_inode->i_e2_tid = cpu_to_le32(inode->i_tid);
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 	raw_inode->i_size = cpu_to_le32(inode->i_size);
 	raw_inode->i_atime = cpu_to_le32(inode->i_atime);
--- ./fs/ext2/ialloc.c	2001/10/16 04:37:09	1.1
+++ ./fs/ext2/ialloc.c	2001/10/18 04:34:27	1.2
@@ -421,6 +421,7 @@
 	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
 	sb->s_dirt = 1;
 	inode->i_uid = current->fsuid;
+	inode->i_tid = treequota_tid(dir, inode->i_uid);
 	if (test_opt (sb, GRPID))
 		inode->i_gid = dir->i_gid;
 	else if (dir->i_mode & S_ISGID) {
--- ./fs/dquot.c	2001/10/15 07:23:34	1.1
+++ ./fs/dquot.c	2001/10/18 04:34:27	1.2
@@ -12,7 +12,7 @@
  * based on one of the several variants of the LINUX inode-subsystem
  * with added complexity of the diskquota system.
  * 
- * Version: $Id: dquot.c,v 6.3 1996/11/17 18:35:34 mvw Exp mvw $
+ * Version: $Id: dquot.c,v 1.1 2001/10/15 07:23:34 neilb Exp neilb $
  * 
  * Author:	Marco van Wieringen <mvw@planets.elm.net>
  *
@@ -64,7 +64,7 @@
 
 #include <asm/uaccess.h>
 
-#define __DQUOT_VERSION__	"dquot_6.4.0"
+#define __DQUOT_VERSION__	"dquot_6.4.0t"
 
 int nr_dquots, nr_free_dquots;
 
@@ -127,6 +127,9 @@
 			return((dqopt->flags & DQUOT_USR_ENABLED) != 0);
 		case GRPQUOTA:
 			return((dqopt->flags & DQUOT_GRP_ENABLED) != 0);
+		case TREEQUOTA:
+			return((dqopt->flags & DQUOT_TREE_ENABLED) != 0);
+
 	}
 	return(0);
 }
@@ -689,6 +692,7 @@
 			return current->fsuid == dquot->dq_id && !(dquot->dq_flags & flag);
 		case GRPQUOTA:
 			return in_group_p(dquot->dq_id) && !(dquot->dq_flags & flag);
+		/* FIXME TREEQUOTA */
 	}
 	return 0;
 }
@@ -988,6 +992,9 @@
 				case GRPQUOTA:
 					id = inode->i_gid;
 					break;
+				case TREEQUOTA:
+					id = inode->i_tid;
+					break;
 			}
 			dquot[cnt] = dqget(inode->i_sb, id, cnt);
 		}
@@ -1152,6 +1159,8 @@
 	struct dquot *transfer_to[MAXQUOTAS];
 	int cnt, ret = NO_QUOTA, chuid = (iattr->ia_valid & ATTR_UID) && inode->i_uid != iattr->ia_uid,
 	    chgid = (iattr->ia_valid & ATTR_GID) && inode->i_gid != iattr->ia_gid;
+	int chtreeid = (iattr->ia_valid & ATTR_TID) && inode->i_tid != iattr->ia_tid;
+	
 	char warntype[MAXQUOTAS];
 
 	/* Clear the arrays */
@@ -1174,6 +1183,11 @@
 					continue;
 				transfer_to[cnt] = dqget(inode->i_sb, iattr->ia_gid, cnt);
 				break;
+			case TREEQUOTA:
+				if (!chtreeid)
+					continue;
+				transfer_to[cnt] = dqget(inode->i_sb, iattr->ia_tid, cnt);
+				break;
 		}
 	}
 	/* NOBLOCK START: From now on we shouldn't block */
@@ -1186,6 +1200,8 @@
 		transfer_from[cnt] = dqduplicate(inode->i_dquot[cnt]);
 		if (transfer_from[cnt] == NODQUOT)	/* Can happen on quotafiles (quota isn't initialized on them)... */
 			continue;
+		if (iattr->ia_valid & ATTR_FORCE)
+			continue;			/* don't check, just do */
 		if (check_idq(transfer_to[cnt], 1, warntype+cnt) == NO_QUOTA ||
 		    check_bdq(transfer_to[cnt], blocks, 0, warntype+cnt) == NO_QUOTA)
 			goto warn_put_all;
@@ -1262,6 +1278,9 @@
 		case GRPQUOTA:
 			dqopt->flags |= DQUOT_GRP_ENABLED;
 			break;
+		case TREEQUOTA:
+			dqopt->flags |= DQUOT_TREE_ENABLED;
+			break;
 	}
 }
 
@@ -1274,6 +1293,9 @@
 		case GRPQUOTA:
 			dqopt->flags &= ~DQUOT_GRP_ENABLED;
 			break;
+		case TREEQUOTA:
+			dqopt->flags &= ~DQUOT_TREE_ENABLED;
+			break;
 	}
 }
 
@@ -1413,7 +1435,7 @@
 			break;
 		case Q_GETQUOTA:
 			if (((type == USRQUOTA && current->euid != id) ||
-			     (type == GRPQUOTA && !in_egroup_p(id))) &&
+			     (type == GRPQUOTA && !in_egroup_p(id))) && /* FIXME TREEQUOTA */
 			    !capable(CAP_SYS_ADMIN))
 				goto out;
 			break;
--- ./fs/attr.c	2001/10/15 22:54:34	1.1
+++ ./fs/attr.c	2001/10/18 04:34:27	1.2
@@ -73,6 +73,8 @@
 		inode->i_uid = attr->ia_uid;
 	if (ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
+	if (ia_valid & ATTR_TID)
+		inode->i_tid = attr->ia_tid;
 	if (ia_valid & ATTR_ATIME)
 		inode->i_atime = attr->ia_atime;
 	if (ia_valid & ATTR_MTIME)
@@ -127,6 +129,16 @@
 	if (!(ia_valid & ATTR_MTIME_SET))
 		attr->ia_mtime = now;
 
+	if (!(ia_valid & ATTR_TID)
+	    && (ia_valid & ATTR_UID)
+	    && !treequota_parent_uid_ok(inode, dentry->d_parent->d_inode,
+					attr->ia_uid)) {
+
+		attr->ia_tid = treequota_tid(dentry->d_parent->d_inode,
+					     attr->ia_uid);
+		ia_valid |= ATTR_TID;
+		attr->ia_valid = ia_valid;
+	}
 	lock_kernel();
 	if (inode->i_op && inode->i_op->setattr) 
 		error = inode->i_op->setattr(dentry, attr);
@@ -134,6 +146,7 @@
 		error = inode_change_ok(inode, attr);
 		if (!error) {
 			if ((ia_valid & ATTR_UID && attr->ia_uid != inode->i_uid) ||
+			    (ia_valid & ATTR_TID && attr->ia_tid != inode->i_tid) ||
 			    (ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid))
 				error = DQUOT_TRANSFER(inode, attr) ? -EDQUOT : 0;
 			if (!error)
--- ./fs/namei.c	2001/10/15 23:04:31	1.1
+++ ./fs/namei.c	2001/10/18 04:34:27	1.2
@@ -524,6 +524,7 @@
 			if (IS_ERR(dentry))
 				break;
 		}
+		treequota_check(dentry);
 		/* Check mountpoints.. */
 		while (d_mountpoint(dentry) && __follow_down(&nd->mnt, &dentry))
 			;
@@ -1586,6 +1587,8 @@
 	if (dir->i_dev != inode->i_dev)
 		goto exit_lock;
 
+	if (!treequota_parent_ok(dir, inode))
+		goto exit_lock;
 	/*
 	 * A link to an append-only or immutable file cannot be created.
 	 */
@@ -1693,6 +1696,7 @@
 {
 	int error;
 	struct inode *target;
+	struct iattr attr;
 
 	if (old_dentry->d_inode == new_dentry->d_inode)
 		return 0;
@@ -1704,6 +1708,10 @@
 	if (new_dir->i_dev != old_dir->i_dev)
 		return -EXDEV;
 
+	if (!treequota_parent_ok(new_dir, old_dentry->d_inode)
+	    && !capable(CAP_CHOWN))
+		return -EXDEV;
+	
 	if (!new_dentry->d_inode)
 		error = may_create(new_dir, new_dentry);
 	else
@@ -1743,11 +1751,16 @@
 	} else
 		double_down(&old_dir->i_zombie,
 			    &new_dir->i_zombie);
+	attr.ia_valid = ATTR_TID;
+	attr.ia_tid = treequota_tid(new_dir, old_dentry->d_inode->i_uid);
 	if (IS_DEADDIR(old_dir)||IS_DEADDIR(new_dir))
 		error = -ENOENT;
 	else if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
 		error = -EBUSY;
-	else 
+	else if (!treequota_parent_ok(old_dentry->d_inode, new_dir)
+		 && (error = notify_change(old_dentry, &attr)))
+		;
+	else
 		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
 	if (target) {
 		if (!error)
@@ -1799,8 +1812,20 @@
 	double_down(&old_dir->i_zombie, &new_dir->i_zombie);
 	if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
 		error = -EBUSY;
-	else
-		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
+	else {
+		error = 0;
+		if (!treequota_parent_ok(new_dir, old_dentry->d_inode)) {
+			struct iattr attr;
+			if (old_dentry->d_inode->i_nlink > 1)
+				return -EXDEV;
+			attr.ia_valid = ATTR_TID;
+			attr.ia_tid = treequota_tid(new_dir,
+					    old_dentry->d_inode->i_uid);
+			error = notify_change(old_dentry, &attr);
+		}
+		if (!error) 
+			error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
+	}
 	double_up(&old_dir->i_zombie, &new_dir->i_zombie);
 	if (error)
 		return error;
--- ./fs/stat.c	2001/10/16 06:44:17	1.1
+++ ./fs/stat.c	2001/10/18 04:34:27	1.2
@@ -78,6 +78,7 @@
 	tmp.st_nlink = inode->i_nlink;
 	SET_STAT_UID(tmp, inode->i_uid);
 	SET_STAT_GID(tmp, inode->i_gid);
+	tmp.__unused5 = inode->i_tid;
 	tmp.st_rdev = kdev_t_to_nr(inode->i_rdev);
 #if BITS_PER_LONG == 32
 	if (inode->i_size > MAX_NON_LFS)
--- ./include/linux/quota.h	2001/10/15 07:04:25	1.1
+++ ./include/linux/quota.h	2001/10/18 04:34:27	1.2
@@ -33,7 +33,7 @@
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE.
  *
- * Version: $Id: quota.h,v 2.0 1996/11/17 16:48:14 mvw Exp mvw $
+ * Version: $Id: quota.h,v 1.1 2001/10/15 07:04:25 neilb Exp neilb $
  */
 
 #ifndef _LINUX_QUOTA_
@@ -65,9 +65,10 @@
 #define MAX_IQ_TIME  604800	/* (7*24*60*60) 1 week */
 #define MAX_DQ_TIME  604800	/* (7*24*60*60) 1 week */
 
-#define MAXQUOTAS 2
+#define MAXQUOTAS 3
 #define USRQUOTA  0		/* element used for user quotas */
 #define GRPQUOTA  1		/* element used for group quotas */
+#define	TREEQUOTA 2		/* element used for tree quotas */
 
 /*
  * Definitions for the default names of the quotas files.
@@ -75,6 +76,7 @@
 #define INITQFNAMES { \
 	"user",    /* USRQUOTA */ \
 	"group",   /* GRPQUOTA */ \
+	"tree",    /* TREEQUOTA */ \
 	"undefined", \
 };
 
--- ./include/linux/quotaops.h	2001/10/15 07:22:03	1.1
+++ ./include/linux/quotaops.h	2001/10/18 04:34:27	1.2
@@ -4,7 +4,7 @@
  *
  * Author:  Marco van Wieringen <mvw@planets.elm.net>
  *
- * Version: $Id: quotaops.h,v 1.2 1998/01/15 16:22:26 ecd Exp $
+ * Version: $Id: quotaops.h,v 1.1 2001/10/15 07:22:03 neilb Exp neilb $
  *
  */
 #ifndef _LINUX_QUOTAOPS_
@@ -36,7 +36,7 @@
 /*
  * Operations supported for diskquotas.
  */
-#define sb_any_quota_enabled(sb) ((sb)->s_dquot.flags & (DQUOT_USR_ENABLED | DQUOT_GRP_ENABLED))
+#define sb_any_quota_enabled(sb) ((sb)->s_dquot.flags & (DQUOT_USR_ENABLED | DQUOT_GRP_ENABLED | DQUOT_TREE_ENABLED))
 
 static __inline__ void DQUOT_INIT(struct inode *inode)
 {
@@ -162,6 +162,53 @@
 #define DQUOT_SYNC(dev)	sync_dquots(dev, -1)
 #define DQUOT_OFF(sb)	quota_off(sb, -1)
 
+static __inline__ int treequota_parent_uid_ok(struct inode *inode, struct inode *dir, uid_t uid)
+{
+	if (!inode->i_sb->s_dquot.flags & DQUOT_TREE_ENABLED)
+		return 1;
+	if (dir->i_tid
+	    ? (inode->i_tid ==   dir->i_tid)
+	    : (inode->i_tid ==   uid))
+		return 1;
+	return 0;
+}
+
+static __inline__ int treequota_parent_ok(struct inode *inode, struct inode *dir)
+{
+	return treequota_parent_uid_ok(inode,dir, inode->i_uid);
+}
+
+static __inline__ int treequota_tid(struct inode *dir, uid_t uid)
+{
+	if (!dir->i_sb->s_dquot.flags & DQUOT_TREE_ENABLED)
+		return 0;
+	return dir->i_tid
+		? dir->i_tid
+		: uid;
+}
+
+static __inline__ void treequota_check(struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	struct iattr attr;
+	if (!inode->i_sb->s_dquot.flags & DQUOT_TREE_ENABLED)
+		return;
+	if (treequota_parent_ok(inode, dentry->d_parent->d_inode))
+		return;
+
+	attr.ia_valid = ATTR_FORCE | ATTR_TID;
+	attr.ia_tid = treequota_tid(dentry->d_parent->d_inode,
+				    inode->i_uid);
+	if (!S_ISDIR(inode->i_mode)
+	    && inode->i_nlink > 1) {
+		printk(KERN_WARNING "treequota: file with multiple links has wrong tree-id\n");
+		printk(KERN_WARNING "  dev=%x ino=%ld dino=%ld\n",
+		       inode->i_dev, inode->i_ino,
+		       dentry->d_parent->d_inode->i_ino);
+		printk(KERN_WARNING "  basename=%s\n", dentry->d_name.name);
+	}
+	notify_change(dentry, &attr);
+}
 #else
 
 /*
@@ -216,6 +263,10 @@
 	DQUOT_FREE_BLOCK_NODIRTY(inode, nr);
 	mark_inode_dirty(inode);
 }	
+
+#define treequota_parent_uid_ok(inode,dir,uid) (1)
+#define	treequota_parent_ok(inode,dir) (1)
+#define treequota_tid(inode,uid) (0)
 
 #endif /* CONFIG_QUOTA */
 #endif /* _LINUX_QUOTAOPS_ */
--- ./include/linux/fs.h	2001/10/15 07:22:35	1.1
+++ ./include/linux/fs.h	2001/10/18 04:34:27	1.2
@@ -327,6 +327,7 @@
 #define ATTR_MTIME_SET	256
 #define ATTR_FORCE	512	/* Not a change, but a change it */
 #define ATTR_ATTR_FLAG	1024
+#define	ATTR_TID	2048
 
 /*
  * This is the Inode Attributes structure, used for notify_change().  It
@@ -347,6 +348,7 @@
 	time_t		ia_mtime;
 	time_t		ia_ctime;
 	unsigned int	ia_attr_flags;
+	uid_t		ia_tid;
 };
 
 /*
@@ -430,6 +432,7 @@
 	nlink_t			i_nlink;
 	uid_t			i_uid;
 	gid_t			i_gid;
+	uid_t			i_tid;	/* tree-id for quotas */
 	kdev_t			i_rdev;
 	loff_t			i_size;
 	time_t			i_atime;
@@ -636,6 +639,7 @@
 
 #define DQUOT_USR_ENABLED	0x01		/* User diskquotas enabled */
 #define DQUOT_GRP_ENABLED	0x02		/* Group diskquotas enabled */
+#define DQUOT_TREE_ENABLED	0x04		/* Tree diskquotas enabled */
 
 struct quota_mount_options
 {
--- ./include/linux/ext2_fs.h	2001/10/15 22:45:41	1.1
+++ ./include/linux/ext2_fs.h	2001/10/18 04:34:27	1.2
@@ -249,7 +249,7 @@
 			__u16	i_pad1;
 			__u16	l_i_uid_high;	/* these 2 fields    */
 			__u16	l_i_gid_high;	/* were reserved2[0] */
-			__u32	l_i_reserved2;
+			__u32	l_i_tid;	/* tree-id for quotas, no longer l_i_reserved2 */
 		} linux2;
 		struct {
 			__u8	h_i_frag;	/* Fragment number */
@@ -278,7 +278,7 @@
 #define i_gid_low	i_gid
 #define i_uid_high	osd2.linux2.l_i_uid_high
 #define i_gid_high	osd2.linux2.l_i_gid_high
-#define i_reserved2	osd2.linux2.l_i_reserved2
+#define i_e2_tid	osd2.linux2.l_i_tid
 #endif
 
 #ifdef	__hurd__



