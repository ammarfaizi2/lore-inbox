Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278818AbRKOArX>; Wed, 14 Nov 2001 19:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278810AbRKOArQ>; Wed, 14 Nov 2001 19:47:16 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:36334 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278795AbRKOAq7>;
	Wed, 14 Nov 2001 19:46:59 -0500
Date: Wed, 14 Nov 2001 17:46:13 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: generic_file_llseek() broken?
Message-ID: <20011114174613.U5739@lynx.no>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20011114165147.S5739@lynx.no> <E164A4l-0006SR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E164A4l-0006SR-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 15, 2001 at 12:08:15AM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  00:08 +0000, Alan Cox wrote:
> > I was recently testing a bit with creating very large files on ext2/ext3
> > (just to see if limits were what they should be).  Now, I know that ext2/3
> > allows files just shy of 2TB right now, because of an issue with i_blocks
> > being in units of 512-byte sectors, instead of fs blocks.
> 
> Does 2.4.13-ac7 show the same. There were some off by one fixes and its
> possible I managed to forget to feed Linus one

The test was done on 2.4.13, but I looked through 2.4.14, 2.4.15-pre4, and
2.4.13-ac8, and the code in question was not touched.  It is definitely not
just an off-by-one error, since if I try to create a 40TB file it is the same
problem (i.e. llseek returns -EINVAL, dd tries to read 40TB of file to try
and make the file offset correct).  When it would eventually get to the
correct offset (I can't see anything on the read path checking s_maxbytes,
and don't know what LFS says on this) it would just get EFBIG as soon as
it tries to write anything.

An example of what I'm thinking should be changed is (not tested, compiled,
anything yet; EFBIG might be EOVERFLOW, I don't know) just for illustration:

--- linux.orig/fs/read_write.c	Tue Aug 14 12:09:09 2001
+++ linux/fs/read_write.c	Wed Nov 14 16:11:23 2001
@@ -36,15 +36,24 @@
 		case 1:
 			offset += file->f_pos;
 	}
-	retval = -EINVAL;
-	if (offset>=0 && offset<=file->f_dentry->d_inode->i_sb->s_maxbytes) {
-		if (offset != file->f_pos) {
-			file->f_pos = offset;
-			file->f_reada = 0;
-			file->f_version = ++event;
-		}
-		retval = offset;
+
+	if (offset < 0) {
+		retval = -EINVAL;
+		goto out;
 	}
+
+	if (offset > file->f_dentry->d_inode->i_sb->s_maxbytes) {
+		retval = -EFBIG;
+		goto out;
+	}
+
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		file->f_reada = 0;
+		file->f_version = ++event;
+	}
+	retval = offset;
+out:
 	return retval;
 }


Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

