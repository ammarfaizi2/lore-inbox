Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291146AbSAaQo1>; Thu, 31 Jan 2002 11:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291147AbSAaQoS>; Thu, 31 Jan 2002 11:44:18 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:63756 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S291146AbSAaQoI>; Thu, 31 Jan 2002 11:44:08 -0500
Date: Thu, 31 Jan 2002 19:44:01 +0300
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@suse.de>, Sebastian Dr?ge <sebastian.droege@gmx.de>,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Cc: mason@suse.com
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020131194401.A818@namesys.com>
In-Reply-To: <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de> <20020130190905.A820@namesys.com> <20020130174011.L24012@suse.de> <20020130201054.6e150f78.sebastian.droege@gmx.de> <20020130201757.Q24012@suse.de> <20020131122424.A874@namesys.com> <20020131134931.A5948@suse.de> <20020131155325.A3629@namesys.com> <20020131141101.B5948@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20020131141101.B5948@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Thu, Jan 31, 2002 at 02:11:01PM +0100, Dave Jones wrote:

   Ok, I think we got it. And yes it it was reiserfs fault.
   What I really cannot understand is how it was working before???

   Ok, so anybody who sees the oopses should try 2 patches attached.
   prealloc_init_list_head.diff is just forgotten initialisation
   and pick_correct_key_version.diff is the real fix.

   I wonder is anybody will be able to reproduce a bug with these 2 fixes
   (I hope not).

   Chris: Can you also take a look?

Bye,
    Oleg

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="prealloc_list_init.diff"

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

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pick_correct_key_version.diff"

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

--LZvS9be/3tNcYl/X--
