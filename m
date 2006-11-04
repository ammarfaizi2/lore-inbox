Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753616AbWKDTJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbWKDTJn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 14:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbWKDTJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 14:09:43 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:37342 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1753616AbWKDTJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 14:09:43 -0500
Message-ID: <454CE576.3000709@vmware.com>
Date: Sat, 04 Nov 2006 11:09:42 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com>
In-Reply-To: <200611040200_MC3-1-D04D-6EA3@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <Pine.LNX.4.64.0611031645141.25218@g5.osdl.org>
>
> On Fri, 3 Nov 2006 16:46:25 -0800, Linus Torvalds wrote:
>
>   
>> On Fri, 3 Nov 2006, Chuck Ebbert wrote:
>>     
>>> There is no real need to save eflags in switch_to().  Instead,
>>> we can keep a constant value in the thread_struct and always
>>> restore that.
>>>       
>> I don't really see the point. The "pushfl" isn't the expensive part, and 
>> it gives sane and expected semantics.
>>
>> The "popfl" is the expensive part, and that's the thing that can't really 
>> even be removed.
>>     
>
> Well that wasn't the impression I got:
>
>   Date: Mon, 18 Sep 2006 12:12:51 -0400
>   From: Benjamin LaHaise <bcrl@kvack.org>
>   Subject: Re: Sysenter crash with Nested Task Bit set
>
>   ...
>
>   It's the pushfl that will be slow on any OoO CPU, as it has dependancies on 
>   any previous instructions that modified the flags, which ends up bringing 
>   all of the memory ordering dependancies into play.  Doing a popfl to set the 
>   flags to some known value is much less expensive.
>   

That doesn't sound correct to me.  The popf is far more expensive.  
There is no popfl $IMM instruction, so setting flags never can avoid the 
memory read and must make some more expensive assumptions about effects 
on further instruction stream (TF, DF, all sign flags for conditional 
jumps...).

Every processor I've ever measured it on, popf is slower.  On P4, for 
example, pushf is 6 cycles, and popf is 54.  On Opteron, it is 2 / 12.  
On Xeon, it is 7 / 91.

Zach
