Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946277AbWJSSAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946277AbWJSSAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946282AbWJSSAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:00:16 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:178 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1946277AbWJSSAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:00:15 -0400
Message-ID: <4537BD27.7050509@qumranet.com>
Date: Thu, 19 Oct 2006 20:00:07 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
References: <4537818D.4060204@qumranet.com> <20061019173151.GD4957@rhun.haifa.ibm.com>
In-Reply-To: <20061019173151.GD4957@rhun.haifa.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 18:00:14.0624 (UTC) FILETIME=[6DA54200:01C6F3A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:
> Hi,
>
> Looks pretty interesting! some comments:
>
> - patch 4/7 hasn't made it to the list?
>   

Probably too big.  It's also the ugliest.  I'll split it and resend (not 
through thunderbird though... ate all my tabs!).


> - it would be useful for reviewing this if you could post example code
>   making use of the /dev/kvm interfaces - they seem fairly complex.
>   

Working code is fairly hairy, since it's emulating a PC.  That'll be on 
sourceforge once they approve my new project.

In general one does

  open("/dev/kvm")
  ioctl(KVM_SET_MEMORY_REGION) for main memory
  ioctl(KVM_SET_MEMORY_REGION) for the framebuffer
  ioctl(KVM_CREATE_VCPU) for the obvious reason
  if (debugger)
    ioctl(KVM_DEBUG_GUEST) to singlestep or breakpoint the guest
  while (1) {
     ioctl(KVM_RUN)
     switch (exit reason) {
         handle mmio, I/O etc. might call
            ioctl(KVM_INTERRUPT) to queue an external interrupt
            ioctl(KVM_{GET,SET}_{REGS,SREGS}) to query/modify registers
            ioctl(KVM_GET_DIRTY_LOG) to see which guest memory pages 
have changed
     }

I have some simple test code, I'll clean it up and post it.

> - why do it this way rather than through a virtual machine monitor
>   such as Xen? what do you gain from having the virtual machines
>   encapsulated as Linux processes?
>   

- architectural simplicity: instead of splitting memory management and 
scheduling between Xen and domain 0, use just the Linux memory 
management and scheduler
- use standard tools (top(1), kill(1)) and security model (permissions 
on /dev/kvm)
- much smaller codebase (although paravirtualization is not included (yet))
- no changes to core code
- easy to upgrade an existing system
- easier for drive-by virtualization (modprobe kvm; do-your-stuff; 
ctrl-C; rmmod kvm)
- longer term, better performance since there's no need to switch to 
domain 0 for I/O (instead just switch to user mode of the VM's process)

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

