Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVCHGos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVCHGos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVCHGor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:44:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:32398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261822AbVCHGka convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:40:30 -0500
Date: Mon, 7 Mar 2005 22:39:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?U+liYXN0aWVuIER1Z3Xp?= <sebastien.dugue@bull.net>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH] 2.6.10 -  direct-io async short read bug
Message-Id: <20050307223917.1e800784.akpm@osdl.org>
In-Reply-To: <1110189607.11938.14.camel@frecb000686>
References: <1110189607.11938.14.camel@frecb000686>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sébastien Dugué <sebastien.dugue@bull.net> wrote:
>
> When reading a file in async mode (using kernel AIO), and the file
>  size is lower than the requested size (short read),  the direct IO
>  layer reports an incorrect number of bytes read (transferred).
> 
>   That case is handled for the sync path in 'direct_io_worker' 
>  (fs/direct-io.c) where a check is made against the file size.
> 
>   This patch does the same thing for the async path.

It looks sane to me.  It needs a couple of fixes, below.  One of them is
horrid and isn't really a fix at all, but it improves things.

Would Suparna and Badari have time to check the logic of these two patches
please?




- i_size is 64 bit, ssize_t is 32-bit

- whitespace tweaks.

- i_size_read() in interrupt context is a no-no.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/direct-io.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff -puN fs/direct-io.c~direct-io-async-short-read-fix-fix fs/direct-io.c
--- 25/fs/direct-io.c~direct-io-async-short-read-fix-fix	2005-03-07 22:28:52.000000000 -0800
+++ 25-akpm/fs/direct-io.c	2005-03-07 22:37:18.000000000 -0800
@@ -231,7 +231,7 @@ static void finished_one_bio(struct dio 
 	if (dio->bio_count == 1) {
 		if (dio->is_async) {
 			ssize_t transferred;
-			ssize_t i_size;
+			loff_t i_size;
 			loff_t offset;
 
 			/*
@@ -241,11 +241,19 @@ static void finished_one_bio(struct dio 
 			spin_unlock_irqrestore(&dio->bio_lock, flags);
 
 			/* Check for short read case */
+
+			/*
+			 * We should use i_size_read() here.  But we're called
+			 * in interrupt context.  If this CPU happened to be
+			 * in the middle of i_size_write() when the interrupt
+			 * occurred, i_size_read() would lock up.
+			 * So we just risk getting a wrong result instead :(
+			 */
+			i_size = dio->inode->i_size;
 			transferred = dio->result;
-			i_size = i_size_read (dio->inode);
 			offset = dio->iocb->ki_pos;
 
-			if ((dio->rw == READ) && ((offset + transferred) > i_size))
+			if ((dio->rw == READ) && (offset+transferred > i_size))
 				transferred = i_size - offset;
 
 			dio_complete(dio, offset, transferred);
_

