Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWA0KMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWA0KMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWA0KMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:12:19 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:12552 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932457AbWA0KMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:12:18 -0500
Message-ID: <43D9F20F.1000906@shadowen.org>
Date: Fri, 27 Jan 2006 10:12:31 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andrew Morton <akpm@osdl.org>, penberg@cs.helsinki.fi,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org>	<43D785E1.4020708@shadowen.org>	<84144f020601250644h6ca4e407q2e15aa53b50ef509@mail.gmail.com>	<43D7AB49.2010709@shadowen.org>	<1138212981.8595.6.camel@localhost>	<43D7E83D.7040603@shadowen.org>	<84144f020601252303x7e2a75c6rdfe789d3477d9317@mail.gmail.com>	<43D96758.4030808@shadowen.org> <20060126192342.7341f9b2.akpm@osdl.org> <43D9B7AD.2030603@cosmosbay.com>
In-Reply-To: <43D9B7AD.2030603@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> Andrew Morton a écrit :
> 
>> Andy Whitcroft <apw@shadowen.org> wrote:
>>
>>> Yes.  I think I have this one.  It appears that the patch below is the
>>>  trigger for all our recent panic woe's.  The last of the testing should
>>>  complete in the next few hours and I will be able to confirm that
>>>  hypothesis; results so far are all good.
>>>
>>>      reduce-size-of-percpudata-and-make-sure-per_cpuobject.patch
>>
>>
>> That patch did have some missed conversions, which might well explain the
>> crash.
>>
>> Thanks for narrowing it down - I'll keep that patch in next -mm (and will
>> include the known fixups).  Could you please boot test that?  If we're
>> still in trouble, I'll drop it.

Sounds eminently fair.  I think the patch has merit so now we know the
symptoms we can spent a little effort to get the kinks out.  Will test
the next -mm as a matter of course.


> The NULL choice was maybe wrong. We might need more than one page to
> fully catch all accesses. Something like 32KB.

The crash behavoir is handy to catch that the problem exists, and is
very cheap (0 cost) at run time.  However, once its known I think we
need something more targetted to allow tracking of the cause.  Perhaps
we could set the offset thingy to -1 or something and simply do
something like the following in per_cpu():

	if (__per_cpu_offset[i] == -1)
		BUG();
	else
		*RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu])

> In the meantime could you apply this one ?
> 
> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- a/arch/i386/kernel/nmi.c	2006-01-27 07:51:04.000000000 +0100
> +++ b/arch/i386/kernel/nmi.c	2006-01-27 07:52:14.000000000 +0100
> @@ -148,7 +148,7 @@
>  	if (nmi_watchdog == NMI_LOCAL_APIC)
>  		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
>  
> -	for (cpu = 0; cpu < NR_CPUS; cpu++)
> +	for_each_cpu(cpu)
>  		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;
>  	local_irq_enable();
>  	mdelay((10*1000)/nmi_hz); // wait 10 ticks

No change to the panic's in alloc_slabmgmt.  A very quick review seems
to say that slab percpu data is actually not in percpu space, so that
seems a little odd.  Not had any real time to trace it further.

If you have any other missed ones than this send them along and I'll put
them through the mill.

-apw
