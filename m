Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVAPVXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVAPVXU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 16:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVAPVXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 16:23:20 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:36068 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262610AbVAPVWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 16:22:33 -0500
Date: Sun, 16 Jan 2005 14:22:28 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: slab.c use of __get_user and sparse
Message-ID: <20050116212228.GJ22715@schnapps.adilger.int>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20050115213906.GA22486@mars.ravnborg.org> <20050115220151.GA16442@wotan.suse.de> <200501151022.00543.agruen@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v2Uk6McLiE8OV1El"
Content-Disposition: inline
In-Reply-To: <200501151022.00543.agruen@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--v2Uk6McLiE8OV1El
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 15, 2005  10:22 +0100, Andreas Gruenbacher wrote:
> On Saturday 15 January 2005 23:01, Andi Kleen wrote:
> Those are just bugs from the time before there was kmem_cache_destroy. I=
=20
> checked the 2.6.11-rc1-mm1 tree: every kmem_cache_create in modules seems=
 to=20
> destroyed properly except in decnet, and decnet module unloading currentl=
y is=20
> disabled. The attached patch fixes the decnet case, puts the slab name in=
 a=20
> static array, and removes the name accessibilty check.

Actually, it appears that a fix I made for 2.4 never made it into 2.5/2.6.
In 2.4 we define the maximum length and check for this in kmem_cache_create=
().
The decnet slab cleanup fix is of course valid, but we may as well make the
2.6 code match the fix in 2.4.

I've shortened the cache names in ntfs to be less than the 20-character
limit present in 2.4, there are no others that are that long.


=3D=3D=3D=3D=3D mm/slab.c 1.153 vs edited =3D=3D=3D=3D=3D
--- 1.153/mm/slab.c	2005-01-07 22:44:01 -07:00
+++ edited/mm/slab.c	2005-01-16 13:42:51 -07:00
@@ -298,7 +298,9 @@
  *
  * manages a cache.
  */
-=09
+
+#define CACHE_NAMELEN	20	/* max name length for a slab cache */
+
 struct kmem_cache_s {
 /* 1) per-cpu data, touched during every alloc/free */
 	struct array_cache	*array[NR_CPUS];
@@ -334,7 +336,7 @@ struct kmem_cache_s {
 	void (*dtor)(void *, kmem_cache_t *, unsigned long);
=20
 /* 4) cache creation/removal */
-	const char		*name;
+	char			name[CACHE_NAMELEN];
 	struct list_head	next;
=20
 /* 5) statistics */
@@ -1198,6 +1200,7 @@ kmem_cache_create (const char *name,
 	 * Sanity checks... these are all serious usage bugs.
 	 */
 	if ((!name) ||
+		(strlen(name) >=3D CACHE_NAMELEN - 1) ||
 		in_interrupt() ||
 		(size < BYTES_PER_WORD) ||
 		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
@@ -1417,7 +1420,8 @@ next:
 		cachep->slabp_cache =3D kmem_find_general_cachep(slab_size,0);
 	cachep->ctor =3D ctor;
 	cachep->dtor =3D dtor;
-	cachep->name =3D name;
+	/* Copy name over so we don't have problems with unloaded modules */
+	strcpy(cachep->name, name);
=20
 	/* Don't let CPUs to come and go */
 	lock_cpu_hotplug();
@@ -1459,21 +1463,12 @@ next:
 		set_fs(KERNEL_DS);
 		list_for_each(p, &cache_chain) {
 			kmem_cache_t *pc =3D list_entry(p, kmem_cache_t, next);
-			char tmp;
-			/* This happens when the module gets unloaded and doesn't
-			   destroy its slab cache and noone else reuses the vmalloc
-			   area of the module. Print a warning. */
-			if (__get_user(tmp,pc->name)) {=20
-				printk("SLAB: cache with size %d has lost its name\n",=20
-					pc->objsize);=20
-				continue;=20
-			} =09
-			if (!strcmp(pc->name,name)) {=20
-				printk("kmem_cache_create: duplicate cache %s\n",name);=20
-				up(&cache_chain_sem);=20
+			if (!strcmp(pc->name,name)) {
+				printk("kmem_cache_create: duplicate cache %s\n",name);
+				up(&cache_chain_sem)
 				unlock_cpu_hotplug();
-				BUG();=20
-			}=09
+				BUG();
+			}
 		}
 		set_fs(old_fs);
 	}
=3D=3D=3D=3D=3D fs/ntfs/super.c 1.184 vs edited =3D=3D=3D=3D=3D
--- 1.184/fs/ntfs/super.c	2005-01-04 19:48:14 -07:00
+++ edited/fs/ntfs/super.c	2005-01-16 14:21:03 -07:00
@@ -2621,11 +2621,11 @@
 };
=20
 /* Stable names for the slab caches. */
-static const char ntfs_index_ctx_cache_name[] =3D "ntfs_index_ctx_cache";
-static const char ntfs_attr_ctx_cache_name[] =3D "ntfs_attr_ctx_cache";
+static const char ntfs_index_ctx_cache_name[] =3D "ntfs_index_ctx";
+static const char ntfs_attr_ctx_cache_name[] =3D "ntfs_attr_ctx";
 static const char ntfs_name_cache_name[] =3D "ntfs_name_cache";
 static const char ntfs_inode_cache_name[] =3D "ntfs_inode_cache";
-static const char ntfs_big_inode_cache_name[] =3D "ntfs_big_inode_cache";
+static const char ntfs_big_inode_cache_name[] =3D "ntfs_big_inode";
=20
 static int __init init_ntfs_fs(void)
 {
@@ -2652,7 +2652,7 @@
 			sizeof(ntfs_index_context), 0 /* offset */,
 			SLAB_HWCACHE_ALIGN, NULL /* ctor */, NULL /* dtor */);
 	if (!ntfs_index_ctx_cache) {
-		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
+		printk(KERN_CRIT "NTFS: Failed to create %s cache!\n",
 				ntfs_index_ctx_cache_name);
 		goto ictx_err_out;
 	}
@@ -2660,7 +2660,7 @@
 			sizeof(ntfs_attr_search_ctx), 0 /* offset */,
 			SLAB_HWCACHE_ALIGN, NULL /* ctor */, NULL /* dtor */);
 	if (!ntfs_attr_ctx_cache) {
-		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
+		printk(KERN_CRIT "NTFS: Failed to create %s cache!\n",
 				ntfs_attr_ctx_cache_name);
 		goto actx_err_out;
 	}
@@ -2688,7 +2688,7 @@
 			SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT,
 			ntfs_big_inode_init_once, NULL);
 	if (!ntfs_big_inode_cache) {
-		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
+		printk(KERN_CRIT "NTFS: Failed to create %s cache!\n",
 				ntfs_big_inode_cache_name);
 		goto big_inode_err_out;
 	}
@@ -2735,7 +2735,7 @@
 	unregister_filesystem(&ntfs_fs_type);
=20
 	if (kmem_cache_destroy(ntfs_big_inode_cache) && (err =3D 1))
-		printk(KERN_CRIT "NTFS: Failed to destory %s.\n",
+		printk(KERN_CRIT "NTFS: Failed to destory %s cache.\n",
 				ntfs_big_inode_cache_name);
 	if (kmem_cache_destroy(ntfs_inode_cache) && (err =3D 1))
 		printk(KERN_CRIT "NTFS: Failed to destory %s.\n",
@@ -2744,10 +2744,10 @@
 		printk(KERN_CRIT "NTFS: Failed to destory %s.\n",
 				ntfs_name_cache_name);
 	if (kmem_cache_destroy(ntfs_attr_ctx_cache) && (err =3D 1))
-		printk(KERN_CRIT "NTFS: Failed to destory %s.\n",
+		printk(KERN_CRIT "NTFS: Failed to destory %s cache.\n",
 				ntfs_attr_ctx_cache_name);
 	if (kmem_cache_destroy(ntfs_index_ctx_cache) && (err =3D 1))
-		printk(KERN_CRIT "NTFS: Failed to destory %s.\n",
+		printk(KERN_CRIT "NTFS: Failed to destory %s cache.\n",
 				ntfs_index_ctx_cache_name);
 	if (err)
 		printk(KERN_CRIT "NTFS: This causes memory to leak! There is "


Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--v2Uk6McLiE8OV1El
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFB6tsUpIg59Q01vtYRArHNAJ4rmy0l8VHUmh3aNYmn2OuzbpsEmACgrUdX
S2stMOpOTZcbu4yVNcUDQlo=
=qm8i
-----END PGP SIGNATURE-----

--v2Uk6McLiE8OV1El--
