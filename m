Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130587AbQK2QRS>; Wed, 29 Nov 2000 11:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131115AbQK2QRI>; Wed, 29 Nov 2000 11:17:08 -0500
Received: from hera.cwi.nl ([192.16.191.1]:2556 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S130587AbQK2QRA>;
        Wed, 29 Nov 2000 11:17:00 -0500
Date: Wed, 29 Nov 2000 16:46:27 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011291546.QAA146016.aeb@aak.cwi.nl>
To: torvalds@transmeta.com
Subject: isofs and no corruption
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried the same test three times with 2.4.0test11 - three times
corruption. Tried it three times with 2.4.0test12pre3 - no corruption.
Good!

On the other hand, isofs still lacks part of the required fixes.
Made a new patch relative to test12pre3.

Andries

-----
diff -u --recursive --new-file ../linux-2.4.0test12pre3/linux/Documentation/filesystems/devfs/README ./linux/Documentation/filesystems/devfs/README
--- ../linux-2.4.0test12pre3/linux/Documentation/filesystems/devfs/README	Thu Jul  6 06:36:49 2000
+++ ./linux/Documentation/filesystems/devfs/README	Wed Nov 29 14:12:46 2000
@@ -529,7 +529,7 @@
 If you want to construct a minimal chroot() gaol, the following
 command should suffice:
 
-mount -t bind /dev/null /gaol/dev/null
+mount --bind /dev/null /gaol/dev/null
 
 
 Repeat for other device nodes you want to expose. Simple!
@@ -739,7 +739,7 @@
 add the following lines near the very beginning of your boot
 scripts:
 
-mount -t bind /dev /dev-state
+mount --bind /dev /dev-state
 mount -t devfs none /dev
 devfsd /dev
 
diff -u --recursive --new-file ../linux-2.4.0test12pre3/linux/Makefile ./linux/Makefile
--- ../linux-2.4.0test12pre3/linux/Makefile	Wed Nov 29 12:58:05 2000
+++ ./linux/Makefile	Wed Nov 29 14:13:36 2000
@@ -206,7 +206,6 @@
 	drivers/net/hamradio/soundmodem/sm_tbl_{hapn4800,psk4800}.h \
 	drivers/net/hamradio/soundmodem/sm_tbl_{afsk2400_7,afsk2400_8}.h \
 	drivers/net/hamradio/soundmodem/gentbl \
-	drivers/char/hfmodem/gentbl drivers/char/hfmodem/tables.h \
 	drivers/sound/*_boot.h drivers/sound/.*.boot \
 	drivers/sound/msndinit.c \
 	drivers/sound/msndperm.c \
diff -u --recursive --new-file ../linux-2.4.0test12pre3/linux/fs/isofs/dir.c ./linux/fs/isofs/dir.c
--- ../linux-2.4.0test12pre3/linux/fs/isofs/dir.c	Wed Nov 29 12:58:08 2000
+++ ./linux/fs/isofs/dir.c	Wed Nov 29 14:24:39 2000
@@ -163,7 +163,7 @@
 					return 0;
 				memcpy((void *) tmpde + slop, bh->b_data, offset);
 			}
-			de = tmpde;				
+			de = tmpde;
 		}
 
 		if (de->flags[-high_sierra] & 0x80) {
diff -u --recursive --new-file ../linux-2.4.0test12pre3/linux/fs/isofs/inode.c ./linux/fs/isofs/inode.c
--- ../linux-2.4.0test12pre3/linux/fs/isofs/inode.c	Wed Nov 29 12:58:08 2000
+++ ./linux/fs/isofs/inode.c	Wed Nov 29 15:07:34 2000
@@ -754,8 +754,9 @@
 	s->u.isofs_sb.s_gid = opt.gid;
 	s->u.isofs_sb.s_utf8 = opt.utf8;
 	/*
-	 * It would be incredibly stupid to allow people to mark every file on the disk
-	 * as suid, so we merely allow them to set the default permissions.
+	 * It would be incredibly stupid to allow people to mark every file
+	 * on the disk as suid, so we merely allow them to set the default
+	 * permissions.
 	 */
 	s->u.isofs_sb.s_mode = opt.mode & 0777;
 
@@ -1017,10 +1018,7 @@
 	unsigned long block, offset;
 	int i = 0;
 	int more_entries = 0;
-	struct iso_directory_record * tmpde = kmalloc(256, GFP_KERNEL);
-
-	if (!tmpde)
-		return -ENOMEM;
+	struct iso_directory_record * tmpde = NULL;
 
 	inode->i_size = 0;
 	inode->u.isofs_i.i_next_section_ino = 0;
@@ -1054,6 +1052,11 @@
 		/* Make sure we have a full directory entry */
 		if (offset >= bufsize) {
 			int slop = bufsize - offset + de_len;
+			if (!tmpde) {
+				tmpde = kmalloc(256, GFP_KERNEL);
+				if (!tmpde)
+					goto out_nomem;
+			}
 			memcpy(tmpde, de, slop);
 			offset &= bufsize - 1;
 			block++;
@@ -1080,14 +1083,23 @@
 			goto out_toomany;
 	} while(more_entries);
 out:
-	kfree(tmpde);
-	if (bh) brelse(bh);
+	if (tmpde)
+		kfree(tmpde);
+	if (bh)
+		brelse(bh);
 	return 0;
 
+out_nomem:
+	if (bh)
+		brelse(bh);
+	return -ENOMEM;
+
 out_noread:
 	printk(KERN_INFO "ISOFS: unable to read i-node block %lu\n", block);
-	kfree(tmpde);
-	return 1;
+	if (tmpde)
+		kfree(tmpde);
+	return -EIO;
+
 out_toomany:
 	printk(KERN_INFO "isofs_read_level3_size: "
 		"More than 100 file sections ?!?, aborting...\n"
@@ -1102,22 +1114,39 @@
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	int block = inode->i_ino >> ISOFS_BUFFER_BITS(inode);
 	int high_sierra = sb->u.isofs_sb.s_high_sierra;
-	struct buffer_head * bh;
-	struct iso_directory_record * raw_inode;
-	unsigned char *pnt;
+	struct buffer_head * bh = NULL;
+	struct iso_directory_record * de;
+	struct iso_directory_record * tmpde = NULL;
+	unsigned int de_len;
+	unsigned long offset;
 	int volume_seq_no, i;
 
 	bh = bread(inode->i_dev, block, bufsize);
-	if (!bh) {
-		printk(KERN_WARNING "ISOFS: unable to read i-node block\n");
-		goto fail;
-	}
+	if (!bh)
+		goto out_badread;
 
-	pnt = ((unsigned char *) bh->b_data
-	       + (inode->i_ino & (bufsize - 1)));
-	raw_inode = ((struct iso_directory_record *) pnt);
+	offset = (inode->i_ino & (bufsize - 1));
+	de = (struct iso_directory_record *) (bh->b_data + offset);
+	de_len = *(unsigned char *) de;
+
+	if (offset + de_len > bufsize) {
+		int frag1 = bufsize - offset;
+
+		tmpde = kmalloc(de_len, GFP_KERNEL);
+		if (tmpde == NULL) {
+			printk(KERN_INFO "isofs_read_inode: out of memory\n");
+			goto fail;
+		}
+		memcpy(tmpde, bh->b_data + offset, frag1);
+		brelse(bh);
+		bh = bread(inode->i_dev, ++block, bufsize);
+		if (!bh)
+			goto out_badread;
+		memcpy((char *)tmpde+frag1, bh->b_data, de_len - frag1);
+		de = tmpde;
+	}
 
-	if (raw_inode->flags[-high_sierra] & 2) {
+	if (de->flags[-high_sierra] & 2) {
 		inode->i_mode = S_IRUGO | S_IXUGO | S_IFDIR;
 		inode->i_nlink = 1; /* Set to 1.  We know there are 2, but
 				       the find utility tries to optimize
@@ -1132,10 +1161,10 @@
 		/* If there are no periods in the name,
 		 * then set the execute permission bit
 		 */
-		for(i=0; i< raw_inode->name_len[0]; i++)
-			if(raw_inode->name[i]=='.' || raw_inode->name[i]==';')
+		for(i=0; i< de->name_len[0]; i++)
+			if(de->name[i]=='.' || de->name[i]==';')
 				break;
-		if(i == raw_inode->name_len[0] || raw_inode->name[i] == ';')
+		if(i == de->name_len[0] || de->name[i] == ';')
 			inode->i_mode |= S_IXUGO; /* execute permission */
 	}
 	inode->i_uid = inode->i_sb->u.isofs_sb.s_uid;
@@ -1143,84 +1172,77 @@
 	inode->i_blocks = inode->i_blksize = 0;
 
 
-	inode->u.isofs_i.i_section_size = isonum_733 (raw_inode->size);
-	if(raw_inode->flags[-high_sierra] & 0x80) {
+	inode->u.isofs_i.i_section_size = isonum_733 (de->size);
+	if(de->flags[-high_sierra] & 0x80) {
 		if(isofs_read_level3_size(inode)) goto fail;
 	} else {
-		inode->i_size = isonum_733 (raw_inode->size);
+		inode->i_size = isonum_733 (de->size);
 	}
 
 	/* There are defective discs out there - we do this to protect
 	   ourselves.  A cdrom will never contain more than 800Mb 
 	   .. but a DVD may be up to 1Gig (Ulrich Habel) */
-	if((inode->i_size < 0 || inode->i_size > 1073741824) &&
+
+	if ((inode->i_size < 0 || inode->i_size > 1073741824) &&
 	    inode->i_sb->u.isofs_sb.s_cruft == 'n') {
-	  printk(KERN_WARNING "Warning: defective CD-ROM.  Enabling \"cruft\" mount option.\n");
-	  inode->i_sb->u.isofs_sb.s_cruft = 'y';
+		printk(KERN_WARNING "Warning: defective CD-ROM.  "
+		       "Enabling \"cruft\" mount option.\n");
+		inode->i_sb->u.isofs_sb.s_cruft = 'y';
 	}
 
-/* Some dipshit decided to store some other bit of information in the high
-   byte of the file length.  Catch this and holler.  WARNING: this will make
-   it impossible for a file to be > 16Mb on the CDROM!!!*/
+	/*
+	 * Some dipshit decided to store some other bit of information
+	 * in the high byte of the file length.  Catch this and holler.
+	 * WARNING: this will make it impossible for a file to be > 16MB
+	 * on the CDROM.
+	 */
 
-	if(inode->i_sb->u.isofs_sb.s_cruft == 'y' &&
-	   inode->i_size & 0xff000000){
-/*	  printk("Illegal format on cdrom.  Pester manufacturer.\n"); */
-	  inode->i_size &= 0x00ffffff;
+	if (inode->i_sb->u.isofs_sb.s_cruft == 'y' &&
+	    inode->i_size & 0xff000000) {
+		inode->i_size &= 0x00ffffff;
 	}
 
-	if (raw_inode->interleave[0]) {
+	if (de->interleave[0]) {
 		printk("Interleaved files not (yet) supported.\n");
 		inode->i_size = 0;
 	}
 
 	/* I have no idea what file_unit_size is used for, so
 	   we will flag it for now */
-	if(raw_inode->file_unit_size[0] != 0){
-		printk("File unit size != 0 for ISO file (%ld).\n",inode->i_ino);
+	if (de->file_unit_size[0] != 0) {
+		printk("File unit size != 0 for ISO file (%ld).\n",
+		       inode->i_ino);
 	}
 
 	/* I have no idea what other flag bits are used for, so
 	   we will flag it for now */
 #ifdef DEBUG
-	if((raw_inode->flags[-high_sierra] & ~2)!= 0){
+	if((de->flags[-high_sierra] & ~2)!= 0){
 		printk("Unusual flag settings for ISO file (%ld %x).\n",
-		       inode->i_ino, raw_inode->flags[-high_sierra]);
+		       inode->i_ino, de->flags[-high_sierra]);
 	}
 #endif
 
-#ifdef DEBUG
-	printk("Get inode %x: %d %d: %d\n",inode->i_ino, block,
-	       ((int)pnt) & 0x3ff, inode->i_size);
-#endif
-
 	inode->i_mtime = inode->i_atime = inode->i_ctime =
-	  iso_date(raw_inode->date, high_sierra);
+		iso_date(de->date, high_sierra);
 
-	inode->u.isofs_i.i_first_extent = (isonum_733 (raw_inode->extent) +
-					   isonum_711 (raw_inode->ext_attr_length));
+	inode->u.isofs_i.i_first_extent = (isonum_733 (de->extent) +
+					   isonum_711 (de->ext_attr_length));
 
-/* Now test for possible Rock Ridge extensions which will override some of
-   these numbers in the inode structure. */
+	/*
+	 * Now test for possible Rock Ridge extensions which will override
+	 * some of these numbers in the inode structure.
+	 */
 
 	if (!high_sierra) {
-	  parse_rock_ridge_inode(raw_inode, inode);
-	  /* hmm..if we want uid or gid set, override the rock ridge setting */
-	 test_and_set_uid(&inode->i_uid, inode->i_sb->u.isofs_sb.s_uid);
-         test_and_set_gid(&inode->i_gid, inode->i_sb->u.isofs_sb.s_gid);
+		parse_rock_ridge_inode(de, inode);
+		/* if we want uid/gid set, override the rock ridge setting */
+		test_and_set_uid(&inode->i_uid, inode->i_sb->u.isofs_sb.s_uid);
+		test_and_set_gid(&inode->i_gid, inode->i_sb->u.isofs_sb.s_gid);
 	}
 
-#ifdef DEBUG
-	printk("Inode: %x extent: %x\n",inode->i_ino, inode->u.isofs_i.i_first_extent);
-#endif
-
 	/* get the volume sequence number */
-	volume_seq_no = isonum_723 (raw_inode->volume_sequence_number) ;
-
-	/*
-	 * All done with buffer ... no more references to buffer memory!
-	 */
-	brelse(bh);
+	volume_seq_no = isonum_723 (de->volume_sequence_number) ;
 
 	/*
 	 * Disable checking if we see any volume number other than 0 or 1.
@@ -1230,8 +1252,10 @@
 	 */
 	if (inode->i_sb->u.isofs_sb.s_cruft == 'n' &&
 	    (volume_seq_no != 0) && (volume_seq_no != 1)) {
-	  printk(KERN_WARNING "Warning: defective CD-ROM (volume sequence number). Enabling \"cruft\" mount option.\n");
-	  inode->i_sb->u.isofs_sb.s_cruft = 'y';
+		printk(KERN_WARNING "Warning: defective CD-ROM "
+		       "(volume sequence number %d). "
+		       "Enabling \"cruft\" mount option.\n", volume_seq_no);
+		inode->i_sb->u.isofs_sb.s_cruft = 'y';
 	}
 
 	/* Install the inode operations vector */
@@ -1242,25 +1266,32 @@
 	} else
 #endif IGNORE_WRONG_MULTI_VOLUME_SPECS
 	{
-	  if (S_ISREG(inode->i_mode)) {
-	    inode->i_fop = &generic_ro_fops;
-	    inode->i_data.a_ops = &isofs_aops;
-	  } else if (S_ISDIR(inode->i_mode)) {
-	    inode->i_op = &isofs_dir_inode_operations;
-	    inode->i_fop = &isofs_dir_operations;
-	  } else if (S_ISLNK(inode->i_mode)) {
-	    inode->i_op = &page_symlink_inode_operations;
-	    inode->i_data.a_ops = &isofs_symlink_aops;
-	  } else
-	    /* XXX - parse_rock_ridge_inode() had already set i_rdev. */
-	    init_special_inode(inode, inode->i_mode, kdev_t_to_nr(inode->i_rdev));
-	}
+		if (S_ISREG(inode->i_mode)) {
+			inode->i_fop = &generic_ro_fops;
+			inode->i_data.a_ops = &isofs_aops;
+		} else if (S_ISDIR(inode->i_mode)) {
+			inode->i_op = &isofs_dir_inode_operations;
+			inode->i_fop = &isofs_dir_operations;
+		} else if (S_ISLNK(inode->i_mode)) {
+			inode->i_op = &page_symlink_inode_operations;
+			inode->i_data.a_ops = &isofs_symlink_aops;
+		} else
+			/* XXX - parse_rock_ridge_inode() had already set i_rdev. */
+			init_special_inode(inode, inode->i_mode,
+					   kdev_t_to_nr(inode->i_rdev));
+	}
+ out:
+	if (tmpde)
+		kfree(tmpde);
+	if (bh)
+		brelse(bh);
 	return;
 
-      fail:
-	/* With a data error we return this information */
+ out_badread:
+	printk(KERN_WARNING "ISOFS: unable to read i-node block\n");
+ fail:
 	make_bad_inode(inode);
-	return;
+	goto out;
 }
 
 #ifdef LEAK_CHECK
diff -u --recursive --new-file ../linux-2.4.0test12pre3/linux/fs/isofs/namei.c ./linux/fs/isofs/namei.c
--- ../linux-2.4.0test12pre3/linux/fs/isofs/namei.c	Wed Nov 29 12:58:08 2000
+++ ./linux/fs/isofs/namei.c	Wed Nov 29 15:10:52 2000
@@ -161,13 +161,14 @@
 	struct inode *inode;
 	struct page *page;
 
-#ifdef DEBUG
-	printk("lookup: %x %s\n",dir->i_ino, dentry->d_name.name);
-#endif
 	dentry->d_op = dir->i_sb->s_root->d_op;
 
 	page = alloc_page(GFP_USER);
-	ino = isofs_find_entry(dir, dentry, page_address(page), 1024 + page_address(page));
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	ino = isofs_find_entry(dir, dentry, page_address(page),
+			       1024 + page_address(page));
 	__free_page(page);
 
 	inode = NULL;
diff -u --recursive --new-file ../linux-2.4.0test12pre3/linux/fs/isofs/rock.c ./linux/fs/isofs/rock.c
--- ../linux-2.4.0test12pre3/linux/fs/isofs/rock.c	Wed Nov 29 12:58:08 2000
+++ ./linux/fs/isofs/rock.c	Wed Nov 29 15:16:34 2000
@@ -72,7 +72,7 @@
       cont_size = 0; \
       cont_offset = 0; \
       goto LABEL; \
-    };    \
+    }    \
     printk("Unable to read rock-ridge attributes\n");    \
   }}
 
@@ -120,22 +120,16 @@
 	CHECK_SP(goto out);
 	break;
       case SIG('C','L'):
-#ifdef DEBUG
-	printk("RR: CL\n");
-#endif
 	if (flag == 0) {
 	  retval = isonum_733(rr->u.CL.location);
 	  goto out;
-	};
+	}
 	break;
       case SIG('P','L'):
-#ifdef DEBUG
-	printk("RR: PL\n");
-#endif
 	if (flag != 0) {
 	  retval = isonum_733(rr->u.PL.location);
 	  goto out;
-	};
+	}
 	break;
       case SIG('C','E'):
 	CHECK_CE; /* This tells is if there is a continuation record */
@@ -143,8 +137,8 @@
       default:
 	break;
       }
-    };
-  };
+    }
+  }
   MAYBE_CONTINUE(repeat, inode);
   return retval;
  out:
@@ -203,24 +197,21 @@
 	if (rr->u.NM.flags & ~1) {
 	  printk("Unsupported NM flag settings (%d)\n",rr->u.NM.flags);
 	  break;
-	};
+	}
 	if((strlen(retname) + rr->len - 5) >= 254) {
 	  truncate = 1;
 	  break;
-	};
+	}
 	strncat(retname, rr->u.NM.name, rr->len - 5);
 	retnamlen += rr->len - 5;
 	break;
       case SIG('R','E'):
-#ifdef DEBUG
-	printk("RR: RE (%x)\n", inode->i_ino);
-#endif
 	if (buffer) kfree(buffer);
 	return -1;
       default:
 	break;
       }
-    };
+    }
   }
   MAYBE_CONTINUE(repeat,inode);
   return retnamlen; /* If 0, this file did not have a NM field */
@@ -266,10 +257,10 @@
 	break;
       case SIG('E','R'):
 	inode->i_sb->u.isofs_sb.s_rock = 1;
-	printk(KERN_DEBUG"ISO 9660 Extensions: ");
+	printk(KERN_DEBUG "ISO 9660 Extensions: ");
 	{ int p;
 	  for(p=0;p<rr->u.ER.len_id;p++) printk("%c",rr->u.ER.data[p]);
-	};
+	}
 	  printk("\n");
 	break;
       case SIG('P','X'):
@@ -294,7 +285,7 @@
 	  } else {
 	    inode->i_rdev = MKDEV(high, low);
 	  }
-	};
+	}
 	break;
       case SIG('T','F'):
 	/* Some RRIP writers incorrectly place ctime in the TF_CREATE field.
@@ -334,7 +325,7 @@
 	     break;
 	   default:
 	     printk("Symlink component flag not implemented\n");
-	   };
+	   }
 	   slen -= slp->len + 2;
 	   oldslp = slp;
 	   slp = (struct SL_component *) (((char *) slp) + slp->len + 2);
@@ -348,19 +339,16 @@
 	   /*
 	    * If this component record isn't continued, then append a '/'.
 	    */
-	   if(   (!rootflag)
-		 && ((oldslp->flags & 1) == 0) ) inode->i_size += 1;
+	   if (!rootflag && (oldslp->flags & 1) == 0)
+		   inode->i_size += 1;
 	 }
 	}
 	symlink_len = inode->i_size;
 	break;
       case SIG('R','E'):
-	printk("Attempt to read inode for relocated directory\n");
+	printk(KERN_WARNING "Attempt to read inode for relocated directory\n");
 	goto out;
       case SIG('C','L'):
-#ifdef DEBUG
-	printk("RR CL (%x)\n",inode->i_ino);
-#endif
 	inode->u.isofs_i.i_first_extent = isonum_733(rr->u.CL.location);
 	reloc = iget(inode->i_sb,
 		     (inode->u.isofs_i.i_first_extent <<
@@ -381,7 +369,7 @@
       default:
 	break;
       }
-    };
+    }
   }
   MAYBE_CONTINUE(repeat,inode);
   return 0;
diff -u --recursive --new-file ../linux-2.4.0test12pre3/linux/fs/isofs/util.c ./linux/fs/isofs/util.c
--- ../linux-2.4.0test12pre3/linux/fs/isofs/util.c	Thu Jan 27 21:51:43 2000
+++ ./linux/fs/isofs/util.c	Wed Nov 29 15:17:29 2000
@@ -98,7 +98,7 @@
 
 int iso_date(char * p, int flag)
 {
-	int year, month, day, hour ,minute, second, tz;
+	int year, month, day, hour, minute, second, tz;
 	int crtime, days, i;
 
 	year = p[0] - 70;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
