Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317110AbSFBBxr>; Sat, 1 Jun 2002 21:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317111AbSFBBxq>; Sat, 1 Jun 2002 21:53:46 -0400
Received: from andiamo.com ([161.58.172.50]:30850 "EHLO andiamo.com")
	by vger.kernel.org with ESMTP id <S317110AbSFBBxp>;
	Sat, 1 Jun 2002 21:53:45 -0400
From: "Hua Zhong" <hzhong@andiamo.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <viro@math.psu.edu>
Subject: look for a patch: bad inode handling
Date: Sat, 1 Jun 2002 18:53:46 -0700
Message-ID: <FEEFKBEFIEBONNKJABKDCEOPDKAA.hzhong@andiamo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We encountered a kernel crash due to bad inode as shown in the following
kgdb trace:

Trying to connect to remotehost sup1
kmem_extra_free_checks (cachep=0xc200f2e0, slabp=0xe9056a64,
objp=0xe8689005)
    at slab.c:1210
1210                    BUG();
warning: shared library handler failed to enable breakpoint
Connected
(gdb) where
#0  kmem_extra_free_checks (cachep=0xc200f2e0, slabp=0xe9056a64,
    objp=0xe8689005) at slab.c:1210
#1  0xc01288a9 in kmem_cache_free (cachep=0xc200f2e0, objp=0xe8689005)
    at slab.c:1437
#2  0xc013855c in open_namei (
    pathname=0xe8689000 "/etc/", 'Z' <repeats 195 times>..., flag=66,
    mode=1929, nd=0xe9cf7f84) at namei.c:1184
#3  0xc012e752 in filp_open (
    filename=0xe8689000 "/etc/", 'Z' <repeats 195 times>..., flags=65,
    mode=1929) at open.c:646
#4  0xc012ea8e in sys_open (filename=0xbfffff27 "/etc/sprom.1", flags=65,
    mode=1929) at open.c:790
#5  0xc0106da4 in system_call () at af_packet.c:1889
#6  0x08049062 in ?? () at af_packet.c:1889
#7  0x40074177 in ?? () at af_packet.c:1889
(gdb) lsmod
(gdb)

The kernel version is Monta Vista's 2.4.17. We searched online and found a
patch
as following: http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.1/1769.html

I also searched whether the recent kernels have already had this fix, and I
found
(according to the changelogs), the "bad inode handling" is in 2.5.6 pre1 and
2.4.19 pre3
already submitted by Al Viro, but the fix seems to be different:

diff -Nru a/fs/bad_inode.c b/fs/bad_inode.c
--- a/fs/bad_inode.c    Tue Feb 26 11:57:57 2002
+++ b/fs/bad_inode.c    Tue Feb 26 11:57:57 2002
@@ -17,9 +17,7 @@
  */
 static int bad_follow_link(struct dentry *dent, struct nameidata *nd)
 {
-       dput(nd->dentry);
-       nd->dentry = dget(dent);
-       return 0;
+       return vfs_follow_link(nd, ERR_PTR(-EIO));
 }


I assume they solve the same problem (because from the 2.5.6 changelog Al
seemed to be
inspired by the original patch), and I prefer a patch that is accepted by
official kernels. However since the above patch is retrieved from a large
set of pre-patchs, I may have missed some parts.

I want to know which patch I should use to solve this problem? Thanks a lot.

Hua


