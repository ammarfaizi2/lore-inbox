Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282491AbRKZUqB>; Mon, 26 Nov 2001 15:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282500AbRKZUoq>; Mon, 26 Nov 2001 15:44:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41230 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282491AbRKZUni>; Mon, 26 Nov 2001 15:43:38 -0500
From: Linus Torvalds <torvalds@transmeta.com>
Date: Mon, 26 Nov 2001 12:37:47 -0800
Message-Id: <200111262037.fAQKblt10496@penguin.transmeta.com>
To: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache
Newsgroups: linux.dev.kernel
In-Reply-To: <3C02A00B.B9948342@zip.com.au>
In-Reply-To: <3C029BE0.2BEA2264@zip.com.au>,
		<Pine.LNX.4.33.0111262201420.18923-100000@localhost.localdomain>
		<20011126.111854.102567147.davem@redhat.com>
		<3C029BE0.2BEA2264@zip.com.au> <20011126.115723.41632923.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C02A00B.B9948342@zip.com.au> you write:
>
>Here's the current rolled-up ext3 diff which I've been using.
>It needs to be resynced with pestiferous ext3 CVS, changelogged
>and pushed out this week.
>
>--- linux-2.4.15-pre9/fs/ext3/inode.c	Thu Nov 22 10:56:33 2001
>+++ linux-akpm/fs/ext3/inode.c	Thu Nov 22 11:07:03 2001
>@@ -1026,9 +1026,20 @@ static int ext3_prepare_write(struct fil
> 	if (ret != 0)
> 		goto prepare_write_failed;
> 
>-	if (ext3_should_journal_data(inode))
>+	if (ext3_should_journal_data(inode)) {
> 		ret = walk_page_buffers(handle, page->buffers,
> 				from, to, NULL, do_journal_get_write_access);
>+		if (ret) {
>+			/*
>+			 * We're going to fail this prepare_write(),
>+			 * so commit_write() will not be called.
>+			 * We need to undo block_prepare_write()'s kmap().
>+			 * AKPM: Do we need to clear PageUptodate?  I don't
>+			 * think so.
>+			 */
>+			kunmap(page);
>+		}
>+	}

This is wrong.

The generic VM layer does the kmap/kunmap itself these days (it really
always should have - it needs the page mapped itself for the memcpy
anyway, and depending on the low-level FS to do kmap/kunmap was an ugly
layering violation). 

So you should just remove all the kmap/kunmap stuff in
prepare/commit_write instead of adding more of them to handle the
brokenness. 

		Linus
