Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbTE3Qan (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263791AbTE3Qan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:30:43 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:51887 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263790AbTE3QaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:30:25 -0400
Date: Fri, 30 May 2003 09:43:44 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm1
Message-Id: <20030530094344.74a0e617.akpm@digeo.com>
In-Reply-To: <12430000.1054309916@[10.10.2.4]>
References: <20030527004255.5e32297b.akpm@digeo.com>
	<1980000.1054189401@[10.10.2.4]>
	<18080000.1054233607@[10.10.2.4]>
	<20030529115237.33c9c09a.akpm@digeo.com>
	<39810000.1054240214@[10.10.2.4]>
	<20030529141405.4578b72c.akpm@digeo.com>
	<12430000.1054309916@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2003 16:43:44.0874 (UTC) FILETIME=[A28A7CA0:01C326CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Well, that just seems to make the box hang in SDET (actually, moving it
>  outside lock_kernel makes it hang in a similar way). Not sure it's 
>  *caused* by this ... it might just change timing enough to trigger it.

Yes, sorry.  Looks like you hit the filemap.c screwup.  The below should
fix it.


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

