Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWCLQ2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWCLQ2u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 11:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWCLQ2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 11:28:50 -0500
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:17324 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751393AbWCLQ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 11:28:49 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Sun, 12 Mar 2006 16:28:43 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Neil Brown <neilb@suse.de>
cc: Christoph Hellwig <hch@lst.de>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Al Viro <viro@viro.linux.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 PATCH]: Incorrect lack of {m,c}time modification for ftruncate.
Message-ID: <Pine.LNX.4.64.0603121544050.14340@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently Neil Brown's patch to fix the standards compliance of setting 
{m,c}time on {f,}truncate and open(O_TRUNC) was applied to the kernel.

See 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4a30131e7dbb17e5fec6958bfac9da9aff1fa29b

>From the patch description:
<quote>
SUS requires that when truncating a file to the size that it currently
is:
  truncate and ftruncate should NOT modify ctime or mtime
  O_TRUNC SHOULD modify ctime and mtime.
[snip]
With this patch:
  ATTR_CTIME|ATTR_MTIME are sent with ATTR_SIZE precisely when
    an update of these times is required whether size changes or not
    (via a new argument to do_truncate).  This allows NFS to do
    the right thing for O_TRUNC.
  inode_setattr nolonger forces ATTR_MTIME|ATTR_CTIME when the ATTR_SIZE
    sets the size to it's current value.  This allows local filesystems
    to do the right thing for f?truncate.
</quote>

The problem with this patch is that the standard does not actually say the 
above, it in fact says that:

- both open(O_TRUNC) and ftruncate() _always_ modify {m,c}time and 

- truncate() modifies {m,c}time _only_ if the file size changes due to the 
truncate.

(This IMO is completely brain damaged... but I guess no-one claims 
standards are not braindamaged...)

Here are the relevant three pages from posix/sus3 together with the 
relevant paragraph quoted:

http://www.opengroup.org/onlinepubs/009695399/functions/open.html
<quote>
If O_TRUNC is set and the file did previously exist, upon successful 
completion, open() shall mark for update the st_ctime and st_mtime fields 
of the file.
</quote>

http://www.opengroup.org/onlinepubs/009695399/functions/ftruncate.html
<quote>
Upon successful completion, if fildes refers to a regular file, the 
ftruncate() function shall mark for update the st_ctime and st_mtime 
fields of the file and the S_ISUID and S_ISGID bits of the file mode may 
be cleared. If the ftruncate() function is unsuccessful, the file is 
unaffected.
</quote>

http://www.opengroup.org/onlinepubs/009695399/functions/truncate.html
<quote>
Upon successful completion, if the file size is changed, this function 
shall mark for update the st_ctime and st_mtime fields of the file, and 
the S_ISUID and S_ISGID bits of the file mode may be cleared.
</quote>

So at present we handle open(O_TRUNC) and truncate() correctly but we do 
the Wrong Thing (TM) for ftruncate().

This is fixed by the simple one liner patch at the bottom of this email.

Please apply or tell me that I can't read the standard and kindly point 
out to me what I have missed...  (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---

Cause the {m,c}time to always be updated when ftruncate() is called as 
required by posix/sus3.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

diff -urNp linux-2.6/fs/open.c.old linux-2.6/fs/open.c
--- linux-2.6/fs/open.c.old	2006-03-12 16:09:26.000000000 +0000
+++ linux-2.6/fs/open.c	2006-03-12 16:10:41.000000000 +0000
@@ -321,7 +321,8 @@ static long do_sys_ftruncate(unsigned in
 
 	error = locks_verify_truncate(inode, file, length);
 	if (!error)
-		error = do_truncate(dentry, length, 0, file);
+		error = do_truncate(dentry, length, ATTR_MTIME | ATTR_CTIME,
+				file);
 out_putf:
 	fput(file);
 out:
