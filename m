Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWHGUvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWHGUvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 16:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWHGUvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 16:51:52 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:41607 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932351AbWHGUvv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 16:51:51 -0400
Message-ID: <44D7A7E6.2060401@vmware.com>
Date: Mon, 07 Aug 2006 13:51:50 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
 ops
References: <1154925835.21647.29.camel@localhost.localdomain>	 <200608070730.17813.ak@muc.de> <1154930669.7642.12.camel@localhost.localdomain>
In-Reply-To: <1154930669.7642.12.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>>> +
>>> +/*
>>> + * Set IOPL bits in EFLAGS from given mask
>>> + */
>>> +static inline void set_iopl_mask(unsigned mask)
>>>       
>> This function can be completely written in C using local_save_flags()/local_restore_flags()
>> Please do that. I guess it's still a good idea to keep it separated
>> though because it might allow other optimizations.
>>
>> e.g. i've been thinking about special casing IF changes in save/restore flags 
>> to optimize CPUs which have slow pushf/popf. If you already make sure
>> all non IF manipulations of flags are separated that would help.
>>     


Actually, that is not quite true.  Local_save_flags / 
raw_local_irq_restore today is used only for operating on IF flag, and 
raw_local_restore_flags does not exist.  Our implementation of these in 
VMI assumes that only the IF flag is being changed, and this is the 
default assumption under which Xen runs as well.  Using local_restore to 
switch IOPL as well causes the extremely performance critical common 
case of pure IRQ restore to do potentially a lot more work in a hypervisor.

So if you do want us to go with the C approach, I would propose using 
raw_local_iopl_restore, which can make a different hypercall (actually, 
in our case, this is not even a hypercall, merely a VMI call).

Zach
