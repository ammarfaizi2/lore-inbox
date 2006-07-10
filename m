Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWGJME5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWGJME5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWGJME5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:04:57 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:40757 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S964953AbWGJME4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:04:56 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
cc: akpm@osdl.org, James.Bottomley@steeleye.com,
       "Eric W. Biederman" <ebiederm@xmission.com>, fastboot@lists.osdl.org,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH 1/3] stack overflow safe kdump (2.6.18-rc1-i386) - safe_smp_processor_id 
In-reply-to: Your message of "Mon, 10 Jul 2006 19:15:50 +0900."
             <1152526550.3003.24.camel@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jul 2006 22:04:35 +1000
Message-ID: <2087.1152533075@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao (on Mon, 10 Jul 2006 19:15:50 +0900) wrote:
>Hi Keith,
>
>Thank you for the comments.
>
>On Mon, 2006-07-10 at 18:27 +1000, Keith Owens wrote:
>> Fernando Luis Vazquez Cao (on Mon, 10 Jul 2006 16:50:52 +0900) wrote:
>> >On the event of a stack overflow critical data that usually resides at
>> >the bottom of the stack is likely to be stomped and, consequently, its
>> >use should be avoided.
>> >
>> >In particular, in the i386 and IA64 architectures the macro
>> >smp_processor_id ultimately makes use of the "cpu" member of struct
>> >thread_info which resides at the bottom of the stack. x86_64, on the
>> >other hand, is not affected by this problem because it benefits from
>> >the use of the PDA infrastructure.
>> >
>> >To circumvent this problem I suggest implementing
>> >"safe_smp_processor_id()" (it already exists in x86_64) for i386 and
>> >IA64 and use it as a replacement for smp_processor_id in the reboot path
>> >to the dump capture kernel. This is a possible implementation for i386.
>> =
>
>> I agree with avoiding the use of thread_info when the stack might be
>> corrupt.  However your patch results in reading apic data and scanning
>> NR_CPU sized tables for each IPI that is sent, which will slow down the
>> sending of all IPIs, not just dump.
>This patch only affects IPIs sent using send_IPI_allbutself which is
>rarely called, so the impact in performance should be negligible.

The main users of send_IPI_allbutself() are smp_call_function() and
on_each_cpu(), which are used quite often.  My main concern are the
architectures that use IPI to flush TLB entries from other cpus.  For
example, i386 ioremap_page_range() -> flush_tlb_all() -> on_each_cpu().

>> It would be far cheaper to define
>> a per-cpu variable containing the logical cpu number, set that variable
>> once as each cpu is brought up and just read it in cases where you
>> might not trust the integrity of struct thread_info.  safe_smp_processor_=
>id()
>> resolves to just a read of the per cpu variable.
>But to read a per-cpu variable you need to index the corresponding array
>with processor id of the current CPU (see code below), but that is
>precisely what we are trying to figure out.

Ouch, I am so used to ia64 where accessing the local per cpu variables
is a direct read, with no need to use smp_processor_id().

The use of smp_processor_id() in include/asm-generic/percpu.h is
worrying, it means that any RAS code like dump or debuggers cannot
access any per cpu variables.  Corrupt the kernel stack and all per cpu
variables become useless!  That is a hidden bug, just waiting to bite
all the RAS code.

ia64, x86_64, power, s390, sparc64 do not suffer from this problem,
they have efficient implementations of __get_cpu_var().  All other
architectures (including i386) use the generic percpu code and per cpu
variables will not work with corrupt kernel stacks.

