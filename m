Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbVHSLPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbVHSLPT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 07:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbVHSLPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 07:15:19 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:27850 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932628AbVHSLPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 07:15:17 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Kernel bug: Bad page state: related to generic symlink code and
	mmap
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: vandrove@vc.cvut.cz, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linware@sh.cvut.cz, fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 19 Aug 2005 12:14:48 +0100
Message-Id: <1124450088.2294.31.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a bug somewhere in 2.6.11.4 and I can't figure out where it is.
I assume it is present in older and newer kernels, too as the related
code hasn't changed much AFAICS and googling for "Bad page state"
returns rather a lot of hits relating to both older (up to 2.5.70!) and
newer kernels...

Note: PLEASE do not stop reading because you read ncpfs below as I am
pretty sure it is not ncpfs related!  And looking at google a lot of
people have reported such similar problems since 2.5.70 or so and they
were all told to go away as they have bad ram.  That is impossible
because this happens on well over 600 workstations and several servers
100% reproducible.  Many different types of hardware, different makes,
difference age, all running smp kernels even if single cpu.  You can't
tell me they all have bad ram.  Windows works fine and Linux works fine
except for that one specific problem which is 100% reproducible...

The bug only appears, but it appears 100% reproducibly when a cross
volume symlink on ncpfs is accessed using nautilus under gnome.  I.e.
double click on a cross volume symlink on ncpfs in nautilus and the
machine locks up solid.  Here is what is logged to syslog over the
network (this is an example, after the second message the machine is
locked up solid, I can send you other traces if you want to see more of
them):

Bad page state at free_hot_cold_page (in process 'nautilus', page c10d33c0)
flags:0x2000000c mapping:cd83f5d0 mapcount:0 count:0
Backtrace:
 [<c01470ec>] bad_page+0x7c/0xb0
 [<c014790c>] free_hot_cold_page+0x7c/0x110
 [<c01482fc>] __pagevec_free+0x1c/0x30
 [<c014d3e3>] release_pages+0x163/0x180
 [<c014d572>] __pagevec_lru_add+0xb2/0xc0
 [<c014d1a5>] lru_add_drain+0x45/0x50
 [<c015640f>] unmap_region+0x2f/0x130
 [<c015653a>] detach_vmas_to_be_unmapped+0x2a/0x60
 [<c0156782>] do_munmap+0x102/0x150
 [<c0156818>] sys_munmap+0x48/0x70
 [<c0104079>] sysenter_past_esp+0x52/0x79
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'nautilus', page c10d33c0)
flags:0x20000004 mapping:00000000 mapcount:1 count:0
Backtrace:
 [<c01470ec>] bad_page+0x7c/0xb0
 [<c014790c>] free_hot_cold_page+0x7c/0x110
 [<c0171659>] link_path_walk+0x929/0xe80
 [<c02b6882>] ip_local_deliver+0x192/0x290
 [<c02b6d94>] ip_rcv+0x414/0x540
 [<c0171e96>] path_lookup+0xa6/0x1c0
 [<c01726f2>] open_namei+0x82/0x680
 [<c011b297>] recalc_task_prio+0xe7/0x200
 [<c0162588>] filp_open+0x28/0x50
 [<c016284a>] get_unused_fd+0x9a/0xc0
 [<c01705e8>] getname+0x68/0xe0
 [<c016295c>] sys_open+0x3c/0xa0
 [<c0104079>] sysenter_past_esp+0x52/0x79
Trying to fix it up, but a reboot is needed

So somehow pages get into a bad state.

Note that using gnome-terminal or console to access the symlink works
fine.  It is only nautilus and looking at the backtrace it has something
to do with mmap.

Note this is not an ncpfs bug AFAICS because ncpfs uses the generic
symlink code provided by VFS.  From fs/ncpfs/inode.c:

static struct inode_operations ncp_symlink_inode_operations = {
        .readlink       = generic_readlink,
        .follow_link    = page_follow_link_light,
        .put_link       = page_put_link,
        .setattr        = ncp_notify_change,
};

And from fs/ncpfs/symlink.c:

struct address_space_operations ncp_symlink_aops = {
        .readpage       = ncp_symlink_readpage,
};

And ncp_symlink_readpage() is:

#define NCP_SYMLINK_MAGIC0      cpu_to_le32(0x6c6d7973)     /* "symlnk->" */
#define NCP_SYMLINK_MAGIC1      cpu_to_le32(0x3e2d6b6e)

/* ----- read a symbolic link ------------------------------------------ */

static int ncp_symlink_readpage(struct file *file, struct page *page)
{
        struct inode *inode = page->mapping->host;
        int error, length, len;
        char *link, *rawlink;
        char *buf = kmap(page);

        error = -ENOMEM;
        rawlink=(char *)kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_KERNEL);
        if (!rawlink)
                goto fail;

        if (ncp_make_open(inode,O_RDONLY))
                goto failEIO;

        error=ncp_read_kernel(NCP_SERVER(inode),NCP_FINFO(inode)->file_handle,
                         0,NCP_MAX_SYMLINK_SIZE,rawlink,&length);

        ncp_inode_close(inode);
        /* Close file handle if no other users... */
        ncp_make_closed(inode);
        if (error)
                goto failEIO;

        if (NCP_FINFO(inode)->flags & NCPI_KLUDGE_SYMLINK) {
                if (length<NCP_MIN_SYMLINK_SIZE ||
                    ((__le32 *)rawlink)[0]!=NCP_SYMLINK_MAGIC0 ||
                    ((__le32 *)rawlink)[1]!=NCP_SYMLINK_MAGIC1)
                        goto failEIO;
                link = rawlink + 8;
                length -= 8;
        } else {
                link = rawlink;
        }

        len = NCP_MAX_SYMLINK_SIZE;
        error = ncp_vol2io(NCP_SERVER(inode), buf, &len, link, length, 0);
        kfree(rawlink);
        if (error)
                goto fail;
        SetPageUptodate(page);
        kunmap(page);
        unlock_page(page);
        return 0;

failEIO:
        error = -EIO;
        kfree(rawlink);
fail:
        SetPageError(page);
        kunmap(page);
        unlock_page(page);
        return error;
}

Looking at fs/namei.c at the generic VFS symlink helpers ncpfs uses I
have no idea what is going wrong.  Any ideas?

Note that this problem is fixed by applying the below patch against
current 2.6.git tree.

Linus/Andrew, unless Petr objects, I would suggest you apply it so at
least ncpfs is fixed.  

This is a really serious problem since _any_ user can completely lockup
a machine by just creating a cross volume symlink using ncpfs and going
across it using nautilus.  For us here at Cambridge University this is a
big problem since we have home directories on ncpfs (we have local
patches to make ncpfs work well enough for that) and on our multiuser
public university Linux servers one user can kill the whole server at
will...

However this patch will not fix whatever the underlying problem in the
vfs/mm is.  It just hides it for ncpfs by not using the generic kernel
symlink mechanism any more.  So it would be good to find and kill the
bug.

The patch is tested and does indeed make the hangs and bad page state
messages go away.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

[ncpfs] Fix cross volume symlink lockups due to nautilus.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

diff -urNp linux-2.6.git/fs/ncpfs.old/inode.c linux-2.6.git/fs/ncpfs/inode.c
--- linux-2.6.git/fs/ncpfs.old/inode.c	2005-07-17 07:19:56.000000000 +0100
+++ linux-2.6.git/fs/ncpfs/inode.c	2005-08-19 12:00:49.000000000 +0100
@@ -104,7 +104,8 @@ static struct super_operations ncp_sops 
 
 extern struct dentry_operations ncp_root_dentry_operations;
 #if defined(CONFIG_NCPFS_EXTRAS) || defined(CONFIG_NCPFS_NFS_NS)
-extern struct address_space_operations ncp_symlink_aops;
+extern int ncp_follow_link(struct dentry *, struct nameidata *);
+extern void ncp_put_link(struct dentry *, struct nameidata *);
 extern int ncp_symlink(struct inode*, struct dentry*, const char*);
 #endif
 
@@ -233,8 +234,8 @@ static void ncp_set_attr(struct inode *i
 #if defined(CONFIG_NCPFS_EXTRAS) || defined(CONFIG_NCPFS_NFS_NS)
 static struct inode_operations ncp_symlink_inode_operations = {
 	.readlink	= generic_readlink,
-	.follow_link	= page_follow_link_light,
-	.put_link	= page_put_link,
+	.follow_link	= ncp_follow_link,
+	.put_link	= ncp_put_link,
 	.setattr	= ncp_notify_change,
 };
 #endif
@@ -272,7 +273,6 @@ ncp_iget(struct super_block *sb, struct 
 #if defined(CONFIG_NCPFS_EXTRAS) || defined(CONFIG_NCPFS_NFS_NS)
 		} else if (S_ISLNK(inode->i_mode)) {
 			inode->i_op = &ncp_symlink_inode_operations;
-			inode->i_data.a_ops = &ncp_symlink_aops;
 #endif
 		} else {
 			make_bad_inode(inode);
diff -urNp linux-2.6.git/fs/ncpfs.old/symlink.c linux-2.6.git/fs/ncpfs/symlink.c
--- linux-2.6.git/fs/ncpfs.old/symlink.c	2005-07-17 07:19:56.000000000 +0100
+++ linux-2.6.git/fs/ncpfs/symlink.c	2005-08-19 12:00:49.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/stat.h>
+#include <linux/namei.h>
 #include "ncplib_kernel.h"
 
 
@@ -41,68 +42,76 @@
 
 /* ----- read a symbolic link ------------------------------------------ */
 
-static int ncp_symlink_readpage(struct file *file, struct page *page)
+static inline int ncp_read_link(struct inode *inode, char *link, int link_len)
 {
-	struct inode *inode = page->mapping->host;
-	int error, length, len;
-	char *link, *rawlink;
-	char *buf = kmap(page);
+	char *rawlink, *tmplink;
+	int err, len;
 
-	error = -ENOMEM;
-	rawlink=(char *)kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_KERNEL);
+	rawlink = (char*)kmalloc(NCP_MAX_SYMLINK_SIZE, GFP_KERNEL);
 	if (!rawlink)
-		goto fail;
-
-	if (ncp_make_open(inode,O_RDONLY))
-		goto failEIO;
-
-	error=ncp_read_kernel(NCP_SERVER(inode),NCP_FINFO(inode)->file_handle,
-                         0,NCP_MAX_SYMLINK_SIZE,rawlink,&length);
+		return -ENOMEM;
 
+	if (ncp_make_open(inode, O_RDONLY)) {
+		err = -EIO;
+		goto fail;
+	}
+	err = ncp_read_kernel(NCP_SERVER(inode), NCP_FINFO(inode)->file_handle,
+                         0, NCP_MAX_SYMLINK_SIZE, rawlink, &len);
 	ncp_inode_close(inode);
 	/* Close file handle if no other users... */
 	ncp_make_closed(inode);
-	if (error)
-		goto failEIO;
-
+	if (err) {
+		err = -EIO;
+		goto fail;
+	}
 	if (NCP_FINFO(inode)->flags & NCPI_KLUDGE_SYMLINK) {
-		if (length<NCP_MIN_SYMLINK_SIZE || 
-		    ((__le32 *)rawlink)[0]!=NCP_SYMLINK_MAGIC0 ||
-		    ((__le32 *)rawlink)[1]!=NCP_SYMLINK_MAGIC1)
-		    	goto failEIO;
-		link = rawlink + 8;
-		length -= 8;
+		if (len < NCP_MIN_SYMLINK_SIZE ||
+				((__le32 *)rawlink)[0] != NCP_SYMLINK_MAGIC0 ||
+				((__le32 *)rawlink)[1] != NCP_SYMLINK_MAGIC1) {
+			err = -EIO;
+			goto fail;
+		}
+		tmplink = rawlink + 8;
+		len -= 8;
 	} else {
-		link = rawlink;
+		tmplink = rawlink;
 	}
-
-	len = NCP_MAX_SYMLINK_SIZE;
-	error = ncp_vol2io(NCP_SERVER(inode), buf, &len, link, length, 0);
+	if (link_len > NCP_MAX_SYMLINK_SIZE)
+		link_len = NCP_MAX_SYMLINK_SIZE;
+	/* Returned string is zero terminated. */
+	err = ncp_vol2io(NCP_SERVER(inode), link, &link_len, tmplink, len, 0);
+	if (!err)
+		err = link_len;
+fail:
 	kfree(rawlink);
-	if (error)
-		goto fail;
-	SetPageUptodate(page);
-	kunmap(page);
-	unlock_page(page);
+	return err;
+}
+
+int ncp_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char *link = __getname();
+
+	if (!link)
+		link = ERR_PTR(-ENOMEM);
+	else {
+		/* Returned string is zero terminated. */
+		int len = ncp_read_link(dentry->d_inode, link, PATH_MAX);
+		if (len < 0) {
+			__putname(link);
+			link = ERR_PTR(len);
+		}
+	}
+	nd_set_link(nd, link);
 	return 0;
+}
 
-failEIO:
-	error = -EIO;
-	kfree(rawlink);
-fail:
-	SetPageError(page);
-	kunmap(page);
-	unlock_page(page);
-	return error;
+void ncp_put_link(struct dentry *dentry, struct nameidata *nd)
+{
+	char *s = nd_get_link(nd);
+	if (!IS_ERR(s))
+		__putname(s);
 }
 
-/*
- * symlinks can't do much...
- */
-struct address_space_operations ncp_symlink_aops = {
-	.readpage	= ncp_symlink_readpage,
-};
-	
 /* ----- create a new symbolic link -------------------------------------- */
  
 int ncp_symlink(struct inode *dir, struct dentry *dentry, const char *symname) {


