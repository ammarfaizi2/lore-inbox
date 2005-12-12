Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVLLJXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVLLJXS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 04:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVLLJXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 04:23:18 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:38250 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751144AbVLLJXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 04:23:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DSvGDl9NrjBoipczXNKDslv9y7XacNmoufd7UibBK4M/HpHC332sp4RlduWGFL9U24mHz72mthzLeuYRF34O7mdirF1rWrsH7YcGx1XN1FtzdqKUne49ErpPZk1ie1F2Fh5MbhAP8oMCEzvTWFQczFHDQiJaBisP0vpx9H7eAqc=  ;
Message-ID: <439D417E.903@yahoo.com.au>
Date: Mon, 12 Dec 2005 20:23:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
CC: Hugh Dickins <hugh@veritas.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
References: <439D3592.70100@yahoo.com.au> <20051212085532.GW14936@mellanox.co.il>
In-Reply-To: <20051212085532.GW14936@mellanox.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin wrote:

> 
> FWIW, I think that copy_to_user will work correctly since it keeps the mmap
> semaphore for the duration of the copy.

Oh, true.

> Direct-io might have the same problem.
> 
> 
>>As such, I don't think it would be something you in particular need to
>>worry about.
>>
>>I guess to solve it, we could either retain mmap_sem for the duration to
>>prevent fork,
> 
> 
> Since this is the receive side, the DMA can take an indefinite
> time to arrive. Isnt this a problem if we keep the mmap_sem?
> 

Well... it goes against our usual stance of trying to push
these kinds of synchronisation issues to userspace.

In a way, you're doing direct-io from the network and so it is
perhaps reasonable to expect the racy semantics that O_DIRECT
has. OTOH, if you are providing the same API on a different
device, then basically by definition you need to provide the
exact same semantics.

> 
>>or try to do something tricky with page_count to determine
>>if we need to do a copy in fork() rather than a COW.
> 
> 
> I'm actually reasonably happy with the trick that I'm using:
> performing a second get_user_pages after DMA and comparing
> the page lists.
> However, doing this every time on the off chance that a
> page was made COW forces me into task context, every time.
> 

I think it might be possible to solve it with the early-copy in
fork(). I'll tinker with it.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
