Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965240AbWEOVSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965240AbWEOVSO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbWEOVR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:17:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:54197 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965244AbWEOVRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:17:50 -0400
Subject: [PATCH 0/4] VFS fileop cleanups by collapsing AIO and vector IO
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: christoph <hch@lst.de>, Benjamin LaHaise <bcrl@kvack.org>,
       cel@citi.umich.edu, pbadari@us.ibm.com,
       Zach Brown <zach.brown@oracle.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
	 <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 14:19:05 -0700
Message-Id: <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

These series of patches clean up and streamlines generic_file_*
interfaces in filemap.c. This time, to avoid public humiliation,
I compiled (allmodconfig) the patchset on 3 different architectures
(i386, x86_64, ppc64) and 4 different compilers versions and made
sure this patchset didn't introduce any new error & warnings :)

This is a patchset against 2.6.17-rc4, so won't apply cleanly on
-mm (few minor fixes in ocfs2, nfs & jffs2 needed). If you want me 
to send patchset against 2.6.17-rc4-mm1, please let me know.

Note:

1. I couldn't reproduce the compiler warning you got:

fs/aio.c: In function `aio_advance_iovec':
fs/aio.c:1314: warning: comparison of distinct pointer types lacks a
cast

So, I didn't fix this.

=====

First (3) patches collapses all the vectored IO support into
single set of file-operation method using aio_read/aio_write.
This work was originally suggested & started by Christoph Hellwig,
when Zach Brown tried to add vectored support for AIO.

Patch 4, sets all the filesystems .read/.write/.aio_read/.aio_write
methods correctly to allow us to cleanup most generic_file_*_read/write
interfaces in filemap.c

After this patch set, we should end up with ONLY following
read/write (exported) interfaces in filemap.c:

        generic_file_aio_read() - read handler
        generic_file_aio_write() - write handler
        generic_file_aio_write_nolock() - no lock write handler

Here is the summary:

[PATCH 1/4] Vectorize aio_read/aio_write methods

[PATCH 2/4] Remove readv/writev methods and use aio_read/aio_write
instead.

[PATCH 3/4] Core aio changes to support vectored AIO.

[PATCH 4/4] Streamline generic_file_* interfaces and filemap cleanups

BTW, Chuck Lever is actually re-arranging NFS DIO, AIO code to
fit into this model.

Thanks to Chuck Lever, Shaggy, Christoph, Zach Brown, Ben LaHaise 
for helping out. 

Thanks,
Badari



