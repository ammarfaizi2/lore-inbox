Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWCVRY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWCVRY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWCVRY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:24:58 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:9481 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751015AbWCVRY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:24:57 -0500
Message-ID: <44218861.8030203@vmware.com>
Date: Wed, 22 Mar 2006 09:24:49 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] Re: [RFC PATCH 11/35] Add support for Xen to entry.S.
References: <20060322063040.960068000@sorel.sous-sol.org>	<20060322063749.275209000@sorel.sous-sol.org> <200603221455.48365.ak@suse.de>
In-Reply-To: <200603221455.48365.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>   
>> +	jnz restore_all_enable_events	#     != 0 => reenable event delivery
>> +#endif
>>  	RESTORE_REGS
>>  	addl $4, %esp
>>  1:	iret
>>  .section .fixup,"ax"
>>  iret_exc:
>> -	sti
>> +#ifndef CONFIG_XEN
>> +	ENABLE_INTERRUPTS
>> +#endif
>>  	pushl $0			# no error code
>>  	pushl $do_iret_error
>>  	jmp error_code
>> @@ -269,6 +317,7 @@ iret_exc:
>>  	.long 1b,iret_exc
>>  .previous
>>  
>> +#ifndef CONFIG_XEN
>>  ldt_ss:
>>     
>
> So are you sure that problem this ugly piece of code tries to work around
> isn't in Xen kernels too? Or do you just not care? If yes add a comment.
>   

This code would otherwise be broken.  ENABLE_INTERRUPTS in Xen requires 
access to the data segment, and the data segment is not available at 
this point.  Plus, it corrupts the %esi register.  Hint - use %ebp.

The LDT SS code is broken as well because the iret onto a 16-bit stack 
is a pretty crippling blow to transparency in this code.  Then, you 
don't have data or even stack segments that are reliable for calling out 
to hypervisor assist code.  We never really fixed this code either in 
our implementation, although we did consider several approaches.  
Leaving it out does break userspace applications.

Zach
