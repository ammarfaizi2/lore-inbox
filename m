Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWH0Ql1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWH0Ql1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWH0Ql0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:41:26 -0400
Received: from gw.goop.org ([64.81.55.164]:19690 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932171AbWH0Ql0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:41:26 -0400
Message-ID: <44F1CB2D.9070703@goop.org>
Date: Sun, 27 Aug 2006 09:41:17 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
References: <20060827084417.918992193@goop.org> <200608271801.44774.ak@suse.de>
In-Reply-To: <200608271801.44774.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I bet qemu doesn't have a real descriptor cache unlike real CPUs.
> So likely it is some disconnect between changing the backing GDT
> and referencing the register. Reload %gs more aggressively?
>   

The GDT only gets touched once in cpu_init(), and %gs is reloaded on 
every kernel entry, so I don't think that's it.  I seems to have 
interrupt issues with SMP.

And either way, it still doesn't work on real hardware...

> Comparing with SimNow! (which should behave more like a real CPU)
> might be also interesting.
>   

Yeah, I'll have to try that out.

>> - Measure performance impact.  The patch adds a segment register
>>   save/restore on entry/exit to the kernel.  This expense should be
>>   offset by savings in using the PDA while in the kernel, but I haven't
>>   measured this yet.  Space savings are already appealing though.
>> - Modify more things to use the PDA.  The more that uses it, the more
>>   the cost of the %gs save/restore is amortized.  smp_processor_id and
>>   current are the obvious first choices, which are implemented in this
>>   series.
>>     
>
> per cpu data would be the prime candidate. It is pretty simple.
>   

Well, it has to be arch-specific per-cpu data, since the PDA is arch 
specific.  But there should be various pieces of interrupt state that 
adapt well to it.

>> - Make it a config option?  UP systems don't need to do any of this,
>>   other than having a single pre-allocated PDA.  Unfortunately, it gets
>>   a bit messy to do this given the changes needed in handling %gs.
>>     
>
> Please don't.
>   

Yeah, that wasn't really a serious thought...

    J
