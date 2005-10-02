Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVJBDIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVJBDIg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 23:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVJBDIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 23:08:36 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:21619 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750950AbVJBDIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 23:08:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=s/OuuSxJZlM1Xs04CrWgCNqUtpsNGEdNMGXYpOts8tlb9dOqx3edpqWz4ULCGf9+I4rF7/LP/C1hbEqiOH2LH/DoxZZGuxWYijkk+SN0a0nOyHF9b2sTfvG8MvlPBaEsF6Tx53efiOAKCqmVsF4FD2H8re81Iz8PRc3BbJOf9Cs=  ;
Message-ID: <433F4F67.4090800@yahoo.com.au>
Date: Sun, 02 Oct 2005 13:09:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Seth, Rohit" <rohit.seth@intel.com>
CC: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Clean up of __alloc_pages
References: <20051001120023.A10250@unix-os.sc.intel.com>
In-Reply-To: <20051001120023.A10250@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth, Rohit wrote:
> 	[PATCH]: Below is the cleaning up of __alloc_pages code.  Few 
> 		 things different from original version are
> 
> 	1: remove the initial direct reclaim logic 
> 	2: order zero pages are now first looked into pcp list upfront
> 	3: GFP_HIGH pages are allowed to go little below low watermark sooner
> 	4: Search for free pages unconditionally after direct reclaim
> 
> 	Signed-off-by: Rohit Seth <rohit.seth@intel.com>
> 

Hi,

Seems pretty good at a quick glance.

Perhaps splitting it into 2 would be a good idea - ie. first
patch does the cleanup, second does the direct pcp list alloc.

Regarding the direct pcp list allocation - I think it is a good
idea, because we're currently already accounting pcp list pages
as being 'allocated' for the purposes of the reclaim watermarks.

Also, the structure is there to avoid touching cachelines whenever
possible so it makes sense to use it early here. Do you have any
performance numbers or allocation statistics (e.g. %pcp hits) to
show?

Also, I would really think about uninlining get_page_from_freelist,
and inlining buffered_rmqueue, so that the constant 'replenish'
argument can be propogated into buffered_rmqueue and should allow
for some nice optimisations. While not bloating the code too much
because your get_page_from_freelist becomes out of line.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
