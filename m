Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbTBKVa3>; Tue, 11 Feb 2003 16:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266564AbTBKVa3>; Tue, 11 Feb 2003 16:30:29 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:24073 "EHLO
	kleikamp.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S266540AbTBKVa2>; Tue, 11 Feb 2003 16:30:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: jfs breakage in 2.5.60
Date: Tue, 11 Feb 2003 15:40:14 -0600
User-Agent: KMail/1.4.3
References: <20030211205710.GA3304@codemonkey.org.uk>
In-Reply-To: <20030211205710.GA3304@codemonkey.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302111540.14217.shaggy@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 February 2003 14:57, Dave Jones wrote:
> Running fsx & fsstress in parallel gets a load of oopsen in the
> logs, here's the first one..
>
> 		Dave

Thanks Dave,
I think I know what the problem is here.  I tried to adapt some code I 
used at unmount for the sync_fs call, but I screwed up.  The routine is 
waiting until all the journal writes have completed but it doesn't 
anticipate (or prevent) new activity.  The code times out after a while 
because a BUG at unmount time is easier to track down than a hang.

I'll work on a real patch, but this should work in the mean time.  
(Pardon the compiler warning.)

===== fs/jfs/super.c 1.33 vs edited =====
--- 1.33/fs/jfs/super.c	Fri Jan 17 14:17:14 2003
+++ edited/fs/jfs/super.c	Tue Feb 11 15:36:25 2003
@@ -396,7 +396,6 @@
 	.write_inode	= jfs_write_inode,
 	.delete_inode	= jfs_delete_inode,
 	.put_super	= jfs_put_super,
-	.sync_fs	= jfs_sync_fs,
 	.write_super_lockfs = jfs_write_super_lockfs,
 	.unlockfs       = jfs_unlockfs,
 	.statfs		= jfs_statfs,

-- 
David Kleikamp
IBM Linux Technology Center

