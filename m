Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWCNPUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWCNPUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWCNPUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:20:46 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:48775 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751321AbWCNPUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:20:46 -0500
Message-ID: <4416DF4A.7040908@watson.ibm.com>
Date: Tue, 14 Mar 2006 10:20:42 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: Patch 2/9] Initialization
References: <1142296834.5858.3.camel@elinux04.optonline.net>	<1142297101.5858.10.camel@elinux04.optonline.net> <yq0slpluwi1.fsf@jaguar.mkp.net>
In-Reply-To: <yq0slpluwi1.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:

>>>>>>"Shailabh" == Shailabh Nagar <nagar@watson.ibm.com> writes:
>>>>>>            
>>>>>>
>
>Shailabh> delayacct-setup.patch Initialization code related to
>Shailabh> collection of per-task "delay" statistics which measure how
>Shailabh> long it had to wait for cpu, sync block io, swapping
>Shailabh> etc. The collection of statistics and the interface are in
>Shailabh> other patches. This patch sets up the data structures and
>Shailabh> allows the statistics collection to be disabled through a
>Shailabh> kernel boot paramater.
>
>Shailabh> +#ifdef CONFIG_TASK_DELAY_ACCT
>Shailabh> +struct task_delay_info {
>Shailabh> +	spinlock_t	lock;
>Shailabh> +
>Shailabh> +	/* For each stat XXX, add following, aligned appropriately
>Shailabh> +	 *
>Shailabh> +	 * struct timespec XXX_start, XXX_end;
>Shailabh> +	 * u64 XXX_delay;
>Shailabh> +	 * u32 XXX_count;
>Shailabh> +	 */
>Shailabh> +};
>Shailabh> +#endif
>
>Hmmm
>
>I thought you were going to change this to do
>
>u64 some_delay
>u32 foo_count
>u32 bar_count
>u64 another_delay
>
>To avoid wasting space on 64 bit platforms.
>  
>

Well, the "aligned appropriately" part of the comment was intended to let
future users know that something like the above should be done.

e.g in a subsequent patch (5/9)
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0603.1/1919.html
when we introduce the additional stat swapin_delay/count, a 64-bit friendly
alignment is being done thus:

u64 blkio_delay; /* wait for sync block io completion */
+ u64 swapin_delay; /* wait for sync block io completion */
u32 blkio_count;
+ u32 swapin_count;

The need for each stat, potentially, to need a separate set of timespec 
variables
to reduce nesting problems does introduce another wrinkle in 
cache-friendliness
since you'd ideally like to have all the XXX_* variables close together. 
Right now
we're good since swapin doesn't need extra timespecs of its own. But future
additions might need to be more careful.

--Shailabh


>Jes
>  
>

