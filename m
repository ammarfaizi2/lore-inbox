Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262866AbTDAV7h>; Tue, 1 Apr 2003 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTDAV7h>; Tue, 1 Apr 2003 16:59:37 -0500
Received: from users.ccur.com ([208.248.32.211]:8610 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S262866AbTDAV7g>;
	Tue, 1 Apr 2003 16:59:36 -0500
Date: Tue, 1 Apr 2003 17:10:33 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Vladimir Serov <vserov@infratel.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS write got EIO on kernel starting from 2.4.19-pre4 (or -pre3 maybe)
Message-ID: <20030401221033.GA14678@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <3E899128.2050200@infratel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E899128.2050200@infratel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 05:16:24PM +0400, Vladimir Serov wrote:
> Hi Trond,
> Belive or not, I've got another NFS related problem. I'm getting EIO in 
> several programs (dd, make) writing relativly large file (several 
> megabytes) over NFS. I've tested several kernels to find out where this 
> problem was introdused. Here the list:

Hi Vladimir, Everyone,
  Try this patch.  The bug was introduced in 2.4.20-rc3.  It tends to show
up when a slow nfs server is used with a fast client.
Joe


diff -Nur prev/2.4-redhawk/fs/nfs/read.c curr/2.4-redhawk/fs/nfs/read.c
+++ curr/2.4-redhawk/fs/nfs/read.c	2003-04-01 17:04:18.000000000 -0500
+++ curr/2.4-redhawk/fs/nfs/read.c	2003-04-01 17:04:18.000000000 -0500
@@ -424,7 +424,8 @@
 				memset(p + count, 0, PAGE_CACHE_SIZE - count);
 				kunmap(page);
 				count = 0;
-				if (data->res.eof)
+				if (data->res.eof
+				|| (page_index(page) < (PAGE_CACHE_ALIGN(inode->i_size) >> PAGE_CACHE_SHIFT)))
 					SetPageUptodate(page);
 				else
 					SetPageError(page);
