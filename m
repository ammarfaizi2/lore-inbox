Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135805AbRDZRtL>; Thu, 26 Apr 2001 13:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135799AbRDZRtA>; Thu, 26 Apr 2001 13:49:00 -0400
Received: from mons.uio.no ([129.240.130.14]:14504 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S133004AbRDZRsa>;
	Thu, 26 Apr 2001 13:48:30 -0400
MIME-Version: 1.0
Message-ID: <15080.24119.524229.296133@charged.uio.no>
Date: Thu, 26 Apr 2001 19:43:19 +0200
To: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.2.19 NFSv3 client breaks fdopen(3)
In-Reply-To: <20010426192632.A18492@maggie.dt.e-technik.uni-dortmund.de>
In-Reply-To: <20010426192632.A18492@maggie.dt.e-technik.uni-dortmund.de>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Matthias Andree <ma@dt.e-technik.uni-dortmund.de> writes:

     > Hi, SHORT:

     > the current 2.2.19 fs/nfs/dir.c ll. 455ff. nfs_dir_lseek breaks
     > fdopen(3) which (at least with glibc 2.1.3) cals __llseek with
     > offset==0 and whence==1 (SEEK_CUR), probably to poll the
     > current file position.  Application software affected comprises
     > cvs (tried 1.10.7) and Perl5 (sysopen, see below).

     > I suggest that SEEK_CUR be allowed for offset == 0 in
     > nfs_dir_llseek, but I'm asking for help since I'm not into this
     > and cannot do this on my own. Thanks in advance.

Ion has already sent in a patch to Alan for this. Here it is...

Please note that if glibc is checking this return value, it will still
screw up if file->f_pos > 0x7fffffff, which can and does happen
against certain servers (particularly IRIX).

As I've said before: it is a bug for glibc to be relying on seekdir if
we want to support non-POSIX compliant filesystems under Linux.

Cheers,
   Trond

--- /mnt/3/linux-2.2.19/fs/nfs/dir.c	Sun Mar 25 08:37:38 2001
+++ linux-2.2.19/fs/nfs/dir.c	Thu Apr  5 14:37:59 2001
@@ -454,6 +454,9 @@
  */
 static loff_t nfs_dir_llseek(struct file *file, loff_t offset, int origin)
 {
+	/* Glibc 2.0 backwards compatibility crap... */
+	if (origin == 1 && offset == 0)
+		return file->f_pos;
 	/* We disallow SEEK_CUR and SEEK_END */
 	if (origin != 0)
 		return -EINVAL;

