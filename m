Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751740AbWCOLTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbWCOLTO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 06:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWCOLTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 06:19:14 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:47741 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751691AbWCOLTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 06:19:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=bY+fmAkN2Hb49zOb20RoGnF1papmYD8ZttrhA24VL/OLwyAboWcfjGbvmuDeeiFYbuwv3R/xp6ePWAqfHw83YunVOJzGGv+m7Ubji/w/YcavfFDLaaam1fKj6bYdQoibMtxGjpIIEcegHaDwxNYEJKXUldHIiQJm16UFLH2q3J4=  ;
Message-ID: <4417F828.1070605@yahoo.com.au>
Date: Wed, 15 Mar 2006 22:19:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1: 28ms latency when process with lots of swapped memory
 exits
References: <1142352926.13256.117.camel@mindpipe>  <Pine.LNX.4.61.0603141812400.5882@goblin.wat.veritas.com>  <20060314210142.GA23458@elte.hu> <1142375939.24603.33.camel@mindpipe> <Pine.LNX.4.61.0603150721040.9086@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0603150721040.9086@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> Oh, thank you for forcing me to take another look, 2.6.15 did make a
> regression there, and this one is very simply remedied: Lee, please
> try the patch below (I've done it against 2.6.16-rc6 because that's
> what I have to hand; and would be a better tree for you to test),
> and let us know if it fixes your case as I expect - thanks.
> 
> (Robin Holt observed how inefficient the small ZAP_BLOCK_SIZE was on
> very sparse mmaps, as originally implemented; so he and Nick reworked
> it to count only real work done; but the swap entries got put on the
> side of "no real work", whereas you've found they may involve very
> significant work.  My patch below reverses that: yes, I've got some
> other cases now going the slow way when they needn't, but they're
> too rare to clutter the code for.)
> 

I think this patch looks good, thanks Hugh.

> Hugh
> 
> --- 2.6.16-rc6/mm/memory.c	2006-03-12 15:25:45.000000000 +0000
> +++ linux/mm/memory.c	2006-03-15 07:32:36.000000000 +0000
> @@ -623,11 +623,12 @@ static unsigned long zap_pte_range(struc
>  			(*zap_work)--;
>  			continue;
>  		}
> +
> +		(*zap_work) -= PAGE_SIZE;
> +
>  		if (pte_present(ptent)) {
>  			struct page *page;
>  
> -			(*zap_work) -= PAGE_SIZE;
> -
>  			page = vm_normal_page(vma, addr, ptent);
>  			if (unlikely(details) && page) {
>  				/*
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
