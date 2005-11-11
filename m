Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVKKUOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVKKUOF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVKKUOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:14:04 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:25604 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751137AbVKKUOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:14:03 -0500
Message-ID: <4374FB89.6000304@vmware.com>
Date: Fri, 11 Nov 2005 12:14:01 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com> <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2005 20:14:02.0657 (UTC) FILETIME=[75736110:01C5E6FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Fri, 11 Nov 2005, Zachary Amsden wrote:
>  
>
>>Agree nested exceptions are evil.  But where is this called from execption
>>context? 
>>    
>>
>
>We have really nice ways of handling these things, so we should just use 
>them.
>
>For example, you can do
>
>	static inline void read_cr4(void)
>	{
>		unsigned long cr4;
>		alternative_input("xorl %0,%0",
>				  "movl %%cr4,%0",
>				  X86_FEATURE_CR4,
>				  "r" (cr4));
>		return cr4;
>	}
>
>and then just add that feature-flag discovery early on in boot (it needs 
>to be pretty early, since the alternative instruction rewriting happens 
>early).
>
>We have several "calculated" features already. Things like X86_FEATURE_P4 
>etc.
>  
>

Yes, this is fine, but is it worth writing the feature discovery code?  
I suppose it doesn't matter, as it gets jettisoned after init.  I guess 
it is just preference.

Considering run time code size, the alternative approach wins, has no 
extra branches, and is just nicer.  The faulting technique requires two 
extra dwords of space that can not be jettisonned.  So obviously, I must 
do it (the alternative approach).

Could we consider doing the same with LOCK prefix for SMP kernels booted 
on UP?  Evil grin.

Zach
