Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSFOORY>; Sat, 15 Jun 2002 10:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSFOORX>; Sat, 15 Jun 2002 10:17:23 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:41397 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315413AbSFOORW>;
	Sat, 15 Jun 2002 10:17:22 -0400
Date: Sat, 15 Jun 2002 16:13:33 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200206151413.QAA07923@harpo.it.uu.se>
To: johnstul@us.ibm.com, kai@tp1.ruhr-uni-bochum.de
Subject: Re: [Patch] tsc-disable_A5
Cc: Martin.Bligh@us.ibm.com, davej@suse.de, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jun 2002 16:44:30 -0700, john stultz wrote:
>On Fri, 2002-06-14 at 16:29, Kai Germaschewski wrote:
>> I suppose you could it rewrite like
>> 
>> ...
>> CONFIG_X86_WANT_TSC=y (or whatever)
>> ...
>> 
>> if [ some_condition ]; then
>>   define_bool CONFIG_X86_TSC n
>> else
>>   define_bool CONFIG_X86_TSC $CONFIG_X86_WANT_TSC
>> fi
>> 
>> Not exactly elegant, but it should work ;)
>
>Yep, my first release was done in a similar fashion, but Alan suggested
>the patch take on its current form. There may be cases where we want to
>know if we have a TSC even if we don't want to use them. 
>
>Thread link:
>http://www.uwsg.iu.edu/hypermail/linux/kernel/0205.3/1188.html

I disagree with Alan's recommendation.
The real problem is that the kernel confuses a CPU-level property
(do the CPUs have TSCs?) with a system-level property (are the
TSCs present and in sync?). CONFIG_X86_TSC really describes the
latter property, for the former we have the cpu_has_tsc() macro.

IMO, Kai is right and a nicer fix is to change arch/i386/config.in to:
- s/CONFIG_X86_TSC=y/CONFIG_X86_CPU_HAS_TSC=y/
  (this one can also be used as an optimisation to avoid runtime
  cpu_has_tsc() checks)
- append a rule which derives CONFIG_X86_TSC from CONFIG_X86_CPU_HAS_TSC
  and !multiquad

The other patch which adds an anti-CONFIG_X86_TSC to cancel the
first CONFIG_X86_TSC is so horribly hacky...

/Mikael
