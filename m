Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266110AbUGOGQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266110AbUGOGQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 02:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266117AbUGOGQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 02:16:22 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:54167 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266110AbUGOGQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 02:16:07 -0400
Message-ID: <40F6211F.5060806@yahoo.com.au>
Date: Thu, 15 Jul 2004 16:15:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: PPC64 External List <linuxppc64-dev@lists.linuxppc.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Oops in find_busiest_group(): 2.6.8-rc1-mm1
References: <1089871489.10000.388.camel@nighthawk>
In-Reply-To: <1089871489.10000.388.camel@nighthawk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> Looks like 'find_busiest_group()::this' is null:
> 
> cpu 0x1: Vector: 380 (Data SLB Access) at [c0000002ffe0b420]
>     pc: c000000000046644: .find_busiest_group+0x24c/0x470
>     lr: c00000000004681c: .find_busiest_group+0x424/0x470
>     sp: c0000002ffe0b6a0
>    msr: 8000000000001032
>    dar: 10
>   current = 0xc0000002fff70da0
>   paca    = 0xc00000000033c900
>     pid   = 0, comm = swapper
> ...
> 1:mon> r
> R00 = 0000000000000080   R16 = 0000000000000080
> R01 = c0000002ffe0b6a0   R17 = 0000000000000080
> R02 = c0000000004a5470   R18 = 0000000000000080
> R03 = 0000000000000046   R19 = c00000000adfb408
> R04 = c00000000050dd27   R20 = 0000000000000001
> R05 = c00000000052dd50   R21 = 0000000000000000
> R06 = c0000000003b7828   R22 = 0000000000000000
> R07 = fffffffffffe0cb8   R23 = c0000002ffe0b710
> R08 = c00000000050d180   R24 = c0000000004a2008
> R09 = c00000000050d918   R25 = c000000000330c38
> R10 = 0000000000000000   R26 = c000000000330c38
> R11 = 0000000000000001   R27 = 0000000000000001
> R12 = 0000000000000010   R28 = c00000000050d198
> R13 = c00000000033c900   R29 = 0000000000000080
> R14 = 0000000000000000   R30 = c0000000003c29e8
> R15 = c000000000330c38   R31 = c0000002ffe0b6a0
> pc  = c000000000046644 .find_busiest_group+0x24c/0x470
> lr  = c00000000004681c .find_busiest_group+0x424/0x470
> msr = 8000000000001032   cr  = 88428428
> ctr = c0000000001527a8   xer = 0000000000000000   trap =      380
> 
> I put a little printk in:
> 
>         /* How much load to actually move to equalise the imbalance */
>         if (!busiest || !this)
>                 printk("%s() busiest: %p this: %p\n", __func__, busiest, this);
>         *imbalance = (*imbalance * min(busiest->cpu_power, this->cpu_power))
>                                 / SCHED_LOAD_SCALE;
> 
> And sure enough, this showed up on the console:
> 
> find_busiest_group() busiest: c00000000050d180 this: 0000000000000000
> 

OK, it is overdue for a bit of an audit anyway, so I'll see if I can
see what is going wrong.

> This code also looks funny to begin with:
> 
> 
>>                if (local_group) {
>>                        this_load = avg_load;
>>                        this = group;
>>                        goto nextgroup;
>>                } else if (avg_load > max_load) {
>>                        max_load = avg_load;
>>                        busiest = group;
>>                }
>>nextgroup:
>>                group = group->next;
>>        } while (group != sd->groups);
> 
> 
> Why bother with the 'goto nextgroup;'?  Shouldn't the first if block
> just fall through to the target of the goto anyway?
> 

It was there for a good reason once... obviously no point to it now.
Thanks for the report.
