Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWDDWek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWDDWek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWDDWek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:34:40 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:37130 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750840AbWDDWek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:34:40 -0400
Message-ID: <4432F469.1040405@vmware.com>
Date: Tue, 04 Apr 2006 15:34:17 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, bunk@stusta.de, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
References: <20060404014504.564bf45a.akpm@osdl.org>	<20060404162921.GK6529@stusta.de>	<m1acb15ja2.fsf@ebiederm.dsl.xmission.com>	<4432B22F.6090803@vmware.com>	<m1irpp41wx.fsf@ebiederm.dsl.xmission.com>	<4432C7AC.9020106@vmware.com>	<20060404132546.565b3dae.akpm@osdl.org>	<4432ECF1.8040606@vmware.com> <20060404151904.764ad9f4.akpm@osdl.org>
In-Reply-To: <20060404151904.764ad9f4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Zachary Amsden <zach@vmware.com> wrote:
>   
>> Andrew Morton wrote:
>>     
>>>>  struct subarch_hooks subarch_hook_vector = {
>>>>       .machine_power_off = machine_power_off,
>>>>       .machine_halt = machine_halt,
>>>>       .machine_irq_setup = machine_irq_setup,
>>>>       .machine_subarch_setup = machine_subarch_probe
>>>>       ...
>>>>  };
>>>>
>>>>  And machine_subarch_probe can dynamically change this vector if it 
>>>>  confirms that the platform is appropriate?
>>>>     
>>>>         
>>> I don't recall anyone expressing any desire for the ability to set these
>>> things at runtime.  Unless there is such a requirement I'd suggest that the
>>> best way to address Eric's point is to simply rename the relevant functions
>>> from foo() to subarch_foo().
>>>   
>>>       
>> Avoiding the runtime assignment isn't possible if you want a generic 
>> subarch that truly can run on multiple different platforms.
>>     
>
> Well as I said - I haven't seen any requirement for this expressed.  That
> doesn't mean that such a requirements doesn't exist, of course.
>
>   
>> I prefer runtime assignment not for this reason, but simply because it 
>> also eliminates two artifacts:
>>
>> 1) You can add new subarch hooks without breaking every other 
>> sub-architecture
>>     
>
> Is that useful?   If you need a new subarch_bar() then
>
> a) Implement it in the subarch which needs it
> b) Implement an attribute(weak) stub in a new subarch-stubs.c
> c) call it.
>
> That's a little more costly than a static inline stub, but not much.  Are
> there likely to be any subarch calls which are a) called frequently and b)
> not required on some subarchs?
>   

No, most of these are one time init calls.  The problem before was the 
default subarch couldn't define weak symbols, since setup.c was in the 
subarch itself and not in arch/i386/kernel.  Do weak symbols work with 
all tool chains?

>   
>> 2) You don't need #ifdef SUBARCH_FUNC_FOO goo to do this (renaming 
>> voyager_halt -> default)
>>     
>
> Why would one need that?  Isn't it simply a matter of renaming
> machine_halt() to subarch_machine_halt() everywhere?
>   

No - if you rename machine_halt to subarch_machine_halt, you again can't 
add a new subarch interface without changing all subarchitectures.  If I 
add voyager_smp_bless_voyage(), I now need to add #define 
visws_smp_bless_voyage default_smp_bless_voyage, ... or did you mean 
subarch_machine_halt literally?

> I'm just looking for the simplest option here.  Eric has identified a code
> maintainability problem - it'd be good to fix that, but we shouldn't add
> runtime cost/complexity unless we actually gain something from it.
>   

I think weak symbols are the best approach, if they indeed work with all 
tool chains.

Zach
