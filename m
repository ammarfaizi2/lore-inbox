Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318922AbSHFDDI>; Mon, 5 Aug 2002 23:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318923AbSHFDDI>; Mon, 5 Aug 2002 23:03:08 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25801 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318922AbSHFDDH>;
	Mon, 5 Aug 2002 23:03:07 -0400
Date: Mon, 05 Aug 2002 20:04:26 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>, Christoph Hellwig <hch@infradead.org>
cc: marcelo <marcelo@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
       Leah Cunningham <leahc@us.ibm.com>, wilhelm.nuesser@sap.com,
       paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B7
Message-ID: <1201883206.1028577864@[10.10.2.3]>
In-Reply-To: <1028592257.1073.81.camel@cog>
References: <1028592257.1073.81.camel@cog>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What's the difference between CONFIG_X86_NUMA and CONFIG_MULTIQUAD?
>> 
>> If CONFIG_X86_NUMA is for numaq boxens please use CONFIG_X86_NUMAQ as
>> in pat's patch.
> 
> Well, at the moment CONFIG_MULTIQUAD ~= numaq specific stuff + generic
> x86 numa stuff, so James and Martin are starting to break out the
> generic stuff out of MULTIQUAD and put the NUMAQ specific stuff under
> X86_NUMAQ.

The current differentiation is a mess, which is my fault.
CONFIG_MULTIQUAD started off life as clustered apic mode,
and grew from there to be a catchall for the NUMA-Q machine.
I can't help but think this is a bad idea, with the benefit
of hindsight. So we'll try to convert everything to more
meaningful config options, where the top level "machine type"
config option turns on the support features that machine needs.

I know the following looks a little verbose, but it's fairly
straightforward, and is a lot more logical than the current,
errm ... mess.

I'll submit a patch to convert the existing code over unless
someone screams pretty loudly (and suggests a better idea ;-))

M.

PS. Looking at the below again, we probably ought to rename
the remaining CONFIG_MULTIQUAD to CONFIG_CLUSTERED_APIC or 
something ... but I'm sure I'll get lynched in the morning 
for that one.
 
> We're trying to all move to something close to:
> 
>    bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
>    if [ "$CONFIG_X86_NUMA" = "y" ]; then
>       #Platform Choices
>       bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_X86_NUMAQ
>       if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
>          define_bool CONFIG_MULTIQUAD y
>          define_bool CONFIG_X86_TSC_DISABLE y
>       fi
>       bool 'IBM x440 Summit support' CONFIG_X86_SUMMIT_NUMA
>       if [ "$CONFIG_X86_SUMMIT_NUMA" = "y" ]; then
>          define_bool CONFIG_X86_TSC_DISABLE y
>       fi
>       # Common NUMA Features
>       if [ "$CONFIG_X86_NUMAQ" = "y" -o "$CONFIG_X86_SUMMIT_NUMA" = "y" ]; then
>          bool 'Numa Memory Allocation Support' CONFIG_NUMA
>          if [ "$CONFIG_NUMA" = "y" ]; then
>             define_bool CONFIG_DISCONTIGMEM y
>             define_bool CONFIG_HAVE_ARCH_BOOTMEM_NODE y
>          fi
>          #[XXX - future] 
>          #bool 'NUMA API support' CONFIG_WHATEVER
>          #bool 'Enable NUMA Scheduler' CONFIG_WHATEVER
>       fi
>    fi
> 
>>  else
>> -   bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
>> +	bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
>> +	if [ "$CONFIG_X86_NUMA" = "y" ]; then
>> +		bool 'Multiquad (IBM/Sequent) NUMAQ support' CONFIG_MULTIQUAD
>> +	fi
>>  fi

