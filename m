Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263268AbTDBXeU>; Wed, 2 Apr 2003 18:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263273AbTDBXeU>; Wed, 2 Apr 2003 18:34:20 -0500
Received: from [12.47.58.55] ([12.47.58.55]:58126 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S263268AbTDBXeM>;
	Wed, 2 Apr 2003 18:34:12 -0500
Date: Wed, 2 Apr 2003 15:45:00 -0800
From: Andrew Morton <akpm@digeo.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: back-trace on mounting ide cd-rom
Message-Id: <20030402154500.3e6b9a62.akpm@digeo.com>
In-Reply-To: <1049326318.2872.36.camel@localhost>
References: <1049326318.2872.36.camel@localhost>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Apr 2003 23:45:33.0782 (UTC) FILETIME=[F3DDDF60:01C2F971]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love <rml@tech9.net> wrote:
>
> I got the following errors and back-trace upon mounting my IDE CD-ROM
> (hdc).  It seems to be a normal ISO9660... its the Red Hat 9 CD.
> 
> I haven't looked into it yet.  Not sure why there is ext3 stuff in
> there... maybe the CD-ROM mount is unrelated?  Mounting the CD
> subsequent times is OK.
> 
> Kernel is 2.5.66-mm2.  UP, preempt, no highmem, i686.
> 
> Here we go:
> 
>         buffer layer error at fs/buffer.c:127

ah, my new debug code is buggy.  It is legal to wait upon a zero-ref buffer
if that buffer's page is locked.

diff -puN fs/buffer.c~a fs/buffer.c
--- 25/fs/buffer.c~a	Wed Apr  2 15:41:25 2003
+++ 25-akpm/fs/buffer.c	Wed Apr  2 15:43:02 2003
@@ -123,7 +123,8 @@ void __wait_on_buffer(struct buffer_head
 	wait_queue_head_t *wqh = bh_waitq_head(bh);
 	DEFINE_WAIT(wait);
 
-	if (atomic_read(&bh->b_count) == 0)
+	if (atomic_read(&bh->b_count) == 0 &&
+			(!bh->b_page || !PageLocked(bh->b_page)))
 		buffer_error();
 
 	do {

_

