Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUJNUQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUJNUQz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267508AbUJNUQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:16:36 -0400
Received: from palrel10.hp.com ([156.153.255.245]:64980 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S267438AbUJNUKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:10:00 -0400
Message-ID: <416EDD19.3010200@hpl.hp.com>
Date: Thu, 14 Oct 2004 13:10:01 -0700
From: Yasushi Saito <ysaito@hpl.hp.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Cc: suparna@in.ibm.com, Janet Morgan <janetmor@us.ibm.com>, ysaito@hpl.hp.com
Subject: [PATCH 1/2]  aio: add vectored I/O support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch against 2.6.9-rc3-mm3 that add supports for vectored 
async I/O.  It adds two additional commands, IO_CMD_PREADV and 
IO_CMD_PWRITEV to libaio.h. The below is roughly what I did:

    * add "aio_readv" and "aio_writev" to struct file_operations.
    * aio_abi.h: add IOCB_CMD_PREADV and PWRITEV. \
      Also make struct iocb compatible with the latest glibc libaio.h.
    * aio.c: change kiocb to support vectored operations.
       IOCB_CMD_PREAD and PWRITE are now simply
       implemented as degenerate variations of PREADV and PWRITEV.
    * block_dev.c, file.c, {ext2,ext3,jfs,reiserfs}/file.c:
       Add implementations of aio_readv and wriitev methods, route 
aio_read and aio_write to the ...v methods.
       They are reasonably straightforward since the low-level code 
already supports vectored I/O.

This feature has been tested on ext3 and a raw block device, but it 
should also work with ext2, nfs, jfs and reiser.
The patch is divided into two parts, one that just fixes bugs in the 
existing code, and the other that adds the vectored I/O feature.  A bit 
more detailed explanation, along with a sample program, is found in 
http://www.hpl.hp.com/personal/Yasushi_Saito/linux-aiov
Comments are appreciated.

yaz

This patch fixes two bugs: (1) aio_free_ring: don't attempt to free page 
on cleanup after io_setup fails  while in do_mmap,
(2) __generic_file_aio_read: properly abort and retry when more than one 
iovec is passed and data is not yet ready.

Signed-off-by: Yasushi Saito <ysaito@hpl.hp.com>

--- .pc/aio-bugfixes.patch/fs/aio.c    2004-10-14 12:58:39 -07:00
+++ fs/aio.c    2004-10-14 12:58:39 -07:00
@@ -86,7 +86,8 @@ static void aio_free_ring(struct kioctx
     long i;
 
     for (i=0; i<info->nr_pages; i++)
-        put_page(info->ring_pages[i]);
+            if (info->ring_pages[i])
+                put_page(info->ring_pages[i]);
 
     if (info->mmap_size) {
         down_write(&ctx->mm->mmap_sem);
--- .pc/aio-bugfixes.patch/mm/filemap.c    2004-10-14 12:58:39 -07:00
+++ mm/filemap.c    2004-10-14 12:58:39 -07:00
@@ -976,9 +976,11 @@ __generic_file_aio_read(struct kiocb *io
             desc.error = 0;
             do_generic_file_read(filp,ppos,&desc,file_read_actor);
             retval += desc.written;
-            if (!retval) {
-                retval = desc.error;
-                break;
+
+            if (desc.written < iov[seg].iov_len) {
+                    if (retval == 0)
+                    retval = desc.error;
+                 break;
             }
         }
     }



