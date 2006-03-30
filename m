Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWC3PV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWC3PV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWC3PV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:21:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:13293 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750811AbWC3PV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:21:27 -0500
Message-ID: <442BF774.3010300@watson.ibm.com>
Date: Thu, 30 Mar 2006 10:21:24 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/8] Block I/O, swapin delays
References: <442B271D.10208@watson.ibm.com>	<442B2836.2020708@watson.ibm.com> <20060329210340.570d63e5.akpm@osdl.org>
In-Reply-To: <20060329210340.570d63e5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>  
>
>>delayacct-blkio-swapin.patch
>>
>>Collect per-task block I/O delay statistics.
>>
>>Unlike earlier iterations of the delay accounting
>>patches, now delays are only collected for the actual
>>I/O waits rather than try and cover the delays seen in
>>I/O submission paths.
>>
>>Account separately for block I/O delays
>>incurred as a result of swapin page faults whose
>>frequency can be affected by the task/process' rss limit.
>>Hence swapin delays can act as feedback for rss limit changes
>>independent of I/O priority changes.
>>
>>..
>>
>>+#define PF_SWAPIN	0x02000000	/* I am doing a swap in */
>>
>>    
>>
>
>Is there really no sane alternative to doing it this way?
>  
>

I'm not sure there is. This goes back to what is really being measured 
as "block I/O delay".

Earlier iterations of the code tried to measure total block I/O delay 
including I/O submission
and the wait for completion:
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0602.3/0905.html
In that design, the swapin delay was being measured as time spent in the 
do_swap_page
function:
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0602.3/0906.html

However, Arjan pointed out the difficulties in trying to account for all 
I/O submission paths
so we reverted to measuring just the block I/O wait time within 
io_schedule/io_schedule_timeout.

Since these functions will be called as a result of do_swap_page, the 
only way to distinguish a
block I/O being done for a swapin vs. others was to mark the task struct 
in some way and
task->flags seemed like a convenient way to do it.

We could easily introduce and use a separate flag variable in the delay 
accounting structure itself if
using up another bit of task->flags is a concern ?

Or do you have doubts about the methodology of using a flag itself ? 
Don't see any other lightweight
way of doing this.

--Shailabh


