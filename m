Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263167AbSJHBGc>; Mon, 7 Oct 2002 21:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263168AbSJHBGb>; Mon, 7 Oct 2002 21:06:31 -0400
Received: from h-66-167-78-146.SNVACAID.covad.net ([66.167.78.146]:23168 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263167AbSJHBGa>; Mon, 7 Oct 2002 21:06:30 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 7 Oct 2002 18:12:01 -0700
Message-Id: <200210080112.SAA01553@adam.yggdrasil.com>
To: tmolina@cox.net
Subject: Re: linux-2.5.40 64GB highmem BUG()
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-10-08 0:48:32, Thomas Molina wrote:
>On Mon, 7 Oct 2002, Adam J. Richter wrote:
>
>>       Although 2.5.40 has been out for a while, I think I ought
>> to post this bug as I haven't seen any other mention of it.
>> 
>>       When I boot an 2.5.40 x86 kernel built with CONFIG_HIGHMEM64G,
>> and with a 920kB initial ramdisk (2.2MB uncompressed), I get a kernel
>> BUG() at highmem.c line 480, preceded by a message saying "scheduling
>> with KM_TYPE 15 held!"  The machine on which I experienced this
>> problem has 1.25GB of RAM.  The problem occurs with and without
>> CONFIG_PREEMPT.  All kernels that tried were SMP kernels running on a
>> uniprocessor.
>> 
>>       The problem does not occur if I build 2.5.40 with
>> CONFIG_HIGHMEM4G or CONFIG_NOHIGMEM.  So, it's probably not causing
>> problems for many people, but I thought I should report it anyhow.
>
>Does the accompanying trace output say BUG(), or is there a might_sleep() 
>in the trace output?  In other words, is it a scheduling while holding a 
>lock kind of thing?

	It is the BUG() statement in check_highmem_ptes in mm/highmem.c:

#if CONFIG_DEBUG_HIGHMEM
void check_highmem_ptes(void)
{
        int idx, type;

        preempt_disable();
        for (type = 0; type < KM_TYPE_NR; type++) {
                idx = type + KM_TYPE_NR*smp_processor_id();
                if (!pte_none(*(kmap_pte-idx))) {
                        printk("scheduling with KM_TYPE %d held!\n", type);
                        BUG();
                }
        }
        preempt_enable();
}
#endif

	I'm updating to 2.5.41 and will post a trace if the problem
still occurs.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
