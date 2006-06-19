Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWFSQfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWFSQfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWFSQfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:35:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:17785 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964784AbWFSQfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:35:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CVKN5XtyYwEs8S28IEI2KLH5KMiwVtGpVRWTUrpsjzBaTPaSItdduJvLGPEMdoR0yQm8NgxfAI5Rx1o5bFH313Sf43W+1nQaHtCXmZPMG/1DxKKwEwu0D6xgVuFAptmX/mL1+zbC+IK4DhiR401jexElj3J4qhTy2Yp42kqpeAE=
Message-ID: <4496D24F.80003@gmail.com>
Date: Mon, 19 Jun 2006 18:35:27 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: tglx@timesys.com, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic
 HZ
References: <1150643426.27073.17.camel@localhost.localdomain> <449580CA.2060704@gmail.com> <20060618182820.GA32765@elte.hu>
In-Reply-To: <20060618182820.GA32765@elte.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ingo Molnar napisał(a):
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> 
>> WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/sound/pci/ac97/snd-ac97-codec.ko needs unknown symbol msecs_to_jiffies
>> WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/net/skge.ko needs unknown symbol jiffies_to_msecs
>> WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/cpufreq/cpufreq_ondemand.ko needs unknown symbol jiffies_to_usecs
>> etc...
>>
>> warnings.
>>
>> Here is fix small fix.
> 
> thanks. I've uploaded the current combo patch to:
> 
>   http://redhat.com/~mingo/high-res-timers-dyntick/hres-dyntick-combo-2.6.17-2.patch
> 
> (this also includes work-in-progress x86_64 bits - the .config options 
> are offered by dynticks are not yet functional there.)
> 
> 	Ingo
> 

Here is the last EXPORT_SYMBOL fix.
WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/cpufreq/cpufreq_stats.ko needs unknown symbol jiffies_64_to_clock_t

BTW. APM doesn't compile.

/usr/src/linux-work1/arch/i386/kernel/apm.c: In function ‘apm_do_idle’:
/usr/src/linux-work1/arch/i386/kernel/apm.c:767: error: ‘TIF_POLLING_NRFLAG’ undeclared (first use in this function)
/usr/src/linux-work1/arch/i386/kernel/apm.c:767: error: (Each undeclared identifier is reported only once
/usr/src/linux-work1/arch/i386/kernel/apm.c:767: error: for each function it appears in.)
/usr/src/linux-work1/arch/i386/kernel/apm.c: In function ‘suspend’:
/usr/src/linux-work1/arch/i386/kernel/apm.c:1193: warning: ‘pm_send_all’ is deprecated (declared at /usr/src/linux-work1/inc
lude/linux/pm_legacy.h:26)
/usr/src/linux-work1/arch/i386/kernel/apm.c:1247: warning: ‘pm_send_all’ is deprecated (declared at /usr/src/linux-work1/inc
lude/linux/pm_legacy.h:26)
/usr/src/linux-work1/arch/i386/kernel/apm.c: In function ‘check_events’:
/usr/src/linux-work1/arch/i386/kernel/apm.c:1368: warning: ‘pm_send_all’ is deprecated (declared at /usr/src/linux-work1/inc
lude/linux/pm_legacy.h:26)
make[2]: *** [arch/i386/kernel/apm.o] Błąd 1
make[1]: *** [arch/i386/kernel] Błąd 2
make: *** [_all] Błąd 2


Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/kernel/time.c linux-work/kernel/time.c
--- linux-work-clean/kernel/time.c	2006-06-19 18:21:37.000000000 +0200
+++ linux-work/kernel/time.c	2006-06-19 18:18:37.000000000 +0200
@@ -879,6 +879,8 @@ u64 jiffies_64_to_clock_t(u64 x)
 	return x;
 }

+EXPORT_SYMBOL(jiffies_64_to_clock_t);
+
 u64 nsec_to_clock_t(u64 x)
 {
 #if (NSEC_PER_SEC % USER_HZ) == 0

