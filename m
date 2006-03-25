Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWCYVfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWCYVfU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 16:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWCYVfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 16:35:20 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:30904 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751089AbWCYVfU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 16:35:20 -0500
Date: Sat, 25 Mar 2006 22:35:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nathan Scott <nathans@sgi.com>
cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parenthesize macros in xfs
In-Reply-To: <20060321084619.E653275@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0603252232570.18484@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr>
 <20060321082327.B653275@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr>
 <20060321084619.E653275@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> while browsing through the xfs/linux source, I noticed that many macros do 
>> >> not do proper bracing. I have started to cook up a patch, but would like 
>> >> feedback first before I continue for nothing.
>> >> It goes like this:
>> >> ...
>> >
>> >That looks fine.  Please be sure to work on the -mm tree or on
>> >CVS on oss.sgi.com, so as to reduce your level of patch conflict.
>> 
>> Hm, would not it even be better to make them 'static inline' functions?
>
>Probably, I guess I'd want to see how invasive the patch becomes...?
>I really dislike those _ACL macros (around that example you gave, that
>could do with a cleanup all of its own - switching to xfs_acl_ maybe).
>Also watch for macros that modify their parameters, I got burned by
>doing an inline conversion a few releases back on just such a beast..
>

To implement static inline, it requires that header files be corrected 
first so that they could 'compile on their own'. Shall I post a patch for 
that too?

Here is the first patch in the series of 'fix most things that annoyed me'.

	- - - - - - - - - -

Multiple instruction #defines should be wrapped into do{}while(0).

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
Compile-tested.

diff -dpru xfs-cvs/dmapi/xfs_dm.c xfs-mod/dmapi/xfs_dm.c
--- xfs-cvs/dmapi/xfs_dm.c	2006-03-17 15:28:04.000000000 +0100
+++ xfs-mod/dmapi/xfs_dm.c	2006-03-25 21:23:45.035287000 +0100
@@ -52,9 +52,10 @@
 
 #define MAXNAMLEN MAXNAMELEN
 
-#define XFS_BHV_LOOKUP(vp, xbdp)  \
+#define XFS_BHV_LOOKUP(vp, xbdp) do { \
 	xbdp = vn_bhv_lookup(VN_BHV_HEAD(vp), &xfs_vnodeops); \
-	ASSERT(xbdp);
+	ASSERT(xbdp); \
+    } while(0)
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 #define MIN_DIO_SIZE(mp)		((mp)->m_sb.sb_sectsize)
@@ -156,7 +157,7 @@ STATIC	dm_size_t  dm_min_dio_xfer = 0; /
 #define DM_STAT_ALIGN		(sizeof(__uint64_t))
 
 /* DMAPI's E2BIG == EA's ERANGE */
-#define DM_EA_XLATE_ERR(err) { if (err == ERANGE) err = E2BIG; }
+#define DM_EA_XLATE_ERR(err) do { if (err == ERANGE) err = E2BIG; } while(0)
 
 /*
  *	xfs_dm_send_data_event()
diff -dpru xfs-mod-01/support/qsort.c xfs-mod-02/support/qsort.c
--- xfs-mod-01/support/qsort.c	2005-09-23 05:51:28.000000000 +0200
+++ xfs-mod-02/support/qsort.c	2006-03-25 22:20:37.055287000 +0100
@@ -55,13 +55,14 @@ swapfunc(char *a, char *b, int n, int sw
 		swapcode(char, a, b, n)
 }
 
-#define swap(a, b)					\
+#define swap(a, b) do {					\
 	if (swaptype == 0) {				\
 		long t = *(long *)(a);			\
 		*(long *)(a) = *(long *)(b);		\
 		*(long *)(b) = t;			\
 	} else						\
-		swapfunc(a, b, es, swaptype)
+		swapfunc(a, b, es, swaptype)		\
+} while(0)
 
 #define vecswap(a, b, n) 	if ((n) > 0) swapfunc(a, b, n, swaptype)
 
diff -dpru xfs-cvs/xfs_arch.h xfs-mod/xfs_arch.h
--- xfs-cvs/xfs_arch.h	2006-01-12 03:43:50.000000000 +0100
+++ xfs-mod/xfs_arch.h	2006-03-25 21:37:04.775287000 +0100
@@ -161,14 +161,14 @@
  */
 
 /* does not return a value */
-#define INT_XLATE(buf,mem,dir,arch) {\
+#define INT_XLATE(buf,mem,dir,arch) do { \
     ASSERT(dir); \
     if (dir>0) { \
 	(mem)=INT_GET(buf, arch); \
     } else { \
 	INT_SET(buf, arch, mem); \
     } \
-}
+} while(0)
 
 static inline void be16_add(__be16 *a, __s16 b)
 {
diff -dpru xfs-cvs/xfs_fs.h xfs-mod/xfs_fs.h
--- xfs-cvs/xfs_fs.h	2005-12-02 03:48:45.000000000 +0100
+++ xfs-mod/xfs_fs.h	2006-03-25 21:37:22.325287000 +0100
@@ -122,12 +122,13 @@ struct getbmapx {
 #define BMV_OF_PREALLOC		0x1	/* segment = unwritten pre-allocation */
 
 /*	Convert getbmap <-> getbmapx - move fields from p1 to p2. */
-#define GETBMAP_CONVERT(p1,p2) {	\
+#define GETBMAP_CONVERT(p1,p2) do {	\
 	p2.bmv_offset = p1.bmv_offset;	\
 	p2.bmv_block = p1.bmv_block;	\
 	p2.bmv_length = p1.bmv_length;	\
 	p2.bmv_count = p1.bmv_count;	\
-	p2.bmv_entries = p1.bmv_entries;  }
+	p2.bmv_entries = p1.bmv_entries; \
+    } while(0)
 
 
 /*
diff -dpru xfs-cvs/xfs_vfsops.c xfs-mod/xfs_vfsops.c
--- xfs-cvs/xfs_vfsops.c	2006-03-25 21:10:18.925287000 +0100
+++ xfs-mod/xfs_vfsops.c	2006-03-25 21:37:36.765287000 +0100
@@ -949,7 +949,7 @@ xfs_sync_inodes(
  * must be locked when this is called. After the call the list will no
  * longer be locked.
  */
-#define IPOINTER_INSERT(ip, mp)	{ \
+#define IPOINTER_INSERT(ip, mp)	do { \
 		ASSERT(ipointer_in == B_FALSE); \
 		ipointer->ip_mnext = ip->i_mnext; \
 		ipointer->ip_mprev = ip; \
@@ -959,14 +959,14 @@ xfs_sync_inodes(
 		XFS_MOUNT_IUNLOCK(mp); \
 		mount_locked = B_FALSE; \
 		IPOINTER_SET; \
-	}
+	} while(0)
 
 /* Remove the marker from the inode list. If the marker was the only item
  * in the list then there are no remaining inodes and we should zero out
  * the whole list. If we are the current head of the list then move the head
  * past us.
  */
-#define IPOINTER_REMOVE(ip, mp)	{ \
+#define IPOINTER_REMOVE(ip, mp)	do { \
 		ASSERT(ipointer_in == B_TRUE); \
 		if (ipointer->ip_mnext != (xfs_inode_t *)ipointer) { \
 			ip = ipointer->ip_mnext; \
@@ -981,7 +981,7 @@ xfs_sync_inodes(
 			ip = NULL; \
 		} \
 		IPOINTER_CLR; \
-	}
+	} while(0)
 
 #define XFS_PREEMPT_MASK	0x7f
 
diff -dpru xfs-cvs/xfs_vnodeops.c xfs-mod/xfs_vnodeops.c
--- xfs-cvs/xfs_vnodeops.c	2006-03-25 21:10:19.085287000 +0100
+++ xfs-mod/xfs_vnodeops.c	2006-03-25 21:37:48.405287000 +0100
@@ -2307,7 +2307,7 @@ again:
 }
 
 #ifdef	DEBUG
-#define	REMOVE_DEBUG_TRACE(x)	{remove_which_error_return = (x);}
+#define	REMOVE_DEBUG_TRACE(x)	do { remove_which_error_return = (x); } while(0)
 int remove_which_error_return = 0;
 #else /* ! DEBUG */
 #define	REMOVE_DEBUG_TRACE(x)
diff -dpru xfs-cvs/xfsidbg.c xfs-mod/xfsidbg.c
--- xfs-cvs/xfsidbg.c	2006-03-25 21:10:19.105287000 +0100
+++ xfs-mod/xfsidbg.c	2006-03-25 21:37:58.325287000 +0100
@@ -7354,7 +7354,7 @@ xfsidbg_xqm_dquot(xfs_dquot_t *dqp)
 
 
 #define XQMIDBG_LIST_PRINT(l, NXT) \
-{ \
+do { \
 	  xfs_dquot_t	*dqp;\
 	  int i = 0; \
 	  kdb_printf("[#%d dquots]\n", (int) (l)->qh_nelems); \
@@ -7367,7 +7367,7 @@ xfsidbg_xqm_dquot(xfs_dquot_t *dqp)
 			 (int) be64_to_cpu(dqp->q_core.d_icount), \
 			 (int) dqp->q_nrefs); }\
 	  kdb_printf("\n"); \
-}
+} while(0)
 
 static void
 xfsidbg_xqm_dqattached_inos(xfs_mount_t	*mp)
#<<eof>>

Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
