Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUIPVrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUIPVrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 17:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUIPVrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 17:47:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:47077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267514AbUIPVr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 17:47:29 -0400
Date: Thu, 16 Sep 2004 14:50:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Seiji Kihara <kihara.seiji@lab.ntt.co.jp>
Cc: sct@redhat.com, adilger@clusterfs.com, ext3-users@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       ospfs@lab.ntt.co.jp
Subject: Re: [PATCH] BUG on fsync/fdatasync with Ext3 data=journal
Message-Id: <20040916145059.44a7e800.akpm@osdl.org>
In-Reply-To: <ufz5i5q4r.wl%kihara.seiji@lab.ntt.co.jp>
References: <ufz5i5q4r.wl%kihara.seiji@lab.ntt.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seiji Kihara <kihara.seiji@lab.ntt.co.jp> wrote:
>
> We found that fsync and fdatasync syscalls sometimes don't sync
> data in an ext3 file system under the following conditions.
> 
> 1. Kernel version is 2.6.6 or later (including 2.6.8.1 and 2.6.9-rc2).
> 2. Ext3's journalling mode is "data=journal".
> 3. Create a file (whose size is 1Mbytes) and execute umount/mount.
> 4. lseek to a random position within the file, write 8192 bytes
>    data, and fsync or fdatasync.
> 
> We presume the data was not written to the corresponding disk
> before returning from fsync or fdatasync syscall on the evidence
> as follows:
> 
> 1. The response time of fsync() and fdatasync() was extremely
>    short.
> 
>    We use the "diskio" tool, which is downloadable from OSDL page
>    (http://developer.osdl.jp/projects/doubt/).  The program showed
>    that the response time was under 10 microseconds.  This time
>    cannot be achieved with data transfer on IDE and PCI bus!
> 
> 2. The IDE writing routine ide_start_dma() was not called under
>    DMA enabled.
> 
>    We inserted the print messages in the sys_write(), sys_fsync()
>    and ide_start_dma() by the attached patch.  Sometimes the
>    "ide_start_dma: ..." message was not shown between "write: in
>    ..." and "fsync: out ...".
> 
> The problem was occurred since 2.6.5-bk1, which includes the patch
> "[PATCH] ext3 fsync() and fdatasync() speedup".  We found that the
> problem was solved by deleting the part of the patch which
> modifies ext3_sync_file().  Maybe, i_state is not correctly set to
> I_DIRTY when the related page cache is dirty (is it true?)

I forgot about this one.

> Attached file is tarball (tar + bzip2) which contains following
> files.  The patches are for 2.6.8.1-kernel (applicable to
> 2.6.9-rc2), and the results were also produced with
> 2.6.8.1-kernel.

We really don't need a 100k tarball to communicate a three line patch :(

Yes, the I_DIRTY test is bogus because data pages are not marked dirty at
write() time when the filesystem is mounted in data=journal mode.

However your patch will disable the above optimisation for data=writeback
and data-ordered modes as well.  I don't think that's necessary?

How about this?

--- 25/fs/ext3/fsync.c~ext3-journal-data-fsync-fix	Thu Sep 16 14:47:21 2004
+++ 25-akpm/fs/ext3/fsync.c	Thu Sep 16 14:47:33 2004
@@ -49,10 +49,6 @@ int ext3_sync_file(struct file * file, s
 
 	J_ASSERT(ext3_journal_current_handle() == 0);
 
-	smp_mb();		/* prepare for lockless i_state read */
-	if (!(inode->i_state & I_DIRTY))
-		goto out;
-
 	/*
 	 * data=writeback:
 	 *  The caller's filemap_fdatawrite()/wait will sync the data.
@@ -76,6 +72,10 @@ int ext3_sync_file(struct file * file, s
 		goto out;
 	}
 
+	smp_mb();		/* prepare for lockless i_state read */
+	if (!(inode->i_state & I_DIRTY))
+		goto out;
+
 	/*
 	 * The VFS has written the file data.  If the inode is unaltered
 	 * then we need not start a commit.
_

