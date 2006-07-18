Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWGRWzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWGRWzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 18:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWGRWzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 18:55:12 -0400
Received: from gw.goop.org ([64.81.55.164]:41911 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932349AbWGRWzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 18:55:10 -0400
Message-ID: <44BD3EBA.5010002@goop.org>
Date: Tue, 18 Jul 2006 13:04:10 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [RFC PATCH 16/33] Add support for Xen to entry.S.
References: <20060718091807.467468000@sous-sol.org>	 <20060718091952.505770000@sous-sol.org> <1153217516.3038.34.camel@laptopd505.fenrus.org>
In-Reply-To: <1153217516.3038.34.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
>   
>> +#ifndef CONFIG_XEN
>>  	movl %cr0, %eax
>>  	testl $0x4, %eax		# EM (math emulation bit)
>> -	jne device_not_available_emulate
>> -	preempt_stop
>> -	call math_state_restore
>> -	jmp ret_from_exception
>> -device_not_available_emulate:
>> +	je device_available_emulate
>>  	pushl $0			# temporary storage for ORIG_EIP
>>  	CFI_ADJUST_CFA_OFFSET 4
>>  	call math_emulate
>>  	addl $4, %esp
>>  	CFI_ADJUST_CFA_OFFSET -4
>> +	jmp ret_from_exception
>> +device_available_emulate:
>> +#endif
>>     
>
>
> Hi,
>
> can you explain what this chunk is for? It appears to be for the non-xen
> case due to the ifndef, yet it seems to visibly change the code for
> that... that deserves an explanation for sure ...
>   

This inverts the logic of the test so that the lines:

	preempt_stop
	call math_state_restore
	jmp ret_from_exception

can be hoisted out of the ifdef and shared in the Xen and non-Xen cases.

    J

