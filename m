Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbUCMSuX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 13:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUCMSuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 13:50:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:15017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263164AbUCMSuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 13:50:21 -0500
Date: Sat, 13 Mar 2004 10:57:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: Hugh Dickins <hugh@veritas.com>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: anon_vma RFC2
In-Reply-To: <Pine.LNX.4.44.0403131227210.15971-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0403131048340.900@ppc970.osdl.org>
References: <Pine.LNX.4.44.0403131227210.15971-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Mar 2004, Rik van Riel wrote:
> 
> No, Linus is right.
> 
> If a child process uses mremap(), it stands to reason that
> it's about to use those pages for something.

That's not necessarily true, since it's entirely possible that it's just a 
realloc(), and the old part of the allocation would have been left alone.

That said, I suspect that
 - mremap() isn't all _that_ common in the first place
 - it's even more rare to do a fork() and then a mremap() (ie most of the 
   time I suspect the page count will be 1, and no COW is necessary). Most
   apps tend to exec() after a fork.
 - I agree that in at least part of the remaining cases we _would_ COW the
   pages anyway.

I suspect that the only common "no execve after fork" usage is for a few 
servers, especially the traditional UNIX kind (ie using processes are 
fairly heavy-weight threads). It could be interesting to see numbers.

But basically I'm inclined to believe that the "unnecessary COW" case is
_so_ rare, that if it allows us to make other things simpler (and thus
more stable and likely faster) it is worth it. Especially the simplicity
just appeals to me.

I just think that if mremap() causes so many problems for reverse mapping,
we should make _that_ the expensive operation, instead of making
everything else more complicated. After all, if it turns out that the
"early COW" behaviour I suggest can be a performance problem for some
(rare) circumstances, then the fix for that is likely to just let
applications know that mremap() can be expensive.

(It's still likely to be a lot cheaper than actually doing a new
mmap+memcpy+munmap, so it's not like mremap would become pointless).

			Linus
