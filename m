Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVHDDHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVHDDHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 23:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbVHDDHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 23:07:41 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:22029 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S261730AbVHDDHj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 23:07:39 -0400
Message-ID: <42F18638.5070108@vmware.com>
Date: Wed, 03 Aug 2005 20:06:32 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name
Subject: Re: [PATCH] 1/5 more-asm-cleanup
References: <200508040043.j740h4wB004166@zach-dev.vmware.com> <42F165BC.9030504@zytor.com>
In-Reply-To: <42F165BC.9030504@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Aug 2005 03:06:33.0062 (UTC) FILETIME=[84887860:01C598A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please explain why this is a reject after looking at the cpuid macro.  
It changed recently.  Note 0 -> %ecx.

Would you prefer that I call cpuid_count and pass an explicit zero 
parameter for ecx?


/*
 * Generic CPUID function
 * clear %ecx since some cpus (Cyrix MII) do not set or clear %ecx
 * resulting in stale register contents being returned.
 */
static inline void cpuid(unsigned int op, unsigned int *eax, unsigned 
int *ebx, unsigned int *ecx, unsigned int *edx)
{
        __asm__("cpuid"
                : "=a" (*eax),
                  "=b" (*ebx),
                  "=c" (*ecx),
                  "=d" (*edx)
                : "0" (op), "c"(0));
}


H. Peter Anvin wrote:

> zach@vmware.com wrote:
>
>> Some more assembler cleanups I noticed along the way.
>
>
>> Index: linux-2.6.13/arch/i386/kernel/cpu/intel.c
>> ===================================================================
>> --- linux-2.6.13.orig/arch/i386/kernel/cpu/intel.c    2005-08-03 
>> 15:18:18.000000000 -0700
>> +++ linux-2.6.13/arch/i386/kernel/cpu/intel.c    2005-08-03 
>> 15:19:39.000000000 -0700
>> @@ -82,16 +82,12 @@
>>   */
>>  static int __devinit num_cpu_cores(struct cpuinfo_x86 *c)
>>  {
>> -    unsigned int eax;
>> +    unsigned int eax, ebx, ecx, edx;
>>  
>>      if (c->cpuid_level < 4)
>>          return 1;
>>  
>> -    __asm__("cpuid"
>> -        : "=a" (eax)
>> -        : "0" (4), "c" (0)
>> -        : "bx", "dx");
>> -
>> +    cpuid(4, &eax, &ebx, &ecx, &edx);
>>      if (eax & 0x1f)
>>          return ((eax >> 26) + 1);
>
>
> Reject!  This is a bogus patch; Intel's CPUID level 4 has a 
> nonstandard dependency on ECX (idiots...) and therefore this needs 
> special handling.
>
>     -hpa
>

