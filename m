Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUDNAyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 20:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbUDNAyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 20:54:01 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:30101 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263845AbUDNAxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 20:53:47 -0400
Subject: [PATCH 4/4] ext3 block reservation patch set -- dynamically
	increase reservation window
From: Mingming Cao <cmm@us.ibm.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, tytso@mit.edu, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <1081903949.3548.6837.camel@localhost.localdomain>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
	<20040330014523.6a368a69.akpm@osdl.org>
	<1080956712.15980.6505.camel@localhost.localdomain>
	<20040402175049.20b10864.akpm@osdl.org>
	<1080959870.3548.6555.camel@localhost.localdomain> 
	<20040402185007.7d41e1a2.akpm@osdl.org> 
	<1081903949.3548.6837.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-2UONXwQipxVa1jPzcpII"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Apr 2004 18:00:27 -0700
Message-Id: <1081904429.3548.6850.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2UONXwQipxVa1jPzcpII
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> [patch 4]ext3_rsv_dw.patch: adjust the reservation window size
> dynamically:
> 	Start from the deault reservation window size, if the hit ration 	of
> the reservation window is more than 50%, we will double the 	reservation
> window size next time up to a certain upper limit.

diffstat ext3_rsv_dw.patch
 fs/ext3/balloc.c          |   13 ++++++++++++-
 fs/ext3/ialloc.c          |    3 ++-
 fs/ext3/super.c           |    1 +
 include/linux/ext3_fs_i.h |    1 +
 4 files changed, 16 insertions(+), 2 deletions(-)


--=-2UONXwQipxVa1jPzcpII
Content-Disposition: attachment; filename=ext3_rsv_dw.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=ext3_rsv_dw.patch; charset=UTF-8

diff -urNp 264-rsv-cleanup-base-mount/fs/ext3/balloc.c 264-rsv-cleanup-base=
-mount-dw/fs/ext3/balloc.c
--- 264-rsv-cleanup-base-mount/fs/ext3/balloc.c	2004-04-13 01:44:50.0914770=
08 -0700
+++ 264-rsv-cleanup-base-mount-dw/fs/ext3/balloc.c	2004-04-12 22:15:12.1286=
18008 -0700
@@ -148,6 +148,7 @@ static inline void rsv_window_remove(str
 {
 		rsv->rsv_start =3D 0;
 		rsv->rsv_end =3D 0;
+		rsv->rsv_alloc_hit =3D 0;
 		list_del(&rsv->rsv_list);
 		INIT_LIST_HEAD(&rsv->rsv_list);
 }
@@ -548,7 +549,8 @@ repeat:
 			goto fail_access;
 		goto repeat;
 	}
-
+	if (my_rsv)
+		my_rsv->rsv_alloc_hit++;
 	return goal;
 fail_access:
 	return -1;
@@ -731,6 +733,15 @@ static int alloc_new_reservation(struct=20
 			start_block =3D my_rsv->rsv_end + 1;
 		search_head =3D list_entry(my_rsv->rsv_list.prev,=20
 				struct reserve_window, rsv_list);
+		if ((my_rsv->rsv_alloc_hit > (my_rsv->rsv_end - my_rsv->rsv_start + 1) /=
 2)) {
+			/*=20
+			 * if we previously allocation hit ration is greater than half
+			 * we double the size of reservation window next time
+			 * otherwise keep the same
+			 */
+			size =3D size * 2;
+			atomic_set(&my_rsv->rsv_goal_size, size);
+		}
 		rsv_window_remove(my_rsv);
 	}
 	else {
diff -urNp 264-rsv-cleanup-base-mount/fs/ext3/ialloc.c 264-rsv-cleanup-base=
-mount-dw/fs/ext3/ialloc.c
--- 264-rsv-cleanup-base-mount/fs/ext3/ialloc.c	2004-04-10 01:19:52.7055037=
44 -0700
+++ 264-rsv-cleanup-base-mount-dw/fs/ext3/ialloc.c	2004-04-12 21:46:19.4430=
26256 -0700
@@ -583,8 +583,9 @@ got:
 	ei->i_dir_acl =3D 0;
 	ei->i_dtime =3D 0;
 	ei->i_rsv_window.rsv_start =3D 0;
-	ei->i_rsv_window.rsv_end=3D 0;
+	ei->i_rsv_window.rsv_end =3D 0;
 	atomic_set(&ei->i_rsv_window.rsv_goal_size, EXT3_DEFAULT_RESERVE_BLOCKS);
+	ei->i_rsv_window.rsv_alloc_hit =3D 0;
 	INIT_LIST_HEAD(&ei->i_rsv_window.rsv_list);
 	ei->i_block_group =3D group;
=20
diff -urNp 264-rsv-cleanup-base-mount/fs/ext3/super.c 264-rsv-cleanup-base-=
mount-dw/fs/ext3/super.c
--- 264-rsv-cleanup-base-mount/fs/ext3/super.c	2004-04-10 01:19:52.71950161=
6 -0700
+++ 264-rsv-cleanup-base-mount-dw/fs/ext3/super.c	2004-04-12 21:47:00.61276=
7504 -0700
@@ -1312,6 +1312,7 @@ static int ext3_fill_super (struct super
 	INIT_LIST_HEAD(&sbi->s_rsv_window_head.rsv_list);
 	sbi->s_rsv_window_head.rsv_start =3D 0;
 	sbi->s_rsv_window_head.rsv_end =3D 0;
+	sbi->s_rsv_window_head.rsv_alloc_hit =3D 0;
 	atomic_set(&sbi->s_rsv_window_head.rsv_goal_size, 0);
=20
 	/*
diff -urNp 264-rsv-cleanup-base-mount/include/linux/ext3_fs_i.h 264-rsv-cle=
anup-base-mount-dw/include/linux/ext3_fs_i.h
--- 264-rsv-cleanup-base-mount/include/linux/ext3_fs_i.h	2004-04-10 01:19:5=
2.723501008 -0700
+++ 264-rsv-cleanup-base-mount-dw/include/linux/ext3_fs_i.h	2004-04-12 21:4=
3:25.019542656 -0700
@@ -23,6 +23,7 @@ struct reserve_window{
 	__u32			rsv_start;
 	__u32			rsv_end;
 	atomic_t		rsv_goal_size;
+	__u32			rsv_alloc_hit;
 };
=20
 /*

--=-2UONXwQipxVa1jPzcpII--

