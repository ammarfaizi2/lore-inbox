Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266531AbRGTEJC>; Fri, 20 Jul 2001 00:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266536AbRGTEIw>; Fri, 20 Jul 2001 00:08:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60336 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266531AbRGTEIo>;
	Fri, 20 Jul 2001 00:08:44 -0400
Date: Fri, 20 Jul 2001 00:08:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsroot uses bogus mountd version for NFSv2
Message-ID: <Pine.GSO.4.21.0107192353170.10544-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

	nfsroot uses bogus protocol version when it asks portmapper on
server for mountd port. Fix is obvious:

--- linux/fs/nfs/nfsroot.c    Fri Feb 16 18:56:03 2001
+++ linux/fs/nfs/nfsroot.c.new      Thu Jul 19 23:55:09 2001
@@ -418,7 +418,7 @@
                        "as nfsd port\n", port);
        }
 
-       if ((port = root_nfs_getport(NFS_MNT_PROGRAM, nfsd_ver, proto)) < 0) {
+       if ((port = root_nfs_getport(NFS_MNT_PROGRAM, mountd_ver, proto)) < 0) {
                printk(KERN_ERR "Root-NFS: Unable to get mountd port "
                                "number from server, using default\n");
                port = mountd_port;

Notice that for NFSv3 both nfsd and mountd are using version 3, so it both
nfsd_ver == mountd_ver. However, for NFSv2 we end up asking for mountd
version 2, which doesn't exist - mountd version for NFSv2 was 1.

Looks like this typo got into the tree in 2.3.99-4-pre3 when NFSv3 had
been merged into the tree - until then we had (correctly) asked for
version 1. Corresponding code in 2.2 is using mountd_ver, so it's also
OK.

