Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbTINNiC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 09:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTINNiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 09:38:02 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:27399 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261157AbTINNhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 09:37:54 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.0-test5] fix oopses is kobject parent is removed before child
Date: Sun, 14 Sep 2003 17:37:04 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A8GZ/a8SWWvEyrR"
Message-Id: <200309141737.04358.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_A8GZ/a8SWWvEyrR
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It is possible that parent is removed before child when child is in use. 
Trivial example is mounted USB storage when you unplug it. The kobject for 
USB device is removed but subordinate SCSI device remains. Then kernel oopses 
on attempt to release child e.g. umount removed USB storage. This patch fixes 
two problems:

- kset_hotplug. It oopses in get_kobj_path_length because child->parent points 
to nowhere - even if parent has not yet been overwritten, its name is already 
freed. Common oops I get is

Unable to handle kernel NULL pointer dereference at virtual address 00000000
printing eip:
c01caf50
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01caf50>]    Tainted: P
EFLAGS: 00010246
EIP is at get_kobj_path_length+0x40/0x60
eax: 00000000   ebx: c87db0fc   ecx: ffffffff   edx: 00000001
esi: ffffffff   edi: 00000000   ebp: c6a7fe14   esp: c6a7fdf8
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 2961, threadinfo=c6a7e000 task=c6f25000)
Stack: c02ecd9e c02ce570 00000000 00000017 c6a7e000 c6cd66a8 000000a7 c6a7fe64
c01cb175 c0346ec0 c8ae51b8 000000a7 c6a7fe40 d1c62e6f c7351d34 c8ae5194
d1c64e64 c70a2004 00000000 c70a201d c03131c0 d1943dbb 00000000 d19543ac
Call Trace:
[<c01cb175>] kset_hotplug+0x195/0x360
[<d1c62e6f>] sd_remove+0x7f/0xb0 [sd_mod]
[<c01cb768>] kobject_del+0x68/0x80
[<c0213f03>] device_del+0x83/0xb0
[<d193739c>] scsi_device_put+0xdc/0x100 [scsi_mod]
[<d1c615e4>] sd_release+0x64/0xb0 [sd_mod]
[<d1c61580>] sd_release+0x0/0xb0 [sd_mod]
[<c0178e46>] blkdev_put+0x236/0x270
[<c0178e04>] blkdev_put+0x1f4/0x270
[<c017716c>] kill_block_super+0x3c/0x50
[<c0175903>] deactivate_super+0xa3/0x170
[<c0191bcc>] sys_umount+0x3c/0x80
[<c0191c29>] sys_oldumount+0x19/0x20
[<c010c9ef>] syscall_call+0x7/0xb

the patch moves kobject_put for parent from unlink() into kobject_cleanup for 
child making sure reference to parents exists for as long as child is there 
and may use it.

- after this oops has been fixed I got next one now in sysfs. The problem is 
sysfs_remove_dir would unlink all children including directories for 
subordinate kobjects. Resulting in dget/dput mismatch. I usually got oops due 
to the fact that d_delete in remove_dir would free inode and then 
simple_rmdir would try to access it like in:

Unable to handle kernel NULL pointer dereference at virtual address 00000024    
printing eip:
c01959b3
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01959b3>]    Tainted: P
EFLAGS: 00010202
EIP is at simple_rmdir+0x33/0x50                                                
eax: 00000000   ebx: c71e8004   ecx: c71e800c   edx: ffffffd9
esi: c766e004   edi: c76d4004   ebp: c7115e20   esp: c7115e10                   
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 2703, threadinfo=c7114000 task=c93e4000)                   
Stack: c71e8004 c71df004 c766e074 c766e004 c7115e40 c01b4510 c766e004 
c71e8004
c71e8004 c71e1004 c7114000 c71e8004 c7115e64 c01b4661 c71e8004 c71e1004         
c71e8028 c7114000 c8a8e1b8 c0346f08 c86220bc c7115e7c c01cb733 c8a8e1b8
Call Trace:
[<c01b4510>] remove_dir+0x70/0xa0
[<c01b4661>] sysfs_remove_dir+0x111/0x1f0
[<c01cb733>] kobject_del+0x43/0x80
[<c0213f03>] device_del+0x83/0xb0
[<d193739c>] scsi_device_put+0xdc/0x100 [scsi_mod]
[<d1c615e4>] sd_release+0x64/0xb0 [sd_mod]
[<d1c61580>] sd_release+0x0/0xb0 [sd_mod]
[<c0178e46>] blkdev_put+0x236/0x270
[<c0178e04>] blkdev_put+0x1f4/0x270
[<c017716c>] kill_block_super+0x3c/0x50
[<c0175903>] deactivate_super+0xa3/0x170
[<c0191bcc>] sys_umount+0x3c/0x80
[<c0191c29>] sys_oldumount+0x19/0x20
[<c010c9ef>] syscall_call+0x7/0xb

The patch avoids calling extra d_delete/unlink on already-deleted dentry. I 
hate this patch but anything better apparently requires complete redesign of 
sysfs implementation. Unlinking busy directory is otherweise impossible and I 
am afraid it will show itself somewhere else.

-andrey

--Boundary-00=_A8GZ/a8SWWvEyrR
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.0-test5-kobj-parent-ref-count.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test5-kobj-parent-ref-count.patch"

--- ../tmp/linux-2.6.0-test5/lib/kobject.c	2003-09-09 23:46:26.000000000 +0400
+++ linux-2.6.0-test5/lib/kobject.c	2003-09-14 12:24:20.000000000 +0400
@@ -236,8 +236,6 @@ static void unlink(struct kobject * kobj
 		list_del_init(&kobj->entry);
 		up_write(&kobj->kset->subsys->rwsem);
 	}
-	if (kobj->parent) 
-		kobject_put(kobj->parent);
 	kobject_put(kobj);
 }
 
@@ -448,6 +446,8 @@ void kobject_cleanup(struct kobject * ko
 	if (kobj->k_name != kobj->name)
 		kfree(kobj->k_name);
 	kobj->k_name = NULL;
+	if (kobj->parent)
+		kobject_put(kobj->parent);
 	if (t && t->release)
 		t->release(kobj);
 	if (s)
--- ../tmp/linux-2.6.0-test5/fs/sysfs/dir.c	2003-09-09 23:46:13.000000000 +0400
+++ linux-2.6.0-test5/fs/sysfs/dir.c	2003-09-14 12:25:20.000000000 +0400
@@ -84,8 +84,16 @@ static void remove_dir(struct dentry * d
 {
 	struct dentry * parent = dget(d->d_parent);
 	down(&parent->d_inode->i_sem);
-	d_delete(d);
-	simple_rmdir(parent->d_inode,d);
+	/*
+	 * It is possible that parent has already been removed, in which
+	 * case directory is already unhashed and dput.
+	 * Note that this won't update parent->d_inode->i_nlink; OTOH
+	 * parent should already be dead
+	 */
+	if (!d_unhashed(d)) {
+		d_delete(d);
+		simple_rmdir(parent->d_inode,d);
+	}
 
 	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
 		 atomic_read(&d->d_count));

--Boundary-00=_A8GZ/a8SWWvEyrR--

