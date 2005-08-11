Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVHKPwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVHKPwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVHKPwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:52:40 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:43524 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932223AbVHKPwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:52:39 -0400
Message-ID: <42FB7440.5060501@vmware.com>
Date: Thu, 11 Aug 2005 08:52:32 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ukil a <ukil_a@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need help in understanding  x86  syscall
References: <20050811053931.71120.qmail@web51604.mail.yahoo.com>
In-Reply-To: <20050811053931.71120.qmail@web51604.mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Aug 2005 15:52:16.0515 (UTC) FILETIME=[A5DB4D30:01C59E8C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ukil a wrote:

>I had this question. As per my understanding, in the
>Linux system call implementation on x86 architecture
>the call flows like this int 0x80 -> syscall ->
>sys_call_vector(taken from the table)-> return from
>interrupt service routine. 
>  
>

Almost. There are two entry points, the one you describe above, and the 
sysenter entry point.


>Now I had the doubt that if the the syscall
>implementation is very large will the scheduling and
>other interrupts be blocked for the whole time till
>the process returns from the ISR (because in an ISR by
>default the interrupts are disabled unless “sti” is
>called explicitly)? That’s appears to be too long for
>the scheduling or other interrupts to be blocked? 
>Am I missing something here?
>  
>

There are 3 types of gates you can use to service interrupts / faults on 
i386. Task gates are used where complex state changes are required, and 
an assured state is needed, such as doublefault and NMI handlers. 
Interrupt gates are used where interrupts must be disabled during 
initial processing, such as the page fault gate. Trap gates are used 
when interrupts may be allowed, and do not clear the interrupt flag.

On Linux, syscall vector int 0x80 is a trap gate, which means interrupts 
are not disabled. The sysenter handler is very special; SYSENTER does 
disable interrupts, so if you look at sysenter_entry, one of the first 
things it will do is re-enable interrupts as soon as the stack is sane. 
Thus, interrupts are enabled by default during system call processing 
unless explicitly disabled.

Your analysis of what would happen otherwise is quite correct.

Zach
