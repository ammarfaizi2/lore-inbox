Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbTCKTPu>; Tue, 11 Mar 2003 14:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbTCKTPu>; Tue, 11 Mar 2003 14:15:50 -0500
Received: from users.ccur.com ([208.248.32.211]:14800 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S261528AbTCKTPt>;
	Tue, 11 Mar 2003 14:15:49 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200303111926.TAA13808@rudolph.ccur.com>
Subject: [RFC] 2.4.20-rc3 change broke NFS
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Date: Tue, 11 Mar 2003 14:26:22 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond, Everyone,
 A change made to nfs_readpage_result() back in 2.4.20-rc3 broke NFS
for me.  The problem shows up as EIO errors under heavy read/write
load (kernel builds) when Linux is the client and PowerMAX OS
(Concurrent Computer Corp) is the server.  Both sides are running
NFSv3.

As the problem does not show up when Linux is also the server, it is
possible that the bug is in the PowerMAX OS side.  However, the patch
made to Linux at that time simply looks *wrong* .. why should errors
be returned by a NFS read routine just because EOF is not set?
Perhaps we are hitting a race on close that Linux, when it is the
server, doesn't see because it responds faster?

Regards,
Joe

Patch is against 2.4.21-pre5+bk and removes the offending code snippet.

--- fs/nfs/read.c.orig	2003-03-11 05:02:10.000000000 -0500
+++ fs/nfs/read.c	2003-03-11 14:18:00.000000000 -0500
@@ -424,14 +424,9 @@
 				memset(p + count, 0, PAGE_CACHE_SIZE - count);
 				kunmap(page);
 				count = 0;
-				if (data->res.eof)
-					SetPageUptodate(page);
-				else
-					SetPageError(page);
-			} else {
+			} else
 				count -= PAGE_CACHE_SIZE;
-				SetPageUptodate(page);
-			}
+			SetPageUptodate(page);
 		} else
 			SetPageError(page);
 		flush_dcache_page(page);
