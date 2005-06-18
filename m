Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVFRO3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVFRO3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 10:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVFRO3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 10:29:13 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:45516 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262123AbVFRO3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:29:04 -0400
Date: Sat, 18 Jun 2005 16:29:01 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Roy Lee <roylee17@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Could someone tell me more about the asmlinkage
Message-ID: <20050618162901.0068ff8a@localhost>
In-Reply-To: <42B42907.8060404@gmail.com>
References: <42B42907.8060404@gmail.com>
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2005 22:00:39 +0800
Roy Lee <roylee17@gmail.com> wrote:

> It says that "To tell a compiler not to use the argument in the
> registers". but the  syscall's argument does pass the arguments though
> registers, doesn't it?

yes, user space programs put arguments in registers (ebx, ecx, edx...) but
see what happens later...

1) user space programs do something like this:

mov	$SYSCALLNUMER, %eax
mov	$ARG1, %ebx
mov	$ARG2, %ecx
...
int	$0x80	------ go to kernel syscall handler --->


---> arch(i386/kernel/entry.S:

....
	# system call handler stub
ENTRY(system_call)
	pushl %eax			# save orig_eax
	SAVE_ALL
	GET_THREAD_INFO(%ebp)
					# system call tracing in operation
	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb
*/	testw
$(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),TI_flags(%ebp)	jnz
syscall_trace_entry	cmpl $(nr_syscalls), %eax
	jae syscall_badsys
syscall_call:
	call *sys_call_table(,%eax,4)
	movl %eax,EAX(%esp)		# store the return value
...


notice just these 2 things:

1) SAVE_ALL  ---> it's a MACRO that do this:

#define SAVE_ALL \
	cld; \
	pushl %es; \
	pushl %ds; \
	pushl %eax; \
	pushl %ebp; \
	pushl %edi; \
	pushl %esi; \			....
	pushl %edx; \			> ARG3 <
	pushl %ecx; \			> ARG2 <
	pushl %ebx; \			> ARG1 <
	movl $(__USER_DS), %edx; \
	movl %edx, %ds; \
	movl %edx, %es;

2) call *sys_call_table(,%eax,4)

this calls the "C" system call function


So, since the arguments are passed on the stack (see SAVE_ALL) the "C"
function MUST take them from the stack.

> 
> While tracing the code, I found the asmlinkage was a #define of a extern
> "C", and  the only usage of extern "C" that I know is to avoid the name
> mangling while calling  a C function in C++. Does the asmlinkage here have
> connection with that?

#define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))

SEE "__attribute__((regparm(0)))"... it tells GCC that the arguments are on
the STACK even if "-mregparm=NUMER" option is used.

--
	Paolo Ornati
	Linux 2.6.12 on x86_64
