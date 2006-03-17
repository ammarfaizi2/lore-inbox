Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWCQKJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWCQKJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 05:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWCQKJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 05:09:34 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:13722 "EHLO
	iramx2.ira.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S1751283AbWCQKJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 05:09:33 -0500
In-Reply-To: <20060315230012.GA1919@elf.ucw.cz>
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <20060315230012.GA1919@elf.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <869E58AF-339F-4660-8458-36F58A5E35EF@ira.uka.de>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
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
Date: Fri, 17 Mar 2006 11:08:46 +0100
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.749.3)
X-Spam-Score: -4.3 (----)
X-Spam-Report: -1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 16, 2006, at 00:00 , Pavel Machek wrote:

>> The question of licensing of such ROM code is a completely separate
>> issue.  We are not trying to hide some proprietary code by putting it
>> inside of a ROM to keep it hidden.  In fact, you can disassemble the
>> ROM code and see it quite readily - and you know all of the entry
>> points.
>
> Could you disassemble one entry point for us and describe how it  
> works?


Here is how I construct my ROM.  My apologies if my email client  
wraps any of the lines.

I have a set of boundary functions between assembler and C code,  
identified by a suffix on the function names: _ext (stands for  
"extended" in response to the evolution of my ROM).  They accept a  
parameter called burn_clobbers_frame_t:
struct burn_clobbers_frame_t {
     word_t burn_ret_address;   /* Return address to the ROM */
     word_t frame_pointer;          /* This parameter. */
     word_t edx;
     word_t ecx;
     word_t eax;
     word_t guest_ret_address;
     word_t params[0];   /* Anything the guest pushed on the stack */
};
I use this structure for the non-performance critical functions.

Here are some of the assembler macros for constructing the ROM:

vmi_stub_simple WRMSR, afterburn_cpu_write_msr_ext
vmi_stub_simple RDMSR, afterburn_cpu_read_msr_ext

vmi_stub_simple SetGDT, afterburn_cpu_write_gdt32_ext
vmi_stub_simple SetLDT, afterburn_cpu_lldt_ext
vmi_stub_simple SetIDT, afterburn_cpu_write_idt32_ext
vmi_stub_simple SetTR,  afterburn_cpu_ltr_ext


macro vmi_stub_simple name func
/* Invoke a front-end C function that expects a burn_clobbers_frame_t as
* the parameter.
*/
         vmi_stub_begin \name
         __afterburn_save_clobbers
         push    %esp
         subl    $8, 0(%esp)
         vmi_call_relocatable \func
         __afterburn_restore_clobbers 4
         ret
         vmi_stub_end
.endm


.macro vmi_stub_begin name
/* Define the prolog of a VMI stub.  */
         vmi_area_begin \name
         burn_counter VMI_\name
         burn_counter_inc VMI_\name
.endm

.macro vmi_stub_end
/* Define the epilog of a VMI stub.  */
         .previous
.endm

.macro vmi_area_begin name
/* Define the start of a VMI area. */
         .section .vmi_rom, "ax"
         .org vmi_rom_offset_\name
         .globl VMI_\name
         .type VMI_\name,@function
VMI_\name:
.endm

.macro vmi_call_relocatable func
         9191: call      \func
         .pushsection .vmi_patchups, "aw"
         .balign 4
         .long 9191b
         .popsection
.endm

.macro vmi_jmp_relocatable target
         9191: jmp       \target
         .pushsection .vmi_patchups, "aw"
         .balign 4
         .long 9191b
         .popsection
.endm


extern "C" void
afterburn_cpu_write_gdt32_ext( burn_clobbers_frame_t *frame )
{
     get_cpu()->gdtr =  *(dtr_t *)frame->eax;
}



The ROM entry points are only half the solution.  The other half  
involves Xen callbacks and traps.  The system call trap is  
constructed to directly activate Linux's system call trap.   
Everything else jumps directly into the ROM for filtering reasons.   
The page-fault handler stays in assembler (because page faults are a  
performance issue; on a linux kernel build, they occur almost as  
frequently as system calls).  The remaining traps enter C code, and  
look like this:

trap_wrapper id=8, use_error_code=1     /* Double fault exception */
trap_wrapper id=9, use_error_code=0     /* Coprocessor segment  
overrun */
trap_wrapper id=10, use_error_code=1    /* Invalid TSS exception */
trap_wrapper id=11, use_error_code=1    /* Segment not present */
trap_wrapper id=12, use_error_code=1    /* Stack fault exception */
trap_wrapper id=13, use_error_code=1    /* general protection fault */

.macro trap_wrapper id, use_error_code
entry trap_wrapper_\id
.if \use_error_code
         subl    $4, %esp        /* Fault addr. */
.else
         subl    $8, %esp        /* Error code, fault addr. */
.endif
         pushl   $(\id | (\use_error_code << 31))        /* Frame ID. */
         cpu_save_all
         movl    %esp, %eax      /* A pointer to the CPU save frame. */
         call    trap
         jmp     afterburn_exit
.endm


entry afterburn_exit
         cpu_restore_all 0, 12   /* Error code, fault addr, frame id. */
         iret


extern "C" void __attribute__(( regparm(1) ))
trap( xen_frame_t *frame )
{
     if( EXPECT_FALSE(frame->iret.ip >= CONFIG_WEDGE_VIRT) ) {
         con << "Unexpected fault in the ROM, ip " << (void *)frame- 
 >iret.ip
             << '\n';
         DEBUGGER_ENTER(frame);
         panic();
     }

     u8_t *opstream = (u8_t *)frame->iret.ip;

     if( cpu_t::get_segment_privilege(frame->iret.cs) == 3 )
     {
         // A user-level fault.

        ... check for TLS issues ...

     }


     // Update virtual CPU state, and deliver the trap to the guest  
kernel.
     xen_deliver_async_vector( frame->get_id(), frame,
             frame->uses_error_code());
}

