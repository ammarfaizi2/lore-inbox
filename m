Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269028AbUIQVCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269028AbUIQVCq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 17:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269018AbUIQU6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 16:58:10 -0400
Received: from mailfe02.swip.net ([212.247.154.33]:58292 "EHLO
	mailfe02.swip.net") by vger.kernel.org with ESMTP id S268982AbUIQUy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 16:54:26 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Fri, 17 Sep 2004 22:54:22 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6] smbfs & "du" illness
Message-ID: <20040917205422.GD2685@bouh.is-a-geek.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When smbmounting some samba-served share and running du on linux with
smbfs, one gets crazy results:

$ ls -l file
-rwxr-xr-x  1 samy thibault 348K 2004-05-12 18:04 file*
$ du file
512M    file
$ stat file
  File: `file'
  Size: 356352          Blocks: 1048576       IO Block: 4096   fichier régulier
Device: bh/11d  Inode: 80199       Links: 1
Access: (0755/-rwxr-xr-x)  Uid: ( 1000/sthibaul)   Gid: (  101/  vmware)
Access: 2004-09-15 23:33:53.000000000 +0200
Modify: 2004-05-12 18:04:28.000000000 +0200
Change: 2004-05-12 18:04:28.000000000 +0200

This can be reproduced with a 2.6 kernel reading at any recent samba
server (2.2 or 3.0). 2.4 works fine.

What happens is that samba & kernel's smbfs don't agree on the meaning
of the 2nd 64-bit value in unix extension: samba/smbd/trans2.c tells
(and has always told since addition, cvs rev 1.149.4.47):
SOFF_T(p,0,get_allocation_size(NULL,&sbuf)); /* Number of bytes used on disk - 64 Bit
while the kernel does (and has always been doing since addition to
2.5.40)
        fattr->f_blocks = LVAL(p, 8);
I.e. takes it as a number of sectors.

Who is wrong ? I could find some draft here:
http://uranus.it.swin.edu.au/~jn/linux/smbfs/Byron_Deadwiler_Paper.doc
which tells that:
CIFS Extensions for UNIX systems V1
LARGE_INTEGER NumOfBlocks
Number of file system block used to store file

Which is on the kernel's side...

But I discussed about it with samba people (see
http://lists.samba.org/archive/samba-technical/2004-September/thread.html
"Unix Extension & "du"" subject), and they told that they modified
it into bytes because there was no block size specified.

Some conservative way of correcting it is the following:

--- fs/smbfs/proc.c.vanilla	2004-09-17 22:18:38.000000000 +0200
+++ fs/smbfs/proc.c	2004-09-17 22:36:12.000000000 +0200
@@ -2095,6 +2095,9 @@ void smb_decode_unix_basic(struct smb_fa
 
 	fattr->f_size = LVAL(p, 0);
 	fattr->f_blocks = LVAL(p, 8);
+	if (fattr->f_blocks * 512 - fattr->f_size >= 512*512 - 512)
+		/* samba reports bytes, convert to sectors */
+		fattr->f_blocks >>= 9;
 	fattr->f_ctime = smb_ntutc2unixutc(LVAL(p, 16));
 	fattr->f_atime = smb_ntutc2unixutc(LVAL(p, 24));
 	fattr->f_mtime = smb_ntutc2unixutc(LVAL(p, 32));

Which works fine, even if samba people think back to tell a number of
sectors. Why 512*512 - 512 ? Because that's the minimum gap you'll
see between "bytes taken as sectors" size and real size: when the
file is 512 bytes and the disk uses 512b blocks.

Now another trouble is that samba people also use a minimum of 1Mo
(hence the number in the above fstat result). I'm not sure what to do
with this: should we then use file size which we divide into sectors
ourselves ? Or should we keep 1Mo, getting some strange results to some
extent ?

Regards,
Samuel Thibault
