Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261470AbVCCGSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261470AbVCCGSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVCCGPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:15:22 -0500
Received: from fire.osdl.org ([65.172.181.4]:46800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261509AbVCCGKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:10:13 -0500
Date: Wed, 2 Mar 2005 21:51:46 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: aia21@cantab.net, akpm <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: fix printk format warning (ia64)
Message-Id: <20050302215146.7a971d99.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ntfs: Fix printk format warnings on ia64:

fs/ntfs/aops.c:947: warning: long long unsigned int format, long int arg (arg 4)
fs/ntfs/debug.c:169: warning: long long unsigned int format, VCN arg (arg 2)
fs/ntfs/debug.c:169: warning: long long unsigned int format, s64 arg (arg 4)
fs/ntfs/debug.c:174: warning: long long unsigned int format, LCN arg (arg 3)
fs/ntfs/debug.c:174: warning: long long unsigned int format, VCN arg (arg 2)
fs/ntfs/debug.c:174: warning: long long unsigned int format, s64 arg (arg 4)
fs/ntfs/inode.c:2517: warning: long long unsigned int format, s64 arg (arg 6)
fs/ntfs/inode.c:2517: warning: long long unsigned int format, s64 arg (arg 7)
fs/ntfs/inode.c:2526: warning: long long unsigned int format, s64 arg (arg 6)
fs/ntfs/inode.c:2526: warning: long long unsigned int format, s64 arg (arg 7)
fs/ntfs/inode.c:2535: warning: long long unsigned int format, s64 arg (arg 6)
fs/ntfs/inode.c:2535: warning: long long unsigned int format, s64 arg (arg 7)
fs/ntfs/lcnalloc.c:759: warning: long long unsigned int format, long unsigned int arg (arg 6)
fs/ntfs/mft.c:1775: warning: long long int format, s64 arg (arg 5)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 fs/ntfs/aops.c     |    3 ++-
 fs/ntfs/debug.c    |   15 +++++++++------
 fs/ntfs/inode.c    |   12 ++++++------
 fs/ntfs/lcnalloc.c |    2 +-
 fs/ntfs/mft.c      |    2 +-
 5 files changed, 19 insertions(+), 15 deletions(-)

diff -Naurp ./fs/ntfs/aops.c~ntfs_printk ./fs/ntfs/aops.c
--- ./fs/ntfs/aops.c~ntfs_printk	2005-03-01 23:38:17.000000000 -0800
+++ ./fs/ntfs/aops.c	2005-03-02 10:55:16.759656072 -0800
@@ -949,7 +949,8 @@ lock_retry_remap:
 						"attribute type 0x%x) because "
 						"its location on disk could "
 						"not be determined (error "
-						"code %lli).", (s64)block <<
+						"code %lli).",
+						(long long)block <<
 						bh_size_bits >>
 						vol->mft_record_size_bits,
 						ni->mft_no, ni->type,
diff -Naurp ./fs/ntfs/mft.c~ntfs_printk ./fs/ntfs/mft.c
--- ./fs/ntfs/mft.c~ntfs_printk	2005-03-01 23:38:13.000000000 -0800
+++ ./fs/ntfs/mft.c	2005-03-02 10:58:11.409105320 -0800
@@ -1772,7 +1772,7 @@ static int ntfs_mft_data_extend_allocati
 		return PTR_ERR(rl);
 	}
 	mft_ni->runlist.rl = rl;
-	ntfs_debug("Allocated %lli clusters.", nr);
+	ntfs_debug("Allocated %lli clusters.", (long long)nr);
 	/* Find the last run in the new runlist. */
 	for (; rl[1].length; rl++)
 		;
diff -Naurp ./fs/ntfs/lcnalloc.c~ntfs_printk ./fs/ntfs/lcnalloc.c
--- ./fs/ntfs/lcnalloc.c~ntfs_printk	2005-03-01 23:38:34.000000000 -0800
+++ ./fs/ntfs/lcnalloc.c	2005-03-02 11:00:07.080520592 -0800
@@ -761,7 +761,7 @@ out:
 					"could allocate up to 0x%llx "
 					"clusters.",
 					(unsigned long long)rl[0].lcn,
-					(unsigned long long)count - clusters);
+					(unsigned long long)(count - clusters));
 		/* Deallocate all allocated clusters. */
 		ntfs_debug("Attempting rollback...");
 		err2 = ntfs_cluster_free_from_rl_nolock(vol, rl);
diff -Naurp ./fs/ntfs/inode.c~ntfs_printk ./fs/ntfs/inode.c
--- ./fs/ntfs/inode.c~ntfs_printk	2005-03-01 23:38:26.000000000 -0800
+++ ./fs/ntfs/inode.c	2005-03-02 11:06:34.090686104 -0800
@@ -2516,8 +2516,8 @@ int ntfs_write_inode(struct inode *vi, i
 	if (si->last_data_change_time != nt) {
 		ntfs_debug("Updating mtime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino,
-				sle64_to_cpu(si->last_data_change_time),
-				sle64_to_cpu(nt));
+				(long long)sle64_to_cpu(si->last_data_change_time),
+				(long long)sle64_to_cpu(nt));
 		si->last_data_change_time = nt;
 		modified = TRUE;
 	}
@@ -2525,8 +2525,8 @@ int ntfs_write_inode(struct inode *vi, i
 	if (si->last_mft_change_time != nt) {
 		ntfs_debug("Updating ctime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino,
-				sle64_to_cpu(si->last_mft_change_time),
-				sle64_to_cpu(nt));
+				(long long)sle64_to_cpu(si->last_mft_change_time),
+				(long long)sle64_to_cpu(nt));
 		si->last_mft_change_time = nt;
 		modified = TRUE;
 	}
@@ -2534,8 +2534,8 @@ int ntfs_write_inode(struct inode *vi, i
 	if (si->last_access_time != nt) {
 		ntfs_debug("Updating atime for inode 0x%lx: old = 0x%llx, "
 				"new = 0x%llx", vi->i_ino,
-				sle64_to_cpu(si->last_access_time),
-				sle64_to_cpu(nt));
+				(long long)sle64_to_cpu(si->last_access_time),
+				(long long)sle64_to_cpu(nt));
 		si->last_access_time = nt;
 		modified = TRUE;
 	}
diff -Naurp ./fs/ntfs/debug.c~ntfs_printk ./fs/ntfs/debug.c
--- ./fs/ntfs/debug.c~ntfs_printk	2005-03-01 23:38:34.000000000 -0800
+++ ./fs/ntfs/debug.c	2005-03-02 11:13:23.530441800 -0800
@@ -164,14 +164,17 @@ void ntfs_debug_dump_runlist(const runli
 			if (index > -LCN_ENOENT - 1)
 				index = 3;
 			printk(KERN_DEBUG "%-16Lx %s %-16Lx%s\n",
-					(rl + i)->vcn, lcn_str[index],
-					(rl + i)->length, (rl + i)->length ?
-					"" : " (runlist end)");
+					(long long)(rl + i)->vcn, lcn_str[index],
+					(long long)(rl + i)->length,
+					(rl + i)->length ? "" :
+						" (runlist end)");
 		} else
 			printk(KERN_DEBUG "%-16Lx %-16Lx  %-16Lx%s\n",
-					(rl + i)->vcn, (rl + i)->lcn,
-					(rl + i)->length, (rl + i)->length ?
-					"" : " (runlist end)");
+					(long long)(rl + i)->vcn,
+					(long long)(rl + i)->lcn,
+					(long long)(rl + i)->length,
+					(rl + i)->length ? "" :
+						" (runlist end)");
 		if (!(rl + i)->length)
 			break;
 	}

---
