Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310304AbSCPMfL>; Sat, 16 Mar 2002 07:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310305AbSCPMfD>; Sat, 16 Mar 2002 07:35:03 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:39953 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S310304AbSCPMet>;
	Sat, 16 Mar 2002 07:34:49 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Paul Mackerras <paulus@samba.org>, Balbir Singh <balbir_soni@yahoo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nice values for kernel modules 
In-Reply-To: Your message of "Sat, 16 Mar 2002 11:27:03 -0000."
             <Pine.LNX.4.33.0203161126130.1090-100000@einstein.homenet> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Mar 2002 23:34:35 +1100
Message-ID: <16358.1016282075@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002 11:27:03 +0000 (GMT), 
Tigran Aivazian <tigran@veritas.com> wrote:
>On Sat, 16 Mar 2002, Paul Mackerras wrote:
>
>> Keith Owens writes:
>>
>> > On Sat, 16 Mar 2002 09:51:16 +0000 (GMT),
>> > <tigran@aivazian.fsnet.co.uk> wrote:
>> > >jump to sys_nice() indirectly via exported sys_call_table[].
>> >
>> > Breaks on ia64 and ppc.
>>
>> Not that I want to encourage this sort of thing, but why would it
>> break on ppc?

Should have been ppc64, not ppc.

>and also why would it break on ia64. I can understand __mips but why ia64?

Address of function text is NOT the same as &function.  On many
architectures &function is the same as the first byte of the function
text but not on all architectures.  On IA64 &func points to a function
descriptor which contains { void * __gp; void * function_text; }.  When
you call a function on ia64, the code is really :-

  save current __gp
  load address of function_text
  load __gp (global data pointer) for new function
  call function_text
  restore original __gp

Within the kernel, all direct function calls (call function by name)
are assumed to have the same __gp so the code reduces to :-

  load address of function_text
  call function_text

just like most other architectures, this is why syscalls within the
kernel work.

When the kernel calls a function via a pointer then __gp must be saved,
set and restored.  This is especially true when calling from the kernel
to a module or vice versa, I guarantee that kernel and modules have
different __gp values.

Fetching &sys_nice from the syscall table and blindly calling that
address from a module will crash the kernel.  PPC64 has a similar
problem, it has a function descriptor that contains 3 fields.

There is no architecture independent method for accessing syscall
entries _as functions_ from a module.  Code that works on ix86 will
break on ia64 and ppc64.  I can see no good reason why the syscall
table has been exported.

