Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbRE3FwC>; Wed, 30 May 2001 01:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262630AbRE3Fvx>; Wed, 30 May 2001 01:51:53 -0400
Received: from chiara.elte.hu ([157.181.150.200]:54538 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262628AbRE3Fvn>;
	Wed, 30 May 2001 01:51:43 -0400
Date: Wed, 30 May 2001 07:48:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 4 security holes in 2.4.4-ac8
In-Reply-To: <200105292257.PAA00192@csl.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0105300705160.1462-300000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-599642900-991201739=:1462"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-599642900-991201739=:1462
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 29 May 2001, Dawson Engler wrote:

> > Believe it or not, this one is OK :-)
> >
> > All callers pass in a pointer to a local stack kernel variable
> > in raddr.
>
> Ah.  I assumed that "sys_*" meant that all pointers were from user
> space --- is this generally not the case?  (Also, are there other
> functions called directly from user space that don't have the sys_*
> prefix?)

to automate this for the Stanford checker i've attached the
'getuserfunctions' script that correctly extracts these function names
from the 2.4.5 x86 entry.S file.

unfortunately the validation of the script will always be manual work,
although for the lifetime of the 2.4 kernel the actual format of the
entry.S file is not going to change. To make this automatic, i've added a
md5sum to the script itself, if entry.S changes then someone has to review
the changes manually. It's important to watch the md5 checksum, because
new system-calls can be added in 2.4 as well.

a few interesting facts. Functions that are called from entry.S but do not
have the sys_ prefix:

 do_nmi
 do_signal
 do_softirq
 old_mmap
 old_readdir
 old_select
 save_v86_state
 schedule
 schedule_tail
 syscall_trace
 do_divide_error
 do_coprocessor_error
 do_simd_coprocessor_error
 do_debug
 do_int3
 do_overflow
 do_bounds
 do_invalid_op
 do_coprocessor_segment_overrun
 do_double_fault
 do_invalid_TSS
 do_segment_not_present
 do_stack_segment
 do_general_protection
 do_alignment_check
 do_page_fault
 do_machine_check
 do_spurious_interrupt_bug

functions in the kernel source that have the sys_ prefix and use
asmlinkage but are not called from the x86 entry.S file:

 sys_accept
 sys_bind
 sys_connect
 sys_gethostname
 sys_getpeername
 sys_getsockname
 sys_getsockopt
 sys_listen
 sys_msgctl
 sys_msgget
 sys_msgrcv
 sys_msgsnd
 sys_recv
 sys_recvfrom
 sys_recvmsg
 sys_semctl
 sys_semget
 sys_semop
 sys_send
 sys_sendmsg
 sys_sendto
 sys_setsockopt
 sys_shmat
 sys_shmctl
 sys_shmdt
 sys_shmget
 sys_shutdown
 sys_socket
 sys_socketpair
 sys_utimes

the list is pretty big. There are 33 functions that are called from
entry.S but do not have the sys_ prefix or do not have the asmlinkage
declaration.

NOTE: there are other entry points into the kernel's 'protection domain'
as well, and not all of them are through function interfaces. Some of
these interfaces pass untrusted pointers and/or untrusted parameters
directly, but most of them pass a pointer to a CPU registers structure
which is stored on the kernel stack (thus the pointer can be trusted), but
the contents of the registers structure are untrusted and must not be used
unchecked.

1) IRQ handling, trap handling, exception handling entry points. I've
atttached the 'getentrypoints' script that extracts these addresses from
the i386 tree:

 divide_error
 debug
 int3
 overflow
 bounds
 invalid_op
 device_not_available
 double_fault
 coprocessor_segment_overrun
 invalid_TSS
 segment_not_present
 stack_segment
 general_protection
 spurious_interrupt_bug
 coprocessor_error
 alignment_check
 machine_check
 simd_coprocessor_error
 system_call
 lcall7
 lcall27

all of these functions get parameters passed that are untrusted.

2) bootup parameter passing.

there is a function entry point, start_kernel, but there is also lots of
implicit parameter passing, values filled out by the boot code, and
parameters stored in hardware devices (eg. PCI settings and more). These
all are theoretical protection domain entry points, but impossible to
check automatically - the validity of current system state will have to be
checked manually. (and in most cases it can be trusted - but not all
cases.) Some 'unexpected' boot-time entry points: initialize_secondary on
SMP systems for example.

3) manually constructed unsafe entry points which are hard to automate.
include/asm-i386/hw_irq.h's BUILD macros are used in a number of places.
One type of IRQ building uses do_IRQ() as an entry point. The SMP
code builds the following entry points:

 reschedule_interrupt
 invalidate_interrupt
 call_function_interrupt
 apic_timer_interrupt
 error_interrupt
 spurious_interrupt

but most of these pass no parameters, but apic_timer_interrupt does get
untrusted parameters.

4) BIOS exit/entry points, eg in the APM code. Impossible to check, we
have to trust the BIOS's code.


i think this mail should be a more or less complete description of all
entry points into the kernel. (Let me know if i missed any of them, or any
of the scripts misidentifies entry points.)

	Ingo

--8323328-599642900-991201739=:1462
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=getentrypoints
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0105300748590.1462@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=getentrypoints

DQpncmVwIC1FICdzZXRfdHJhcF9nYXRlfHNldF9zeXN0ZW1fZ2F0ZXxzZXRf
Y2FsbF9nYXRlJyBhcmNoL2kzODYvKi8qLmMgYXJjaC9pMzg2LyovKi5oIHwg
Z3JlcCAtdiAnc3RhdGljIHZvaWQnIHwgY3V0IC1kLCAtZjItIHwgc2VkICdz
LyYvL2cnIHwgY3V0IC1kXCkgLWYxDQoNCg==
--8323328-599642900-991201739=:1462
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=getuserfunctions
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0105300748591.1462@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename=getuserfunctions

DQppZiBbICJgbWQ1c3VtIGFyY2gvaTM4Ni9rZXJuZWwvZW50cnkuU2AiICE9
ICIwZTE5YjA4OTJmNGJkMjUwMTVmNWYxYmZlOTBiNDQxYSAgYXJjaC9pMzg2
L2tlcm5lbC9lbnRyeS5TIiBdOyB0aGVuIGVjaG8gImVudHJ5LlMgZmlsZSdz
IE1ENXN1bSBjaGFuZ2VkISBQbGVhc2UgcmV2YWxpZGF0ZSB0aGUgY2hhbmdl
cyBhbmQgY2hhbmdlIHRoZSBtZDVzdW0gaW4gdGhpcyBzY3JpcHQuIjsgZXhp
dCAtMTsgZmkNCg0KKGdyZXAgJ2NhbGwgUycgYXJjaC9pMzg2L2tlcm5lbC9l
bnRyeS5TICB8IGdyZXAgJ1soKV0nOyBncmVwICdcLmxvbmcgU1lNQk9MX05B
TUUnIGFyY2gvaTM4Ni9rZXJuZWwvZW50cnkuUzsgZ3JlcCAncHVzaGwgXCQg
U1lNQk9MJyBhcmNoL2kzODYva2VybmVsL2VudHJ5LlMpIHwgY3V0IC1kXCgg
LWYyIHwgY3V0IC1kXCkgLWYxIHwgc29ydCB8IHVuaXENCg0K
--8323328-599642900-991201739=:1462--
