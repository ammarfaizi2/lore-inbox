Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbTEQDen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 23:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbTEQDen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 23:34:43 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:38133 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261183AbTEQDem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 23:34:42 -0400
Date: Fri, 16 May 2003 20:49:20 -0700
From: Andrew Morton <akpm@digeo.com>
To: Kevin Brosius <cobra@compuserve.com>
Cc: dmo@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: DAC960 breakage, 2.5 bk current
Message-Id: <20030516204920.25b8e951.akpm@digeo.com>
In-Reply-To: <3EC5AD4A.B6C18A1C@compuserve.com>
References: <3EC5AD4A.B6C18A1C@compuserve.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 May 2003 03:47:30.0772 (UTC) FILETIME=[0AD7C140:01C31C27]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Brosius <cobra@compuserve.com> wrote:
>
> kernel NULL pointer deref - virt 00000019
>  Oops: 0000 [#1]
>  CPU: 0
>  EIP: 0060:[<c02774d3>]  Not tainted
>  EFLAGS: 00010286
>  EIP is at DAC960_ioctl+0x33/0x190
> 
>  Process swapper (pid: 1, ...)
> 
>  Call Trace:
>  ] blkdev_ioctl+0xa5/0x466
>  ] ioctl_by_dev+0x41/0x50

You tricking me.  That's "ioctl_by_bdev".  It passes in a null file*, and
we have to handle it.

Does this fix?

diff -puN drivers/block/DAC960.c~DAC960-oops-fix drivers/block/DAC960.c
--- 25/drivers/block/DAC960.c~DAC960-oops-fix	2003-05-16 20:44:52.000000000 -0700
+++ 25-akpm/drivers/block/DAC960.c	2003-05-16 20:45:16.000000000 -0700
@@ -102,7 +102,7 @@ static int DAC960_ioctl(struct inode *in
 	int drive_nr = (int)disk->private_data;
 	struct hd_geometry g, *loc = (struct hd_geometry *)arg;
 
-	if (file->f_flags & O_NONBLOCK)
+	if (file && file->f_flags & O_NONBLOCK)
 		return DAC960_UserIOCTL(inode, file, cmd, arg);
 
 	if (cmd != HDIO_GETGEO || !loc)

_

