Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312277AbSCTKgZ>; Wed, 20 Mar 2002 05:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312274AbSCTKgG>; Wed, 20 Mar 2002 05:36:06 -0500
Received: from morrison.empeg.co.uk ([193.119.19.130]:44284 "EHLO
	fatboy.internal.empeg.com") by vger.kernel.org with ESMTP
	id <S312277AbSCTKfz>; Wed, 20 Mar 2002 05:35:55 -0500
Message-ID: <004a01c1cffa$807528e0$2701230a@electronic>
From: "Peter Hartley" <pdh@utter.chaos.org.uk>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Andreas Dilger" <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <E16nOb2-0008Pk-00@the-village.bc.nu>
Subject: [PATCH] Re: setrlimit and RLIM_INFINITY causing fsck failure, 2.4.18
Date: Wed, 20 Mar 2002 10:12:16 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0042_01C1CFF7.B67E5950"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0042_01C1CFF7.B67E5950
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

AC wrote:
> Test it and see 8)

OK, did do. Patch attached. The occurrence in filemap.c was the one killing
fsck, but I went looking for other occurrences of SIGXFS and made sure they
did the right thing too.

This doesn't address any other wonkiness of rlimit, it just stops it
applying to block devices.

        Peter


------=_NextPart_000_0042_01C1CFF7.B67E5950
Content-Type: application/octet-stream;
	name="sigxfs-vs-blkdev.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sigxfs-vs-blkdev.patch"

diff -u3 -r linux/fs/buffer.c linux.pdh/fs/buffer.c=0A=
--- linux/fs/buffer.c	Mon Feb 25 19:38:08 2002=0A=
+++ linux.pdh/fs/buffer.c	Tue Mar 19 19:23:43 2002=0A=
@@ -1834,7 +1834,7 @@=0A=
 =0A=
 	err =3D -EFBIG;=0A=
         limit =3D current->rlim[RLIMIT_FSIZE].rlim_cur;=0A=
-	if (limit !=3D RLIM_INFINITY && size > (loff_t)limit) {=0A=
+	if (limit !=3D RLIM_INFINITY && size > (loff_t)limit && =
!S_ISBLK(inode->i_mode)) {=0A=
 		send_sig(SIGXFSZ, current, 0);=0A=
 		goto out;=0A=
 	}=0A=
diff -u3 -r linux/mm/filemap.c linux.pdh/mm/filemap.c=0A=
--- linux/mm/filemap.c	Mon Feb 25 19:38:13 2002=0A=
+++ linux.pdh/mm/filemap.c	Tue Mar 19 19:21:17 2002=0A=
@@ -2885,8 +2885,8 @@=0A=
 	 * Check whether we've reached the file size limit.=0A=
 	 */=0A=
 	err =3D -EFBIG;=0A=
-	=0A=
-	if (limit !=3D RLIM_INFINITY) {=0A=
+=0A=
+	if (limit !=3D RLIM_INFINITY && !S_ISBLK(inode->i_mode)) {=0A=
 		if (pos >=3D limit) {=0A=
 			send_sig(SIGXFSZ, current, 0);=0A=
 			goto out;=0A=
diff -u3 -r linux/mm/memory.c linux.pdh/mm/memory.c=0A=
--- linux/mm/memory.c	Mon Feb 25 19:38:13 2002=0A=
+++ linux.pdh/mm/memory.c	Tue Mar 19 19:22:45 2002=0A=
@@ -1059,7 +1059,7 @@=0A=
 =0A=
 do_expand:=0A=
 	limit =3D current->rlim[RLIMIT_FSIZE].rlim_cur;=0A=
-	if (limit !=3D RLIM_INFINITY && offset > limit)=0A=
+	if (limit !=3D RLIM_INFINITY && offset > limit && =
!S_ISBLK(inode->i_mode))=0A=
 		goto out_sig;=0A=
 	if (offset > inode->i_sb->s_maxbytes)=0A=
 		goto out;=0A=
diff -u3 -r linux/mm/shmem.c linux.pdh/mm/shmem.c=0A=
--- linux/mm/shmem.c	Mon Feb 25 19:38:14 2002=0A=
+++ linux.pdh/mm/shmem.c	Tue Mar 19 19:23:17 2002=0A=
@@ -780,7 +780,7 @@=0A=
 	 * Check whether we've reached the file size limit.=0A=
 	 */=0A=
 	err =3D -EFBIG;=0A=
-	if (limit !=3D RLIM_INFINITY) {=0A=
+	if (limit !=3D RLIM_INFINITY && !S_ISBLK(inode->i_mode)) {=0A=
 		if (pos >=3D limit) {=0A=
 			send_sig(SIGXFSZ, current, 0);=0A=
 			goto out;=0A=

------=_NextPart_000_0042_01C1CFF7.B67E5950--

