Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278665AbRKOJDg>; Thu, 15 Nov 2001 04:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280786AbRKOJDa>; Thu, 15 Nov 2001 04:03:30 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:31215 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278665AbRKOJDU>;
	Thu, 15 Nov 2001 04:03:20 -0500
Date: Thu, 15 Nov 2001 02:02:59 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: generic_file_llseek() broken?
Message-ID: <20011115020259.C5739@lynx.no>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <UTC200111150055.AAA93544.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <UTC200111150055.AAA93544.aeb@cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Nov 15, 2001 at 12:55:58AM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  00:55 +0000, Andries.Brouwer@cwi.nl wrote:
> My reading of the standards is:
> 
> [EFBIG] - File too large. You get this when trying to write. Not for a seek.
>   The size of a file would exceed the maximum file size
>   of an implementation or offset maximum established
>   in the corresponding file description.

OK.  So, for write only.

> [EOVERFLOW] - Value too large for data type. This can happen for a seek.
>   The resulting file offset would be a value which cannot be represented
>   correctly in an object of the given type.

Technically, the offset isn't too large for a 64-bit datatype, but it is
too large for an underlying filesystem datatype, so I'm OK with this.  I
will change my patch and test it a bit to make sure it actually works.

> [EINVAL] - Bad value for other reasons. This will happen for a seek to a
>   negative offset.

Agreed.

Now, there still appear to be a couple of issues related to LFS in the
kernel.  One is that there doesn't appear to be any checking of the
file offset on a read call.  Secondly, there appear to still be some
overflow or unchecked conditions on a write, namely doing this:

dd if=/dev/zero of=/mnt/tmp/tt bs=1k count=1 seek=81920M

causes the following syslog message:

EXT3-fs warning (device lvm(58,1)): ext3_block_to_path: block < 0

and   dd if=/dev/zero of=/mnt/tmp/tt bs=1k count=1 seek=4096M

EXT3-fs warning (device lvm(58,1)): ext3_block_to_path: block > big

Yet, running with a smaller seek just returns -EINVAL (presumably from
generic_file_llseek(), but now I'm not so sure) and breaks dd like
it always has.  We are seeking to 2^10 * 2^32 = 2^42 bytes (4TB),
on a 4kB = 2^12 byte ext3 filesystem, so 2^30 filesystem blocks.
We should never be getting as far as the fs.



In sys_lseek() we only set EOVERFLOW _after_ doing the llseek.  But
according to LFS 2.1.1.6 this is explicitly what should not happen.
I can see the argument for doing this (to avoid failing the seek,
not checking the return, and overwriting some other data) but what
can happen instead is the creation of a large file by a non-large-file
aware application, which will subsequently not be able to open/read it.
It also says that this violates POSIX (changing position and returning
an error also).



Also, in all cases, regardless of what works and what doesn't, the file
size is set to the "new" size by ftruncate64, which succeeds:

ftruncate64(0x1, 0, 0x4fa, 0, 0x1)      = 0

I don't know what SUS/POSIX/etc and LFS say about this.  Is it reasonable
to have a file size which is larger than can be read/written/stored on
disk?



It also appears that if a filesystem sets a very large s_maxbytes (i.e.
larger than MAX_ULONG << PAGE_CACHE_SHIFT) the page index will overflow
in several places in generic_file_read/write.  It appears that UDF and
NTFS set such an s_maxbytes (e.g. ~0ULL and ~0ULL >> 1, respectively).
It _looks_ like NTFS handles this correctly internally (it does not use
generic_file_{read,write}), but UDF does not.

Cheers, Andreas
=============== untested generic_file_{llseek,read} patch ================
--- linux.orig/mm/filemap.c	Thu Oct 25 03:05:19 2001
+++ linux/mm/filemap.c	Thu Nov 15 01:55:49 2001
@@ -1384,10 +1392,34 @@
  */
 ssize_t generic_file_read(struct file * filp, char * buf, size_t count, loff_t *ppos)
 {
-	ssize_t retval;
+	ssize_t retval = -EINVAL;
 
 	if ((ssize_t) count < 0)
-		return -EINVAL;
+		goto out;
+
+	retval = -EOVERFLOW;
+	/*
+	 * LFS rule 2.2.1.25: can't read past MAX_NON_LFS for non-LFS file
+	 *                    as that would put the file position past 2^31-1
+	 */
+	if (!(filp->f_flags & O_LARGEFILE)) {
+		if (*ppos > MAX_NON_LFS)
+			goto out;
+
+		if (*ppos + count > MAX_NON_LFS)
+			count = MAX_NON_LFS - *ppos;
+	}
+
+	/*
+	 *	Are we about to exceed the fs block limit ?
+	 *
+	 *	If are reading data it becomes a short read
+	 */
+	if (*ppos > filp->f_dentry->d_inode->i_sb->s_maxbytes)
+		goto out;
+
+	if (*ppos + count > filp->f_dentry->d_inode->i_sb->s_maxbytes)
+		count = filp->f_dentry->d_inode->i_sb->s_maxbytes - *ppos;
 
 	retval = -EFAULT;
 	if (access_ok(VERIFY_WRITE, buf, count)) {
@@ -1407,6 +1439,7 @@
 				retval = desc.error;
 		}
 	}
+out:
 	return retval;
 }
 
@@ -2680,7 +2713,7 @@
 	}
 
 	/*
-	 *	LFS rule 
+	 *	LFS rule 2.2.1.27
 	 */
 	if ( pos + count > MAX_NON_LFS && !(file->f_flags&O_LARGEFILE)) {
 		if (pos >= MAX_NON_LFS) {
@@ -2816,7 +2849,6 @@
 	
 	err = written ? written : status;
 out:
-
 	up(&inode->i_sem);
 	return err;
 fail_write:
--- linux.orig/fs/read_write.c	Tue Aug 14 12:09:09 2001
+++ linux/fs/read_write.c	Thu Nov 15 01:54:35 2001
@@ -36,15 +36,24 @@
 		case 1:
 			offset += file->f_pos;
 	}
+
+	/* LFS 2.1.1.6: can't seek to a position that doesn't fit in off_t */
+	retval = -EOVERFLOW;
+	if ((!(file->f_flags & O_LARGEFILE) && offset > MAX_NON_LFS) ||
+	    offset > file->f_dentry->d_inode->i_sb->s_maxbytes)
+		goto out;
+
 	retval = -EINVAL;
-	if (offset>=0 && offset<=file->f_dentry->d_inode->i_sb->s_maxbytes) {
-		if (offset != file->f_pos) {
-			file->f_pos = offset;
-			file->f_reada = 0;
-			file->f_version = ++event;
-		}
-		retval = offset;
+	if (offset < 0)
+		goto out;
+
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		file->f_reada = 0;
+		file->f_version = ++event;
 	}
+	retval = offset;
+out:
 	return retval;
 }
 
@@ -64,6 +73,12 @@
 		case 1:
 			offset += file->f_pos;
 	}
+
+	/* LFS 2.1.1.6: can't seek to a position that doesn't fit in off_t */
+	retval = -EOVERFLOW;
+	if (!(file->f_flags & O_LARGEFILE) && offset > MAX_NON_LFS)
+		goto out;
+
 	retval = -EINVAL;
 	if (offset >= 0) {
 		if (offset != file->f_pos) {
@@ -73,6 +88,7 @@
 		}
 		retval = offset;
 	}
+out:
 	return retval;
 }
 
@@ -103,8 +119,6 @@
 	if (origin <= 2) {
 		loff_t res = llseek(file, offset, origin);
 		retval = res;
-		if (res != (loff_t)retval)
-			retval = -EOVERFLOW;	/* LFS: should only happen on 32 bit platforms */
 	}
 	fput(file);
 bad:
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

