Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWGRNz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWGRNz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWGRNz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:55:56 -0400
Received: from dvhart.com ([64.146.134.43]:12469 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932210AbWGRNzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:55:55 -0400
Message-ID: <44BCE86A.4030602@mbligh.org>
Date: Tue, 18 Jul 2006 09:55:54 -0400
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
References: <1153167857.31891.78.camel@lappy>  <Pine.LNX.4.64.0607172035140.28956@schroedinger.engr.sgi.com> <1153224998.2041.15.camel@lappy> <Pine.LNX.4.64.0607180557440.30245@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607180557440.30245@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 18 Jul 2006, Peter Zijlstra wrote:
> 
> 
>>>I thought we wanted to just track the number of unmapped clean pages and 
>>>insure that they do not go under a certain limit? That would not require
>>>any locking changes but just a new zoned counter and a check in the dirty
>>>handling path.
>>
>>The problem I see with that is that we cannot create new unmapped clean
>>pages. Where will we get new pages to satisfy our demand when there is
>>nothing mmap'ed.
> 
> 
> Hmmm... I am not sure that we both have this straight yet.
> 
> Adding logic to determine the number of clean pages is not necessary. The 
> number of clean pages in the pagecache can be determined by:
> 
> global_page_state(NR_FILE_PAGES) - global_page_state(NR_FILE_DIRTY) 

It's not that simple. We also need to deal with other types of 
non-freeable pages, such as memlocked.

Someone remind me why we can't remove the memlocked pages from the LRU
again? Apart from needing a refcount of how many times they're memlocked
(or we just shove them back whenever they're unlocked, and let it fall
out again when we walk the list, but that doesn't fix the accounting
problem).
