Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261623AbTCKVnr>; Tue, 11 Mar 2003 16:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbTCKVnr>; Tue, 11 Mar 2003 16:43:47 -0500
Received: from mons.uio.no ([129.240.130.14]:48358 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261623AbTCKVnq>;
	Tue, 11 Mar 2003 16:43:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15982.23313.285256.769067@charged.uio.no>
Date: Tue, 11 Mar 2003 22:54:25 +0100
To: joe.korty@ccur.com (Joe Korty)
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] 2.4.20-rc3 change broke NFS
In-Reply-To: <200303111926.TAA13808@rudolph.ccur.com>
References: <200303111926.TAA13808@rudolph.ccur.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Joe Korty <jak@rudolph.ccur.com> writes:

     > As the problem does not show up when Linux is also the server,
     > it is possible that the bug is in the PowerMAX OS side.
     > However, the patch made to Linux at that time simply looks
     > *wrong* .. why should errors be returned by a NFS read routine
     > just because EOF is not set?  Perhaps we are hitting a race on
     > close that Linux, when it is the server, doesn't see because it
     > responds faster?

You are actually probably hitting a hole in the file. If the client
has written beyond the eof, but not yet transmitted the data to the
server, then you would indeed probably see an EIO.

Your fix is probably correct, but could you just cross-check by seeing
if the appended patch also fixes the problem?

Cheers,
  Trond

--- linux-2.4.21-up/fs/nfs/read.c.orig	2002-12-12 02:23:09.000000000 -0800
+++ linux-2.4.21-up/fs/nfs/read.c	2003-03-11 13:52:26.000000000 -0800
@@ -424,7 +424,7 @@
 				memset(p + count, 0, PAGE_CACHE_SIZE - count);
 				kunmap(page);
 				count = 0;
-				if (data->res.eof)
+				if (data->res.eof || page_index(page) <= inode->i_size >> PAGE_CACHE_SHIFT)
 					SetPageUptodate(page);
 				else
 					SetPageError(page);
