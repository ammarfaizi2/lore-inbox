Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752181AbWIHEeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbWIHEeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 00:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbWIHEd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 00:33:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:17574 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752174AbWIHEd4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 00:33:56 -0400
Message-ID: <4500F2B2.4010204@us.ibm.com>
Date: Thu, 07 Sep 2006 21:33:54 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       sct@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
References: <20060901101801.7845bca2.akpm@osdl.org> <1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com> <20060906124719.GA11868@atrey.karlin.mff.cuni.cz> <1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com> <20060906153449.GC18281@atrey.karlin.mff.cuni.cz> <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com> <20060906162723.GA14345@atrey.karlin.mff.cuni.cz> <1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com> <20060906172733.GC14345@atrey.karlin.mff.cuni.cz> <1157641877.7725.13.camel@dyn9047017100.beaverton.ibm.com> <20060907223048.GD22549@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060907223048.GD22549@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:
>>>   Ugh! Are you sure? For this path the buffer must be attached (only) to
>>> the running transaction. But then how the commit code comes to it?
>>> Somebody would have to even manage to refile the buffer from the
>>> committing transaction to the running one while the buffer is in wbuf[].
>>> Could you check whether someone does __journal_refile_buffer() on your
>>> marked buffers, please? Or whether we move buffer to BJ_Locked list in
>>> the write_out_data: loop? Thanks.
>>>
>>> 							
>>>       
>> I added more debug in __journal_refile_buffer() to see if the marked
>> buffers are getting refiled. I am able to reproduce the problem,
>> but I don't see any debug including my original prints. (It looks as 
>> if none of my debug code exists) - its really confusing. 
>>
>> I will keep looking and get back to you.
>>     
>   I've been looking more at the code and I have revived my patch fixing
> this part of the code. I've mildly tested the patch. Could you also give
> it a try? Thanks.
>
> 								Honza
>   
> ------------------------------------------------------------------------
>
> Original commit code assumes, that when a buffer on BJ_SyncData list is locked,
> it is being written to disk. But this is not true and hence it can lead to a
> potential data loss on crash. Also the code didn't count with the fact that
> journal_dirty_data() can steal buffers from committing transaction and hence
> could write buffers that no longer belong to the committing transaction.
> Finally it could possibly happen that we tried writing out one buffer several
> times.
>
> The patch below tries to solve these problems by a complete rewrite of the data
> commit code. We go through buffers on t_sync_datalist, lock buffers needing
> write out and store them in an array. Buffers are also immediately refiled to
> BJ_Locked list or unfiled (if the write out is completed). When the array is
> full or we have to block on buffer lock, we submit all accumulated buffers for
> IO.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
>
>   
I have been running 4+ hours with this patch and seems to work fine. I 
haven't hit any
assert yet :)

I will let it run till tomorrow. I will let you know, how it goes.

Thanks,
Badari

