Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281289AbRKHCQX>; Wed, 7 Nov 2001 21:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281288AbRKHCQM>; Wed, 7 Nov 2001 21:16:12 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:51471 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281289AbRKHCP7>; Wed, 7 Nov 2001 21:15:59 -0500
Message-ID: <3BE9E9A7.6F90C4DB@zip.com.au>
Date: Wed, 07 Nov 2001 18:10:47 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory accounting problem in 2.4.13, 2.4.14pre, and possibly 2.4.14
In-Reply-To: <20011106140335.A13678@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> Hello,
> 
> I am trying to track down a memory accounting problem I've seen ever since I
> tried a 2.4.13 based kernel.  Specifically I've noticed an overflow for the
> "Cached" entry in /proc/meminfo, but also the numbers don't add up to the
> total memory count.  Shouldn't they add up?  If they should, I haven't seen
> one that does....
> 
> I first noticed it on:
> 2.4.13freeswan-1.91+ac5+preempt+netdev_random+vm_freeswap
> 2.4.14-pre6+preempt+netdev_random+ext3_0.9.14-2414p5
> 
> I thought it may be preempt so I tried:
> 2.4.14-pre8+netdev_random-p7+xsched+ext3_0.9.14-2414p8+elevator
> 
> But I still get the same problem with "Cached".
> 
> Now I'm trying to see if it could be ext3 with:
> 2.4.14-ext3-2.4-0.9.14-2414p8
> 
> And I haven't noticed the problem after 16 hours uptime.  Sometimes it would
> show earlier, or later.
> 

Ah.  So are you saying that it does *not* occur on
ext3, but that it does occur on ext2?

Could you retest ext2 with this:

--- linux-2.4.14/mm/filemap.c	Mon Nov  5 21:01:12 2001
+++ linux-akpm/mm/filemap.c	Wed Nov  7 18:09:38 2001
@@ -223,6 +223,8 @@ static void truncate_complete_page(struc
 	/* Leave it on the LRU if it gets converted into anonymous buffers */
 	if (!page->buffers || block_flushpage(page, 0))
 		lru_cache_del(page);
+	else
+		atomic_inc(&buffermem_pages);
 
 	/*
 	 * We remove the page from the page cache _after_ we have

(This will break ext3's accounting)
