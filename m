Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUEEDQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUEEDQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 23:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUEEDQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 23:16:40 -0400
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:32856 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261631AbUEEDQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 23:16:37 -0400
Message-ID: <40985C91.9080809@yahoo.com.au>
Date: Wed, 05 May 2004 13:16:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: sgoel01@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [VM PATCH 2.6.6-rc3-bk5] Dirty balancing in the presence of mapped
 pages
References: <20040505002029.11785.qmail@web12821.mail.yahoo.com>	<20040504180345.099926ec.akpm@osdl.org>	<40984E89.6070501@yahoo.com.au> <20040504195753.0a9e4a54.akpm@osdl.org>
In-Reply-To: <20040504195753.0a9e4a54.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Andrew Morton wrote:
>>
>>>Shantanu Goel <sgoel01@yahoo.com> wrote:
>>>
>>>
>>>>Presently the kernel does not collection information
>>>>about the percentage of memory that processes have
>>>>dirtied via mmap until reclamation.  Nothing analogous
>>>>to balance_dirty_pages() is being done for mmap'ed
>>>>pages.  The attached patch adds collection of dirty
>>>>page information during kswapd() scans and initiation
>>>>of background writeback by waking up bdflush.
>>>
>>>
>>>And what were the effects of this patch?
>>>
>>
>>I havea modified patch from Nikita that does the
>>if (ptep_test_and_clear_dirty) set_page_dirty from
>>page_referenced, under the page_table_lock.
> 
> 
> Dude.  I have lots of patches too.  The question is: what use are they?
> 
> In this case, given that we have an actively mapped MAP_SHARED pagecache
> page, marking it dirty will cause it to be written by pdflush.  Even though
> we're not about to reclaim it, and even though the process which is mapping
> the page may well modify it again.  This patch will cause additional I/O.
> 
> So we need to understand why it was written, and what effects were
> observed, with what workload, and all that good stuff.
> 

I guess it is an attempt to do somewhat better at dirty page accounting
for mmap'ed pages. The balance_dirty_pages_ratelimited writeout path
also has the same problem as you describe. Maybe usage patterns means
this is less of an issue here?

But I suppose it wouldn't be nice to change without seeing some
improvement somewhere.

> 
>>It doesn't do the wakeup_bdflush thing, but that sounds
>>like a good idea. What does wakeup_bdflush(-1) mean?
> 
> 
> It appears that it will cause pdflush to write out down to
> dirty_background_ratio.
> 

Yeah. So wakeup_bdflush(0) would be more consistent?
