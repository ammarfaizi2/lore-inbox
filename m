Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTK1PDO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 10:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTK1PDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 10:03:13 -0500
Received: from mail-red.bigfish.com ([216.148.222.61]:7567 "EHLO
	mail16-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S262328AbTK1PDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 10:03:09 -0500
Message-ID: <3FC763A5.6030404@lehman.com>
Date: Fri, 28 Nov 2003 10:03:01 -0500
From: "Shantanu Goel" <Shantanu.Goel@lehman.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1)
 Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: [NFS PATCH] 2.6.0-test10 Invalidate cached inode
 attributes after rename]
X-WSS-ID: 13D9BC2F4582450-01-01
Content-Type: multipart/mixed;
 boundary=------------030709030502040307000202
X-BigFish: v
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030709030502040307000202
Content-Type: text/plain;
 charset=us-ascii;
 format=flowed
Content-Transfer-Encoding: 7bit

I initially mailed this to the NFS mailing list on sourceforge.net but 
it doesn't seem to have made it through.

------------------------------------------------------------------------------
This message is intended only for the personal and confidential use of the
designated recipient(s) named above.  If you are not the intended recipient of
this message you are hereby notified that any review, dissemination,
distribution or copying of this message is strictly prohibited.  This
communication is for information purposes only and should not be regarded as
an offer to sell or as a solicitation of an offer to buy any financial
product, an official confirmation of any transaction, or as an official
statement of Lehman Brothers.  Email transmission cannot be guaranteed to be
secure or error-free.  Therefore, we do not represent that this information is
complete or accurate and it should not be relied upon as such.  All
information is subject to change without notice.

--------------030709030502040307000202
Content-Type: message/rfc822;
 name="[NFS PATCH] 2.6.0-test10 Invalidate cached inode attributes after rename"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[NFS PATCH] 2.6.0-test10 Invalidate cached inode attributes after rename"

Message-ID: <3FC501F9.1050306@lehman.com>
Date: Wed, 26 Nov 2003 14:41:45 -0500
From: "Shantanu Goel" <Shantanu.Goel@lehman.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1)
 Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nfs@lists.sourceforge.net
Subject: [NFS PATCH] 2.6.0-test10 Invalidate cached inode attributes
 after rename
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Trond et al,

The following one line patch invalidates the attributes of the 
underlying inode when a file is renamed.  Some filesystems update ctime 
upon rename().  One such filesystem is ext3, and a comment in the 
relevant code there indicates this is true with other Unix filesystems 
as well.
The following problem was observed on Fedora Core 1 running a stock 
kernel.org 2.6.0-test10.
The server is running Solaris 2.8 but I have verified the same issue 
exists with a server running Linix 2.4.22.  These operations a done via 
a Perl script.

1. Check out a CVS repository into an NFS mounted directory.
2. Move files from CVS working directory into another directory in the 
same filesystem.
3. Tar up the resultant directory.
4. Tar prints lots of "file changed after we read it" messages.

Tar obtains ctime via stat() before reading the file and compares it to 
the ctime obtained via fstat() after having read the file.  The two 
differ because the intervening open() forces an attribute refresh due to 
CTO consistency at which time ctime is updated.  Forcing a cache 
invalidation during rename() eliminates this particular scenario.

Thanks,
Shantanu

--- 2.6.0-test10/fs/nfs/dir.c.~1~    2003-10-17 17:43:11.000000000 -0400
+++ 2.6.0-test10/fs/nfs/dir.c    2003-11-26 12:42:27.000000000 -0500
@@ -1257,6 +1257,7 @@
 
     nfs_zap_caches(new_dir);
     nfs_zap_caches(old_dir);
+    NFS_CACHEINV(old_inode);
     error = NFS_PROTO(old_dir)->rename(old_dir, &old_dentry->d_name,
                        new_dir, &new_dentry->d_name);
 out:


--------------030709030502040307000202--

