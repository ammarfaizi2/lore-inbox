Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbTDGBVA (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTDGBVA (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:21:00 -0400
Received: from [12.47.58.55] ([12.47.58.55]:42452 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263180AbTDGBU6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 21:20:58 -0400
Date: Sun, 6 Apr 2003 18:32:34 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-bk12 causes "rpm" errors
Message-Id: <20030406183234.1e8abd7f.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 01:32:28.0583 (UTC) FILETIME=[8D09D370:01C2FCA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> wrote:
>
> 
>   got 2.5.66-bk12 to boot on my inspiron 8100, and ran 
> "rpm -q iptables", got the following:
> 
> rpmdb: write: 0xbfffc2d0, 8192: Invalid argument
> error: db4 error(22) from dbenv->open: Invalid argument
> error: cannot open Packages index using db3 - Invalid argument (22)
> error: cannot open Packages database in /var/lib/rpm
> package iptables is not installed
> 

Does it work OK with earlier 2.5 kernels?

The only change which comes to mind is the below one.  Could you do a
patch -R of this and retest?

Also, the log from `strace -f -o log rpm -q iptables' would be interesting.

Thanks.



 mm/filemap.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff -puN mm/filemap.c~file-limit-checking-cleanup mm/filemap.c
--- 25/mm/filemap.c~file-limit-checking-cleanup	2003-04-02 22:51:02.000000000 -0800
+++ 25-akpm/mm/filemap.c	2003-04-02 22:51:02.000000000 -0800
@@ -1509,9 +1509,8 @@ inline int generic_write_checks(struct i
 				send_sig(SIGXFSZ, current, 0);
 				return -EFBIG;
 			}
-			if (*pos > 0xFFFFFFFFULL || *count > limit-(u32)*pos) {
-				/* send_sig(SIGXFSZ, current, 0); */
-				*count = limit - (u32)*pos;
+			if (*count > limit - (typeof(limit))*pos) {
+				*count = limit - (typeof(limit))*pos;
 			}
 		}
 	}
@@ -1525,9 +1524,8 @@ inline int generic_write_checks(struct i
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
 		}
-		if (*count > MAX_NON_LFS - (u32)*pos) {
-			/* send_sig(SIGXFSZ, current, 0); */
-			*count = MAX_NON_LFS - (u32)*pos;
+		if (*count > MAX_NON_LFS - (unsigned long)*pos) {
+			*count = MAX_NON_LFS - (unsigned long)*pos;
 		}
 	}
 

_

