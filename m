Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263354AbTDCLqz>; Thu, 3 Apr 2003 06:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263355AbTDCLqz>; Thu, 3 Apr 2003 06:46:55 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:57504 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S263354AbTDCLqx>; Thu, 3 Apr 2003 06:46:53 -0500
Date: Thu, 03 Apr 2003 20:57:53 +0900 (JST)
Message-Id: <20030403.205753.229733725.nomura@hpc.bs1.fc.nec.co.jp>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, j-nomura@ce.jp.nec.com
Subject: Re: 2.4.18: lru_list_lock contention in write_unlocked_buffers()
From: j-nomura@ce.jp.nec.com
In-Reply-To: <20030402002317.5bb07d11.akpm@digeo.com>
References: <20030402.165044.576024545.nomura@hpc.bs1.fc.nec.co.jp>
	<20030402002317.5bb07d11.akpm@digeo.com>
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > I found there are hard contention on lru_list_lock, which is mostly held
> > by write_unlocked_buffers().
> > It happens only on large memory machine because lru_list can grow very long
> > and write_some_buffers() scans the long list from head on each call.
<snip>
> I don't think there's a sane fix for this in the 2.4 context.
> 
> What you can do is to convert fsync_dev() to sync _all_ devices and not just
> the one which is being closed.
> 
> It will take longer, but it converts the O(n*n) search into O(n).

thank you.
Putting the same modification in __block_fsync reduce the contention
very much.

The other solution might be adapting nfract value to match the memory size
to avoid lru_list growing too long.

Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com, nomura@hpc.bs1.fc.nec.co.jp>
Enterprise Linux Group, 1st Computers Software Division,
Computers Software Operations Unit, NEC Solutions.


--- linux/fs/block_dev.c
+++ linux/fs/block_dev.c
@@ -174,7 +174,7 @@ static int __block_fsync(struct inode * 
 	int ret, err;
 
 	ret = filemap_fdatasync(inode->i_mapping);
-	err = sync_buffers(inode->i_rdev, 1);
+	err = sync_buffers(NODEV, 1);
 	if (err && !ret)
 		ret = err;
 	err = filemap_fdatawait(inode->i_mapping);
--- linux/fs/buffer.c
+++ linux/fs/buffer.c
@@ -384,7 +384,7 @@ int fsync_no_super(kdev_t dev)
 
 int fsync_dev(kdev_t dev)
 {
-	sync_buffers(dev, 0);
+	sync_buffers(NODEV, 0);
 
 	lock_kernel();
 	sync_inodes(dev);
