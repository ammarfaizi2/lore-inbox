Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265181AbUFBXRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265181AbUFBXRs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 19:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbUFBXRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 19:17:48 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:65179 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265181AbUFBXQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 19:16:11 -0400
From: "Peter J. Braam" <braam@clusterfs.com>
To: <linux-kernel@vger.kernel.org>
Cc: <hch@infradead.org>, <axboe@suse.de>, <lmb@suse.de>, <kevcorry@us.ibm.com>,
       <arjanv@redhat.com>, <iro@parcelfarce.linux.theplanet.co.uk>,
       <trond.myklebust@fys.uio.no>, <anton@samba.org>,
       <lustre-devel@clusterfs.com>
Subject: RE: [PATCH/RFC] Lustre VFS patch, version 2
Date: Wed, 2 Jun 2004 17:15:27 -0600
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002D_01C448C5.340A8B80"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRI93iowqv+eXCVRkiiirS70Dr8Xw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <20040602231554.ADC7B3100AE@moraine.clusterfs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello!
 
The feedback of the Lustre patches was of very high quality, thanks a
lot for studying it carefully.  Things are simpler now.
 
Oleg Drokin and I discussed the emails extensively and here is our reply. 
We have attached another collection of patches, addressing many of the
concerns.
We felt it is was perhaps easier to keep this all in one long email.
 
People requested to see the code that uses the patch.  We have uploaded that
to:
 
ftp://ftp.clusterfs.com:/pub/lustre/lkml/lustre-client_and_mds.tgz 
 
The client file system is the primary user of the kernel patch, in the
llite directory. The MDS server is a sample user of do_kern_mount.  As
requested I have removed many other things from the tar ball to make
review simple (so this won't compile or run).
 
1. Export symbols concerns by Christoph Hellwig: 
 
Indeed we can do without __iget, kernel_text_address, reparent_to_init
and exit_files.
 
We actually need do_kern_mount and truncate_complete_page.  Do kern
mount is used because we use a file system namespace in servers in the
kernel without exporting it to user space (mds/handler.c).  The server
file systems are ext3 file systems but we replace VFS locking with DLM
locks, and it would take considerable work to export that as a file
system.
 
Truncate_complete_page is used to remove pages in the middle of a file
mapping, when lock revocations happen (llite/file.c
ll_extent_lock_callback, calling ll_pgcache_remove_extent) .
 
2. lustre_version.patch concerns by Christoph Hellwig:
 
This one can easily be removed, but kernel version alone does not
necessarily represent anything useful. There are tons of people
patching their kernel with patches, even applying parts of newer
kernel and still leaving kernel version at its old value
(distributions immediately come to mind). So we still need something
to identify version of necessary bits. E.g. version of intent API.
 
3. Introduction of lock-less version of d_rehash (__d_rehash) by
   Christoph Hellwig:
 
In some places lustre needs to do several things to dentry's with
dcache lock held already, e.g. traverse alias dentries in inode to
find one with same name and parent as the one we have already.  Lustre
can invalidate busy dentries, which we put on a list.  If these are
looked up again, concurrently, we find them on this list and re-use
them, to avoid having several identical aliases in an inode.  See
llite/{dcache.c,namei.c} ll_revalidate and the lock callback function
ll_mdc_blocking_ast which calls ll_unhash_aliases.  We use d_move to
manipulate dentries associated with raw inodes and names in ext3.
 
4. vfs intent API changes kernel exported concern API by Christoph
   Hellwig:
 
With slight modification it is possible to reduce the changes to just
changes in the name of intent structure itself and some of its
fields. 
 
This renaming was requested by Linus, but we can change names back
easily if needed, that would avoid any api change.  Are there other
users, please let us know what to do?
 
All the functions can easily be split into valid intent expecting ones
(with some suffix in name like _it) and those that are part of old API
would just initialise the intent to something sensible and then call
corresponding intent-expecting function. No harm should be done to
external filesystems this way. We have modified vfs intent API patch
to achieve this.
 
5. Some objections from Trond Myklebust about open flags in exec, cwd
   revalidation, and revalidate_counter patch:
 
We have fixed the exec open flags issue (our error). Also
revalidate_counter patch was dropped since we can do this inside
lustre as well. CWD revalidation can be converted to FS_REVAL_DOT in
fs flags instead, but we still need part of that patch, the
LOOKUP_LAST/LOOKUP_NOT_LAST part. Lustre needs to know when we reached
the last component in the path so that intent needs to be looked
at. (It seems we cannot use LOOKUP_CONTINUE for this reliably).
 
6. from Trond Myklebust:
 
> The vfs-intent_lustre-vanilla-2.6.patch + the "intent_release()"
> code. What if you end up crossing a mountpoint? How do you then know 
> to which superblock/filesystem the private field belongs if there are 
> more than one user of this mechanism?
 
Basically intent only makes sence for the last component. Our code
checks that and if we are doing lookup a component before the last,
then a dummy IT_LOOKUP intent is created on stack and we work with
that, perhaps the same is true for other filesystems that would like
to use this mechanism.
 
7. raw operations concerns by various people:
 
We have now implemented an alternative approach to this, that is
taking place when parent lookup is done, using intents.  For setattr
we managed to remove the raw operations alltogether, (praying that we
haven't forgotten some awful problem we solved that led to the
introduction of setattr_raw in the first place).
 
The correctly filled intent is recognised by filesystem's lookup or
revalidate method.  After the parent is looked up, based on the intent
the correct "raw" server call is executed, within the file
system. Then a special flag is set in intent, the caller of parent
lookup checks for the flag and if it is set, the functions returns
immediately with supplied (in intent)exit code, without instantiating
child dentries.
 
This needs some minor changes to VFS, though. There are at
least two approaches.
 
One is to not introduce any new methods and just rely on fs' metohds
to do everything, for this to work filesystem needs to know the
remaining path to be traversed (we can fill nd->last with remaining
path before calling into fs).  In the root directory of the mount, we
need to call a revalidate (if supported by fs) on mountpoint to
intercept the intent, after we crossed mountpoint. We have this
approach implemented in that attached patch.  Does it look better than
the raw operations?  
 
Much simpler for us is to add additional inode operation
"process_intent" method that would be called when LOOKUP_PARENT sort
of lookup was requested and we are about to leave link_path_walk()
with nameidata structure filled and everything ready.  Then the same
flag in intent will be set and everything else as in previous
approach.  
 
We believe both methods are less intrusive than the raw methods, but
slightly more delicate.
 
8. Mountpoint-crossing issues during rename (and link) noticed by
   Arjan van de Ven:
 
Well, indeed this can happen if source or destination is a mountpoint
on client but not server, this needs to be addressed by individual
filesystems that chose to implement those raw methods.
 
9. dev_readonly patch concerns by Jens Axboe:
 
We already clarified why we need it in this exact way. But there were
some valid suggestions to use other means like dm-flakey device mapper
module, so we decided to write a failure simulator DM.
 
10. "Have these patches undergone any siginifant test?" by Anton Blanchard:
 
There are two important questions I think: 
- Do the patches cause damage?
   Probably not anymore. SUSE has done testing and it appears the
   original patch I attached didn't break things (after one fix was
   made).
- Is Lustre stable?
   On 2.4 Lustre is quite stable.  On 2.6 we have done testing but,
   for example, never more than on 40 nodes.  We don't consider it
   rock solid on 2.6, it does pass POSIX and just about every other
   benchmark without failures.
 
Since the patches were modified for this discussion there are of
course some new issues which Oleg Drokin is now ironing out.
 
Our test results are visible at https://buffalo.lustre.org
 
Well, how close are we now to this being acceptable?
 
- Peter J. Braam & Oleg Drokin -


------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="export-vanilla-2.6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="export-vanilla-2.6.patch"

 fs/jbd/journal.c   |    1 +=0A=
 fs/super.c         |    2 ++=0A=
 include/linux/fs.h |    1 +=0A=
 include/linux/mm.h |    3 +++=0A=
 mm/truncate.c      |    4 +++-=0A=
 5 files changed, 10 insertions(+), 1 deletion(-)=0A=
=0A=
Index: linux-2.6.6/fs/jbd/journal.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/jbd/journal.c	2004-05-26 20:25:49.000000000 +0300=0A=
+++ linux-2.6.6/fs/jbd/journal.c	2004-05-27 21:08:52.686693408 +0300=0A=
@@ -71,6 +71,7 @@=0A=
 EXPORT_SYMBOL(journal_errno);=0A=
 EXPORT_SYMBOL(journal_ack_err);=0A=
 EXPORT_SYMBOL(journal_clear_err);=0A=
+EXPORT_SYMBOL(log_start_commit);=0A=
 EXPORT_SYMBOL(log_wait_commit);=0A=
 EXPORT_SYMBOL(journal_start_commit);=0A=
 EXPORT_SYMBOL(journal_wipe);=0A=
Index: linux-2.6.6/fs/super.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/super.c	2004-05-26 20:25:43.000000000 +0300=0A=
+++ linux-2.6.6/fs/super.c	2004-05-27 21:08:52.718688544 +0300=0A=
@@ -788,6 +788,8 @@=0A=
 	return (struct vfsmount *)sb;=0A=
 }=0A=
 =0A=
+EXPORT_SYMBOL(do_kern_mount);=0A=
+=0A=
 struct vfsmount *kern_mount(struct file_system_type *type)=0A=
 {=0A=
 	return do_kern_mount(type->name, 0, type->name, NULL);=0A=
Index: linux-2.6.6/include/linux/mm.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/mm.h	2004-05-26 20:26:11.000000000 =
+0300=0A=
+++ linux-2.6.6/include/linux/mm.h	2004-05-27 21:08:52.735685960 +0300=0A=
@@ -589,6 +589,9 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/* truncate.c */=0A=
+extern void truncate_complete_page(struct address_space *mapping,struct =
page *);=0A=
+=0A=
 /* filemap.c */=0A=
 extern unsigned long page_unuse(struct page *);=0A=
 extern void truncate_inode_pages(struct address_space *, loff_t);=0A=
Index: linux-2.6.6/include/linux/fs.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/fs.h	2004-05-27 21:08:45.986711960 =
+0300=0A=
+++ linux-2.6.6/include/linux/fs.h	2004-05-27 21:08:52.738685504 +0300=0A=
@@ -1137,6 +1137,7 @@=0A=
 extern int unregister_filesystem(struct file_system_type *);=0A=
 extern struct vfsmount *kern_mount(struct file_system_type *);=0A=
 extern int may_umount(struct vfsmount *);=0A=
+struct vfsmount *do_kern_mount(const char *type, int flags, const char =
*name, void *data);=0A=
 extern long do_mount(char *, char *, char *, unsigned long, void *);=0A=
 =0A=
 extern int vfs_statfs(struct super_block *, struct kstatfs *);=0A=
Index: linux-2.6.6/mm/truncate.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/mm/truncate.c	2004-05-26 20:26:14.000000000 +0300=0A=
+++ linux-2.6.6/mm/truncate.c	2004-05-27 21:08:52.750683680 +0300=0A=
@@ -42,7 +42,7 @@=0A=
  * its lock, b) when a concurrent invalidate_inode_pages got there =
first and=0A=
  * c) when tmpfs swizzles a page between a tmpfs inode and =
swapper_space.=0A=
  */=0A=
-static void=0A=
+void=0A=
 truncate_complete_page(struct address_space *mapping, struct page *page)=0A=
 {=0A=
 	if (page->mapping !=3D mapping)=0A=
@@ -58,6 +58,8 @@=0A=
 	page_cache_release(page);	/* pagecache ref */=0A=
 }=0A=
 =0A=
+EXPORT_SYMBOL(truncate_complete_page);=0A=
+=0A=
 /*=0A=
  * This is for invalidate_inode_pages().  That function can be called at=0A=
  * any time, and is not supposed to throw away dirty pages.  But pages =
can=0A=
=0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="header_guards-vanilla-2.6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="header_guards-vanilla-2.6.patch"

%diffstat=0A=
 blockgroup_lock.h |    4 +++-=0A=
 percpu_counter.h  |    4 ++++=0A=
 2 files changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
%patch=0A=
Index: linux-2.6.6/include/linux/percpu_counter.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/percpu_counter.h	2004-04-04 =
11:37:23.000000000 +0800=0A=
+++ linux-2.6.6/include/linux/percpu_counter.h	2004-05-22 =
16:08:16.000000000 +0800=0A=
@@ -3,6 +3,8 @@=0A=
  *=0A=
  * WARNING: these things are HUGE.  4 kbytes per counter on 32-way P4.=0A=
  */=0A=
+#ifndef _LINUX_PERCPU_COUNTER_H=0A=
+#define _LINUX_PERCPU_COUNTER_H=0A=
 =0A=
 #include <linux/config.h>=0A=
 #include <linux/spinlock.h>=0A=
@@ -101,3 +103,5 @@ static inline void percpu_counter_dec(st=0A=
 {=0A=
 	percpu_counter_mod(fbc, -1);=0A=
 }=0A=
+=0A=
+#endif /* _LINUX_PERCPU_COUNTER_H */=0A=
Index: linux-2.6.6/include/linux/blockgroup_lock.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/blockgroup_lock.h	2004-04-04 =
11:36:26.000000000 +0800=0A=
+++ linux-2.6.6/include/linux/blockgroup_lock.h	2004-05-22 =
16:08:45.000000000 +0800=0A=
@@ -3,6 +3,8 @@=0A=
  *=0A=
  * Simple hashed spinlocking.=0A=
  */=0A=
+#ifndef _LINUX_BLOCKGROUP_LOCK_H=0A=
+#define _LINUX_BLOCKGROUP_LOCK_H=0A=
 =0A=
 #include <linux/config.h>=0A=
 #include <linux/spinlock.h>=0A=
@@ -55,4 +57,4 @@ static inline void bgl_lock_init(struct =0A=
 #define sb_bgl_lock(sb, block_group) \=0A=
 	(&(sb)->s_blockgroup_lock.locks[(block_group) & (NR_BG_LOCKS-1)].lock)=0A=
 =0A=
-=0A=
+#endif=0A=
=0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="lustre_version.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lustre_version.patch"

Version 36: don't dput dentry after error (b=3D2350), zero page->private =
(3119)=0A=
Version 35: pass intent to real_lookup after revalidate failure =
(b=3D3285)=0A=
Version 34: fix ext3 iopen assertion failure (b=3D2517, b=3D2399)=0A=
=0A=
 include/linux/lustre_version.h |    1 +=0A=
 1 files changed, 1 insertion(+)=0A=
=0A=
--- /dev/null	Fri Aug 30 17:31:37 2002=0A=
+++ linux-2.4.18-18.8.0-l12-braam/include/linux/lustre_version.h	Thu Feb =
13 07:58:33 2003=0A=
@@ -0,0 +1 @@=0A=
+#define LUSTRE_KERNEL_VERSION 36=0A=
=0A=
_=0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="vanilla-2.6.6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vanilla-2.6.6"

lustre_version.patch=0A=
vfs_intent-flags_rename-vanilla-2.6.patch =0A=
vfs-dcache_locking-vanilla-2.6.patch=0A=
vfs-dcache_lustre_invalid-vanilla-2.6.patch =0A=
vfs-intent_api-vanilla-2.6.patch =0A=
vfs-raw_ops-vanilla-2.6.patch =0A=
export-vanilla-2.6.patch =0A=
header_guards-vanilla-2.6.patch =0A=
vfs-intent_lustre-vanilla-2.6.patch =0A=
vfs-do_truncate.patch=0A=
vfs-lookup_last-vanilla-2.6.patch=0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="vfs_intent-flags_rename-vanilla-2.6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vfs_intent-flags_rename-vanilla-2.6.patch"

%diffstat=0A=
 fs/cifs/dir.c         |   14 +++++++-------=0A=
 fs/exec.c             |    4 ++--=0A=
 fs/namei.c            |    4 ++--=0A=
 fs/nfs/dir.c          |   14 +++++++-------=0A=
 fs/nfs/nfs4proc.c     |    6 +++---=0A=
 include/linux/namei.h |   15 +++++++--------=0A=
 6 files changed, 28 insertions(+), 29 deletions(-)=0A=
=0A=
%patch=0A=
Index: linux-2.6.6/fs/exec.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/exec.c	2004-05-22 00:46:19.000000000 +0800=0A=
+++ linux-2.6.6/fs/exec.c	2004-05-22 01:36:12.000000000 +0800=0A=
@@ -122,7 +122,7 @@ asmlinkage long sys_uselib(const char __=0A=
 	struct nameidata nd;=0A=
 	int error;=0A=
 =0A=
-	nd.intent.open.flags =3D FMODE_READ;=0A=
+	nd.intent.it_flags =3D FMODE_READ;=0A=
 	error =3D __user_walk(library, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);=0A=
 	if (error)=0A=
 		goto out;=0A=
@@ -483,7 +483,7 @@ struct file *open_exec(const char *name)=0A=
 	int err;=0A=
 	struct file *file;=0A=
 =0A=
-	nd.intent.open.flags =3D FMODE_READ;=0A=
+	nd.intent.it_flags =3D FMODE_READ;=0A=
 	err =3D path_lookup(name, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);=0A=
 	file =3D ERR_PTR(err);=0A=
 =0A=
Index: linux-2.6.6/fs/namei.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/namei.c	2004-05-22 00:46:19.000000000 +0800=0A=
+++ linux-2.6.6/fs/namei.c	2004-05-22 01:36:46.000000000 +0800=0A=
@@ -1266,8 +1266,8 @@ int open_namei(const char * pathname, in=0A=
 		acc_mode |=3D MAY_APPEND;=0A=
 =0A=
 	/* Fill in the open() intent data */=0A=
-	nd->intent.open.flags =3D flag;=0A=
-	nd->intent.open.create_mode =3D mode;=0A=
+	nd->intent.it_flags =3D flag;=0A=
+	nd->intent.it_create_mode =3D mode;=0A=
 =0A=
 	/*=0A=
 	 * The simplest case - just a plain lookup.=0A=
Index: linux-2.6.6/fs/nfs/dir.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/nfs/dir.c	2004-04-04 11:37:06.000000000 +0800=0A=
+++ linux-2.6.6/fs/nfs/dir.c	2004-05-22 01:58:56.000000000 +0800=0A=
@@ -705,7 +705,7 @@ int nfs_is_exclusive_create(struct inode=0A=
 		return 0;=0A=
 	if (!nd || (nd->flags & LOOKUP_CONTINUE) || !(nd->flags & =
LOOKUP_CREATE))=0A=
 		return 0;=0A=
-	return (nd->intent.open.flags & O_EXCL) !=3D 0;=0A=
+	return (nd->intent.it_flags & O_EXCL) !=3D 0;=0A=
 }=0A=
 =0A=
 static struct dentry *nfs_lookup(struct inode *dir, struct dentry * =
dentry, struct nameidata *nd)=0A=
@@ -778,7 +778,7 @@ static int is_atomic_open(struct inode *=0A=
 	if (nd->flags & LOOKUP_DIRECTORY)=0A=
 		return 0;=0A=
 	/* Are we trying to write to a read only partition? */=0A=
-	if (IS_RDONLY(dir) && (nd->intent.open.flags & =
(O_CREAT|O_TRUNC|FMODE_WRITE)))=0A=
+	if (IS_RDONLY(dir) && (nd->intent.it_flags & =
(O_CREAT|O_TRUNC|FMODE_WRITE)))=0A=
 		return 0;=0A=
 	return 1;=0A=
 }=0A=
@@ -799,7 +799,7 @@ static struct dentry *nfs_atomic_lookup(=0A=
 	dentry->d_op =3D NFS_PROTO(dir)->dentry_ops;=0A=
 =0A=
 	/* Let vfs_create() deal with O_EXCL */=0A=
-	if (nd->intent.open.flags & O_EXCL)=0A=
+	if (nd->intent.it_flags & O_EXCL)=0A=
 		goto no_entry;=0A=
 =0A=
 	/* Open the file on the server */=0A=
@@ -807,7 +807,7 @@ static struct dentry *nfs_atomic_lookup(=0A=
 	/* Revalidate parent directory attribute cache */=0A=
 	nfs_revalidate_inode(NFS_SERVER(dir), dir);=0A=
 =0A=
-	if (nd->intent.open.flags & O_CREAT) {=0A=
+	if (nd->intent.it_flags & O_CREAT) {=0A=
 		nfs_begin_data_update(dir);=0A=
 		inode =3D nfs4_atomic_open(dir, dentry, nd);=0A=
 		nfs_end_data_update(dir);=0A=
@@ -823,7 +823,7 @@ static struct dentry *nfs_atomic_lookup(=0A=
 				break;=0A=
 			/* This turned out not to be a regular file */=0A=
 			case -ELOOP:=0A=
-				if (!(nd->intent.open.flags & O_NOFOLLOW))=0A=
+				if (!(nd->intent.it_flags & O_NOFOLLOW))=0A=
 					goto no_open;=0A=
 			/* case -EISDIR: */=0A=
 			/* case -EINVAL: */=0A=
@@ -857,7 +857,7 @@ static int nfs_open_revalidate(struct de=0A=
 	dir =3D parent->d_inode;=0A=
 	if (!is_atomic_open(dir, nd))=0A=
 		goto no_open;=0A=
-	openflags =3D nd->intent.open.flags;=0A=
+	openflags =3D nd->intent.it_flags;=0A=
 	if (openflags & O_CREAT) {=0A=
 		/* If this is a negative dentry, just drop it */=0A=
 		if (!inode)=0A=
@@ -1022,7 +1022,7 @@ static int nfs_create(struct inode *dir,=0A=
 	attr.ia_valid =3D ATTR_MODE;=0A=
 =0A=
 	if (nd && (nd->flags & LOOKUP_CREATE))=0A=
-		open_flags =3D nd->intent.open.flags;=0A=
+		open_flags =3D nd->intent.it_flags;=0A=
 =0A=
 	/*=0A=
 	 * The 0 argument passed into the create function should one day=0A=
Index: linux-2.6.6/fs/nfs/nfs4proc.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/nfs/nfs4proc.c	2004-05-22 00:46:19.000000000 =
+0800=0A=
+++ linux-2.6.6/fs/nfs/nfs4proc.c	2004-05-22 01:59:41.000000000 +0800=0A=
@@ -475,17 +475,17 @@ nfs4_atomic_open(struct inode *dir, stru=0A=
 	struct nfs4_state *state;=0A=
 =0A=
 	if (nd->flags & LOOKUP_CREATE) {=0A=
-		attr.ia_mode =3D nd->intent.open.create_mode;=0A=
+		attr.ia_mode =3D nd->intent.it_create_mode;=0A=
 		attr.ia_valid =3D ATTR_MODE;=0A=
 		if (!IS_POSIXACL(dir))=0A=
 			attr.ia_mode &=3D ~current->fs->umask;=0A=
 	} else {=0A=
 		attr.ia_valid =3D 0;=0A=
-		BUG_ON(nd->intent.open.flags & O_CREAT);=0A=
+		BUG_ON(nd->intent.it_flags & O_CREAT);=0A=
 	}=0A=
 =0A=
 	cred =3D rpcauth_lookupcred(NFS_SERVER(dir)->client->cl_auth, 0);=0A=
-	state =3D nfs4_do_open(dir, &dentry->d_name, nd->intent.open.flags, =
&attr, cred);=0A=
+	state =3D nfs4_do_open(dir, &dentry->d_name, nd->intent.it_flags, =
&attr, cred);=0A=
 	put_rpccred(cred);=0A=
 	if (IS_ERR(state))=0A=
 		return (struct inode *)state;=0A=
Index: linux-2.6.6/fs/cifs/dir.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/cifs/dir.c	2004-05-22 00:46:19.000000000 +0800=0A=
+++ linux-2.6.6/fs/cifs/dir.c	2004-05-22 02:00:12.000000000 +0800=0A=
@@ -146,22 +146,22 @@ cifs_create(struct inode *inode, struct =0A=
 	if(nd) { =0A=
 		cFYI(1,("In create for inode %p dentry->inode %p nd flags =3D 0x%x =
for %s",inode, direntry->d_inode, nd->flags,full_path));=0A=
 =0A=
-		if ((nd->intent.open.flags & O_ACCMODE) =3D=3D O_RDONLY)=0A=
+		if ((nd->intent.it_flags & O_ACCMODE) =3D=3D O_RDONLY)=0A=
 			desiredAccess =3D GENERIC_READ;=0A=
-		else if ((nd->intent.open.flags & O_ACCMODE) =3D=3D O_WRONLY)=0A=
+		else if ((nd->intent.it_flags & O_ACCMODE) =3D=3D O_WRONLY)=0A=
 			desiredAccess =3D GENERIC_WRITE;=0A=
-		else if ((nd->intent.open.flags & O_ACCMODE) =3D=3D O_RDWR) {=0A=
+		else if ((nd->intent.it_flags & O_ACCMODE) =3D=3D O_RDWR) {=0A=
 			/* GENERIC_ALL is too much permission to request */=0A=
 			/* can cause unnecessary access denied on create */=0A=
 			/* desiredAccess =3D GENERIC_ALL; */=0A=
 			desiredAccess =3D GENERIC_READ | GENERIC_WRITE;=0A=
 		}=0A=
 =0A=
-		if((nd->intent.open.flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | =
O_EXCL))=0A=
+		if((nd->intent.it_flags & (O_CREAT | O_EXCL)) =3D=3D (O_CREAT | =
O_EXCL))=0A=
 			disposition =3D FILE_CREATE;=0A=
-		else if((nd->intent.open.flags & (O_CREAT | O_TRUNC)) =3D=3D (O_CREAT =
| O_TRUNC))=0A=
+		else if((nd->intent.it_flags & (O_CREAT | O_TRUNC)) =3D=3D (O_CREAT | =
O_TRUNC))=0A=
 			disposition =3D FILE_OVERWRITE_IF;=0A=
-		else if((nd->intent.open.flags & O_CREAT) =3D=3D O_CREAT)=0A=
+		else if((nd->intent.it_flags & O_CREAT) =3D=3D O_CREAT)=0A=
 			disposition =3D FILE_OPEN_IF;=0A=
 		else {=0A=
 			cFYI(1,("Create flag not set in create function"));=0A=
@@ -311,7 +311,7 @@ cifs_lookup(struct inode *parent_dir_ino=0A=
 	      parent_dir_inode, direntry->d_name.name, direntry));=0A=
 =0A=
 	if(nd) {  /* BB removeme */=0A=
-		cFYI(1,("In lookup nd flags 0x%x open intent flags =
0x%x",nd->flags,nd->intent.open.flags));=0A=
+		cFYI(1,("In lookup nd flags 0x%x open intent flags =
0x%x",nd->flags,nd->intent.it_flags));=0A=
 	} /* BB removeme BB */=0A=
 	/* BB Add check of incoming data - e.g. frame not longer than maximum =
SMB - let server check the namelen BB */=0A=
 =0A=
Index: linux-2.6.6/include/linux/namei.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/namei.h	2004-04-04 11:36:55.000000000 =
+0800=0A=
+++ linux-2.6.6/include/linux/namei.h	2004-05-22 01:46:25.000000000 +0800=0A=
@@ -5,9 +5,12 @@=0A=
 =0A=
 struct vfsmount;=0A=
 =0A=
-struct open_intent {=0A=
-	int	flags;=0A=
-	int	create_mode;=0A=
+#define INTENT_MAGIC 0x19620323=0A=
+struct lookup_intent {=0A=
+	int     it_magic;=0A=
+	int     it_op;=0A=
+	int     it_flags;=0A=
+	int     it_create_mode;=0A=
 };=0A=
 =0A=
 struct nameidata {=0A=
@@ -16,11 +19,7 @@ struct nameidata {=0A=
 	struct qstr	last;=0A=
 	unsigned int	flags;=0A=
 	int		last_type;=0A=
-=0A=
-	/* Intent data */=0A=
-	union {=0A=
-		struct open_intent open;=0A=
-	} intent;=0A=
+	struct lookup_intent intent;=0A=
 };=0A=
 =0A=
 /*=0A=
=0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="vfs-dcache_locking-vanilla-2.6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vfs-dcache_locking-vanilla-2.6.patch"

%diffstat=0A=
 fs/dcache.c            |   22 ++++++++++++++++++----=0A=
 include/linux/dcache.h |    2 ++=0A=
 2 files changed, 20 insertions(+), 4 deletions(-)=0A=
=0A=
%patch=0A=
Index: linux-2.6.6/fs/dcache.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/dcache.c	2004-05-22 00:46:19.000000000 +0800=0A=
+++ linux-2.6.6/fs/dcache.c	2004-05-22 02:11:17.000000000 +0800=0A=
@@ -1115,13 +1115,20 @@ void d_delete(struct dentry * dentry)=0A=
  * Adds a dentry to the hash according to its name.=0A=
  */=0A=
  =0A=
-void d_rehash(struct dentry * entry)=0A=
+void __d_rehash(struct dentry * entry)=0A=
 {=0A=
 	struct hlist_head *list =3D d_hash(entry->d_parent, =
entry->d_name.hash);=0A=
-	spin_lock(&dcache_lock);=0A=
  	entry->d_vfs_flags &=3D ~DCACHE_UNHASHED;=0A=
 	entry->d_bucket =3D list;=0A=
  	hlist_add_head_rcu(&entry->d_hash, list);=0A=
+}=0A=
+=0A=
+EXPORT_SYMBOL(__d_rehash);=0A=
+=0A=
+void d_rehash(struct dentry * entry)=0A=
+{=0A=
+	spin_lock(&dcache_lock);=0A=
+        __d_rehash(entry);=0A=
 	spin_unlock(&dcache_lock);=0A=
 }=0A=
 =0A=
@@ -1185,12 +1192,11 @@ static inline void switch_names(struct d=0A=
  * dcache entries should not be moved in this way.=0A=
  */=0A=
 =0A=
-void d_move(struct dentry * dentry, struct dentry * target)=0A=
+void __d_move(struct dentry * dentry, struct dentry * target)=0A=
 {=0A=
 	if (!dentry->d_inode)=0A=
 		printk(KERN_WARNING "VFS: moving negative dcache entry\n");=0A=
 =0A=
-	spin_lock(&dcache_lock);=0A=
 	write_seqlock(&rename_lock);=0A=
 	/*=0A=
 	 * XXXX: do we really need to take target->d_lock?=0A=
@@ -1243,6 +1249,14 @@ already_unhashed:=0A=
 	spin_unlock(&target->d_lock);=0A=
 	spin_unlock(&dentry->d_lock);=0A=
 	write_sequnlock(&rename_lock);=0A=
+}=0A=
+=0A=
+EXPORT_SYMBOL(__d_move);=0A=
+=0A=
+void d_move(struct dentry *dentry, struct dentry *target)=0A=
+{=0A=
+	spin_lock(&dcache_lock);=0A=
+	__d_move(dentry, target);=0A=
 	spin_unlock(&dcache_lock);=0A=
 }=0A=
 =0A=
Index: linux-2.6.6/include/linux/dcache.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/dcache.h	2004-05-22 =
00:46:20.000000000 +0800=0A=
+++ linux-2.6.6/include/linux/dcache.h	2004-05-22 02:10:01.000000000 =
+0800=0A=
@@ -224,6 +224,7 @@ extern int have_submounts(struct dentry =0A=
  * This adds the entry to the hash queues.=0A=
  */=0A=
 extern void d_rehash(struct dentry *);=0A=
+extern void __d_rehash(struct dentry *);=0A=
 =0A=
 /**=0A=
  * d_add - add dentry to hash queues=0A=
@@ -242,6 +243,7 @@ static inline void d_add(struct dentry *=0A=
 =0A=
 /* used for rename() and baskets */=0A=
 extern void d_move(struct dentry *, struct dentry *);=0A=
+extern void __d_move(struct dentry *, struct dentry *);=0A=
 =0A=
 /* appendix may either be NULL or be used for transname suffixes */=0A=
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);=0A=
=0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="vfs-dcache_lustre_invalid-vanilla-2.6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vfs-dcache_lustre_invalid-vanilla-2.6.patch"

%diffstat=0A=
 fs/dcache.c            |    7 +++++++=0A=
 include/linux/dcache.h |    1 +=0A=
 2 files changed, 8 insertions(+)=0A=
=0A=
%patch=0A=
Index: linux-2.6.6/fs/dcache.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/dcache.c	2004-05-22 02:11:17.000000000 +0800=0A=
+++ linux-2.6.6/fs/dcache.c	2004-05-22 02:14:46.000000000 +0800=0A=
@@ -217,6 +217,13 @@ int d_invalidate(struct dentry * dentry)=0A=
 		spin_unlock(&dcache_lock);=0A=
 		return 0;=0A=
 	}=0A=
+=0A=
+	/* network invalidation by Lustre */=0A=
+	if (dentry->d_flags & DCACHE_LUSTRE_INVALID) {=0A=
+		spin_unlock(&dcache_lock);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
 	/*=0A=
 	 * Check whether to do a partial shrink_dcache=0A=
 	 * to get rid of unused child entries.=0A=
Index: linux-2.6.6/include/linux/dcache.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/dcache.h	2004-05-22 =
02:10:01.000000000 +0800=0A=
+++ linux-2.6.6/include/linux/dcache.h	2004-05-22 02:15:17.000000000 =
+0800=0A=
@@ -153,6 +153,7 @@ d_iput:		no		no		yes=0A=
 =0A=
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */=0A=
 #define DCACHE_UNHASHED		0x0010	=0A=
+#define DCACHE_LUSTRE_INVALID	0x0020	/* invalidated by Lustre */=0A=
 =0A=
 extern spinlock_t dcache_lock;=0A=
 =0A=
=0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="vfs-do_truncate.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vfs-do_truncate.patch"

 fs/exec.c          |    2 +-=0A=
 fs/namei.c         |    2 +-=0A=
 fs/open.c          |    8 +++++---=0A=
 include/linux/fs.h |    3 ++-=0A=
 4 files changed, 9 insertions(+), 6 deletions(-)=0A=
Index: linux-2.6.6/fs/namei.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/namei.c	2004-05-30 23:17:06.267030976 +0300=0A=
+++ linux-2.6.6/fs/namei.c	2004-05-30 23:23:15.642877312 +0300=0A=
@@ -1270,7 +1270,7 @@=0A=
 		if (!error) {=0A=
 			DQUOT_INIT(inode);=0A=
 			=0A=
-			error =3D do_truncate(dentry, 0);=0A=
+			error =3D do_truncate(dentry, 0, 1);=0A=
 		}=0A=
 		put_write_access(inode);=0A=
 		if (error)=0A=
Index: linux-2.6.6/fs/open.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/open.c	2004-05-30 20:05:26.857206992 +0300=0A=
+++ linux-2.6.6/fs/open.c	2004-05-30 23:24:38.908219056 +0300=0A=
@@ -189,7 +189,7 @@=0A=
 	return error;=0A=
 }=0A=
 =0A=
-int do_truncate(struct dentry *dentry, loff_t length)=0A=
+int do_truncate(struct dentry *dentry, loff_t length, int =
called_from_open)=0A=
 {=0A=
 	int err;=0A=
 	struct iattr newattrs;=0A=
@@ -202,6 +202,8 @@=0A=
 	newattrs.ia_valid =3D ATTR_SIZE | ATTR_CTIME;=0A=
 	down(&dentry->d_inode->i_sem);=0A=
 	down_write(&dentry->d_inode->i_alloc_sem);=0A=
+	if (called_from_open)=0A=
+		newattrs.ia_valid |=3D ATTR_FROM_OPEN;=0A=
 	err =3D notify_change(dentry, &newattrs);=0A=
 	up_write(&dentry->d_inode->i_alloc_sem);=0A=
 	up(&dentry->d_inode->i_sem);=0A=
@@ -259,7 +261,7 @@=0A=
 	error =3D locks_verify_truncate(inode, NULL, length);=0A=
 	if (!error) {=0A=
 		DQUOT_INIT(inode);=0A=
-		error =3D do_truncate(nd.dentry, length);=0A=
+		error =3D do_truncate(nd.dentry, length, 0);=0A=
 	}=0A=
 	put_write_access(inode);=0A=
 =0A=
@@ -311,7 +313,7 @@=0A=
 =0A=
 	error =3D locks_verify_truncate(inode, file, length);=0A=
 	if (!error)=0A=
-		error =3D do_truncate(dentry, length);=0A=
+		error =3D do_truncate(dentry, length, 0);=0A=
 out_putf:=0A=
 	fput(file);=0A=
 out:=0A=
Index: linux-2.6.6/fs/exec.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/exec.c	2004-05-30 20:05:26.862206232 +0300=0A=
+++ linux-2.6.6/fs/exec.c	2004-05-30 23:23:15.648876400 +0300=0A=
@@ -1395,7 +1395,7 @@=0A=
 		goto close_fail;=0A=
 	if (!file->f_op->write)=0A=
 		goto close_fail;=0A=
-	if (do_truncate(file->f_dentry, 0) !=3D 0)=0A=
+	if (do_truncate(file->f_dentry, 0, 0) !=3D 0)=0A=
 		goto close_fail;=0A=
 =0A=
 	retval =3D binfmt->core_dump(signr, regs, file);=0A=
Index: linux-2.6.6/include/linux/fs.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/fs.h	2004-05-30 23:20:11.979798344 =
+0300=0A=
+++ linux-2.6.6/include/linux/fs.h	2004-05-30 23:25:29.167578472 +0300=0A=
@@ -249,6 +249,7 @@=0A=
 #define ATTR_ATTR_FLAG	1024=0A=
 #define ATTR_KILL_SUID	2048=0A=
 #define ATTR_KILL_SGID	4096=0A=
+#define ATTR_FROM_OPEN	8192   /* called from open path, ie O_TRUNC */=0A=
 =0A=
 /*=0A=
  * This is the Inode Attributes structure, used for notify_change().  It=0A=
@@ -1189,7 +1190,7 @@=0A=
 =0A=
 /* fs/open.c */=0A=
 =0A=
-extern int do_truncate(struct dentry *, loff_t start);=0A=
+extern int do_truncate(struct dentry *, loff_t start, int =
called_from_open);=0A=
 extern struct file *filp_open(const char *, int, int);=0A=
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, =
int);=0A=
 extern struct file * dentry_open_it(struct dentry *, struct vfsmount *, =
int, struct lookup_intent *);=0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="vfs-intent_api-vanilla-2.6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vfs-intent_api-vanilla-2.6.patch"

 fs/exec.c             |   10 ++++---=0A=
 fs/namei.c            |   69 =
++++++++++++++++++++++++++++++++++++++++++++------=0A=
 fs/namespace.c        |    1 =0A=
 fs/open.c             |   28 +++++++++++++++-----=0A=
 fs/stat.c             |   10 +++++--=0A=
 fs/xattr.c            |   12 +++++---=0A=
 include/linux/fs.h    |    2 +=0A=
 include/linux/namei.h |   27 +++++++++++++++++++=0A=
 8 files changed, 134 insertions(+), 25 deletions(-)=0A=
=0A=
Index: linux-2.6.6/include/linux/namei.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/namei.h	2004-05-30 19:46:50.238958768 =
+0300=0A=
+++ linux-2.6.6/include/linux/namei.h	2004-05-30 20:05:26.849208208 +0300=0A=
@@ -2,17 +2,36 @@=0A=
 #define _LINUX_NAMEI_H=0A=
 =0A=
 #include <linux/linkage.h>=0A=
+#include <linux/string.h>=0A=
 =0A=
 struct vfsmount;=0A=
 =0A=
+/* intent opcodes */=0A=
+#define IT_OPEN		(1)=0A=
+#define IT_CREAT	(1<<1)=0A=
+#define IT_READDIR	(1<<2)=0A=
+#define IT_GETATTR	(1<<3)=0A=
+#define IT_LOOKUP	(1<<4)=0A=
+#define IT_UNLINK	(1<<5)=0A=
+#define IT_TRUNC	(1<<6)=0A=
+#define IT_GETXATTR	(1<<7)=0A=
+=0A=
 #define INTENT_MAGIC 0x19620323=0A=
 struct lookup_intent {=0A=
 	int     it_magic;=0A=
 	int     it_op;=0A=
+	void    (*it_op_release)(struct lookup_intent *);=0A=
 	int     it_flags;=0A=
 	int     it_create_mode;=0A=
 };=0A=
 =0A=
+static inline void intent_init(struct lookup_intent *it, int op)=0A=
+{=0A=
+	memset(it, 0, sizeof(*it));=0A=
+	it->it_magic =3D INTENT_MAGIC;=0A=
+	it->it_op =3D op;=0A=
+}=0A=
+=0A=
 struct nameidata {=0A=
 	struct dentry	*dentry;=0A=
 	struct vfsmount *mnt;=0A=
@@ -48,14 +67,22 @@=0A=
 #define LOOKUP_ACCESS		(0x0400)=0A=
 =0A=
 extern int FASTCALL(__user_walk(const char __user *, unsigned, struct =
nameidata *));=0A=
+extern int FASTCALL(__user_walk_it(const char __user *, unsigned, =
struct nameidata *));=0A=
 #define user_path_walk(name,nd) \=0A=
 	__user_walk(name, LOOKUP_FOLLOW, nd)=0A=
+#define user_path_walk_it(name,nd) \=0A=
+	__user_walk_it(name, LOOKUP_FOLLOW, nd)=0A=
 #define user_path_walk_link(name,nd) \=0A=
 	__user_walk(name, 0, nd)=0A=
+#define user_path_walk_link_it(name,nd) \=0A=
+	__user_walk_it(name, 0, nd)=0A=
 extern int FASTCALL(path_lookup(const char *, unsigned, struct =
nameidata *));=0A=
+extern int FASTCALL(path_lookup_it(const char *, unsigned, struct =
nameidata *));=0A=
 extern int FASTCALL(path_walk(const char *, struct nameidata *));=0A=
+extern int FASTCALL(path_walk_it(const char *, struct nameidata *));=0A=
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));=0A=
 extern void path_release(struct nameidata *);=0A=
+extern void intent_release(struct lookup_intent *);=0A=
 =0A=
 extern struct dentry * lookup_one_len(const char *, struct dentry *, =
int);=0A=
 extern struct dentry * lookup_hash(struct qstr *, struct dentry *);=0A=
Index: linux-2.6.6/include/linux/fs.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/fs.h	2004-05-26 20:26:11.000000000 =
+0300=0A=
+++ linux-2.6.6/include/linux/fs.h	2004-05-30 20:05:26.852207752 +0300=0A=
@@ -576,6 +576,7 @@=0A=
 	spinlock_t		f_ep_lock;=0A=
 #endif /* #ifdef CONFIG_EPOLL */=0A=
 	struct address_space	*f_mapping;=0A=
+	struct lookup_intent	*f_it;=0A=
 };=0A=
 extern spinlock_t files_lock;=0A=
 #define file_list_lock() spin_lock(&files_lock);=0A=
@@ -1190,6 +1191,7 @@=0A=
 extern int do_truncate(struct dentry *, loff_t start);=0A=
 extern struct file *filp_open(const char *, int, int);=0A=
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, =
int);=0A=
+extern struct file * dentry_open_it(struct dentry *, struct vfsmount *, =
int, struct lookup_intent *);=0A=
 extern int filp_close(struct file *, fl_owner_t id);=0A=
 extern char * getname(const char __user *);=0A=
 =0A=
Index: linux-2.6.6/fs/namei.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/namei.c	2004-05-30 19:46:50.185966824 +0300=0A=
+++ linux-2.6.6/fs/namei.c	2004-05-30 20:05:26.855207296 +0300=0A=
@@ -272,8 +272,19 @@=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+void intent_release(struct lookup_intent *it)=0A=
+{=0A=
+	if (!it)=0A=
+		return;=0A=
+	if (it->it_magic !=3D INTENT_MAGIC)=0A=
+		return;=0A=
+	if (it->it_op_release)=0A=
+		it->it_op_release(it);=0A=
+}=0A=
+=0A=
 void path_release(struct nameidata *nd)=0A=
 {=0A=
+	intent_release(&nd->intent);=0A=
 	dput(nd->dentry);=0A=
 	mntput(nd->mnt);=0A=
 }=0A=
@@ -774,8 +785,14 @@=0A=
 	return err;=0A=
 }=0A=
 =0A=
+int fastcall path_walk_it(const char * name, struct nameidata *nd)=0A=
+{=0A=
+	current->total_link_count =3D 0;=0A=
+	return link_path_walk(name, nd);=0A=
+}=0A=
 int fastcall path_walk(const char * name, struct nameidata *nd)=0A=
 {=0A=
+	intent_init(&nd->intent, IT_LOOKUP);=0A=
 	current->total_link_count =3D 0;=0A=
 	return link_path_walk(name, nd);=0A=
 }=0A=
@@ -784,7 +801,7 @@=0A=
 /* returns 1 if everything is done */=0A=
 static int __emul_lookup_dentry(const char *name, struct nameidata *nd)=0A=
 {=0A=
-	if (path_walk(name, nd))=0A=
+	if (path_walk_it(name, nd))=0A=
 		return 0;		/* something went wrong... */=0A=
 =0A=
 	if (!nd->dentry->d_inode || S_ISDIR(nd->dentry->d_inode->i_mode)) {=0A=
@@ -861,7 +878,18 @@=0A=
 	return 1;=0A=
 }=0A=
 =0A=
-int fastcall path_lookup(const char *name, unsigned int flags, struct =
nameidata *nd)=0A=
+static inline int it_mode_from_lookup_flags(int flags)=0A=
+{=0A=
+	int mode =3D IT_LOOKUP;=0A=
+=0A=
+	if (flags & LOOKUP_OPEN)=0A=
+		mode =3D IT_OPEN;=0A=
+	if (flags & LOOKUP_CREATE)=0A=
+		mode |=3D IT_CREAT;=0A=
+	return mode;=0A=
+}=0A=
+=0A=
+int fastcall path_lookup_it(const char *name, unsigned int flags, =
struct nameidata *nd)=0A=
 {=0A=
 	int retval;=0A=
 =0A=
@@ -896,6 +924,12 @@=0A=
 	return retval;=0A=
 }=0A=
 =0A=
+int fastcall path_lookup(const char *name, unsigned int flags, struct =
nameidata *nd)=0A=
+{=0A=
+	intent_init(&nd->intent, it_mode_from_lookup_flags(flags));=0A=
+	return path_lookup_it(name, flags, nd);=0A=
+}=0A=
+=0A=
 /*=0A=
  * Restricted form of lookup. Doesn't follow links, single-component =
only,=0A=
  * needs parent already locked. Doesn't follow mounts.=0A=
@@ -946,7 +980,7 @@=0A=
 }=0A=
 =0A=
 /* SMP-safe */=0A=
-struct dentry * lookup_one_len(const char * name, struct dentry * base, =
int len)=0A=
+struct dentry * lookup_one_len_it(const char * name, struct dentry * =
base, int len, struct nameidata *nd)=0A=
 {=0A=
 	unsigned long hash;=0A=
 	struct qstr this;=0A=
@@ -966,11 +1000,16 @@=0A=
 	}=0A=
 	this.hash =3D end_name_hash(hash);=0A=
 =0A=
-	return lookup_hash(&this, base);=0A=
+	return __lookup_hash(&this, base, nd);=0A=
 access:=0A=
 	return ERR_PTR(-EACCES);=0A=
 }=0A=
 =0A=
+struct dentry * lookup_one_len(const char * name, struct dentry * base, =
int len)=0A=
+{=0A=
+	return lookup_one_len_it(name, base, len, NULL);=0A=
+}=0A=
+=0A=
 /*=0A=
  *	namei()=0A=
  *=0A=
@@ -982,18 +1021,24 @@=0A=
  * that namei follows links, while lnamei does not.=0A=
  * SMP-safe=0A=
  */=0A=
-int fastcall __user_walk(const char __user *name, unsigned flags, =
struct nameidata *nd)=0A=
+int fastcall __user_walk_it(const char __user *name, unsigned flags, =
struct nameidata *nd)=0A=
 {=0A=
 	char *tmp =3D getname(name);=0A=
 	int err =3D PTR_ERR(tmp);=0A=
 =0A=
 	if (!IS_ERR(tmp)) {=0A=
-		err =3D path_lookup(tmp, flags, nd);=0A=
+		err =3D path_lookup_it(tmp, flags, nd);=0A=
 		putname(tmp);=0A=
 	}=0A=
 	return err;=0A=
 }=0A=
 =0A=
+int fastcall __user_walk(const char __user *name, unsigned flags, =
struct nameidata *nd)=0A=
+{=0A=
+	intent_init(&nd->intent, it_mode_from_lookup_flags(flags));=0A=
+	return __user_walk_it(name, flags, nd);=0A=
+}=0A=
+=0A=
 /*=0A=
  * It's inline, so penalty for filesystems that don't use sticky bit is=0A=
  * minimal.=0A=
@@ -1273,7 +1318,7 @@=0A=
 	 * The simplest case - just a plain lookup.=0A=
 	 */=0A=
 	if (!(flag & O_CREAT)) {=0A=
-		error =3D path_lookup(pathname, lookup_flags(flag)|LOOKUP_OPEN, nd);=0A=
+		error =3D path_lookup_it(pathname, lookup_flags(flag), nd);=0A=
 		if (error)=0A=
 			return error;=0A=
 		goto ok;=0A=
@@ -1282,7 +1327,8 @@=0A=
 	/*=0A=
 	 * Create - we need to know the parent.=0A=
 	 */=0A=
-	error =3D path_lookup(pathname, =
LOOKUP_PARENT|LOOKUP_OPEN|LOOKUP_CREATE, nd);=0A=
+	nd->intent.it_op |=3D IT_CREAT;=0A=
+	error =3D path_lookup_it(pathname, LOOKUP_PARENT, nd);=0A=
 	if (error)=0A=
 		return error;=0A=
 =0A=
@@ -2165,6 +2211,7 @@=0A=
 __vfs_follow_link(struct nameidata *nd, const char *link)=0A=
 {=0A=
 	int res =3D 0;=0A=
+	struct lookup_intent it =3D nd->intent;=0A=
 	char *name;=0A=
 	if (IS_ERR(link))=0A=
 		goto fail;=0A=
@@ -2175,6 +2222,9 @@=0A=
 			/* weird __emul_prefix() stuff did it */=0A=
 			goto out;=0A=
 	}=0A=
+	intent_init(&nd->intent, it.it_op);=0A=
+	nd->intent.it_flags =3D it.it_flags;=0A=
+	nd->intent.it_create_mode =3D it.it_create_mode;=0A=
 	res =3D link_path_walk(link, nd);=0A=
 out:=0A=
 	if (current->link_count || res || nd->last_type!=3DLAST_NORM)=0A=
@@ -2249,6 +2299,7 @@=0A=
 	return res;=0A=
 }=0A=
 =0A=
+=0A=
 int page_symlink(struct inode *inode, const char *symname, int len)=0A=
 {=0A=
 	struct address_space *mapping =3D inode->i_mapping;=0A=
@@ -2309,8 +2360,10 @@=0A=
 EXPORT_SYMBOL(page_symlink);=0A=
 EXPORT_SYMBOL(page_symlink_inode_operations);=0A=
 EXPORT_SYMBOL(path_lookup);=0A=
+EXPORT_SYMBOL(path_lookup_it);=0A=
 EXPORT_SYMBOL(path_release);=0A=
 EXPORT_SYMBOL(path_walk);=0A=
+EXPORT_SYMBOL(path_walk_it);=0A=
 EXPORT_SYMBOL(permission);=0A=
 EXPORT_SYMBOL(unlock_rename);=0A=
 EXPORT_SYMBOL(vfs_create);=0A=
Index: linux-2.6.6/fs/open.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/open.c	2004-05-26 20:25:43.000000000 +0300=0A=
+++ linux-2.6.6/fs/open.c	2004-05-30 20:05:26.857206992 +0300=0A=
@@ -214,11 +214,12 @@=0A=
 	struct inode * inode;=0A=
 	int error;=0A=
 =0A=
+	intent_init(&nd.intent, IT_GETATTR);=0A=
 	error =3D -EINVAL;=0A=
 	if (length < 0)	/* sorry, but loff_t says... */=0A=
 		goto out;=0A=
 =0A=
-	error =3D user_path_walk(path, &nd);=0A=
+	error =3D user_path_walk_it(path, &nd);=0A=
 	if (error)=0A=
 		goto out;=0A=
 	inode =3D nd.dentry->d_inode;=0A=
@@ -473,6 +474,7 @@=0A=
 	kernel_cap_t old_cap;=0A=
 	int res;=0A=
 =0A=
+	intent_init(&nd.intent, IT_GETATTR);=0A=
 	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */=0A=
 		return -EINVAL;=0A=
 =0A=
@@ -496,7 +498,7 @@=0A=
 	else=0A=
 		current->cap_effective =3D current->cap_permitted;=0A=
 =0A=
-	res =3D __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_ACCESS, &nd);=0A=
+	res =3D __user_walk_it(filename, LOOKUP_FOLLOW|LOOKUP_ACCESS, &nd);=0A=
 	if (!res) {=0A=
 		res =3D permission(nd.dentry->d_inode, mode, &nd);=0A=
 		/* SuS v2 requires we report a read only fs too */=0A=
@@ -518,7 +520,8 @@=0A=
 	struct nameidata nd;=0A=
 	int error;=0A=
 =0A=
-	error =3D __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &nd);=0A=
+	intent_init(&nd.intent, IT_GETATTR);=0A=
+	error =3D __user_walk_it(filename, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, =
&nd);=0A=
 	if (error)=0A=
 		goto out;=0A=
 =0A=
@@ -569,7 +572,8 @@=0A=
 	struct nameidata nd;=0A=
 	int error;=0A=
 =0A=
-	error =3D __user_walk(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY | =
LOOKUP_NOALT, &nd);=0A=
+	intent_init(&nd.intent, IT_GETATTR);=0A=
+	error =3D __user_walk_it(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY | =
LOOKUP_NOALT, &nd);=0A=
 	if (error)=0A=
 		goto out;=0A=
 =0A=
@@ -752,6 +756,7 @@=0A=
 {=0A=
 	int namei_flags, error;=0A=
 	struct nameidata nd;=0A=
+	intent_init(&nd.intent, IT_OPEN);=0A=
 =0A=
 	namei_flags =3D flags;=0A=
 	if ((namei_flags+1) & O_ACCMODE)=0A=
@@ -761,14 +766,14 @@=0A=
 =0A=
 	error =3D open_namei(filename, namei_flags, mode, &nd);=0A=
 	if (!error)=0A=
-		return dentry_open(nd.dentry, nd.mnt, flags);=0A=
+		return dentry_open_it(nd.dentry, nd.mnt, flags, &nd.intent);=0A=
 =0A=
 	return ERR_PTR(error);=0A=
 }=0A=
 =0A=
 EXPORT_SYMBOL(filp_open);=0A=
 =0A=
-struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, =
int flags)=0A=
+struct file *dentry_open_it(struct dentry *dentry, struct vfsmount =
*mnt, int flags, struct lookup_intent *it)=0A=
 {=0A=
 	struct file * f;=0A=
 	struct inode *inode;=0A=
@@ -780,6 +785,7 @@=0A=
 		goto cleanup_dentry;=0A=
 	f->f_flags =3D flags;=0A=
 	f->f_mode =3D (flags+1) & O_ACCMODE;=0A=
+	f->f_it =3D it;=0A=
 	inode =3D dentry->d_inode;=0A=
 	if (f->f_mode & FMODE_WRITE) {=0A=
 		error =3D get_write_access(inode);=0A=
@@ -799,6 +805,7 @@=0A=
 		error =3D f->f_op->open(inode,f);=0A=
 		if (error)=0A=
 			goto cleanup_all;=0A=
+		intent_release(it);=0A=
 	}=0A=
 	f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);=0A=
 =0A=
@@ -823,11 +830,20 @@=0A=
 cleanup_file:=0A=
 	put_filp(f);=0A=
 cleanup_dentry:=0A=
+	intent_release(it);=0A=
 	dput(dentry);=0A=
 	mntput(mnt);=0A=
 	return ERR_PTR(error);=0A=
 }=0A=
 =0A=
+struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, =
int flags)=0A=
+{=0A=
+	struct lookup_intent it;=0A=
+	intent_init(&it, IT_LOOKUP);=0A=
+=0A=
+	return dentry_open_it(dentry, mnt, flags, &it);=0A=
+}=0A=
+=0A=
 EXPORT_SYMBOL(dentry_open);=0A=
 =0A=
 /*=0A=
Index: linux-2.6.6/fs/stat.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/stat.c	2004-05-26 20:25:43.000000000 +0300=0A=
+++ linux-2.6.6/fs/stat.c	2004-05-30 23:46:08.545164440 +0300=0A=
@@ -58,15 +58,15 @@=0A=
 	}=0A=
 	return 0;=0A=
 }=0A=
-=0A=
 EXPORT_SYMBOL(vfs_getattr);=0A=
 =0A=
 int vfs_stat(char __user *name, struct kstat *stat)=0A=
 {=0A=
 	struct nameidata nd;=0A=
 	int error;=0A=
+	intent_init(&nd.intent, IT_GETATTR);=0A=
 =0A=
-	error =3D user_path_walk(name, &nd);=0A=
+	error =3D user_path_walk_it(name, &nd);=0A=
 	if (!error) {=0A=
 		error =3D vfs_getattr(nd.mnt, nd.dentry, stat);=0A=
 		path_release(&nd);=0A=
@@ -80,8 +80,9 @@=0A=
 {=0A=
 	struct nameidata nd;=0A=
 	int error;=0A=
+	intent_init(&nd.intent, IT_GETATTR);=0A=
 =0A=
-	error =3D user_path_walk_link(name, &nd);=0A=
+	error =3D user_path_walk_link_it(name, &nd);=0A=
 	if (!error) {=0A=
 		error =3D vfs_getattr(nd.mnt, nd.dentry, stat);=0A=
 		path_release(&nd);=0A=
@@ -95,9 +96,12 @@=0A=
 {=0A=
 	struct file *f =3D fget(fd);=0A=
 	int error =3D -EBADF;=0A=
+	struct nameidata nd;=0A=
+	intent_init(&nd.intent, IT_GETATTR);=0A=
 =0A=
 	if (f) {=0A=
 		error =3D vfs_getattr(f->f_vfsmnt, f->f_dentry, stat);=0A=
+		intent_release(&nd.intent);=0A=
 		fput(f);=0A=
 	}=0A=
 	return error;=0A=
Index: linux-2.6.6/fs/namespace.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/namespace.c	2004-05-26 20:25:43.000000000 +0300=0A=
+++ linux-2.6.6/fs/namespace.c	2004-05-30 20:05:26.860206536 +0300=0A=
@@ -115,6 +115,7 @@=0A=
 =0A=
 static void detach_mnt(struct vfsmount *mnt, struct nameidata *old_nd)=0A=
 {=0A=
+	memset(old_nd, 0, sizeof(*old_nd));=0A=
 	old_nd->dentry =3D mnt->mnt_mountpoint;=0A=
 	old_nd->mnt =3D mnt->mnt_parent;=0A=
 	mnt->mnt_parent =3D mnt;=0A=
Index: linux-2.6.6/fs/exec.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/exec.c	2004-05-30 19:46:50.182967280 +0300=0A=
+++ linux-2.6.6/fs/exec.c	2004-05-30 20:05:26.862206232 +0300=0A=
@@ -122,8 +122,9 @@=0A=
 	struct nameidata nd;=0A=
 	int error;=0A=
 =0A=
+	intent_init(&nd.intent, IT_OPEN);=0A=
 	nd.intent.it_flags =3D FMODE_READ;=0A=
-	error =3D __user_walk(library, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);=0A=
+	error =3D user_path_walk_it(library, &nd);=0A=
 	if (error)=0A=
 		goto out;=0A=
 =0A=
@@ -135,7 +136,7 @@=0A=
 	if (error)=0A=
 		goto exit;=0A=
 =0A=
-	file =3D dentry_open(nd.dentry, nd.mnt, O_RDONLY);=0A=
+	file =3D dentry_open_it(nd.dentry, nd.mnt, O_RDONLY, &nd.intent);=0A=
 	error =3D PTR_ERR(file);=0A=
 	if (IS_ERR(file))=0A=
 		goto out;=0A=
@@ -483,8 +484,9 @@=0A=
 	int err;=0A=
 	struct file *file;=0A=
 =0A=
+	intent_init(&nd.intent, IT_OPEN);=0A=
 	nd.intent.it_flags =3D FMODE_READ;=0A=
-	err =3D path_lookup(name, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);=0A=
+	err =3D path_lookup_it(name, LOOKUP_FOLLOW, &nd);=0A=
 	file =3D ERR_PTR(err);=0A=
 =0A=
 	if (!err) {=0A=
@@ -497,7 +499,7 @@=0A=
 				err =3D -EACCES;=0A=
 			file =3D ERR_PTR(err);=0A=
 			if (!err) {=0A=
-				file =3D dentry_open(nd.dentry, nd.mnt, O_RDONLY);=0A=
+				file =3D dentry_open_it(nd.dentry, nd.mnt, O_RDONLY, &nd.intent);=0A=
 				if (!IS_ERR(file)) {=0A=
 					err =3D deny_write_access(file);=0A=
 					if (err) {=0A=
Index: linux-2.6.6/fs/xattr.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/xattr.c	2004-05-26 20:25:43.000000000 +0300=0A=
+++ linux-2.6.6/fs/xattr.c	2004-05-30 20:05:26.863206080 +0300=0A=
@@ -161,7 +161,8 @@=0A=
 	struct nameidata nd;=0A=
 	ssize_t error;=0A=
 =0A=
-	error =3D user_path_walk(path, &nd);=0A=
+	intent_init(&nd.intent, IT_GETXATTR);=0A=
+	error =3D user_path_walk_it(path, &nd);=0A=
 	if (error)=0A=
 		return error;=0A=
 	error =3D getxattr(nd.dentry, name, value, size);=0A=
@@ -176,7 +177,8 @@=0A=
 	struct nameidata nd;=0A=
 	ssize_t error;=0A=
 =0A=
-	error =3D user_path_walk_link(path, &nd);=0A=
+	intent_init(&nd.intent, IT_GETXATTR);=0A=
+	error =3D user_path_walk_link_it(path, &nd);=0A=
 	if (error)=0A=
 		return error;=0A=
 	error =3D getxattr(nd.dentry, name, value, size);=0A=
@@ -242,7 +244,8 @@=0A=
 	struct nameidata nd;=0A=
 	ssize_t error;=0A=
 =0A=
-	error =3D user_path_walk(path, &nd);=0A=
+	intent_init(&nd.intent, IT_GETXATTR);=0A=
+	error =3D user_path_walk_it(path, &nd);=0A=
 	if (error)=0A=
 		return error;=0A=
 	error =3D listxattr(nd.dentry, list, size);=0A=
@@ -256,7 +259,8 @@=0A=
 	struct nameidata nd;=0A=
 	ssize_t error;=0A=
 =0A=
-	error =3D user_path_walk_link(path, &nd);=0A=
+	intent_init(&nd.intent, IT_GETXATTR);=0A=
+	error =3D user_path_walk_link_it(path, &nd);=0A=
 	if (error)=0A=
 		return error;=0A=
 	error =3D listxattr(nd.dentry, list, size);=0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="vfs-intent_lustre-vanilla-2.6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vfs-intent_lustre-vanilla-2.6.patch"

 namei.h |   11 +++++++++++=0A=
 1 files changed, 11 insertions(+)=0A=
Index: linux-2.6.6/include/linux/namei.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/namei.h	2004-05-31 11:55:11.399239832 =
+0300=0A=
+++ linux-2.6.6/include/linux/namei.h	2004-05-31 11:56:45.338958824 +0300=0A=
@@ -22,6 +22,14 @@=0A=
 #define IT_MKNOD	(1<<12)=0A=
 #define IT_SYMLINK	(1<<13)=0A=
 =0A=
+struct lustre_intent_data {=0A=
+	int       it_disposition;=0A=
+	int       it_status;=0A=
+	__u64     it_lock_handle;=0A=
+	void     *it_data;=0A=
+	int       it_lock_mode;=0A=
+};=0A=
+=0A=
 #define INTENT_MAGIC 0x19620323=0A=
 #define IT_STATUS_RAW (1<<10)	/* Setting this in it_flags on exit from =
lookup=0A=
 				   means everything was done already and return=0A=
@@ -38,6 +46,9 @@=0A=
 		char	*link;	/* For symlink */=0A=
 		struct nameidata *source_nd; /* For link/rename */=0A=
 	} it_create;=0A=
+	union {=0A=
+		struct lustre_intent_data *lustre;=0A=
+	} d;=0A=
 };=0A=
 =0A=
 =0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="vfs-lookup_last-vanilla-2.6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vfs-lookup_last-vanilla-2.6.patch"

 fs/namei.c            |    8 ++++++++=0A=
 include/linux/namei.h |    3 +++=0A=
 2 files changed, 11 insertions(+)=0A=
=0A=
Index: linux-2.6.6/fs/namei.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/namei.c	2004-05-27 21:24:45.151896688 +0300=0A=
+++ linux-2.6.6/fs/namei.c	2004-05-27 22:48:34.155371952 +0300=0A=
@@ -677,7 +677,9 @@=0A=
 =0A=
 		if (inode->i_op->follow_link) {=0A=
 			mntget(next.mnt);=0A=
+			nd->flags |=3D LOOKUP_LINK_NOTLAST;=0A=
 			err =3D do_follow_link(next.dentry, nd);=0A=
+			nd->flags &=3D ~LOOKUP_LINK_NOTLAST;=0A=
 			dput(next.dentry);=0A=
 			mntput(next.mnt);=0A=
 			if (err)=0A=
@@ -723,7 +725,9 @@=0A=
 			if (err < 0)=0A=
 				break;=0A=
 		}=0A=
+		nd->flags |=3D LOOKUP_LAST;=0A=
 		err =3D do_lookup(nd, &this, &next);=0A=
+		nd->flags &=3D ~LOOKUP_LAST;=0A=
 		if (err)=0A=
 			break;=0A=
 		follow_mount(&next.mnt, &next.dentry);=0A=
@@ -1344,7 +1348,9 @@=0A=
 	dir =3D nd->dentry;=0A=
 	nd->flags &=3D ~LOOKUP_PARENT;=0A=
 	down(&dir->d_inode->i_sem);=0A=
+	nd->flags |=3D LOOKUP_LAST;=0A=
 	dentry =3D __lookup_hash(&nd->last, nd->dentry, nd);=0A=
+	nd->flags &=3D ~LOOKUP_LAST;=0A=
 =0A=
 do_last:=0A=
 	error =3D PTR_ERR(dentry);=0A=
@@ -1449,7 +1455,9 @@=0A=
 	}=0A=
 	dir =3D nd->dentry;=0A=
 	down(&dir->d_inode->i_sem);=0A=
+	nd->flags |=3D LOOKUP_LAST;=0A=
 	dentry =3D __lookup_hash(&nd->last, nd->dentry, nd);=0A=
+	nd->flags &=3D ~LOOKUP_LAST;=0A=
 	putname(nd->last.name);=0A=
 	goto do_last;=0A=
 }=0A=
Index: linux-2.6.6/include/linux/namei.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/namei.h	2004-05-27 21:24:45.078907784 =
+0300=0A=
+++ linux-2.6.6/include/linux/namei.h	2004-05-27 22:47:58.870736032 +0300=0A=
@@ -70,6 +70,9 @@=0A=
 #define LOOKUP_CONTINUE		 4=0A=
 #define LOOKUP_PARENT		16=0A=
 #define LOOKUP_NOALT		32=0A=
+#define LOOKUP_LAST		64=0A=
+#define LOOKUP_LINK_NOTLAST	128=0A=
+=0A=
 /*=0A=
  * Intent data=0A=
  */=0A=

------=_NextPart_000_002D_01C448C5.340A8B80
Content-Type: application/octet-stream;
	name="vfs-raw_ops-vanilla-2.6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vfs-raw_ops-vanilla-2.6.patch"

 fs/namei.c            |   73 =
++++++++++++++++++++++++++++++++++++++++++++------=0A=
 include/linux/namei.h |   17 +++++++++++=0A=
 2 files changed, 82 insertions(+), 8 deletions(-)=0A=
=0A=
Index: linux-2.6.6/fs/namei.c=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/fs/namei.c	2004-06-02 17:01:51.115405512 +0300=0A=
+++ linux-2.6.6/fs/namei.c	2004-06-02 17:05:18.898817632 +0300=0A=
@@ -560,12 +560,14 @@=0A=
 	return 0;=0A=
 =0A=
 need_lookup:=0A=
+	nd->last =3D *name;=0A=
 	dentry =3D real_lookup(nd->dentry, name, nd);=0A=
 	if (IS_ERR(dentry))=0A=
 		goto fail;=0A=
 	goto done;=0A=
 =0A=
 need_revalidate:=0A=
+	nd->last =3D *name;=0A=
 	if (dentry->d_op->d_revalidate(dentry, nd))=0A=
 		goto done;=0A=
 	if (d_invalidate(dentry))=0A=
@@ -606,6 +608,7 @@=0A=
 		unsigned long hash;=0A=
 		struct qstr this;=0A=
 		unsigned int c;=0A=
+		int span_mount =3D 0;=0A=
 =0A=
 		err =3D exec_permission_lite(inode, nd);=0A=
 		if (err =3D=3D -EAGAIN) { =0A=
@@ -665,7 +668,8 @@=0A=
 		if (err)=0A=
 			break;=0A=
 		/* Check mountpoints.. */=0A=
-		follow_mount(&next.mnt, &next.dentry);=0A=
+		if (follow_mount(&next.mnt, &next.dentry))=0A=
+			span_mount =3D 1;=0A=
 =0A=
 		err =3D -ENOENT;=0A=
 		inode =3D next.dentry->d_inode;=0A=
@@ -693,6 +697,12 @@=0A=
 			dput(nd->dentry);=0A=
 			nd->mnt =3D next.mnt;=0A=
 			nd->dentry =3D next.dentry;=0A=
+			if (span_mount && next.dentry->d_op &&=0A=
+			    next.dentry->d_op->d_revalidate) {=0A=
+				nd->last =3D this;=0A=
+				next.dentry->d_op->d_revalidate(next.dentry, nd);=0A=
+				span_mount =3D 0;=0A=
+			}=0A=
 		}=0A=
 		err =3D -ENOTDIR; =0A=
 		if (!inode->i_op->lookup)=0A=
@@ -1523,9 +1533,18 @@=0A=
 	if (IS_ERR(tmp))=0A=
 		return PTR_ERR(tmp);=0A=
 =0A=
-	error =3D path_lookup(tmp, LOOKUP_PARENT, &nd);=0A=
+	intent_init(&nd.intent, IT_MKNOD);=0A=
+	nd.intent.it_create_mode =3D mode;=0A=
+	nd.intent.it_create.dev =3D dev;=0A=
+=0A=
+	error =3D path_lookup_it(tmp, LOOKUP_PARENT, &nd);=0A=
 	if (error)=0A=
 		goto out;=0A=
+	if (nd.intent.it_flags & IT_STATUS_RAW) {=0A=
+		error =3D nd.intent.it_create.raw_status;=0A=
+		goto out2;=0A=
+	}=0A=
+=0A=
 	dentry =3D lookup_create(&nd, 0);=0A=
 	error =3D PTR_ERR(dentry);=0A=
 =0A=
@@ -1552,6 +1571,7 @@=0A=
 		dput(dentry);=0A=
 	}=0A=
 	up(&nd.dentry->d_inode->i_sem);=0A=
+out2:=0A=
 	path_release(&nd);=0A=
 out:=0A=
 	putname(tmp);=0A=
@@ -1594,9 +1614,15 @@=0A=
 		struct dentry *dentry;=0A=
 		struct nameidata nd;=0A=
 =0A=
-		error =3D path_lookup(tmp, LOOKUP_PARENT, &nd);=0A=
+		intent_init(&nd.intent, IT_MKDIR);=0A=
+		nd.intent.it_create_mode =3D mode;=0A=
+		error =3D path_lookup_it(tmp, LOOKUP_PARENT, &nd);=0A=
 		if (error)=0A=
 			goto out;=0A=
+		if (nd.intent.it_flags & IT_STATUS_RAW) {=0A=
+			error =3D nd.intent.it_create.raw_status;=0A=
+			goto out2;=0A=
+		}=0A=
 		dentry =3D lookup_create(&nd, 1);=0A=
 		error =3D PTR_ERR(dentry);=0A=
 		if (!IS_ERR(dentry)) {=0A=
@@ -1606,6 +1632,7 @@=0A=
 			dput(dentry);=0A=
 		}=0A=
 		up(&nd.dentry->d_inode->i_sem);=0A=
+out2:=0A=
 		path_release(&nd);=0A=
 out:=0A=
 		putname(tmp);=0A=
@@ -1691,9 +1718,14 @@=0A=
 	if(IS_ERR(name))=0A=
 		return PTR_ERR(name);=0A=
 =0A=
-	error =3D path_lookup(name, LOOKUP_PARENT, &nd);=0A=
+	intent_init(&nd.intent, IT_RMDIR);=0A=
+	error =3D path_lookup_it(name, LOOKUP_PARENT, &nd);=0A=
 	if (error)=0A=
 		goto exit;=0A=
+	if (nd.intent.it_flags & IT_STATUS_RAW) {=0A=
+		error =3D nd.intent.it_create.raw_status;=0A=
+		goto exit1;=0A=
+	}=0A=
 =0A=
 	switch(nd.last_type) {=0A=
 		case LAST_DOTDOT:=0A=
@@ -1769,9 +1801,15 @@=0A=
 	if(IS_ERR(name))=0A=
 		return PTR_ERR(name);=0A=
 =0A=
-	error =3D path_lookup(name, LOOKUP_PARENT, &nd);=0A=
+	intent_init(&nd.intent, IT_UNLINK);=0A=
+	error =3D path_lookup_it(name, LOOKUP_PARENT, &nd);=0A=
 	if (error)=0A=
 		goto exit;=0A=
+	if (nd.intent.it_flags & IT_STATUS_RAW) {=0A=
+		error =3D nd.intent.it_create.raw_status;=0A=
+		goto exit1;=0A=
+	}=0A=
+=0A=
 	error =3D -EISDIR;=0A=
 	if (nd.last_type !=3D LAST_NORM)=0A=
 		goto exit1;=0A=
@@ -1843,9 +1881,15 @@=0A=
 		struct dentry *dentry;=0A=
 		struct nameidata nd;=0A=
 =0A=
-		error =3D path_lookup(to, LOOKUP_PARENT, &nd);=0A=
+		intent_init(&nd.intent, IT_SYMLINK);=0A=
+		nd.intent.it_create.link =3D from;=0A=
+		error =3D path_lookup_it(to, LOOKUP_PARENT, &nd);=0A=
 		if (error)=0A=
 			goto out;=0A=
+		if (nd.intent.it_flags & IT_STATUS_RAW) {=0A=
+			error =3D nd.intent.it_create.raw_status;=0A=
+			goto out2;=0A=
+		}=0A=
 		dentry =3D lookup_create(&nd, 0);=0A=
 		error =3D PTR_ERR(dentry);=0A=
 		if (!IS_ERR(dentry)) {=0A=
@@ -1853,6 +1897,7 @@=0A=
 			dput(dentry);=0A=
 		}=0A=
 		up(&nd.dentry->d_inode->i_sem);=0A=
+out2:=0A=
 		path_release(&nd);=0A=
 out:=0A=
 		putname(to);=0A=
@@ -1924,9 +1969,15 @@=0A=
 	error =3D __user_walk(oldname, 0, &old_nd);=0A=
 	if (error)=0A=
 		goto exit;=0A=
-	error =3D path_lookup(to, LOOKUP_PARENT, &nd);=0A=
+	intent_init(&nd.intent, IT_LINK);=0A=
+	nd.intent.it_create.source_nd =3D &old_nd;=0A=
+	error =3D path_lookup_it(to, LOOKUP_PARENT, &nd);=0A=
 	if (error)=0A=
 		goto out;=0A=
+	if (nd.intent.it_flags & IT_STATUS_RAW) {=0A=
+		error =3D nd.intent.it_create.raw_status;=0A=
+		goto out_release;=0A=
+	}=0A=
 	error =3D -EXDEV;=0A=
 	if (old_nd.mnt !=3D nd.mnt)=0A=
 		goto out_release;=0A=
@@ -2107,9 +2158,15 @@=0A=
 	if (error)=0A=
 		goto exit;=0A=
 =0A=
-	error =3D path_lookup(newname, LOOKUP_PARENT, &newnd);=0A=
+	intent_init(&newnd.intent, IT_RENAME);=0A=
+	newnd.intent.it_create.source_nd =3D &oldnd;=0A=
+	error =3D path_lookup_it(newname, LOOKUP_PARENT, &newnd);=0A=
 	if (error)=0A=
 		goto exit1;=0A=
+	if (newnd.intent.it_flags & IT_STATUS_RAW) {=0A=
+		error =3D newnd.intent.it_create.raw_status;=0A=
+		goto exit2;=0A=
+	}=0A=
 =0A=
 	error =3D -EXDEV;=0A=
 	if (oldnd.mnt !=3D newnd.mnt)=0A=
Index: linux-2.6.6/include/linux/namei.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.6.orig/include/linux/namei.h	2004-06-02 17:01:51.091409160 =
+0300=0A=
+++ linux-2.6.6/include/linux/namei.h	2004-06-02 17:01:54.912828216 +0300=0A=
@@ -15,16 +15,33 @@=0A=
 #define IT_UNLINK	(1<<5)=0A=
 #define IT_TRUNC	(1<<6)=0A=
 #define IT_GETXATTR	(1<<7)=0A=
+#define IT_RMDIR	(1<<8)=0A=
+#define IT_LINK		(1<<9)=0A=
+#define IT_RENAME	(1<<10)=0A=
+#define IT_MKDIR	(1<<11)=0A=
+#define IT_MKNOD	(1<<12)=0A=
+#define IT_SYMLINK	(1<<13)=0A=
 =0A=
 #define INTENT_MAGIC 0x19620323=0A=
+#define IT_STATUS_RAW (1<<10)	/* Setting this in it_flags on exit from =
lookup=0A=
+				   means everything was done already and return=0A=
+				   value from lookup is in fact status of=0A=
+				   already performed operation */=0A=
 struct lookup_intent {=0A=
 	int     it_magic;=0A=
 	int     it_op;=0A=
 	void    (*it_op_release)(struct lookup_intent *);=0A=
 	int     it_flags;=0A=
 	int     it_create_mode;=0A=
+	union {=0A=
+		int	raw_status;	/* return value from raw method */=0A=
+		unsigned	dev;	/* For mknod */=0A=
+		char	*link;	/* For symlink */=0A=
+		struct nameidata *source_nd; /* For link/rename */=0A=
+	} it_create;=0A=
 };=0A=
 =0A=
+=0A=
 static inline void intent_init(struct lookup_intent *it, int op)=0A=
 {=0A=
 	memset(it, 0, sizeof(*it));=0A=

------=_NextPart_000_002D_01C448C5.340A8B80--

