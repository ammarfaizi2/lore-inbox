Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQL1Tug>; Thu, 28 Dec 2000 14:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQL1TuQ>; Thu, 28 Dec 2000 14:50:16 -0500
Received: from hermes.mixx.net ([212.84.196.2]:41993 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129257AbQL1TuE>;
	Thu, 28 Dec 2000 14:50:04 -0500
Message-ID: <3A4B91B6.9354E666@innominate.de>
Date: Thu, 28 Dec 2000 20:17:10 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <3A4B8895.CEDA8311@innominate.de> <Pine.LNX.4.10.10012281051480.12260-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> No, I'd much rather have
> 
>         if (PageDirty(page)) BUG();
> 
> there, and then have the free_swap_cache code clear the dirty bit.
> 
> We don't want to lose dirty bits by mistake. The only cases where it's ok
> to clear the dirty bit is when we truncate a page completely (so it won't
> be needed and obviously really shouldn't be written out) and when we've
> lost the last user of a swap cache entry.
> 
> Any other cases might be bugs, where we remove a page from a mapping
> without noticing that it is dirty (we had this bug in reclaim_pages(), for
> example).

And in this case it's clear we lose data with nfs and smbfs that way. 
Maybe this is more like it:

--- 2.4.0-test13.clean/mm/filemap.c	Fri Dec 29 03:14:58 2000
+++ 2.4.0-test13/mm/filemap.c	Fri Dec 29 04:13:27 2000
@@ -132,7 +132,7 @@
 		curr = curr->next;
 
 		/* We cannot invalidate a locked page */
-		if (TryLockPage(page))
+		if (PageDirty(page) || TryLockPage(page))
 			continue;
 
 		/* Neither can we invalidate something in use.. */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
