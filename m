Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUGBNOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUGBNOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUGBNOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:14:49 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:17821 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264512AbUGBNNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:13:19 -0400
Date: Fri, 2 Jul 2004 18:53:03 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/22] AIO immediate read (needed for AIO pipes & sockets)
Message-ID: <20040702132303.GI4374@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20040702130030.GA4256@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702130030.GA4256@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:30:30PM +0530, Suparna Bhattacharya wrote:
> The patchset contains modifications and fixes to the AIO core
> to support the full retry model, an implementation of AIO
> support for buffered filesystem AIO reads and O_SYNC writes
> (the latter courtesy O_SYNC speedup changes from Andrew Morton),
> an implementation of AIO reads and writes to pipes (from
> Chris Mason) and AIO poll (again from Chris Mason).
> 
> Full retry infrastructure and fixes
> [1] aio-retry.patch
> [2] 4g4g-aio-hang-fix.patch
> [3] aio-retry-elevated-refcount.patch
> [4] aio-splice-runlist.patch
> 
> FS AIO read
> [5] aio-wait-page.patch
> [6] aio-fs_read.patch
> [7] aio-upfront-readahead.patch
> 
> AIO for pipes
> [8] aio-cancel-fix.patch
> [9] aio-read-immediate.patch

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

----------------------------------------------

From: Suparna Bhattacharya <suparna@in.ibm.com>

Currently, the high level AIO code keeps issuing retries until the
entire transfer is done, i.e. until all the bytes requested are
read (See aio_pread), which is what we needed for filesystem aio
read. However, in the pipe read case, the expected semantics would
be to return as soon as it has any bytes transferred, rather than
waiting for the entire transfer.  This will also be true in for
network aio reads if/when we implement it.
                                                                         
Hmm, so we need to get the generic code to allow for this
possibility - maybe based on a check for ISFIFO/ISSOCK ?


 aio.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

--- aio/fs/aio.c	2004-06-18 09:31:00.795414792 -0700
+++ aio-read-immediate/fs/aio.c	2004-06-18 09:31:39.459536952 -0700
@@ -1272,6 +1272,8 @@ asmlinkage long sys_io_destroy(aio_conte
 static ssize_t aio_pread(struct kiocb *iocb)
 {
 	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
 	ssize_t ret = 0;
 
 	ret = file->f_op->aio_read(iocb, iocb->ki_buf,
@@ -1284,8 +1286,14 @@ static ssize_t aio_pread(struct kiocb *i
 	if (ret > 0) {
 		iocb->ki_buf += ret;
 		iocb->ki_left -= ret;
-
-		ret = -EIOCBRETRY;
+		/* 
+		 * For pipes and sockets we return once we have
+		 * some data; for regular files we retry till we
+		 * complete the entire read or find that we can't
+		 * read any more data (e.g short reads).
+		 */
+		if (!S_ISFIFO(inode->i_mode) && !S_ISSOCK(inode->i_mode))
+			ret = -EIOCBRETRY;
 	}
 
 	/* This means we must have transferred all that we could */
