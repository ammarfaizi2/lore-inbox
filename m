Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbTLVJcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 04:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTLVJcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 04:32:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:50566 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264265AbTLVJcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 04:32:21 -0500
Date: Mon, 22 Dec 2003 01:32:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 Ooops while accessing ejected floppy
Message-Id: <20031222013215.7dc0595e.akpm@osdl.org>
In-Reply-To: <20031221163947.GA897@gmx.de>
References: <20031221163947.GA897@gmx.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wiktor Wodecki <wodecki@gmx.de> wrote:
>
> I forgot to unmount my floppy before ejecting it. No problem here (it is
>  my fault after all) but the kernel gave me an Ooops.
>  Nothing bad really happend, and I could continue work. However, I
>  thought to give a note here.
> 
>  Dec 21 14:50:38 kakerlak kernel: floppy0: disk absent or changed during
>  operation
>  Dec 21 14:50:38 kakerlak kernel: end_request: I/O error, dev fd0, sector
>  7
>  Dec 21 14:50:38 kakerlak kernel: lost page write due to I/O error on fd0 
>  Dec 21 14:50:38 kakerlak kernel: buffer layer error at fs/buffer.c:2827

It's a warning, not an oops.  The below should shut it up.




From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Suppress a buffer_error() warning which occurs when a page which previously
had an I/O error gets its buffers stripped.



 fs/buffer.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/buffer.c~buffer_error-suppression fs/buffer.c
--- 25/fs/buffer.c~buffer_error-suppression	2003-12-21 22:11:33.000000000 -0800
+++ 25-akpm/fs/buffer.c	2003-12-21 22:11:33.000000000 -0800
@@ -2820,7 +2820,7 @@ drop_buffers(struct page *page, struct b
 		bh = bh->b_this_page;
 	} while (bh != head);
 
-	if (!was_uptodate && PageUptodate(page))
+	if (!was_uptodate && PageUptodate(page) && !PageError(page))
 		buffer_error();
 
 	do {

_

