Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLLHWl>; Tue, 12 Dec 2000 02:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQLLHWc>; Tue, 12 Dec 2000 02:22:32 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:51893 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129226AbQLLHW0>; Tue, 12 Dec 2000 02:22:26 -0500
From: Heiko.Carstens@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Message-ID: <C12569B3.0024DA06.00@d12mta01.de.ibm.com>
Date: Tue, 12 Dec 2000 07:42:29 +0100
Subject: Re: CPU attachent and detachment in a running Linux system
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





>> sigp. To synchronize n CPUs one can create n kernel threads and give
>> them a high priority to make sure they will be executed soon (e.g. by
>> setting p->policy to SCHED_RR and p->rt_priority to a very high
>> value). As soon as all CPUs are in synchronized state (with
>> interrupts disabled) the new CPU can be started. But before this can
>> be done there are some other things left to do:
>
>You dont IMHO need to use such a large hammer. We already do similar
sequences
>for tlb invalidation on X86 for example. You can broadcast an
interprocessor
>interrupt and have the other processors set a flag each. You spin until
they
>are all captured, then when you clear the flag they all continue. You just
>need to watch two processors doing it at the same time 8)

Alan,

thanks for your input but I think it won't work this way because the value
of smp_num_cpus needs to be increased by one right before a new cpu gets
started. Then one can imagine the following situation at one of the cpus
that needs to be captured:

read the value of smp_num_cpus;
- interrupt that is intended to capture this cpu -
the value of smp_num_cpus will be increased and the new cpu will be started
by another cpu before this cpu continues with normal operation;
- end of interrupt handling -
do something that relies on the prior read value of smp_num_cpus (which is
now wrong);

The result would be an inconsistency. This problem should not occur if all
cpus would be captured by kernel threads.

I still wonder what you and other people think about the idea of an
interface where the parts of the kernel with per-cpu dependencies should
register two functions...

Best regards,
Heiko

By the way, I changed the subject of your original reply because I sent my
first mail twice (with and without a subject line).
I'm sorry for my own stupidity :)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
