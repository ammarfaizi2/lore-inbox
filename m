Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUD0GKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUD0GKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263797AbUD0GKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:10:54 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:427 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263795AbUD0GKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:10:51 -0400
Message-ID: <408DF968.70500@yahoo.com.au>
Date: Tue, 27 Apr 2004 16:10:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, sgoel01@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page writeback
References: <20040427011237.33342.qmail@web12824.mail.yahoo.com>	<20040426191512.69485c42.akpm@osdl.org>	<1083035471.3710.65.camel@lade.trondhjem.org> <20040426205928.58d76dbc.akpm@osdl.org>
In-Reply-To: <20040426205928.58d76dbc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> 
>>On Mon, 2004-04-26 at 22:15, Andrew Morton wrote:
>>
>>>WRITEPAGE_ACTIVATE is a bit of a hack to fix up specific peculiarities of
>>>the interaction between tmpfs and page reclaim.
>>>
>>>Trond, the changelog for that patch does not explain what is going on in
>>>there - can you help out?
>>
>>As far as I understand, the WRITEPAGE_ACTIVATE hack is supposed to allow
>>filesystems to defer actually starting the I/O until the call to
>>->writepages(). This is indeed beneficial to NFS, since most servers
>>will work more efficiently if we cluster NFS write requests into "wsize"
>>sized chunks.
> 
> 
> No, it's purely used by tmpfs when we discover the page was under mlock or
> we've run out of swapspace.
> 
> Yes, single-page writepage off the LRU is inefficient and we want
> writepages() to do most of the work.  For most workloads, this is the case.
> It's only the whacky mmap-based test which should encounter significant
> amounts of vmscan.c writepage activity.

Nikita has a patch to gather a page's dirty bits before
taking it off the active list. It might help here a bit.
Looks like it would need porting to the new rmap stuff.

>  If you're seeing much traffic via
> that route I'd be interested in knowing what the workload is.
> 
> There's one scenario in which we _do_ do too much writepage off the LRU,
> and that's on 1G ia32 highmem boxes: the tiny highmem zone is smaller than
> dirty_ratio and vmscan ends up doing work which balance_dirty_pages()
> should have done.  Hard to fix, apart from reducing the dirty memory
> limits.
> 

You might be able to improve this by not allocating the
highmem zone right down to its scanning watermark while
zone normal has lots of free memory.
