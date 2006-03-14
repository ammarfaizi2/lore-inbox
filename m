Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752259AbWCNRBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbWCNRBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbWCNRBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:01:31 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:33550 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751124AbWCNRBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:01:30 -0500
Message-ID: <4416F6DF.3050407@vmware.com>
Date: Tue, 14 Mar 2006 09:01:19 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VMI Interface Proposal Documentation for I386, Part 5
References: <4415CE76.9030006@vmware.com> <Pine.LNX.4.64.0603132328270.11606@montezuma.fsmlabs.com> <44167E03.3060807@vmware.com> <Pine.LNX.4.64.0603140040230.11606@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.64.0603140040230.11606@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> I believe it certainly is worth seperating and would help in the iret, in 
> that you could enable interrupts without recursing again.
>   

The iret instruction is by far the trickiest and most sinister 
instruction in the i386 architecture to virtualize.  It is used for so 
many different things - setting VIF and VIP flags, returning to kernel 
mode from an interrupt or exception, returning to user mode from a 
system call, returning to v8086 mode.  And it uses the stack differently 
for some of these.  And it is inherently non-virtualizable, because it 
is sensitive to IOPL without trapping.  And it performs many actions 
atomically - setting CPU flags, segment registers and EIP,  popping 
values off the stack.  And it is often used from one code location for 
many of these possible effects simultaneously.  And it alters code flow, 
so after it executes, there is no going back.  Unfortunately, it is 
usually not possible to entirely separate the implications of interrupt 
delivery from the iret instruction.

Iret really does need specially treatment.  You can't virtualize it in 
one instruction without hardware assistance.  But you can emulate it 
successfully if you can perform a simple test on your fault / IRQ 
delivery path.  See patch 8, Vmi syscall assembly for some more 
details.  The same race condition is inherent to all stack based event 
delivery mechanisms.

Zach
