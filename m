Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTE3LDf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 07:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTE3LDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 07:03:35 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:17044 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263584AbTE3LDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 07:03:34 -0400
Date: Fri, 30 May 2003 04:17:04 -0700
From: Andrew Morton <akpm@digeo.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, nsharoff@us.ibm.com,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.5.70-mm2
Message-Id: <20030530041704.5d740ee2.akpm@digeo.com>
In-Reply-To: <200305291452.09041.pbadari@us.ibm.com>
References: <20030529012914.2c315dad.akpm@digeo.com>
	<200305291452.09041.pbadari@us.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2003 11:16:53.0802 (UTC) FILETIME=[F96E60A0:01C3269C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> 2.5.70-mm2 seems to hang while running LTP.

It is actually a VFS bug.  A brand new one.  Here's a fix, but we should
check that it still gets all the LTP writev cases right.

A couple of ext3 bugs in -mm2 have been fixed so please don't spend time
stresstesting it until mm3.

Thanks.



The recent writev() fix broke the invariant that ->commit_write _must_ be
called after a successful ->prepare_write().  It leaves ext3 with a
transaction stuck open and the filesystem locks up.




 mm/filemap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff -puN mm/filemap.c~generic_file_write-commit_write-fix mm/filemap.c
--- 25/mm/filemap.c~generic_file_write-commit_write-fix	2003-05-30 04:01:19.000000000 -0700
+++ 25-akpm/mm/filemap.c	2003-05-30 04:04:11.000000000 -0700
@@ -1718,10 +1718,9 @@ generic_file_aio_write_nolock(struct kio
 			copied = filemap_copy_from_user_iovec(page, offset,
 						cur_iov, iov_base, bytes);
 		flush_dcache_page(page);
+		status = a_ops->commit_write(file, page, offset,
+						offset + copied);
 		if (likely(copied > 0)) {
-			status = a_ops->commit_write(file, page, offset,
-						     offset + copied);
-
 			if (!status)
 				status = copied;
 

_

