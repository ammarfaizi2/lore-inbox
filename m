Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286365AbSAIMzZ>; Wed, 9 Jan 2002 07:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286371AbSAIMzS>; Wed, 9 Jan 2002 07:55:18 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:54800 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286365AbSAIMzH>; Wed, 9 Jan 2002 07:55:07 -0500
Date: Wed, 9 Jan 2002 15:55:04 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Cc: adilger@turbolabs.com
Subject: [PATCH] UUID & volume labels support for reiserfs
Message-ID: <20020109155504.A4551@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

    Attached is the patch that reserves space for volume label and UUID in reiserfs v3.6 superblock.
    It also generates random UUID for volumes converted from 3.5 to 3.6 format by the kernel.
    Original patch author is Andreas Dilger <adilger@turbolabs.com>.
    Please apply.

Bye,
    Oleg

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="v3.6_uuid_support-1.diff"

--- linux/fs/reiserfs/objectid.c.orig	Tue Jan  8 16:04:06 2002
+++ linux/fs/reiserfs/objectid.c	Tue Jan  8 17:45:15 2002
@@ -5,6 +5,7 @@
 #include <linux/config.h>
 #include <linux/string.h>
 #include <linux/locks.h>
+#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/reiserfs_fs.h>
 
@@ -195,6 +196,10 @@
 
     /* set the max size so we don't overflow later */
     disk_sb->s_oid_maxsize = cpu_to_le16(new_size) ;
+
+    /* Zero out label and generate random UUID */
+    memset(disk_sb->s_label, 0, sizeof(disk_sb->s_label)) ;
+    generate_random_uuid(disk_sb->s_uuid);
 
     /* finally, zero out the unused chunk of the new super */
     memset(disk_sb->s_unused, 0, sizeof(disk_sb->s_unused)) ;
--- linux/include/linux/reiserfs_fs_sb.h.orig	Tue Jan  8 16:05:59 2002
+++ linux/include/linux/reiserfs_fs_sb.h	Tue Jan  8 17:34:22 2002
@@ -61,7 +61,13 @@
                                    superblock. -Hans */
   __u16 s_reserved;
   __u32 s_inode_generation;
-  char s_unused[124] ;			/* zero filled by mkreiserfs */
+  __u32 s_flags;		       /* Right now used only by inode-attributes, if enabled */
+  unsigned char s_uuid[16];            /* filesystem unique identifier */
+  unsigned char s_label[16];           /* filesystem volume label */
+  char s_unused[88] ;                  /* zero filled by mkreiserfs and
+                                        * reiserfs_convert_objectid_map_v1()
+                                        * so any additions must be updated
+                                        * there as well. */
 } __attribute__ ((__packed__));
 
 #define SB_SIZE (sizeof(struct reiserfs_super_block))

--EeQfGwPcQSOJBaQU--
