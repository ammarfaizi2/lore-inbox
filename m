Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262845AbTDBILb>; Wed, 2 Apr 2003 03:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262948AbTDBILb>; Wed, 2 Apr 2003 03:11:31 -0500
Received: from [12.47.58.55] ([12.47.58.55]:33954 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S262845AbTDBILa>;
	Wed, 2 Apr 2003 03:11:30 -0500
Date: Wed, 2 Apr 2003 00:23:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: j-nomura@ce.jp.nec.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18: lru_list_lock contention in write_unlocked_buffers()
Message-Id: <20030402002317.5bb07d11.akpm@digeo.com>
In-Reply-To: <20030402.165044.576024545.nomura@hpc.bs1.fc.nec.co.jp>
References: <20030402.165044.576024545.nomura@hpc.bs1.fc.nec.co.jp>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Apr 2003 08:22:49.0277 (UTC) FILETIME=[0C0CD6D0:01C2F8F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

j-nomura@ce.jp.nec.com wrote:
>
> Hello,
> 
> when I run mkfs while doing other large file I/O in parallel,
> the system response becomes terribly bad on 2.4.18 kernel.
> (probably on other 2.4 kernels also)
> 
> I found there are hard contention on lru_list_lock, which is mostly held
> by write_unlocked_buffers().
> It happens only on large memory machine because lru_list can grow very long
> and write_some_buffers() scans the long list from head on each call.
> 
> Lowlatency patch in aa tree did not help this situation.
> 
> The patch below is hasty workaround for it.
> Any comments, or suggestions to better fix?
> 

I don't think there's a sane fix for this in the 2.4 context.

What you can do is to convert fsync_dev() to sync _all_ devices and not just
the one which is being closed.

It will take longer, but it converts the O(n*n) search into O(n).

diff -puN fs/buffer.c~a fs/buffer.c
--- 24/fs/buffer.c~a	2003-04-02 00:21:39.000000000 -0800
+++ 24-akpm/fs/buffer.c	2003-04-02 00:21:51.000000000 -0800
@@ -343,6 +343,7 @@ int fsync_no_super(kdev_t dev)
 
 int fsync_dev(kdev_t dev)
 {
+	dev = NODEV;
 	sync_buffers(dev, 0);
 
 	lock_kernel();

_

