Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbTAXLku>; Fri, 24 Jan 2003 06:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbTAXLku>; Fri, 24 Jan 2003 06:40:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:27591 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267597AbTAXLkr>;
	Fri, 24 Jan 2003 06:40:47 -0500
Date: Fri, 24 Jan 2003 03:50:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@alex.org.uk, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm5
Message-Id: <20030124035017.6276002f.akpm@digeo.com>
In-Reply-To: <m3d6mmvlip.fsf@lexa.home.net>
References: <20030123195044.47c51d39.akpm@digeo.com>
	<946253340.1043406208@[192.168.100.5]>
	<20030124031632.7e28055f.akpm@digeo.com>
	<m3d6mmvlip.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 11:49:51.0858 (UTC) FILETIME=[B4654520:01C2C39E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> >>>>> Andrew Morton (AM) writes:
> 
>  AM> But writes are completely different.  There is no dependency
>  AM> between them and at any point in time we know where on-disk a lot
>  AM> of writes will be placed.  We don't know that for reads, which is
>  AM> why we need to twiddle thumbs until the application or filesystem
>  AM> makes up its mind.
> 
> 
> it's significant that application doesn't want to wait read completion
> long and doesn't wait for write completion in most cases.

That's correct.  Reads are usually synchronous and writes are rarely
synchronous.

The most common place where the kernel forces a user process to wait on
completion of a write is actually in unlink (truncate, really).  Because
truncate must wait for in-progress I/O to complete before allowing the
filesystem to free (and potentially reuse) the affected blocks.

If there's a lot of writeout happening then truncate can take _ages_.  Hence
this patch:





Truncates can take a very long time.  Especially if there is a lot of
writeout happening, because truncate must wait on in-progress I/O.

And sys_unlink() is performing that truncate while holding the parent
directory's i_sem.  This basically shuts down new accesses to the entire
directory until the synchronous I/O completes.

In the testing I've been doing, that directory is /tmp, and this hurts.

So change sys_unlink() to perform the actual truncate outside i_sem.

When there is a continuous streaming write to the same disk, this patch
reduces the time for `make -j4 bzImage' from 370 seconds to 220.



 namei.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

diff -puN fs/namei.c~unlink-latency-fix fs/namei.c
--- 25/fs/namei.c~unlink-latency-fix	2003-01-24 02:41:04.000000000 -0800
+++ 25-akpm/fs/namei.c	2003-01-24 02:47:36.000000000 -0800
@@ -1659,12 +1659,19 @@ int vfs_unlink(struct inode *dir, struct
 	return error;
 }
 
+/*
+ * Make sure that the actual truncation of the file will occur outside its
+ * diretory's i_sem.  truncate can take a long time if there is a lot of
+ * writeout happening, and we don't want to prevent access to the directory
+ * while waiting on the I/O.
+ */
 asmlinkage long sys_unlink(const char * pathname)
 {
 	int error = 0;
 	char * name;
 	struct dentry *dentry;
 	struct nameidata nd;
+	struct inode *inode = NULL;
 
 	name = getname(pathname);
 	if(IS_ERR(name))
@@ -1683,6 +1690,9 @@ asmlinkage long sys_unlink(const char * 
 		/* Why not before? Because we want correct error value */
 		if (nd.last.name[nd.last.len])
 			goto slashes;
+		inode = dentry->d_inode;
+		if (inode)
+			inode = igrab(inode);
 		error = vfs_unlink(nd.dentry->d_inode, dentry);
 	exit2:
 		dput(dentry);
@@ -1693,6 +1703,8 @@ exit1:
 exit:
 	putname(name);
 
+	if (inode)
+		iput(inode);	/* truncate the inode here */
 	return error;
 
 slashes:

_

