Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUDCAHD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 19:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUDCAHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 19:07:03 -0500
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:18007 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261437AbUDCAG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 19:06:57 -0500
Message-ID: <406DFABD.8070400@yahoo.com.au>
Date: Sat, 03 Apr 2004 09:43:57 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: markw@osdl.org, linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.5-rc3-mm4
References: <20040401020512.0db54102.akpm@osdl.org>	<200404021904.i32J4M215682@mail.osdl.org> <20040402115601.24912093.akpm@osdl.org>
In-Reply-To: <20040402115601.24912093.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> markw@osdl.org wrote:
> 
>>I reran DBT-2 to with ext2 and ext3 (in case you were still interested)
>> on my 4-way Xeon system with 60+ drives:
>> 	http://developer.osdl.org/markw/fs/dbt2_project_results.html
>>
>> Aside from the from the drop you're already aware of since 2.6.3, it
>> looks like DBT-2 takes another smaller hit after 2.6.5-rc3-mm2.  Here's
>> a brief summary from the link above:
> 
> 
> The profile is interesting:
> 
> 3671973 poll_idle                                63309.8793
>  77750 __copy_from_user_ll                      637.2951
>  64788 generic_unplug_device                    487.1278
>  62968 DAC960_LP_InterruptHandler               336.7273
>  53908 finish_task_switch                       361.7987
>  52947 __copy_to_user_ll                        441.2250
>  29419 dm_table_unplug_all                      439.0896
>  25947 __make_request                            17.9938
>  18564 dm_table_any_congested                   199.6129
>  13785 update_queue                             104.4318
>  13498 try_to_wake_up                            20.3590
>  12736 __wake_up                                114.7387
>  12560 kmem_cache_alloc                         163.1169
>  12221 .text.lock.sched                          40.7367
> 
> - There's a ton of idle time there.
> 
> - The CPU scheduler is hurting.  Nick and Ingo are patching up a storm to
>   fix a similar problem which Jeremy Higdon is observing at 200,000
>   IOs/sec.  This will get better.

Versus this for 2.6.3:

12825181 poll_idle                                221123.8103
219606 schedule                                 126.7201
194233 __copy_from_user_ll                      1541.5317
191707 __copy_to_user_ll                        1597.5583
149704 DAC960_LP_InterruptHandler               800.5561
120972 generic_unplug_device                    822.9388
  87891 __make_request                            60.9931
  49207 try_to_wake_up                            74.5561
  42647 do_anonymous_page                         65.5100

Which looks like it is taking a lot longer (is it the same test?)
It is difficult to tell how idle each one is due to lack of total
ticks reported, but, copy_to/from_user is 3% the amount of idle
time in 2.6.3, while being 3.5% the amount of idle time in your
profile.

So 2.6.3 could be relatively more idle than -mm.

Do we know what the 2.6.3 regression is caused by? Or is it
likely to be the CPU scheduler?
