Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWA0GD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWA0GD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 01:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWA0GD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 01:03:28 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:33664 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932180AbWA0GD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 01:03:27 -0500
Message-ID: <43D9B7AD.2030603@cosmosbay.com>
Date: Fri, 27 Jan 2006 07:03:25 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, penberg@cs.helsinki.fi,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org>	<43D785E1.4020708@shadowen.org>	<84144f020601250644h6ca4e407q2e15aa53b50ef509@mail.gmail.com>	<43D7AB49.2010709@shadowen.org>	<1138212981.8595.6.camel@localhost>	<43D7E83D.7040603@shadowen.org>	<84144f020601252303x7e2a75c6rdfe789d3477d9317@mail.gmail.com>	<43D96758.4030808@shadowen.org> <20060126192342.7341f9b2.akpm@osdl.org>
In-Reply-To: <20060126192342.7341f9b2.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000202060508000107070207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000202060508000107070207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> Andy Whitcroft <apw@shadowen.org> wrote:
>> Yes.  I think I have this one.  It appears that the patch below is the
>>  trigger for all our recent panic woe's.  The last of the testing should
>>  complete in the next few hours and I will be able to confirm that
>>  hypothesis; results so far are all good.
>>
>>  	reduce-size-of-percpudata-and-make-sure-per_cpuobject.patch
> 
> That patch did have some missed conversions, which might well explain the
> crash.
> 
> Thanks for narrowing it down - I'll keep that patch in next -mm (and will
> include the known fixups).  Could you please boot test that?  If we're
> still in trouble, I'll drop it.

The NULL choice was maybe wrong. We might need more than one page to fully 
catch all accesses. Something like 32KB.

In the meantime could you apply this one ?

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>



--------------000202060508000107070207
Content-Type: text/plain;
 name="nmi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmi.patch"

--- a/arch/i386/kernel/nmi.c	2006-01-27 07:51:04.000000000 +0100
+++ b/arch/i386/kernel/nmi.c	2006-01-27 07:52:14.000000000 +0100
@@ -148,7 +148,7 @@
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for_each_cpu(cpu)
 		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks

--------------000202060508000107070207--
