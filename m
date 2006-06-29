Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWF2FVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWF2FVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 01:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWF2FVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 01:21:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49573 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932178AbWF2FVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 01:21:31 -0400
Date: Wed, 28 Jun 2006 22:20:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: ornati@fastwebnet.it, linux-kernel@vger.kernel.org, vs@namesys.com,
       neilb@suse.de, schwidefsky@de.ibm.com, stable@kernel.org
Subject: Re: Unkillable process in last git -- Bisected
Message-Id: <20060628222036.e4e40bab.akpm@osdl.org>
In-Reply-To: <20060628203825.47790a10@localhost>
References: <20060628142918.1b2c25c3@localhost>
	<20060628145349.53873ccc@localhost>
	<20060628150943.78e91871@localhost>
	<20060628151955.0acdb39a@localhost>
	<20060628203825.47790a10@localhost>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 20:38:25 +0200
Paolo Ornati <ornati@fastwebnet.it> wrote:

> After a git-bisect session I've found that reverting the following
> commit fixes the problem.
> 
> Any idea?
> 
> 
> commit 6527c2bdf1f833cc18e8f42bd97973d583e4aa83
> Author: Vladimir V. Saveliev <vs@namesys.com>
> Date:   Tue Jun 27 02:53:57 2006 -0700
> 
>     [PATCH] generic_file_buffered_write(): deadlock on vectored write



From: Andrew Morton <akpm@osdl.org>

The recent generic_file_write() deadlock fix caused
generic_file_buffered_write() to loop inifinitely when presented with a
zero-length iovec segment.  Fix.

Note that this fix deliberately avoids calling ->prepare_write(),
->commit_write() etc with a zero-length write.  This is because I don't trust
all filesystems to get that right.

This is a cautious approach, for 2.6.17.x.  For 2.6.18 we should just go ahead
and call ->prepare_write() and ->commit_write() with the zero length and fix
any broken filesystems.  So I'll make that change once this code is stabilised
and backported into 2.6.17.x.

The reason for preferring to call ->prepare_write() and ->commit_write() with
the zero-length segment: a zero-length segment _should_ be sufficiently
uncommon that this is the correct way of handling it.  We don't want to
optimise for poorly-written userspace at the expense of well-written
userspace.

Cc: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Neil Brown <neilb@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>
Cc: Greg KH <greg@kroah.com>
Cc: <stable@kernel.org>
Cc: walt <wa1ter@myrealbox.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/filemap.c |    9 ++++++++-
 mm/filemap.h |    4 ++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff -puN mm/filemap.c~generic_file_buffered_write-handle-zero-length-iovec-segments-stable mm/filemap.c
--- a/mm/filemap.c~generic_file_buffered_write-handle-zero-length-iovec-segments-stable
+++ a/mm/filemap.c
@@ -2125,6 +2125,12 @@ generic_file_buffered_write(struct kiocb
 			break;
 		}
 
+		if (unlikely(bytes == 0)) {
+			status = 0;
+			copied = 0;
+			goto zero_length_segment;
+		}
+
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
 			loff_t isize = i_size_read(inode);
@@ -2154,7 +2160,8 @@ generic_file_buffered_write(struct kiocb
 			page_cache_release(page);
 			continue;
 		}
-		if (likely(copied > 0)) {
+zero_length_segment:
+		if (likely(copied >= 0)) {
 			if (!status)
 				status = copied;
 
diff -puN mm/filemap.h~generic_file_buffered_write-handle-zero-length-iovec-segments-stable mm/filemap.h
--- a/mm/filemap.h~generic_file_buffered_write-handle-zero-length-iovec-segments-stable
+++ a/mm/filemap.h
@@ -88,7 +88,7 @@ filemap_set_next_iovec(const struct iove
 	const struct iovec *iov = *iovp;
 	size_t base = *basep;
 
-	while (bytes) {
+	do {
 		int copy = min(bytes, iov->iov_len - base);
 
 		bytes -= copy;
@@ -97,7 +97,7 @@ filemap_set_next_iovec(const struct iove
 			iov++;
 			base = 0;
 		}
-	}
+	} while (bytes);
 	*iovp = iov;
 	*basep = base;
 }
_

