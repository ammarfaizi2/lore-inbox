Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVFNQio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFNQio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 12:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVFNQio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 12:38:44 -0400
Received: from mail00hq.adic.com ([63.81.117.10]:35636 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261240AbVFNQii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 12:38:38 -0400
Message-ID: <42AF080A.1000307@xfs.org>
Date: Tue, 14 Jun 2005 11:38:34 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "K.R. Foley" <kr@cybsft.com>, pozsy@uhulinux.hu,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org>	<20050610112515.691dcb6e.akpm@osdl.org>	<20050611082642.GB17639@ojjektum.uhulinux.hu>	<42AAE5C8.9060609@xfs.org>	<20050611150525.GI17639@ojjektum.uhulinux.hu>	<42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org> <42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com>
In-Reply-To: <42AEF979.2000207@cybsft.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Jun 2005 16:38:36.0853 (UTC) FILETIME=[831BB650:01C570FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

K.R. Foley wrote:
> Steve Lord wrote:
> 
>> Andrew Morton wrote:
>>
>>> Stephen Lord <lord@xfs.org> wrote:
>>>
>>>> Pozsár Balázs wrote:
>>>> > On Sat, Jun 11, 2005 at 08:23:20AM -0500, Steve Lord wrote:
>>>> > >>I think this is not actually module loading itself, but a problem
>>>> >>between the fork/exec/wait code in nash and the kernel.
>>>> > > > I do not use nash, only bash, so this is not a nash-specific 
>>>> issue.
>>>> > >
>>>> I disabled hyperthreading and things started working, so are there any
>>>> HT related scheduling bugs right now?
>>>
>>>
>>>
>>>
>>> There haven't been any scheduler changes for some time.  There have 
>>> been a
>>> few low-level SMT changes I think.
>>>
>>> Are you able to identify which kernel version broke it?
>>>
>>
>> Still have not narrowed this down too far, disabling SMT made no
>> difference, disabling SMP did, which I was expecting.
>>
>> Steve
>>
> 
> I initially saw this with 2.6.12-rc1 and every version up through rc3. I
> haven't tried with later versions. :-/ I initially reported here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111235814529008&w=2
> 
> The way that I got around it was to compile in my aic7xxx driver instead
> of making it a module. I have also recently received an email from
> someone saying that disabling module unloading would also solve it. That
> very well may be true since I did run into another booting problem
> (2.6.12-rc5) that disabling module unloading fixed :-/ I haven't had a
> chance to go back and check this out though.
> 
> So to summarize: I have a dual 933 with aic7xxx compiled in to get
> passed the problem described above. I have a dual 2.6 w/HT that I have
> disabled module unloading to get passed another boot condition.
> 
> 

I found another system which exhibits the problem, a dual Xeon
with HT support.

Here is one of the cpus from /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Xeon(TM) CPU 1.40GHz
stepping        : 1
cpu MHz         : 1393.851
cache size      : 256 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2752.51

I discovered that if I disable P4 support on this host and run with
P3 Xeon support instead, things start working. The host type in the
boot up is identified as a P4/Xeon:

Jun 14 11:25:19 k4 kernel: Booting processor 2/2 eip 3000
Jun 14 11:25:19 k4 kernel: CPU 2 irqstacks, hard=c03e7000 soft=c03df000
Jun 14 11:25:19 k4 kernel: Initializing CPU#2
Jun 14 11:25:19 k4 kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Jun 14 11:25:19 k4 kernel: CPU: L2 cache: 256K
Jun 14 11:25:19 k4 kernel: CPU: L3 cache: 512K
Jun 14 11:25:19 k4 kernel: CPU: Physical Processor ID: 1
Jun 14 11:25:19 k4 kernel: Intel machine check architecture supported.
Jun 14 11:25:19 k4 kernel: Intel machine check reporting enabled on CPU#2.
Jun 14 11:25:19 k4 kernel: CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
Jun 14 11:25:19 k4 kernel: CPU2: Intel(R) Xeon(TM) CPU 1.40GHz stepping 01

So is this some P4 specific optimization which is not working as
intended?

Steve

