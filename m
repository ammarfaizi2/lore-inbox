Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267049AbTAZXJ3>; Sun, 26 Jan 2003 18:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTAZXJ3>; Sun, 26 Jan 2003 18:09:29 -0500
Received: from ns.xdr.com ([209.48.37.1]:62862 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S267049AbTAZXJ2>;
	Sun, 26 Jan 2003 18:09:28 -0500
Date: Sun, 26 Jan 2003 15:18:49 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200301262318.h0QNInq10032@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Serious filesystem bug in linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem has happened on 2.4.4 and 2.4.20, on an ext2 filesystem as
well as a jfs filesystem. Through normal file operations a file is
operated on and its size becomes something way too large, like this:
-rw-r--r--    1 root     root     1965107636224 Jan 26 14:59 output1.iso

The file should be 4.5 gb or so.
It is opened with this:
	fd=open(savename,O_RDWR|O_CREAT|O_TRUNC|O_LARGEFILE,0644);

Operations done on the file handle are read,write, lseek64 and close.
All reads/writes to the file are in units of 2048 bytes. First something
like 4+ gigs is written to the file. Then without closing the file it
is all read out again 2048 bytes at a time. Before every read is an lseek64,
almost always right to where the file position would have been anyway.
Finally some fraction of the sectors are rewritten, on the order of 1/150,
spread pretty much evenly thoughout the file. Before every write there is
an lseek64. Then the file is closed.

I'm not certain but it may be that if I do this operation as root then
sometimes the problem occurs. I'm not certain if the problem has ever
occured when not running as root.

The resultant file can be read out beyond the actual size of the file.
What can it be reading? I'm assuming the contents of the hard drive in
other areas not part of the original file, as in other user's files.
As such it is a very real security risk.

The hard drives are IDE in both cases. 2.4.4 was ext2, and 2.4.20 was jfs.
I figure it must relate to the O_LARGEFILE since that probably hasn't been
exercised as much.

-Dave
