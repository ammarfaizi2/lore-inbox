Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbUKWCZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbUKWCZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbUKWCXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:23:37 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:2577 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261212AbUKWCWL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:22:11 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
References: <877joexjk5.fsf@devron.myhome.or.jp>
	<20041122024654.37eb5f3d.akpm@osdl.org>
	<87ekimw1uj.fsf@devron.myhome.or.jp>
	<20041122134344.3b2cb489.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 23 Nov 2004 11:22:01 +0900
In-Reply-To: <20041122134344.3b2cb489.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 22 Nov 2004 13:43:44 -0800")
Message-ID: <87k6sdwbhy.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>> Umm... however, if ->i_size is updated before ->commit_write(),
>> doesn't it allow access to those pages, before all write() work is
>> successful?
>
> That's OK.  A thread which is read()ing that page will either
>
> a) decide that the page is outside i_size, and won't read it anyway or
>
> b) decide that the page is inside i_size and will read the page's contents.
>
> Still, I'd be inclined to update i_size after running ->commit_write.  It
> looks like we can simply replace the call to __block_commit_write() with a
> call to generic_commit_write().

If ->prepare_write() failed, I thought we should restore the ->i_size
by vmtruncate() before running ->prepare_write().

But, it's not required... yes?

Anyway, fixed patch is the following.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



 fs/buffer.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN fs/buffer.c~cont_prepare_write-fix fs/buffer.c
--- linux-2.6.10-rc2/fs/buffer.c~cont_prepare_write-fix	2004-11-23 11:10:10.000000000 +0900
+++ linux-2.6.10-rc2-hirofumi/fs/buffer.c	2004-11-23 11:10:10.000000000 +0900
@@ -2224,8 +2224,7 @@ int cont_prepare_write(struct page *page
 		memset(kaddr+zerofrom, 0, PAGE_CACHE_SIZE-zerofrom);
 		flush_dcache_page(new_page);
 		kunmap_atomic(kaddr, KM_USER0);
-		__block_commit_write(inode, new_page,
-				zerofrom, PAGE_CACHE_SIZE);
+		generic_commit_write(NULL, new_page, zerofrom, PAGE_CACHE_SIZE);
 		unlock_page(new_page);
 		page_cache_release(new_page);
 	}
_
