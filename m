Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSBRVJD>; Mon, 18 Feb 2002 16:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287289AbSBRVIg>; Mon, 18 Feb 2002 16:08:36 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:40395 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S287045AbSBRVGi>; Mon, 18 Feb 2002 16:06:38 -0500
Date: Mon, 18 Feb 2002 22:06:48 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-kernel@vger.kernel.org
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Olaf Kirch <okir@caldera.de>
Subject: [patches] RFC: Export inode generations to the userland
Message-ID: <Pine.GSO.3.96.1020218204630.13485Q-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 As you may know, there are serious problems with creating unique file
handles in the userland NFS server.  They exist because the inode
generation number, which allows to determine if an inode was deleted and
recreated, is currently only available to the kernel -- it's by no means
exported to user programs[1].  I've been working to remove this limitation
recently and here I am presenting the results. 

1. Linux was modified to add another member of "struct stat" and "struct
stat64".  The member provides the value of the inode generation at the
time one of the stat syscalls is invoked.  It is named "st_gen" as it is
the name other systems give it (it seems DEC OSF/1 and IBM AIX define this
member currently).  New syscalls have been defined wherever spare space
was not available in "struct stat" or "struct stat64", otherwise only the
semantics of old ones was extended.  Due to its moderate size the patch is
not attached. It's available at:
'ftp://ftp.ds2.pg.gda.pl/pub/macro/st_gen/patches/patch-2.4.16-stat-st_gen-26.gz'. 

2. Glibc was updated to make the Linux change usable.  This is an example
implementation and may seriously differ from what might go into glibc
finally.  The patch is available at: 
'ftp://ftp.ds2.pg.gda.pl/pub/macro/st_gen/patches/glibc-2.2.5-stat-st_gen.patch.gz'. 

3. The userland NFS server was changed to embed the inode generation into
file handles.  The patch is available at: 
'ftp://ftp.ds2.pg.gda.pl/pub/macro/st_gen/patches/nfs-server-2.2beta50-stat.patch.gz'. 

 Patches were tested against versions embedded in their names.  Tests were
successful on an i386 and a mipsel system.  Additionally the Linux patch
was tested as is with Linux 2.4.17 (a 2.4.17 snapshot take on Jan 29th
from oss.sgi.com for mipsel; a slightly modified patch is available at the
site well).  Glibc and nfs-server RPM packages are available at the site
as well.

 I'm looking forward to any constructive comments, whether positive or
critical.  The destined target of the changes is obviously Linux 2.6 and
glibc 2.3; testing of such changes is better with stable versions, though. 
I believe the changes may be useful to other software dealing with
filesystems as well, not only to the NFS server. 

  Maciej

[1] There is that weird EXT2_IOC_GETVERSION ioctl, but it's neither
portable nor usable for anything but maybe debugging.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

