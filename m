Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282540AbRKZVFX>; Mon, 26 Nov 2001 16:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282531AbRKZVE3>; Mon, 26 Nov 2001 16:04:29 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6160 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282524AbRKZVDZ>; Mon, 26 Nov 2001 16:03:25 -0500
Message-ID: <3C02ADF2.E505E672@zip.com.au>
Date: Mon, 26 Nov 2001 13:02:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <3C02A00B.B9948342@zip.com.au>,
		<3C029BE0.2BEA2264@zip.com.au>,
			<Pine.LNX.4.33.0111262201420.18923-100000@localhost.localdomain>
			<20011126.111854.102567147.davem@redhat.com>
			<3C029BE0.2BEA2264@zip.com.au> <20011126.115723.41632923.davem@redhat.com> <200111262037.fAQKblt10496@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3C02A00B.B9948342@zip.com.au> you write:
> >
> >Here's the current rolled-up ext3 diff which I've been using.
> >It needs to be resynced with pestiferous ext3 CVS, changelogged
> >and pushed out this week.
> >
> >--- linux-2.4.15-pre9/fs/ext3/inode.c  Thu Nov 22 10:56:33 2001
> >+++ linux-akpm/fs/ext3/inode.c Thu Nov 22 11:07:03 2001
> >@@ -1026,9 +1026,20 @@ static int ext3_prepare_write(struct fil
> >       if (ret != 0)
> >               goto prepare_write_failed;
> >
> >-      if (ext3_should_journal_data(inode))
> >+      if (ext3_should_journal_data(inode)) {
> >               ret = walk_page_buffers(handle, page->buffers,
> >                               from, to, NULL, do_journal_get_write_access);
> >+              if (ret) {
> >+                      /*
> >+                       * We're going to fail this prepare_write(),
> >+                       * so commit_write() will not be called.
> >+                       * We need to undo block_prepare_write()'s kmap().
> >+                       * AKPM: Do we need to clear PageUptodate?  I don't
> >+                       * think so.
> >+                       */
> >+                      kunmap(page);
> >+              }
> >+      }
> 
> This is wrong.
> 
> The generic VM layer does the kmap/kunmap itself these days (it really
> always should have - it needs the page mapped itself for the memcpy
> anyway, and depending on the low-level FS to do kmap/kunmap was an ugly
> layering violation).

Actually the comment is a bit misleading.

We've called block_prepare_write(), which has done the kmap.
But even though block_prepare_write() returned success, this
call to the filesystem's ->prepare_write() is about to fail.

So the caller of ->prepare_write() isn't going to run ->commit_write(),
and we have to undo the kmap here.

> So you should just remove all the kmap/kunmap stuff in
> prepare/commit_write instead of adding more of them to handle the
> brokenness.

There have been a number of mistakes made over this particular kmap()
operation.  NFS client had it wrong for a while. I think sct had
some proposal for making it more robust.

-
