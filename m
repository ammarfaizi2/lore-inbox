Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932962AbWJIQZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962AbWJIQZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 12:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbWJIQZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 12:25:05 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:47196 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932962AbWJIQZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 12:25:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wOlg7LlFgiIAI+glTo3gGLM9JG3IHyFymwf+whcdUJS5hcMzDRkGFKSriVmH2I2Ps/JHrDxmXLNFUCNUj0PLeN1FGAQbw9irHF59KBsNWiVG1bQBFeb+KBKWrHGqvSVbUSCpnNO2Mir1GYWMzOHZGg5YcJ3tMj6+c40ZjDsTFOM=  ;
Message-ID: <452A77ED.6070001@yahoo.com.au>
Date: Tue, 10 Oct 2006 02:25:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Try to avoid a pessimistic vmalloc() recursion
References: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz> <20061006230609.c04e78bc.akpm@osdl.org> <200610091647.55184.dada1@cosmosbay.com>
In-Reply-To: <200610091647.55184.dada1@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> __vmalloc_area_node() is a litle bit pessimist when allocating space for 
> storing struct page pointers.
> 
> When allocating more than 4 MB on ia32, or 2 MB on x86_64,  
> __vmalloc_area_node() has to allocate more than PAGE_SIZE bytes to store 
> pointers to  page structs. This means that two TLB translations are needed to 
> access data.
> 
> This patch tries a kmalloc() call, then only if this first attempt failed, a 
> vmalloc() is performed. (Later, at vfree() time we chose kfree() or vfree() 
> with a test on flags & VM_VPAGES : no change is needed) 
> 
> Most of the time, the first kmalloc() should be OK, so we reduce TLB usage.

But this is only TLB usage when managing (read: freeing) the vmalloc pages,
isn't it? Not when actually accessing the data.

I'd be inclined to NACK this, unless you can show an improvement somewhere:
it is suboptimal to even _try_ allocating higher order pages.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
