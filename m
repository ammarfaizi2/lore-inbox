Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSIAJkI>; Sun, 1 Sep 2002 05:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSIAJkI>; Sun, 1 Sep 2002 05:40:08 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:31753 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316599AbSIAJkH>; Sun, 1 Sep 2002 05:40:07 -0400
Date: Sun, 1 Sep 2002 11:44:16 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com
Subject: Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020901094416.GF32122@louise.pinerecords.com>
References: <20020901085524.GB32122@louise.pinerecords.com> <20020901.015204.124081360.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020901.015204.124081360.davem@redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 5 days, 8:49
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Tomas Szepe <szepe@pinerecords.com>
>    Date: Sun, 1 Sep 2002 10:55:24 +0200
> 
>    Against 2.4.20-pre5 - fix up the type of nlink_t. This makes jfs and
>    reiserfs stop complaining about comparisons always turning up false
>    due to limited range of data type.
> 
> If you change this, you change the types exported to userspace
> which will break everything.

Right.  Here's a corresponding reiserfs/jfs fix, then.  I've checked the
constants aren't used for anything else except nlink overflow alerts.

T.


diff -urN linux-2.4.20-pre5/fs/jfs/jfs_filsys.h linux-2.4.20-pre5.n/fs/jfs/jfs_filsys.h
--- linux-2.4.20-pre5/fs/jfs/jfs_filsys.h	2002-09-01 11:31:44.000000000 +0200
+++ linux-2.4.20-pre5.n/fs/jfs/jfs_filsys.h	2002-09-01 11:30:13.000000000 +0200
@@ -125,7 +125,8 @@
 #define MAXBLOCKSIZE		4096
 #define	MAXFILESIZE		((s64)1 << 52)
 
-#define JFS_LINK_MAX		65535	/* nlink_t is unsigned short */
+/* the shortest nlink_t there is is sparc's signed short */
+#define JFS_LINK_MAX		32767
 
 /* Minimum number of bytes supported for a JFS partition */
 #define MINJFS			(0x1000000)
diff -urN linux-2.4.20-pre5/include/linux/reiserfs_fs.h linux-2.4.20-pre5.n/include/linux/reiserfs_fs.h
--- linux-2.4.20-pre5/include/linux/reiserfs_fs.h	2002-09-01 11:31:45.000000000 +0200
+++ linux-2.4.20-pre5.n/include/linux/reiserfs_fs.h	2002-09-01 11:23:30.000000000 +0200
@@ -1185,10 +1185,12 @@
 #define MAX_B_NUM  MAX_UL_INT
 #define MAX_FC_NUM MAX_US_INT
 
-
-/* the purpose is to detect overflow of an unsigned short */
-#define REISERFS_LINK_MAX (MAX_US_INT - 1000)
-
+/* the original purpose was to detect a possible overflow
+ * of an unsigned short nlink_t. However, there are archs
+ * that only provide a signed short nlink_t, so this will
+ * have to start ringing a wee bit earlier.
+ */
+#define REISERFS_LINK_MAX (0x7fff - 1000)
 
 /* The following defines are used in reiserfs_insert_item and reiserfs_append_item  */
 #define REISERFS_KERNEL_MEM		0	/* reiserfs kernel memory mode	*/
