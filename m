Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313687AbSDZGz0>; Fri, 26 Apr 2002 02:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSDZGzZ>; Fri, 26 Apr 2002 02:55:25 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:54289 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S313687AbSDZGzW>;
	Fri, 26 Apr 2002 02:55:22 -0400
Date: Fri, 26 Apr 2002 10:59:56 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] fs/fat: printk cleanup
Message-ID: <20020426065956.GA14489@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.10 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: multipart/mixed; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Attached patch adds proper printk levels into the FAT filesystem driver.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-printk-fat-2.5.10"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/fs/fat/cache.c linux/fs/fat/=
cache.c
--- linux.vanilla/fs/fat/cache.c	Fri Apr 26 10:09:45 2002
+++ linux/fs/fat/cache.c	Fri Apr 26 10:13:42 2002
@@ -52,7 +52,7 @@
 	}
 	b =3D MSDOS_SB(sb)->fat_start + (first >> sb->s_blocksize_bits);
 	if (!(bh =3D fat_bread(sb, b))) {
-		printk("bread in fat_access failed\n");
+		printk(KERN_ERR "bread in fat_access failed\n");
 		return 0;
 	}
 	if ((first >> sb->s_blocksize_bits) =3D=3D (last >> sb->s_blocksize_bits)=
) {
@@ -60,7 +60,7 @@
 	} else {
 		if (!(bh2 =3D fat_bread(sb, b+1))) {
 			fat_brelse(sb, bh);
-			printk("2nd bread in fat_access failed\n");
+			printk(KERN_ERR "2nd bread in fat_access failed\n");
 			return 0;
 		}
 	}
@@ -208,7 +208,7 @@
 		    && walk->start_cluster =3D=3D first
 		    && walk->file_cluster =3D=3D f_clu) {
 			if (walk->disk_cluster !=3D d_clu) {
-				printk("FAT cache corruption inode=3D%ld\n",
+				printk(KERN_ERR "FAT cache corruption inode=3D%ld\n",
 					inode->i_ino);
 				spin_unlock(&fat_cache_lock);
 				fat_cache_inval_inode(inode);
@@ -327,7 +327,7 @@
 		last =3D nr;
 		if ((nr =3D fat_access(inode->i_sb,nr,-1)) =3D=3D -1) return 0;
 		if (!nr) {
-			printk("fat_free: skipped EOF\n");
+			printk(KERN_ERR "fat_free: skipped EOF\n");
 			return -EIO;
 		}
 	}
diff -urN -X /usr/share/dontdiff linux.vanilla/fs/fat/inode.c linux/fs/fat/=
inode.c
--- linux.vanilla/fs/fat/inode.c	Fri Apr 26 10:09:45 2002
+++ linux/fs/fat/inode.c	Fri Apr 26 10:13:42 2002
@@ -298,7 +298,7 @@
 			else *debug =3D 1;
 		}
 		else if (!strcmp(this_char,"fat")) {
-			printk("FAT: fat option is obsolete, "
+			printk(KERN_WARNING "FAT: fat option is obsolete, "
 			       "not supported now\n");
 		}
 		else if (!strcmp(this_char,"quiet")) {
@@ -306,7 +306,7 @@
 			else opts->quiet =3D 1;
 		}
 		else if (!strcmp(this_char,"blocksize")) {
-			printk("FAT: blocksize option is obsolete, "
+			printk(KERN_WARNING "FAT: blocksize option is obsolete, "
 			       "not supported now\n");
 		}
 		else if (!strcmp(this_char,"sys_immutable")) {
@@ -371,7 +371,7 @@
 	do {
 		inode->i_size +=3D 1 << MSDOS_SB(sb)->cluster_bits;
 		if (!(nr =3D fat_access(sb, nr, -1))) {
-			printk("FAT: Directory %ld: bad FAT\n",
+			printk(KERN_ERR "FAT: Directory %ld: bad FAT\n",
 			       inode->i_ino);
 			break;
 		}
@@ -612,32 +612,32 @@
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
@@ -648,7 +648,7 @@
 	    || (logical_sector_size < 512)
 	    || (PAGE_CACHE_SIZE < logical_sector_size)) {
 		if (!silent)
-			printk("FAT: bogus logical sector size %d\n",
+			printk(KERN_ERR "FAT: bogus logical sector size %d\n",
 			       logical_sector_size);
 		brelse(bh);
 		goto out_invalid;
@@ -657,14 +657,14 @@
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
@@ -673,13 +673,13 @@
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
@@ -712,7 +712,7 @@
=20
 		fsinfo_bh =3D sb_bread(sb, sbi->fsinfo_sector);
 		if (fsinfo_bh =3D=3D NULL) {
-			printk("FAT: bread failed, FSINFO block"
+			printk(KERN_ERR "FAT: bread failed, FSINFO block"
 			       " (sector =3D %lu)\n", sbi->fsinfo_sector);
 			brelse(bh);
 			goto out_fail;
@@ -720,7 +720,7 @@
=20
 		fsinfo =3D (struct fat_boot_fsinfo *)fsinfo_bh->b_data;
 		if (!IS_FSINFO(fsinfo)) {
-			printk("FAT: Did not find valid FSINFO signature.\n"
+			printk(KERN_WARNING "FAT: Did not find valid FSINFO signature.\n"
 			       "     Found signature1 0x%08x signature2 0x%08x"
 			       " (sector =3D %lu)\n",
 			       CF_LE_L(fsinfo->signature1),
@@ -740,7 +740,7 @@
 	sbi->dir_entries =3D
 		CF_LE_W(get_unaligned((unsigned short *)&b->dir_entries));
 	if (sbi->dir_entries & (sbi->dir_per_block - 1)) {
-		printk("FAT: bogus directroy-entries per block\n");
+		printk(KERN_ERR "FAT: bogus directroy-entries per block\n");
 		brelse(bh);
 		goto out_invalid;
 	}
@@ -778,27 +778,27 @@
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
 	if (sbi->options.isvfat && !sbi->options.utf8) {
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
@@ -812,7 +812,7 @@
 	insert_inode_hash(root_inode);
 	sb->s_root =3D d_alloc_root(root_inode);
 	if (!sb->s_root) {
-		printk("FAT: get root inode failed\n");
+		printk(KERN_ERR "FAT: get root inode failed\n");
 		iput(root_inode);
 		goto out_fail;
 	}
@@ -934,7 +934,7 @@
 		    /* includes .., compensating for "self" */
 #ifdef DEBUG
 		if (!inode->i_nlink) {
-			printk("directory %d: i_nlink =3D=3D 0\n",inode->i_ino);
+			printk(KERN_DEBUG "directory %d: i_nlink =3D=3D 0\n",inode->i_ino);
 			inode->i_nlink =3D 1;
 		}
 #endif
@@ -990,7 +990,7 @@
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
--- linux.vanilla/fs/fat/misc.c	Fri Apr 26 10:09:45 2002
+++ linux/fs/fat/misc.c	Fri Apr 26 10:13:42 2002
@@ -48,10 +48,10 @@
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
@@ -74,7 +74,7 @@
 				if (!strncmp(extension,walk,3)) return 0;
 			return 1;	/* default binary conversion */
 		default:
-			printk("Invalid conversion mode - defaulting to "
+			printk(KERN_WARNING "Invalid conversion mode - defaulting to "
 			    "binary.\n");
 			return 1;
 	}
@@ -99,14 +99,14 @@
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
@@ -194,7 +194,7 @@
 		mark_inode_dirty(inode);
 	}
 	if (file_cluster !=3D (inode->i_blocks >> (cluster_bits - 9))) {
-		printk ("file_cluster badly computed!!! %d <> %ld\n",
+		printk (KERN_ERR "file_cluster badly computed!!! %d <> %ld\n",
 			file_cluster, inode->i_blocks >> (cluster_bits - 9));
 		fat_cache_inval_inode(inode);
 	}
@@ -228,7 +228,7 @@
 	} else {
 		for ( ; sector < last_sector; sector++) {
 			if (!(bh =3D fat_getblk(sb, sector)))
-				printk("FAT: fat_getblk() failed\n");
+				printk(KERN_ERR "FAT: fat_getblk() failed\n");
 			else {
 				memset(bh->b_data, 0, sb->s_blocksize);
 				fat_set_uptodate(sb, bh, 1);
@@ -346,7 +346,7 @@
 			return -1; /* beyond EOF */
 		*pos +=3D sizeof(struct msdos_dir_entry);
 		if (!(*bh =3D fat_bread(sb, sector))) {
-			printk("Directory sread (sector 0x%x) failed\n",sector);
+			printk(KERN_ERR "Directory sread (sector 0x%x) failed\n",sector);
 			continue;
 		}
 		PRINTK (("get_entry apres sread\n"));

--CUfgB8w4ZwR/yMy5--

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8yPrsBm4rlNOo3YgRAoQ8AJ9ru91Fq/fFcgElACCKgXrMGJ11QACZAU6T
+BpTPnzpAP5Djc1xEEbCnyI=
=RfsJ
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
