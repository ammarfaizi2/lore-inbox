Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbVBKUwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbVBKUwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 15:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVBKUwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 15:52:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262337AbVBKUwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 15:52:45 -0500
Subject: Ext2/3 32-bit stat() wrap for ~2TB files
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       "Theodore Ts'o" <tytso@mit.edu>, Alex Tomas <alex@clusterfs.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108155135.1944.196.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 11 Feb 2005 20:52:16 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In testing large (>4TB) device support on 2.6, I've been using a simple
write/verify test to check both block device and regular file
correctness. 

Set to write 1MB poison patterns for the whole of a file until EOF is
encountered, it worked just fine on ext3: the file got a short write on
the last write, leaving the file at its largest permitted size of
0x1fffffff000 (2^32 sectors minus a page.)  Verify works fine.

This 2^32 sector limit is set in ext3_max_size(), which has the comment

/*
 * Maximal file size.  There is a direct, and {,double-,triple-}indirect
 * block limit, and also a limit of (2^32 - 1) 512-byte sectors in i_blocks.
 * We need to be 1 filesystem block less than the 2^32 sector limit.
 */

Trouble is, that limit *should* be an i_blocks limit, because i_blocks
is still 32-bits, and (more importantly) is multiplied by the fs
blocksize / 512 in stat(2) to return st_blocks in 512-byte chunks. 
Overflow 2^32 sectors in i_blocks and stat(2) wraps.

But i_blocks includes indirect blocks as well as data, so for a
non-sparse file we wrap stat(2) st_blocks well before the file is
2^32*512 bytes long.  Yet ext3_max_size() doesn't understand this:
it simply caps the size with

	if (res > (512LL << 32) - (1 << bits))
		res = (512LL << 32) - (1 << bits);

so write() keeps writing past the wrap, resulting in a file which looks
like:

        [root@host scratch]# ls -lh verif-file9.tmp
        -rw-r--r--  1 root root 2.0T Feb 10 05:49 verif-file9.tmp
        [root@host scratch]# du -h verif-file9.tmp
        2.1G    verif-file9.tmp

Worse comes at e2fsck time: near the end of walking the indirect tree,
e2fsck decides that the file has grown too large, as in this fsck -n
output:

        Pass 1: Checking inodes, blocks, and sizes
        Inode 20 is too big.  Truncate? no
        
        Block #536346622 (980630816) causes file to be too big.  IGNORED.
        Block #536346623 (980630817) causes file to be too big.  IGNORED.
        Block #536346624 (980630818) causes file to be too big.  IGNORED.
        ...

Whoops.  e2fsck sees that st_blocks is too large at this point, and
decides that it wants to truncate the file to make it fit.  So if a user
has legitimately created such a file, fsck will effectively attempt to
corrupt it at the next fsck.

So who is right?  Should ext3 let the file grow that large? 

For now, I think we need to constrain ext2/3 files so that i_blocks does
not exceed 2^32*512/blocksize.  Even if we fix up all the stat() stuff
to pass back 64-bit st_blocks, we still have every e2fsck in existence
which will not be able to deal with those files.  Eventually 64-bit
st_blocks would be good to have, but it needs to have a fs feature flag
to let e2fsck know about it.

--Stephen

