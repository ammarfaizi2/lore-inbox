Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262391AbSJPMCC>; Wed, 16 Oct 2002 08:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSJPMCC>; Wed, 16 Oct 2002 08:02:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58287 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262391AbSJPMB6>;
	Wed, 16 Oct 2002 08:01:58 -0400
Date: Wed, 16 Oct 2002 05:00:31 -0700 (PDT)
Message-Id: <20021016.050031.31945417.davem@redhat.com>
To: Nikita@Namesys.COM
Cc: geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS build error on m68k in 2.5.43
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15789.19959.929002.906160@laputa.namesys.com>
References: <Pine.GSO.4.21.0210161319210.9988-100000@vervain.sonytel.be>
	<15789.19959.929002.906160@laputa.namesys.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nikita Danilov <Nikita@Namesys.COM>
   Date: Wed, 16 Oct 2002 15:31:03 +0400
   
   Second parameter of xfs_bmbt_disk_set_allf is 0 (zero). Try to replace
   it with O.

You'll need lots more fixes ever after that, big-endian
is pretty broke with the most recent updates.

Here are the fixes I sent to the XFS maintainers.

--- ./fs/xfs/linux/xfs_globals.c.~1~	Tue Oct 15 22:56:37 2002
+++ ./fs/xfs/linux/xfs_globals.c	Tue Oct 15 22:57:18 2002
@@ -64,5 +64,6 @@ EXPORT_SYMBOL(xfs_Gqm);
 EXPORT_SYMBOL(xfs_next_bit);
 EXPORT_SYMBOL(xfs_contig_bits);
 EXPORT_SYMBOL(xfs_bmbt_get_all);
+#if ARCH_CONVERT != ARCH_NOCONVERT
 EXPORT_SYMBOL(xfs_bmbt_disk_get_all);
-
+#endif
--- ./fs/xfs/xfs_bmap_btree.h.~1~	Tue Oct 15 22:37:02 2002
+++ ./fs/xfs/xfs_bmap_btree.h	Tue Oct 15 22:37:59 2002
@@ -658,8 +658,8 @@ xfs_bmbt_disk_set_allf(
 #else
 #define xfs_bmbt_disk_set_all(r, s) \
 	xfs_bmbt_set_all(r, s)
-#define xfs_bmbt_disk_set_allf(r, 0, b, c, v) \
-	xfs_bmbt_set_allf(r, 0, b, c, v)
+#define xfs_bmbt_disk_set_allf(r, o, b, c, v) \
+	xfs_bmbt_set_allf(r, o, b, c, v)
 #endif
 
 void
--- ./fs/xfs/xfs_inode_item.c.~1~	Tue Oct 15 22:50:14 2002
+++ ./fs/xfs/xfs_inode_item.c	Tue Oct 15 22:54:57 2002
@@ -214,7 +214,7 @@ xfs_inode_item_format(
 	xfs_log_iovec_t		*vecp;
 	xfs_inode_t		*ip;
 	size_t			data_bytes;
-	xfs_bmbt_rec_t		*ext_buffer;
+	xfs_bmbt_rec_32_t	*ext_buffer;
 	int			nrecs;
 	xfs_mount_t		*mp;
 
@@ -340,7 +340,8 @@ xfs_inode_item_format(
 					KM_SLEEP);
 				iip->ili_extents_buf = ext_buffer;
 				vecp->i_addr = (xfs_caddr_t)ext_buffer;
-				vecp->i_len = xfs_iextents_copy(ip, ext_buffer,
+				vecp->i_len = xfs_iextents_copy(ip,
+						(xfs_bmbt_rec_64_t *) ext_buffer,
 						XFS_DATA_FORK);
 			}
 			ASSERT(vecp->i_len <= ip->i_df.if_bytes);
--- ./fs/xfs/xfs_inode.c.~1~	Tue Oct 15 22:50:33 2002
+++ ./fs/xfs/xfs_inode.c	Tue Oct 15 22:51:15 2002
@@ -602,9 +602,12 @@ xfs_iformat_extents(
 	int		whichfork)
 {
 	xfs_ifork_t	*ifp;
-	int		nex, i;
+	int		nex;
 	int		real_size;
 	int		size;
+#if ARCH_CONVERT != ARCH_NOCONVERT
+	int		i;
+#endif
 	xfs_bmbt_rec_t	*ep, *dp;
 
 	ifp = XFS_IFORK_PTR(ip, whichfork);
