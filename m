Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291356AbSBADZU>; Thu, 31 Jan 2002 22:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290925AbSBADZL>; Thu, 31 Jan 2002 22:25:11 -0500
Received: from ns.suse.de ([213.95.15.193]:32262 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290258AbSBADY6>;
	Thu, 31 Jan 2002 22:24:58 -0500
Date: Fri, 1 Feb 2002 04:24:57 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: <rwhron@earthlink.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops immediately following dbench 192 on 2.5.3
In-Reply-To: <20020201030951.GA5946@earthlink.net>
Message-ID: <Pine.LNX.4.33.0202010423590.14833-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 rwhron@earthlink.net wrote:

> Hmm, I don't see my similar report on 2.5.2-dj7 in the archive.

The patches in question..

--- linux-2.5.3/fs/reiserfs/inode.c.orig	Thu Jan 31 19:28:57 2002
+++ linux-2.5.3/fs/reiserfs/inode.c	Thu Jan 31 19:31:01 2002
@@ -888,6 +888,8 @@
     copy_key (INODE_PKEY (inode), &(ih->ih_key));
     inode->i_blksize = PAGE_SIZE;

+    INIT_LIST_HEAD(&(REISERFS_I(inode)->i_prealloc_list ));
+
     if (stat_data_v1 (ih)) {
 	struct stat_data_v1 * sd = (struct stat_data_v1 *)B_I_PITEM (bh, ih);
 	unsigned long blocks;
@@ -1532,6 +1534,7 @@
     REISERFS_I(inode)->i_first_direct_byte = S_ISLNK(mode) ? 1 :
       U32_MAX/*NO_BYTES_IN_DIRECT_ITEM*/;

+    INIT_LIST_HEAD(&(REISERFS_I(inode)->i_prealloc_list ));
     REISERFS_I(inode)->i_flags = 0;
     REISERFS_I(inode)->i_prealloc_block = 0;
     REISERFS_I(inode)->i_prealloc_count = 0;
--- linux-2.5.3/fs/reiserfs/stree.c.orig	Thu Jan 31 19:24:47 2002
+++ linux-2.5.3/fs/reiserfs/stree.c	Thu Jan 31 19:26:54 2002
@@ -126,19 +126,19 @@
   retval = comp_short_keys (le_key, cpu_key);
   if (retval)
       return retval;
-  if (le_key_k_offset (cpu_key->version, le_key) < cpu_key_k_offset (cpu_key))
+  if (le_key_k_offset (le_key_version(le_key), le_key) < cpu_key_k_offset (cpu_key))
       return -1;
-  if (le_key_k_offset (cpu_key->version, le_key) > cpu_key_k_offset (cpu_key))
+  if (le_key_k_offset (le_key_version(le_key), le_key) > cpu_key_k_offset (cpu_key))
       return 1;

   if (cpu_key->key_length == 3)
       return 0;

   /* this part is needed only when tail conversion is in progress */
-  if (le_key_k_type (cpu_key->version, le_key) < cpu_key_k_type (cpu_key))
+  if (le_key_k_type (le_key_version(le_key), le_key) < cpu_key_k_type (cpu_key))
     return -1;

-  if (le_key_k_type (cpu_key->version, le_key) > cpu_key_k_type (cpu_key))
+  if (le_key_k_type (le_key_version(le_key), le_key) > cpu_key_k_type (cpu_key))
     return 1;

   return 0;
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

