Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315235AbSEaMpk>; Fri, 31 May 2002 08:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSEaMpj>; Fri, 31 May 2002 08:45:39 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:21255 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S315235AbSEaMph>;
	Fri, 31 May 2002 08:45:37 -0400
Date: Fri, 31 May 2002 16:50:45 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT fs printk() cleanup
Message-ID: <20020531125045.GA310@pazke.ipt>
Mail-Followup-To: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.19 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XOIedfhf+7KOe/yw
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Patch (against 2.5.19) adds proper printk level into fat fs driver.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-printk-fat-2.5.19"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/fs/fat/cache.c linux/fs/fat/=
cache.c
--- linux.vanilla/fs/fat/cache.c	Fri May 31 16:34:46 2002
+++ linux/fs/fat/cache.c	Fri May 31 16:45:48 2002
@@ -52,7 +52,7 @@
 	}
 	b =3D sbi->fat_start + (first >> sb->s_blocksize_bits);
 	if (!(bh =3D fat_bread(sb, b))) {
-		printk("FAT: bread(block %d) in fat_access failed\n", b);
+		printk(KERN_ERR "FAT: bread(block %d) in fat_access failed\n", b);
 		return -EIO;
 	}
 	if ((first >> sb->s_blocksize_bits) =3D=3D (last >> sb->s_blocksize_bits)=
) {
@@ -60,7 +60,7 @@
 	} else {
 		if (!(bh2 =3D fat_bread(sb, b+1))) {
 			fat_brelse(sb, bh);
-			printk("FAT: bread(block %d) in fat_access failed\n",
+			printk(KERN_ERR "FAT: bread(block %d) in fat_access failed\n",
 			       b + 1);
 			return -EIO;
 		}
@@ -227,7 +227,7 @@
 		    && walk->start_cluster =3D=3D first
 		    && walk->file_cluster =3D=3D f_clu) {
 			if (walk->disk_cluster !=3D d_clu) {
-				printk("FAT: cache corruption inode=3D%lu\n",
+				printk(KERN_ERR "FAT: cache corruption inode=3D%lu\n",
 					inode->i_ino);
 				spin_unlock(&fat_cache_lock);
 				fat_cache_inval_inode(inode);
diff -urN -X /usr/share/dontdiff linux.vanilla/fs/fat/inode.c linux/fs/fat/=
inode.c
--- linux.vanilla/fs/fat/inode.c	Fri May 31 16:34:46 2002
+++ linux/fs/fat/inode.c	Fri May 31 16:46:39 2002
@@ -300,7 +300,7 @@
 			else *debug =3D 1;
 		}
 		else if (!strcmp(this_char,"fat")) {
-			printk("FAT: fat option is obsolete, "
+			printk(KERN_WARNING "FAT: fat option is obsolete, "
 			       "not supported now\n");
 		}
 		else if (!strcmp(this_char,"quiet")) {
@@ -308,7 +308,7 @@
 			else opts->quiet =3D 1;
 		}
 		else if (!strcmp(this_char,"blocksize")) {
-			printk("FAT: blocksize option is obsolete, "
+			printk(KERN_WARNING "FAT: blocksize option is obsolete, "
 			       "not supported now\n");
 		}
 		else if (!strcmp(this_char,"sys_immutable")) {
@@ -675,39 +675,39 @@
 	sb_min_blocksize(sb, 512);
 	bh =3D sb_bread(sb, 0);
 	if (bh =3D=3D NULL) {
-		printk("FAT: unable to read boot sector\n");
+		printk(KERN_ERR "FAT: unable to read boot sector\n");
 		goto out_fail;
 	}
=20
 	b =3D (struct fat_boot_sector *) bh->b_data;
 	if (!b->reserved) {
 		if (!silent)
-			printk("FAT: bogus number of reserved sectors\n");
+			printk(KERN_ERR "FAT: bogus number of reserved sectors\n");
 		brelse(bh);
 		goto out_invalid;
 	}
 	if (!b->fats) {
 		if (!silent)
-			printk("FAT: bogus number of FAT structure\n");
+			printk(KERN_ERR "FAT: bogus number of FAT structure\n");
 		brelse(bh);
 		goto out_invalid;
 	}
 	if (!b->secs_track) {
 		if (!silent)
-			printk("FAT: bogus sectors-per-track value\n");
+			printk(KERN_ERR "FAT: bogus sectors-per-track value\n");
 		brelse(bh);
 		goto out_invalid;
 	}
 	if (!b->heads) {
 		if (!silent)
-			printk("FAT: bogus number-of-heads value\n");
+			printk(KERN_ERR "FAT: bogus number-of-heads value\n");
 		brelse(bh);
 		goto out_invalid;
 	}
 	media =3D b->media;
 	if (!FAT_VALID_MEDIA(media)) {
 		if (!silent)
-			printk("FAT: invalid media value (0x%02x)\n", media);
+			printk(KERN_ERR "FAT: invalid media value (0x%02x)\n", media);
 		brelse(bh);
 		goto out_invalid;
 	}
@@ -718,7 +718,7 @@
 	    || (logical_sector_size < 512)
 	    || (PAGE_CACHE_SIZE < logical_sector_size)) {
 		if (!silent)
-			printk("FAT: bogus logical sector size %d\n",
+			printk(KERN_ERR "FAT: bogus logical sector size %d\n",
 			       logical_sector_size);
 		brelse(bh);
 		goto out_invalid;
@@ -727,14 +727,14 @@
 	if (!sbi->cluster_size
 	    || (sbi->cluster_size & (sbi->cluster_size - 1))) {
 		if (!silent)
-			printk("FAT: bogus cluster size %d\n",
+			printk(KERN_ERR "FAT: bogus cluster size %d\n",
 			       sbi->cluster_size);
 		brelse(bh);
 		goto out_invalid;
 	}
=20
 	if (logical_sector_size < sb->s_blocksize) {
-		printk("FAT: logical sector size too small for device"
+		printk(KERN_ERR "FAT: logical sector size too small for device"
 		       " (logical sector size =3D %d)\n", logical_sector_size);
 		brelse(bh);
 		goto out_fail;
@@ -743,13 +743,13 @@
 		brelse(bh);
=20
 		if (!sb_set_blocksize(sb, logical_sector_size)) {
-			printk("FAT: unable to set blocksize %d\n",
+			printk(KERN_ERR "FAT: unable to set blocksize %d\n",
 			       logical_sector_size);
 			goto out_fail;
 		}
 		bh =3D sb_bread(sb, 0);
 		if (bh =3D=3D NULL) {
-			printk("FAT: unable to read boot sector"
+			printk(KERN_ERR "FAT: unable to read boot sector"
 			       " (logical sector size =3D %lu)\n",
 			       sb->s_blocksize);
 			goto out_fail;
@@ -782,7 +782,7 @@
=20
 		fsinfo_bh =3D sb_bread(sb, sbi->fsinfo_sector);
 		if (fsinfo_bh =3D=3D NULL) {
-			printk("FAT: bread failed, FSINFO block"
+			printk(KERN_ERR "FAT: bread failed, FSINFO block"
 			       " (sector =3D %lu)\n", sbi->fsinfo_sector);
 			brelse(bh);
 			goto out_fail;
@@ -790,7 +790,7 @@
=20
 		fsinfo =3D (struct fat_boot_fsinfo *)fsinfo_bh->b_data;
 		if (!IS_FSINFO(fsinfo)) {
-			printk("FAT: Did not find valid FSINFO signature.\n"
+			printk(KERN_WARNING "FAT: Did not find valid FSINFO signature.\n"
 			       "     Found signature1 0x%08x signature2 0x%08x"
 			       " (sector =3D %lu)\n",
 			       CF_LE_L(fsinfo->signature1),
@@ -810,7 +810,7 @@
 	sbi->dir_entries =3D
 		CF_LE_W(get_unaligned((unsigned short *)&b->dir_entries));
 	if (sbi->dir_entries & (sbi->dir_per_block - 1)) {
-		printk("FAT: bogus directroy-entries per block\n");
+		printk(KERN_ERR "FAT: bogus directroy-entries per block\n");
 		brelse(bh);
 		goto out_invalid;
 	}
@@ -841,7 +841,7 @@
 	}
 	if (FAT_FIRST_ENT(sb, media) !=3D first) {
 		if (!silent) {
-			printk("FAT: invalid first entry of FAT "
+			printk(KERN_ERR "FAT: invalid first entry of FAT "
 			       "(0x%x !=3D 0x%x)\n",
 			       FAT_FIRST_ENT(sb, media), first);
 		}
@@ -863,28 +863,28 @@
 	if (! sbi->nls_disk) {
 		/* Fail only if explicit charset specified */
 		if (sbi->options.codepage !=3D 0) {
-			printk("FAT: codepage %s not found\n", buf);
+			printk(KERN_ERR "FAT: codepage %s not found\n", buf);
 			goto out_fail;
 		}
 		sbi->options.codepage =3D 0; /* already 0?? */
 		sbi->nls_disk =3D load_nls_default();
 	}
 	if (!silent)
-		printk("FAT: Using codepage %s\n", sbi->nls_disk->charset);
+		printk(KERN_INFO "FAT: Using codepage %s\n", sbi->nls_disk->charset);
=20
 	/* FIXME: utf8 is using iocharset for upper/lower conversion */
 	if (sbi->options.isvfat) {
 		if (sbi->options.iocharset !=3D NULL) {
 			sbi->nls_io =3D load_nls(sbi->options.iocharset);
 			if (!sbi->nls_io) {
-				printk("FAT: IO charset %s not found\n",
+				printk(KERN_ERR "FAT: IO charset %s not found\n",
 				       sbi->options.iocharset);
 				goto out_fail;
 			}
 		} else
 			sbi->nls_io =3D load_nls_default();
 		if (!silent)
-			printk("FAT: Using IO charset %s\n",
+			printk(KERN_INFO "FAT: Using IO charset %s\n",
 			       sbi->nls_io->charset);
 	}
=20
@@ -901,7 +901,7 @@
 	insert_inode_hash(root_inode);
 	sb->s_root =3D d_alloc_root(root_inode);
 	if (!sb->s_root) {
-		printk("FAT: get root inode failed\n");
+		printk(KERN_ERR "FAT: get root inode failed\n");
 		goto out_fail;
 	}
 	if(i >=3D 0) {
@@ -1089,7 +1089,7 @@
 	}
 	lock_kernel();
 	if (!(bh =3D fat_bread(sb, i_pos >> MSDOS_SB(sb)->dir_per_block_bits))) {
-		printk("dev =3D %s, ino =3D %d\n", sb->s_id, i_pos);
+		printk(KERN_ERR "dev =3D %s, ino =3D %d\n", sb->s_id, i_pos);
 		fat_fs_panic(sb, "msdos_write_inode: unable to read i-node block");
 		unlock_kernel();
 		return;
diff -urN -X /usr/share/dontdiff linux.vanilla/fs/fat/misc.c linux/fs/fat/m=
isc.c
--- linux.vanilla/fs/fat/misc.c	Fri May 31 16:34:46 2002
+++ linux/fs/fat/misc.c	Fri May 31 16:45:48 2002
@@ -49,10 +49,10 @@
 	if (not_ro)
 		s->s_flags |=3D MS_RDONLY;
=20
-	printk("FAT: Filesystem panic (dev %s)\n"
+	printk(KERN_ERR "FAT: Filesystem panic (dev %s)\n"
 	       "    %s\n", s->s_id, panic_msg);
 	if (not_ro)
-		printk("    File system has been set read-only\n");
+		printk(KERN_ERR "    File system has been set read-only\n");
 }
=20
=20
@@ -75,7 +75,7 @@
 				if (!strncmp(extension,walk,3)) return 0;
 			return 1;	/* default binary conversion */
 		default:
-			printk("Invalid conversion mode - defaulting to "
+			printk(KERN_WARNING "Invalid conversion mode - defaulting to "
 			    "binary.\n");
 			return 1;
 	}
@@ -105,14 +105,14 @@
=20
 	bh =3D fat_bread(sb, MSDOS_SB(sb)->fsinfo_sector);
 	if (bh =3D=3D NULL) {
-		printk("FAT bread failed in fat_clusters_flush\n");
+		printk(KERN_ERR "FAT bread failed in fat_clusters_flush\n");
 		return;
 	}
=20
 	fsinfo =3D (struct fat_boot_fsinfo *)bh->b_data;
 	/* Sanity check */
 	if (!IS_FSINFO(fsinfo)) {
-		printk("FAT: Did not find valid FSINFO signature.\n"
+		printk(KERN_ERR "FAT: Did not find valid FSINFO signature.\n"
 		       "     Found signature1 0x%08x signature2 0x%08x"
 		       " (sector =3D %lu)\n",
 		       CF_LE_L(fsinfo->signature1), CF_LE_L(fsinfo->signature2),
@@ -205,7 +205,7 @@
 		mark_inode_dirty(inode);
 	}
 	if (file_cluster !=3D (inode->i_blocks >> (cluster_bits - 9))) {
-		printk ("file_cluster badly computed!!! %d <> %ld\n",
+		printk (KERN_ERR "file_cluster badly computed!!! %d <> %ld\n",
 			file_cluster, inode->i_blocks >> (cluster_bits - 9));
 		fat_cache_inval_inode(inode);
 	}
@@ -240,7 +240,7 @@
 	} else {
 		for ( ; sector < last_sector; sector++) {
 			if (!(bh =3D fat_getblk(sb, sector)))
-				printk("FAT: fat_getblk() failed\n");
+				printk(KERN_ERR "FAT: fat_getblk() failed\n");
 			else {
 				memset(bh->b_data, 0, sb->s_blocksize);
 				fat_set_uptodate(sb, bh, 1);
@@ -357,7 +357,7 @@
=20
 	*bh =3D fat_bread(sb, sector);
 	if (*bh =3D=3D NULL) {
-		printk("FAT: Directory bread(block %d) failed\n", sector);
+		printk(KERN_ERR "FAT: Directory bread(block %d) failed\n", sector);
 		/* skip this block */
 		*pos =3D (iblock + 1) << sb->s_blocksize_bits;
 		goto next;

--huq684BweRXVnRxX--

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE893GlBm4rlNOo3YgRAgSxAJ9nMbx39bV1VExCvoaMcYYpgjisQQCfWak7
HKvulusgUkTGzlLonJ4mlaQ=
=5tue
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
