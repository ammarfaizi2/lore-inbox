Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVFMXUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVFMXUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 19:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVFMXSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 19:18:45 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:17414 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261632AbVFMXRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 19:17:04 -0400
Message-ID: <42AE13EF.8060105@vmware.com>
Date: Mon, 13 Jun 2005 16:17:03 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Duffy <tduffy@sun.com>
Cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>, discuss@x86-64.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [discuss] [OOPS] powernow on smp dual core amd64
References: <84EA05E2CA77634C82730353CBE3A84301CFC14C@SAUSEXMB1.amd.com> <1118701245.9114.23.camel@duffman>
In-Reply-To: <1118701245.9114.23.camel@duffman>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2005 23:17:03.0078 (UTC) FILETIME=[01EA6860:01C5706E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Duffy wrote:

>On Mon, 2005-06-13 at 16:47 -0500, Langsdorf, Mark wrote:
>  
>
>>Okay, I think I have figured this out.  During initialization,
>>the cpufreq infrastruture only initializes the first core of
>>each processor.  When a request comes into the second core,
>>it's data structre is unitialized and we get the null point
>>dereference.
>>
>>The solution is to assign the pointer to the data structure for
>>the first core to all the other cores.
>>
>>Tom, could you try this patch and see if it helps?
>>    
>>
>
>Yes!  It fixed the panic.  I get much further.
>
>Thanks!
>
>Unfortunately, after starting cpuspeed daemon, I get this:
>
>Starting cpuspeed: [  OK  ]
>Starting pcmcia:  Starting PCMCIA services:
>CPU 6: Machine Check Exception:                4 Bank 4: b200000000070f0f
>TSC 4129a3d70d
>Kernel panic - not syncing: Machine check
> <1>Unable to handle kernel NULL pointer dereference at 00000000000000ff RIP:
>[<00000000000000ff>]
>  
>

asmlinkage void smp_call_function_interrupt(void)
{
        void (*func) (void *info) = call_data->func;
        void *info = call_data->info;
        int wait = call_data->wait;

        ack_APIC_irq();
        /*
         * Notify initiating CPU that I've grabbed the data and am
         * about to execute the function
         */
        mb();
        atomic_inc(&call_data->started);
        /*
         * At this point the info structure may be out of scope unless 
wait==1
         */
        irq_enter();
        (*func)(info);  <--- passed bogus data

Looks like you jumped through a bogus function pointer.  I'm guessing it 
has something to do with an unitialized IRQ vector for the CPU speed on 
one of the cores (simply because it seems somewhat plausible):

extern u8 irq_vector[NR_IRQ_VECTORS];
#define IO_APIC_VECTOR(irq)     (irq_vector[irq])
#define AUTO_ASSIGN             -1

So irq_vector[AUTO_ASSIGN] = 0xff which could have somehow made it into 
your function pointer.

Just a theory.
