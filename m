Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751526AbWCRAtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWCRAtV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWCRAtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:49:21 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:60112 "EHLO
	iramx2.ira.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S1750967AbWCRAtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:49:20 -0500
In-Reply-To: <20060317211146.GP15997@sorel.sous-sol.org>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <20060315230012.GA1919@elf.ucw.cz> <869E58AF-339F-4660-8458-36F58A5E35EF@ira.uka.de> <20060317211146.GP15997@sorel.sous-sol.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DE41DEAE-3CE5-43D8-8784-DDBC58CE2ABB@ira.uka.de>
Cc: Pavel Machek <pavel@ucw.cz>, Zachary Amsden <zach@vmware.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rik Van Riel <riel@redhat.com>, Jyothy Reddy <jreddy@vmware.com>,
       Jack Lo <jlo@vmware.com>, Kip Macy <kmacy@fsmware.com>,
       Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Content-Transfer-Encoding: 7bit
From: Joshua LeVasseur <jtl@ira.uka.de>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
Date: Sat, 18 Mar 2006 01:49:03 +0100
To: Chris Wright <chrisw@sous-sol.org>
X-Mailer: Apple Mail (2.749.3)
X-Spam-Score: -4.3 (----)
X-Spam-Report: -1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 17, 2006, at 22:11 , Chris Wright wrote:

> * Joshua LeVasseur (jtl@ira.uka.de) wrote:
>> extern "C" void
>> afterburn_cpu_write_gdt32_ext( burn_clobbers_frame_t *frame )
>> {
>>     get_cpu()->gdtr =  *(dtr_t *)frame->eax;
>> }
>
> What is this get_cpu()?  Accessing data structure that's avail. in ROM
> and shared with hypervisor...could you elaborate a bit here?
>
> thanks,
> -chris


VMI is a very versatile interface due to the ROM; within the ROM you  
can translate the instruction set architecture and device register  
activity (as represented by the VMI interface) to a variety of  
hypervisor interfaces.  I use a virtual CPU to help perform the  
translation.  The performance of virtualization depends on the extent  
to which you can minimize interaction with the hypervisor via  
hypercalls.  Many of the operations needn't be exposed to the  
hypervisor, and only operate on the virtual CPU, and thus remain  
completely within the ROM.  The goal is to minimize interaction with  
the hypervisor.

I don't share the virtual CPU with the hypervisor.  There probably  
are performance benefits for codesign between the hypervisor and ROM,  
but I haven't had that luxury; I take the hypervisors as given and  
none of them are fundamentally designed to use a ROM.  On the other  
hand, it makes sense to concentrate virtualization within the ROM,  
rather than the hypervisor, for the same arguments you can make for  
implementing functionality in an application rather than the kernel.

I've implemented ROMs for two (open source) hypervisors so far, and  
try to share as much code between them as possible.  The get_cpu() is  
an abstraction to help hide the hypervisor specifics for locating the  
virtual CPU (and it handles multiprocessor issues).

To help illustrate the role of the ROM, consider using Linux as a  
hypervisor, i.e., Linux-on-Linux but with the guest kernel using the  
VMI interface [1].  The ROM would translate the low-level operations  
of the guest kernel into the system calls of the host Linux, and it  
would be important to minimize the amount of interaction with the  
host Linux.  Consider interrupt delivery, which would probably be  
mapped to POSIX signals.  VMI offers VMI_EnableInterrupts(),  
VMI_DisableInterrupts(), VMI_GetInterruptMask(), and  
VMI_SetInterruptMask().  All of these operations are executed  
frequently by Linux, and it would be critical to limit their side  
effects to within the ROM; for performance reasons, they mustn't map  
to POSIX signal mask/unmask operations.  The solution is to update  
only the EFLAGS in the virtual CPU when the guest kernel invokes  
VMI_EnableInterrupts, DisableInterrupts, etc..  Then the ROM must  
always accept asynchronous POSIX signal delivery, and must only  
forward asynchronous events to the guest kernel if interrupts are  
enabled in the virtual CPU.  If the virtual CPU's interrupts are  
disabled, then the event is only recorded in the virtual PIC, and  
delivered at the next VMI_EnableInterrupts() or VMI_SetInterruptMask().

[1]  Linux-on-Linux would probably limp with the current VMI.  A  
couple changes would be necessary, such as permitting the Linux  
kernel to run at ring 3, and offering put_user() and get_user()  
hooks, since the guest applications and guest kernel must use  
different host address spaces.  Unfortunately, put_user() and get_user 
() hooks are higher-level interfaces that don't fit well within VMI.   
For other CPU architectures with only two privilege levels, put_user 
() and get_user() hooks may be necessary too.


Joshua


