Return-Path: <linux-kernel-owner+w=401wt.eu-S1751180AbXAFElu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbXAFElu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 23:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbXAFElu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 23:41:50 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:37795 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbXAFElt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 23:41:49 -0500
Message-ID: <459F288C.1070809@vmware.com>
Date: Fri, 05 Jan 2007 20:41:48 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch] paravirt: isolate module ops
References: <20070106000715.GA6688@elte.hu>  <459EF537.6090301@vmware.com> <1168049229.3101.15.camel@laptopd505.fenrus.org>
In-Reply-To: <1168049229.3101.15.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> I would suggest a slightly different carving.  For one, no TLB flushes.  
>> If you can't modify PTEs, why do you need to have TLB flushes?  And I 
>> would allow CR0 read / write for code which saves and restores FPU state 
>>     
>
> no that is abstracted away by kernel_fpu_begin/end. Modules have no
> business doing that themselves
>   

As long as they don't rely on inlines for that... checking and 
kernel_fpu_end is inline and uses stts(), which requires CR0 read / 
write.  One can easily imagine binary modules which do use the fpu, and 
these were not broken before, so breaking them now seems the wrong thing 
to do.

I agree on debug registers - anything touching them is way too shady.  
And there is no reason modules should be doing raw page table 
operations, they should use proper mm functions and leave the page 
details to the mm layer, which doesn't do these things inline.

Basically, it is just the things that do get inlined that I think we 
should worry about.  If you all feel strongly that this should be fixed 
in 2.6.20, perhaps the best thing to do is in fact 
EXPORT_SYMBOL_GPL(paravirt_ops), and we can queue up a patch in -mm 
which will export those paravirt_ops required inline by modules for 
2.6.21.  Otherwise, I think there will be too many rejects against the 
paravirt code in Andrew's tree.

Zach
