Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUFIMT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUFIMT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265742AbUFIMT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:19:26 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:26348 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S263831AbUFIMTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:19:21 -0400
Subject: [PATCH] A generic_file_sendpage()
From: Alexander Nyberg <alexn@telia.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040608193621.GA12780@holomorphy.com>
References: <20040608154438.GK18083@dualathlon.random>
	 <20040608193621.GA12780@holomorphy.com>
Content-Type: text/plain
Message-Id: <1086783559.1194.24.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 14:19:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sendfile() for all file systems remain unusable as it is right now,
only works for sending data to socket. But that should be as much performance
enhancing as this yes?

Please hit me with cluebat for what I'm missing.
(yes, rebooted between all copying)

-----------------------------------
Normal read/write with 16K buffers:

comp1 with 4 scsi disks sw raid0:
kernie:/mnt/data/playground# time ./copyf tref x1
size: 2097152000

real    2m9.680s
user    0m0.075s
sys     0m21.019s

comp2 with single ide disk:
om3:/home/alex# time ./copyf haha c1
size: 1048576000

real    1m25.104s
user    0m0.042s
sys     0m14.880s


-----------------------------------
Normal read/write with 64K buffers:

comp1 with 4 scsi disks sw raid0:
kernie:/mnt/data/playground# time ./copyf tref x3
size: 2097152000

real    2m11.160s
user    0m0.035s
sys     0m20.745s


comp2 with single ide disk:
om3:/home/alex# time ./copyf haha c3
size: 1048576000

real    1m25.651s
user    0m0.052s
sys     0m14.020s


-----------------------------------
Using sendfile() to copy entire files:

comp1 with 4 scsi disks sw raid0:
kernie:/mnt/data/playground# time ./sendf tref x2
size: 2097152000

real    2m9.645s
user    0m0.001s
sys     0m19.961s

and again:

real    2m9.675s
user    0m0.001s
sys     0m19.271s


comp2 with single ide disk:
om3:/home/alex# time ./sendf haha c2
size: 1048576000

real    1m24.395s
user    0m0.002s
sys     0m13.151s

and again:

real    1m23.781s
user    0m0.001s
sys     0m12.967s



--- include/linux/fs_orig.h     2004-06-09 00:37:29.000000000 +0200
+++ include/linux/fs.h  2004-06-07 18:13:54.000000000 +0200
@@ -1405,6 +1405,7 @@ extern ssize_t do_sync_write(struct file
 ssize_t generic_file_write_nolock(struct file *file, const struct iovec *iov,
                                unsigned long nr_segs, loff_t *ppos);
 extern ssize_t generic_file_sendfile(struct file *, loff_t *, size_t, read_actor_t, void __user *);
+extern ssize_t generic_file_sendpage(struct file *, struct page *, int, size_t, loff_t *, int);
 extern void do_generic_mapping_read(struct address_space *mapping,
                                    struct file_ra_state *, struct file *,
                                    loff_t *, read_descriptor_t *, read_actor_t);
--- mm/filemap_orig.c   2004-06-09 00:37:45.000000000 +0200
+++ mm/filemap.c        2004-06-08 22:19:48.000000000 +0200
@@ -961,7 +961,32 @@ generic_file_read(struct file *filp, cha

 EXPORT_SYMBOL(generic_file_read);

-int file_send_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
+ssize_t generic_file_sendpage(struct file *out_file, struct page *page,
+                       int offset, size_t size, loff_t *pos, int more)
+{
+       void *addr;
+       int ret;
+       mm_segment_t old_fs;
+
+       old_fs = get_fs();
+       set_fs(KERNEL_DS);
+
+       addr = kmap(page);
+       if (!addr) {
+               set_fs(old_fs);
+               return -ENOMEM;
+       }
+
+       ret = out_file->f_op->write(out_file, addr + offset, size, pos);
+
+       kunmap(addr);
+
+       set_fs(old_fs);
+       return ret;
+}
+
+int file_send_actor(read_descriptor_t * desc, struct page *page,
+                       unsigned long offset, unsigned long size)
 {
        ssize_t written;
        unsigned long count = desc->count;
--- fs/ext3/file_orig.c 2004-06-09 00:42:50.000000000 +0200
+++ fs/ext3/file.c      2004-06-07 18:12:19.000000000 +0200
@@ -129,6 +129,7 @@ struct file_operations ext3_file_operati
        .release        = ext3_release_file,
        .fsync          = ext3_sync_file,
        .sendfile       = generic_file_sendfile,
+       .sendpage       = generic_file_sendpage,
 };

 struct inode_operations ext3_file_inode_operations = {
@@ -140,4 +141,3 @@ struct inode_operations ext3_file_inode_
        .removexattr    = ext3_removexattr,
        .permission     = ext3_permission,
 };
-


