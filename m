Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267895AbUHPTUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267895AbUHPTUE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267896AbUHPTUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:20:04 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:14764 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267895AbUHPTT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:19:58 -0400
Message-ID: <412108E0.4090300@namesys.com>
Date: Mon, 16 Aug 2004 12:20:00 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Thomas Charbonnel <thomas@undata.org>, Lee Revell <rlrevell@joe-job.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P1
References: <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net> <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net> <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
In-Reply-To: <20040816113131.GA30527@elte.hu>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Thomas Charbonnel <thomas@undata.org> wrote:
>
>  
>
>>Tested P1. The biggest offender on my system is still reiserfs'
>>search_by_key. The trace is made of a very long loop of :
>> 0.016ms (+0.000ms): reiserfs_in_journal (scan_bitmap_block)
>> 0.016ms (+0.000ms): find_next_zero_bit (scan_bitmap_block)
>>(...)
>> 0.977ms (+0.000ms): reiserfs_in_journal (scan_bitmap_block)
>> 0.977ms (+0.000ms): find_next_zero_bit (scan_bitmap_block)
>>with interrupts showing up in the trace from time to time. Do you have
>>plans to fix this, or should I switch to ext3 ?
>>    
>>
>
>i took a quick look and the reiserfs locking rules in that place do not
>seem to be easily fixable - this is the tree-lookup code which i suspect
>cannot be preempted. The reiser journalling code also makes use of the
>big kernel lock. I'd suggest reporting this to the reiserfs folks
>
the fix to reiserfs doing single threaded balancing/searching is called 
reiser4;-)  It was not a trivial fix.  It is however released.

> and
>(if it's not too much effort to migrate) use ext3 meanwhile.
>
>  
>
>>but the weird thing is that the latency sum goes way above those 100us,
>>the culprit being do_IRQ, regularly chewing up to 1ms !
>>    
>>
>
>  
>
>> 0.011ms (+0.000ms): enable_8259A_irq (startup_8259A_irq)
>> 0.954ms (+0.943ms): do_IRQ (common_interrupt)
>>    
>>
>
>weird. This has the looks of a preempt-timing bug (we get a timer IRQ
>every 1 msec) - but there should be no preempt-timing when we are in the
>idle task (swapper).
>
>  
>
>>http://www.undata.org/~thomas/swapper.trace
>>    
>>
>
>i'll upload -P2 in a couple of minutes, it will trace the code that
>do_IRQ() interrupted too - that would be quite useful in your case.
>
>	Ingo
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

