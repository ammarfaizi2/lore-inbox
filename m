Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUJZUWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUJZUWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUJZUWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:22:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:45261 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261422AbUJZUVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:21:46 -0400
Date: Tue, 26 Oct 2004 13:19:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-mm1
Message-Id: <20041026131945.5640cb26.akpm@osdl.org>
In-Reply-To: <1098813484.10011.226.camel@boxen>
References: <20041022032039.730eb226.akpm@osdl.org>
	<1098813484.10011.226.camel@boxen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@dsv.su.se> wrote:
>
> On Fri, 2004-10-22 at 12:20, Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/
>  > 
>  > - Lots of new patches.
> 
>  Two different boxes, hits when running the ltp tests'./runltp -x 4'.

Yup, sorry.


From: Jens Axboe <axboe@suse.de>

->head and ->tail were not initialized in the cleanup path, I'm guessing
this happens if we adjust the read to zero.  Seems best to simply check for
that condition and bail early, instead of initing ->head and tail earlier
and go through the whole path.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/direct-io.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN fs/direct-io.c~dio-handle-eof-fix fs/direct-io.c
--- 25/fs/direct-io.c~dio-handle-eof-fix	2004-10-26 00:49:40.363376432 -0700
+++ 25-akpm/fs/direct-io.c	2004-10-26 00:49:40.367375824 -0700
@@ -987,6 +987,8 @@ direct_io_worker(int rw, struct kiocb *i
 	isize = i_size_read(inode);
 	if (bytes_todo > (isize - offset))
 		bytes_todo = isize - offset;
+	if (!bytes_todo)
+		return 0;
 
 	for (seg = 0; seg < nr_segs && bytes_todo; seg++) {
 		user_addr = (unsigned long)iov[seg].iov_base;
_

