Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276600AbRI2Tob>; Sat, 29 Sep 2001 15:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276601AbRI2ToV>; Sat, 29 Sep 2001 15:44:21 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:2827 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S276600AbRI2ToF>;
	Sat, 29 Sep 2001 15:44:05 -0400
Date: Sat, 29 Sep 2001 21:43:04 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM, active cache pages, and OOM
In-Reply-To: <9p54c2$836$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0109292135200.17290-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2001, Linus Torvalds wrote:

> However, I'd also like to fix generic_file_read() to only mark the page
> accessed when we're touching it for the first time, and notice
> sequential accesses automatically. That way the use-once logic doesn't
> depend on the read size - which is a totally independent problem.
>
> If you want to test, the fix for _that_ is in mm/filemap.c:
> do_generic_file_read(), where the code does:
>
> 		...
>                 ret = actor(desc, page, offset, nr);
>                 offset += ret;
>                 index += offset >> PAGE_CACHE_SHIFT;
>                 offset &= ~PAGE_CACHE_MASK;
>
>                 mark_page_accessed(page);
> 		...
>
> and it would be interesting to hear if the behaviour improves with the
> above mark_page_accessed() logic moved a bit and changed to:
>
> 		...
>                 ret = actor(desc, page, offset, nr);
> 		if (!offset || !file->f_reada)
> 			mark_page_accessed(page);
>                 offset += ret;
>                 index += offset >> PAGE_CACHE_SHIFT;
>                 offset &= ~PAGE_CACHE_MASK;
> 		...
>
> (which basically says: we only mark the page accessed if we read the
> _beginning_ of the page, or if we just did a seek to it)
>
> Btw, if you test the above change out and confirm that it fixes te
> behaviour, please send me an acknowledgement email - I've not done it in
> my own tree yet, and unless I get a "yes, that works well" email I won't
> be doing it..

Yes, that works well, and I tried with a block sizes of 1, 512, 4095 and
4096.  The cache pages are not beeing activated now.  When reading the
same buf twice with a seek between the reads, the pages are activated, as
expected.

I'll have a look at the other problem, and Andrea's solution, later.

/Tobias

