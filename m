Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265199AbUD3Njf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265199AbUD3Njf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 09:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUD3Njf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 09:39:35 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:40383 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265199AbUD3NjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 09:39:23 -0400
Message-ID: <40925705.6020205@yahoo.com.au>
Date: Fri, 30 Apr 2004 23:39:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Paul Mackerras <paulus@samba.org>, brettspamacct@fastclick.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <4091C15D.7040800@yahoo.com.au>	<Pine.LNX.4.44.0404300849480.6976-200000@chimarrao.boston.redhat.com> <16530.21039.756717.489879@laputa.namesys.com>
In-Reply-To: <16530.21039.756717.489879@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

> Here are results that I obtained some time ago. Test is to concurrently
> clone (bk) and build (make -jN) kernel source in M directories.
> 
> For N = M = 11, TIMEFORMAT='%3R %3S %3U'
> 
>                                         REAL    SYS      USER
> "stock"                               3818.320 568.999 4358.460
> transfer-dirty-on-refill              3368.690 569.066 4377.845
> check-PageSwapCache-after-add-to-swap 3237.632 576.208 4381.248
> dont-unmap-on-pageout                 3207.522 566.539 4374.504
> async-writepage                       3115.338 562.702 4325.212
> 

I like your transfer-dirty-on-refill change. It is definitely
worthwhile to mark a page as dirty when it drops off the active
list in order to hopefully get it written before it reaches the
tail of the inactive list.

> (check-PageSwapCache-after-add-to-swap was added to mainline since them.)
> 
> These patches weren't updated for some time. Last version is at
> ftp://ftp.namesys.com/pub/misc-patches/unsupported/extra/2004.03.25-2.6.5-rc2
> 
> [from Nick Piggin's patch]
>  > 
>  > Changes mark_page_accessed to only set the PageAccessed bit, and
>  > not move pages around the LRUs. This means we don't have to take
>  > the lru_lock, and it also makes page ageing and scanning consistient
>  > and all handled in mm/vmscan.c
> 
> By the way, batch-mark_page_accessed patch at the URL above also tries
> to reduce lock contention in mark_page_accessed(), but through more
> standard approach of batching target pages in per-cpu pvec.
> 

This is a good patch too if mark_page_accessed is required to
take the lock (which it currently is, of course).
