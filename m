Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276587AbRI2ShV>; Sat, 29 Sep 2001 14:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276588AbRI2ShK>; Sat, 29 Sep 2001 14:37:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21518 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276587AbRI2Sgy>; Sat, 29 Sep 2001 14:36:54 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.4.10 VM, active cache pages, and OOM
Date: Sat, 29 Sep 2001 18:36:50 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9p54c2$836$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109291645260.16885-100000@boris.prodako.se>
X-Trace: palladium.transmeta.com 1001788623 10546 127.0.0.1 (29 Sep 2001 18:37:03 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 29 Sep 2001 18:37:03 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0109291645260.16885-100000@boris.prodako.se>,
Tobias Ringstrom  <tori@ringstrom.mine.nu> wrote:
>
>I assume that the difference between a buf size of 512 and 4096 is that
>for the 512-byte case, each page is touched more than once, and that's why
>the system think the pages are active.  This is a very wrong decision,
>since I'm doing a sequential read.
>
>Fixing that particular problem will get rid of my problem, but I'm
>guessing that it would only hide another real problem, which is that
>2.4.10 has a huge problem freeing pages from the list of active pages,
>even if they are clean, and thus making a wrong decision on the
>availibility of free(able) pages.

Absolutely right.

It's probably worth fixing the "sequential accesses of < pagesize count
as 'active'" problem too, but the real issue is that if you get into a
situation with _many_ more active pages than inactive, the plain 2.4.10
VM doesn't age the active list nearly fast enough.

That's fixed in Andrea's VM tweaks, but if you want to look into this,
the basic problem is in mm/vmscan.c, shrink_caches(), which in plain
2.4.10 does

        /* Do we want to age the active list? */
        if (nr_inactive_pages < nr_active_pages*2)
                refill_inactive(nr_pages);

which doesn't take into account just _how_ imbalanced the active list
is. So if the active list is huge, it will still just scan a small fixed
percentage of it (and to make matters worse, the small part of it is
proportional to the size of the _inactive_ list, so if the inactive list
is small, that just makes the problem worse.

What Andreas fix does is to make the refill rate be proportional to the
sizes of the lists, which should fix this problem for you. 

However, I'd also like to fix generic_file_read() to only mark the page
accessed when we're touching it for the first time, and notice
sequential accesses automatically. That way the use-once logic doesn't
depend on the read size - which is a totally independent problem.

If you want to test, the fix for _that_ is in mm/filemap.c:
do_generic_file_read(), where the code does:

		...
                ret = actor(desc, page, offset, nr);
                offset += ret;
                index += offset >> PAGE_CACHE_SHIFT;
                offset &= ~PAGE_CACHE_MASK;

                mark_page_accessed(page);
		...

and it would be interesting to hear if the behaviour improves with the
above mark_page_accessed() logic moved a bit and changed to:

		...
                ret = actor(desc, page, offset, nr);
		if (!offset || !file->f_reada)
			mark_page_accessed(page);
                offset += ret;
                index += offset >> PAGE_CACHE_SHIFT;
                offset &= ~PAGE_CACHE_MASK;
		...

(which basically says: we only mark the page accessed if we read the
_beginning_ of the page, or if we just did a seek to it)

Btw, if you test the above change out and confirm that it fixes te
behaviour, please send me an acknowledgement email - I've not done it in
my own tree yet, and unless I get a "yes, that works well" email I won't
be doing it..

		Linus
