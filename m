Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUFXPCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUFXPCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUFXPCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:02:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7602 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265399AbUFXPBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:01:30 -0400
Date: Thu, 24 Jun 2004 17:01:22 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Jason Mancini <xorbe@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/isofs/inode.c, 2-4GB files rejected on DVDs
Message-ID: <20040624150122.GB5068@apps.cwi.nl>
References: <1088073870.17691.8.camel@xorbe.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088073870.17691.8.camel@xorbe.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 03:44:30AM -0700, Jason Mancini wrote:

> DVDs with 2-4GB files get their filesizes truncated.  Are there even
> "cruft" CDs in circulation today?  Maybe it should be a config item.
> A popular competing os seems to handle 2-4GB isofs filesizes.
> -Jason Mancini
> 
> =============================================================================
> diff -Nru inode.c.orig inode.c
> --- inode.c.orig        2004-06-24 03:38:09.171898370 -0700
> +++ inode.c     2004-06-24 03:37:47.997909378 -0700
> @@ -1282,12 +1282,20 @@
>          * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully
>          *          legal. Do not prevent to use DVD's schilling@fokus.gmd.de
>          */
> +       /*
>         if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
>             sbi->s_cruft == 'n') {
>                 printk(KERN_WARNING "Warning: defective CD-ROM.  "
>                        "Enabling \"cruft\" mount option.\n");
>                 sbi->s_cruft = 'y';
>         }
> +       */
> +
> +       /*  Forget "cruft", I have DVDs to read with 2-4GB files.
> +        */
> +       if (inode->i_size < 0) {
> +         inode->i_size &= 0x0FFFFFFFF;
> +       }
> 
>         /*
>          * Some dipshit decided to store some other bit of information
> =============================================================================

Config item? No. There are far too many.

Automatically enabling? No - that code must be deleted, like you did.
Anyone with such a CDROM can give the "cruft" mount option herself.

Testing for negative i_size? But it only becomes negative when
some earlier code is broken, so probably we should fix that
earlier code instead.

More in particular, I read ISO 9660 section 7.3.3 as talking about
unsigned integers. Only in 7.1.2 do signed integers occur.
So, I suppose changing isonum_733 to return unsigned should suffice.

Could you test the below?

Andries

---
diff -uprN -X /linux/dontdiff a/fs/isofs/inode.c b/fs/isofs/inode.c
--- a/fs/isofs/inode.c	2004-05-28 20:53:22
+++ b/fs/isofs/inode.c	2004-06-24 16:20:41
@@ -1276,30 +1276,13 @@ static void isofs_read_inode(struct inod
 	}
 
 	/*
-	 * The ISO-9660 filesystem only stores 32 bits for file size.
-	 * mkisofs handles files up to 2GB-2 = 2147483646 = 0x7FFFFFFE bytes
-	 * in size. This is according to the large file summit paper from 1996.
-	 * WARNING: ISO-9660 filesystems > 1 GB and even > 2 GB are fully
-	 *	    legal. Do not prevent to use DVD's schilling@fokus.gmd.de
-	 */
-	if ((inode->i_size < 0 || inode->i_size > 0x7FFFFFFE) &&
-	    sbi->s_cruft == 'n') {
-		printk(KERN_WARNING "Warning: defective CD-ROM.  "
-		       "Enabling \"cruft\" mount option.\n");
-		sbi->s_cruft = 'y';
-	}
-
-	/*
 	 * Some dipshit decided to store some other bit of information
-	 * in the high byte of the file length.  Catch this and holler.
-	 * WARNING: this will make it impossible for a file to be > 16MB
-	 * on the CDROM.
+	 * in the high byte of the file length.  Truncate size in case
+	 * this CDROM was mounted with the cruft option.
 	 */
 
-	if (sbi->s_cruft == 'y' &&
-	    inode->i_size & 0xff000000) {
+	if (sbi->s_cruft == 'y')
 		inode->i_size &= 0x00ffffff;
-	}
 
 	if (de->interleave[0]) {
 		printk("Interleaved files not (yet) supported.\n");
diff -uprN -X /linux/dontdiff a/include/linux/iso_fs.h b/include/linux/iso_fs.h
--- a/include/linux/iso_fs.h	2003-12-18 03:58:58
+++ b/include/linux/iso_fs.h	2004-06-24 16:13:00
@@ -190,28 +190,28 @@ static inline int isonum_712(char *p)
 {
 	return *(s8 *)p;
 }
-static inline int isonum_721(char *p)
+static inline unsigned int isonum_721(char *p)
 {
 	return le16_to_cpu(get_unaligned((u16 *)p));
 }
-static inline int isonum_722(char *p)
+static inline unsigned int isonum_722(char *p)
 {
 	return be16_to_cpu(get_unaligned((u16 *)p));
 }
-static inline int isonum_723(char *p)
+static inline unsigned int isonum_723(char *p)
 {
 	/* Ignore bigendian datum due to broken mastering programs */
 	return le16_to_cpu(get_unaligned((u16 *)p));
 }
-static inline int isonum_731(char *p)
+static inline unsigned int isonum_731(char *p)
 {
 	return le32_to_cpu(get_unaligned((u32 *)p));
 }
-static inline int isonum_732(char *p)
+static inline unsigned int isonum_732(char *p)
 {
 	return be32_to_cpu(get_unaligned((u32 *)p));
 }
-static inline int isonum_733(char *p)
+static inline unsigned int isonum_733(char *p)
 {
 	/* Ignore bigendian datum due to broken mastering programs */
 	return le32_to_cpu(get_unaligned((u32 *)p));
