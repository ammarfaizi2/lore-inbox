Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284300AbSAPR4g>; Wed, 16 Jan 2002 12:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285369AbSAPR41>; Wed, 16 Jan 2002 12:56:27 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36081 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S284300AbSAPRzj>;
	Wed, 16 Jan 2002 12:55:39 -0500
Date: Wed, 16 Jan 2002 10:55:25 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Carsten Otte <COTTE@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
        torvalds@transmeta.com
Subject: Re: RFC: Bug in ext2?
Message-ID: <20020116105524.D775@lynx.adilger.int>
Mail-Followup-To: Carsten Otte <COTTE@de.ibm.com>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>, torvalds@transmeta.com
In-Reply-To: <OF8874D237.85B223A3-ONC1256B43.004BF905@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF8874D237.85B223A3-ONC1256B43.004BF905@de.ibm.com>; from COTTE@de.ibm.com on Wed, Jan 16, 2002 at 02:52:56PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 16, 2002  14:52 +0100, Carsten Otte wrote:
> I am currently reviewing the second extended fs. I found the following
> code in fs/ext2/super.c (taken from kernel 2.4.17):
> 
> static int ext2_setup_super (struct super_block * sb,
>                      struct ext2_super_block * es,
>                      int read_only)
> {
>      int res = 0;
>      if (le32_to_cpu(es->s_rev_level) > EXT2_MAX_SUPP_REV) {
>           printk ("EXT2-fs warning: revision level too high, "
>                "forcing read-only mode\n");
>           res = MS_RDONLY;
>      }
>      if (read_only)
>           return res;
> ------------------8<-------------------------------*SNIPP*
>      ext2_write_super(sb);
> ------------------8<-------------------------------*SNIPP*
>      return res;
> }

> To me, it looks like if the fs revision in the super block is higher than
> the supported one while read_only is false, the result is set to MS_RDONLY,
> but the super block will be written anyway.
> I'd expect that MS_RDONLY should be returned at the beginning of the
> funcion & the super block of a fs with an unsupported revision should _not_
> be written. Am I getting  s.th. wrong?

You are correct.  This is something that I have fixed a long time in my
tree but have not submitted a patch.  The fix is attached below, but is
extracted from among other changes so may have some offsets or other
minor context issues.  In addition to correctly handling unsupported
revisions, it also returns an error if you try to remount such a fs
as read-write so the user knows there was a problem.

If nobody sees any obvious errors, then please apply.

Cheers, Andreas
======================== ext2-2.4.17-rev.diff ================================
--- linux-2.4.17.orig/fs/ext2/super.c	Thu Dec 13 12:44:33 2001
+++ linux/fs/ext2/super.c	Thu Dec 13 12:22:21 2001
@@ -282,18 +323,17 @@
 	return 1;
 }
 
-static int ext2_setup_super (struct super_block * sb,
-			      struct ext2_super_block * es,
-			      int read_only)
+static int ext2_setup_super(struct super_block *sb, struct ext2_super_block *es,
+			    int read_only)
 {
-	int res = 0;
+	if (read_only)
+		return 0;
 	if (le32_to_cpu(es->s_rev_level) > EXT2_MAX_SUPP_REV) {
 		printk ("EXT2-fs warning: revision level too high, "
 			"forcing read-only mode\n");
-		res = MS_RDONLY;
+		sb->s_flags |= MS_RDONLY;
+		return MS_RDONLY;
 	}
-	if (read_only)
-		return res;
 	if (!(sb->u.ext2_sb.s_mount_state & EXT2_VALID_FS))
 		printk ("EXT2-fs warning: mounting unchecked fs, "
 			"running e2fsck is recommended\n");
@@ -328,7 +368,7 @@
 		ext2_check_inodes_bitmap (sb);
 	}
 #endif
-	return res;
+	return 0;
 }
 
 static int ext2_check_descriptors (struct super_block * sb)
@@ -751,8 +1023,9 @@
 		 * by e2fsck since we originally mounted the partition.)
 		 */
 		sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
-		if (!ext2_setup_super (sb, es, 0))
-			sb->s_flags &= ~MS_RDONLY;
+		if (ext2_setup_super(sb, es, 0))
+			return -EROFS;
+		sb->s_flags &= ~MS_RDONLY;
 	}
 	ext2_sync_super(sb, es);
 	return 0;
==============================================================================
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

