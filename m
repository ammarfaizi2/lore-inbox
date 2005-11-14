Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVKNTqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVKNTqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVKNTqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:46:09 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:53773 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751260AbVKNTqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:46:07 -0500
Message-ID: <4378E97E.2060707@vmware.com>
Date: Mon, 14 Nov 2005 11:46:06 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com> <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com> <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Nov 2005 19:46:05.0492 (UTC) FILETIME=[0D058F40:01C5E954]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Mon, 14 Nov 2005, Gerd Knorr wrote:
>  
>
>>Throwing another patch into the discussion ;)
>>    
>>
>
>Ouch, this one is really ugly.
>
>If you want to go this way, then you should instead add an X86_FEATURE_SMP 
>that gets cleared on UP and on SMP with just one core (and detect when CPU 
>hotplug ain't gonna happen ;), and then do
>
>	#ifdef CONFIG_SMP
>	#define smp_alternative(x,y) alternative(x,y,X86_FEATURE_SMP)
>	#else
>	#define smp_alternative(x,y) asm(x)
>	#endif
>
>or something similar, instead of creating a totally new infrastructure to 
>do the thing that "alternative()" already does.
>
>(Yeah, the above doesn't really work, since usually the SMP form is the 
>longer one, and "alternative()" wants the long complex one first. So maybe 
>the x86 feature needs to be "X86_FEATURE_UP" instead, since it's now a 
>"feature" to only have one core ;)
>  
>

It seems that SMP vs. UP lock / spinlock overhead is relevant even for 
future, multi-core CPUs in a virtualization context, as the notion of 
hotplug here is based on scheduling constraints of the virtualization 
engine, and the kernel can quite readily end up with only one VCPU.

But it also seems that there are separate, competing mechanisms for 
implementing this dynamic code change, which is undesirable.  The notion 
of boot-time dynamic code change for SMP is useful for native hardware.  
Run-time dynamic code change is useful for virtual hardware, and 
minimally useful for hardware CPU hotplug.  Run-time dynamic code change 
is also useful on virtual hardware if you consider live kernel 
migrations across CPUs from different vendors, or with different 
features.  Again, this is minimally useful for hardware CPU hotplug.

But in essence, there should be one nice way to encapsulate this code 
modification that lives for both run-time and boot-time code.  The 
boot-time modifiers can jettison the alternative tables, and the 
run-time guys (which might include CPU hotplug) can keep those 
alternatives around so they can be unapplied later.  One can even 
imagine more complex alternative features (if I have SSE2, use code X, 
but if SSE3 is available use code Y, else fall back to code Z) being 
useful at some point.

Both points combined are a basic argument for providing an alternative 
choice function in apply_alternatives, which takes as input the 
alternative specification, and returns a pointer to the chosen code.  
This function can be driven by dynamic data (number of plugged CPUs), or 
by static specifications (feature spec in the alternative section).

Zach
