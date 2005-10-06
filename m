Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVJFNO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVJFNO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVJFNO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:14:57 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:29458 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750889AbVJFNO4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:14:56 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <434520FF.8050100@sw.ru>
References: <434520FF.8050100@sw.ru>
X-OriginalArrivalTime: 06 Oct 2005 13:14:50.0501 (UTC) FILETIME=[EEB9F350:01C5CA77]
Content-class: urn:content-classes:message
Subject: Re: SMP syncronization on AMD processors (broken?)
Date: Thu, 6 Oct 2005 09:14:50 -0400
Message-ID: <Pine.LNX.4.61.0510060910350.10893@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SMP syncronization on AMD processors (broken?)
Thread-Index: AcXKd+7D53qYsZ23ThOFlePQgZGjiQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Kirill Korotaev" <dev@sw.ru>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, <xemul@sw.ru>,
       "Andrey Savochkin" <saw@sawoct.com>, <st@sw.ru>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Oct 2005, Kirill Korotaev wrote:

> Hello Linus, Andrew and others,
>
> Please help with a not simple question about spin_lock/spin_unlock on
> SMP archs. The question is whether concurrent spin_lock()'s should
> acquire it in more or less "fair" fashinon or one of CPUs can starve any
> arbitrary time while others do reacquire it in a loop.
>
> The question raised because the situation we observe on AMD processors
> is really strange and makes us believe that something is wrong in
> kerne/in processor or our minds. Below goes an explanation:
>
> The whole story started when we wrote the following code:
>
> void XXX(void)
> {
> 	/* ints disabled */
> restart:
> 	spin_lock(&lock);
> 	do_something();
> 	if (!flag)
> 		need_restart = 1;
> 	spin_unlock(&lock);
> 	if (need_restart)
> 		goto restart;	<<<< LOOPS 4EVER ON AMD!!!
> }
>
> void YYY(void)
> {
> 	spin_lock(&lock);	<<<< SPINS 4EVER ON AMD!!!
> 	flag = 1;
> 	spin_unlock(&lock);
> }
>
> function XXX() starts on CPU0 and begins to loop since flag is not set,
> then CPU1 calls function YYY() and it turns out that it can't take the
> lock any arbitrary time.
>
> Other observations:
> - This does not happen on Intel processors, more over on Intel 2 CPUs
> take locks in a fair manner, exactly one by one!
> - If do_something() = usleep(3) we observed that XXX() loops forever,
> while YYY spins 4EVER on the same lock...
> - cpu_relax() doesn't help after spin_unlock()...
> - wbinvd() after spin_unlock() helpes and 2 CPUs began to take the lock
> in a fair manner.
>
> How can this happen? Is it regulated somehow by SMP specifications?
>

Are your flags atomic_t types manipulated correctly with
the proper primatives or are you just setting globals?

> - wbinvd() after spin_unlock() helpes and 2 CPUs began to take the lock
     ^^^^^^^^^_________ This is the hint that your flags are not
doing what you expect, i.e., a change not seen by another CPU.


> Kirill
> P.S. Below is provided /proc/cpuinfo of machines affected.
>
> -----------------------------------------------------------------------------
>
> [root@ts25 ~]# cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 35
> model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
> stepping        : 2
> cpu MHz         : 2010.433
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext lm
> 3dnowext 3dnow pni
> bogomips        : 3981.31
>
> processor       : 1
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 35
> model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
> stepping        : 2
> cpu MHz         : 2010.433
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext lm
> 3dnowext 3dnow pni
> bogomips        : 3964.92
>
> -----------------------------------------------------------------------------
>
> [root@opteron root]# cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 5
> model name      : AMD Opteron(tm) Processor 246
> stepping        : 10
> cpu MHz         : 1992.595
> cache size      : 1024 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
> 3dnowext 3dnow
> bogomips        : 3915.77
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
