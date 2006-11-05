Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161692AbWKEULa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161692AbWKEULa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161693AbWKEULa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:11:30 -0500
Received: from terminus.zytor.com ([192.83.249.54]:16326 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161692AbWKEUL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:11:29 -0500
Message-ID: <454E4541.7090807@zytor.com>
Date: Sun, 05 Nov 2006 12:10:41 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Benjamin LaHaise <bcrl@kvack.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [rfc patch] i386: don't save eflags on task switch
References: <200611040200_MC3-1-D04D-6EA3@compuserve.com> <454CE576.3000709@vmware.com> <20061105035556.GQ9057@kvack.org> <454D65E8.3000409@vmware.com>
In-Reply-To: <454D65E8.3000409@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> Benjamin LaHaise wrote:
>> On Sat, Nov 04, 2006 at 11:09:42AM -0800, Zachary Amsden wrote:
>>  
>>> Every processor I've ever measured it on, popf is slower.  On P4, for 
>>> example, pushf is 6 cycles, and popf is 54.  On Opteron, it is 2 / 
>>> 12.  On Xeon, it is 7 / 91.
>>
>> pushf has to wait until all flag dependancies can be resolved.  On the 
>> P4 with >100 instructions in flight, that can take a long time.  Popf 
>> on the other hand has no dependancies on outstanding instructions as 
>> it resets the machine state.
> 
> Yes, but as Linus points out popf is most likely microcoded, thus much 
> slower.  Flag dependency is not unique to pushf, many much more common 
> instructions (adc, jcc, sbc, cmovcc, movs, stos, ...) have flag 
> dependencies, which can still be pipeline forwarded.  I think the raw 
> cycle counts speak for themselves, despite the fact that I only measured 
> instruction latency, not throughput.  Using a branch to eliminate a 
> pushf is thus probably not a win in most cases.
> 

The "sane" decomposition of popf into uops something like this:

- Memory read
- Mask bits that are immutable in the current mode
- Trap to microcode on changing any bit that alters the pipeline state

The "trap to microcode" can obviously be arbitrarily expensive.  So when 
timing popf, it's also important to know *which* bits change.

The simplest case, obviously, is when no flags change.  I still *fully* 
expect that to be more painful than pushf ever is.

	-hpa
