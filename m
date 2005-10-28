Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbVJ1XH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVJ1XH0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVJ1XH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:07:26 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:23641 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750745AbVJ1XHX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:07:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R5vLYFSMYWzHVVzrz0bJFo5EzQ0q2uiCoWijdSWPdv/KqaDT0xo8z9Q/PsI8gbj3ld1vWGjMn0CMfLKgtFlVuYoefEz22HJMbiB1wJYcYtgBdmTEhXRI+fLAM9gfnVgbu4jx5a+J4Y5INqRntjbQoCl18f6boLGVRbWS+BsQwuQ=
Message-ID: <5bdc1c8b0510281607g3c761c6ct4e268a298b611fd7@mail.gmail.com>
Date: Fri, 28 Oct 2005 16:07:22 -0700
From: Mark Knecht <markknecht@gmail.com>
To: William Weston <weston@lysdexia.org>
Subject: Re: Overruns are killing my recordings.
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0510281403410.26693@echo.lysdexia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3aa654a40510271212j13e0843s9de81c02f4e766ac@mail.gmail.com>
	 <200510271528.28919.diablod3@gmail.com>
	 <3aa654a40510271257t62d2fd82n5f2bcbcae2bcba9d@mail.gmail.com>
	 <1130447216.19492.87.camel@mindpipe>
	 <3aa654a40510271700l49fb06cfv37d8b6030df5ac49@mail.gmail.com>
	 <1130470852.4363.26.camel@mindpipe>
	 <5bdc1c8b0510280752y5b7a665cpfdd512d15f896482@mail.gmail.com>
	 <1130525006.4363.44.camel@mindpipe>
	 <5bdc1c8b0510281155w2b86be0bp9f85de02b806d664@mail.gmail.com>
	 <Pine.LNX.4.58.0510281403410.26693@echo.lysdexia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, William Weston <weston@lysdexia.org> wrote:
> On Fri, 28 Oct 2005, Mark Knecht wrote:
>
> > OK then I'll just hang tinght. I've not seen any response on the email
> > I sent about 2.6.14-rc5-rt7. I cannot build it. It fails like this:
> >
> > CC      arch/x86_64/kernel/sys_x86_64.o
> >  CC      arch/x86_64/kernel/x8664_ksyms.o
> >  CC      arch/x86_64/kernel/i387.o
> >  CC      arch/x86_64/kernel/syscall.o
> >  CC      arch/x86_64/kernel/vsyscall.o
> > arch/x86_64/kernel/vsyscall.c:57: error: `SEQLOCK_UNLOCKED' undeclared
> > here (not in a function)
> > make[1]: *** [arch/x86_64/kernel/vsyscall.o] Error 1
> > make: *** [arch/x86_64/kernel] Error 2
> > lightning linux #
> >
> > This is a new failure here since -rc5-rt3.
>
> I don't have a 64 bit machine to test on, but the following patch should
> at least make the compiler happy.  This is the only place outside of
> seqlock.h that SEQLOCK_UNLOCKED is used, btw.
>
> If this kernel gives you the 'BUG in get_monotonic_clock_ts' and 'time
> warped' warnings, then you may want to look at the '2.6.14-rc4-rt7' lkml
> thread for Steven's patch to fix the false positives.
>
> Cheers,
> --ww
>
>
> --- linux-2.6.14-rc5-rt7/arch/x86_64/kernel/vsyscall.c.orig     2005-10-25 14:20:21.000000000 -0700
> +++ linux-2.6.14-rc5-rt7/arch/x86_64/kernel/vsyscall.c  2005-10-28 14:08:37.000000000 -0700
> @@ -54,7 +54,7 @@
>  struct vsyscall_gtod_data_t __vsyscall_gtod_data __section_vsyscall_gtod_data;
>
>  extern seqlock_t vsyscall_gtod_lock;
> -seqlock_t __vsyscall_gtod_lock __section_vsyscall_gtod_lock = SEQLOCK_UNLOCKED;
> +seqlock_t __vsyscall_gtod_lock __section_vsyscall_gtod_lock = SEQLOCK_UNLOCKED(__section_vsyscall_gtod_lock);
>
>
>  #include <asm/unistd.h>
>
>

William,
   Thanks for trying but this patch has only uncovered mare problems
for me. Since it's Friday evening and I won't have much more time I
think that since 2.6.14 is out I should just wait for Ingo to release
patch-2.6.14-rt1 and we'll see how it goes from there.

   As for what I'm seeing here's what I have after the patch:

<SNIP>
        struct clocksource clock;
};

extern struct vsyscall_gtod_data_t vsyscall_gtod_data;
struct vsyscall_gtod_data_t __vsyscall_gtod_data __section_vsyscall_gtod_data;

extern seqlock_t vsyscall_gtod_lock;
seqlock_t __vsyscall_gtod_lock __section_vsyscall_gtod_lock =
SEQLOCK_UNLOCKED(__section_vsyscall_gtod_lock);


#include <asm/unistd.h>
<SNIP>

Here are the error messages:

  CC      arch/x86_64/kernel/syscall.o
  CC      arch/x86_64/kernel/vsyscall.o
arch/x86_64/kernel/vsyscall.c:57: error: parse error before '.' token
arch/x86_64/kernel/vsyscall.c:57: error: parse error before '.' token
arch/x86_64/kernel/vsyscall.c:57: error: parse error before '}' token
arch/x86_64/kernel/vsyscall.c:57: warning: implicit declaration of
function `aligned'
arch/x86_64/kernel/vsyscall.c:57: warning: left-hand operand of comma
expression has no effect
arch/x86_64/kernel/vsyscall.c:57: warning: left-hand operand of comma
expression has no effect
arch/x86_64/kernel/vsyscall.c:57: error: invalid lvalue in unary `&'
arch/x86_64/kernel/vsyscall.c:57: warning: use of compound expressions
as lvalues is deprecated
arch/x86_64/kernel/vsyscall.c:57: warning: use of compound expressions
as lvalues is deprecated
arch/x86_64/kernel/vsyscall.c:57: error: parse error before ')' token
arch/x86_64/kernel/vsyscall.c:57: error: parse error before '.' token
arch/x86_64/kernel/vsyscall.c:57: error: parse error before '}' token
In file included from include/asm/unistd.h:782,
                 from arch/x86_64/kernel/vsyscall.c:60:
include/asm/ptrace.h:97: error: `EF_PF' undeclared here (not in a function)
include/asm/ptrace.h:97: warning: excess elements in struct initializer
include/asm/ptrace.h:97: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:98: error: `EF_AF' undeclared here (not in a function)
include/asm/ptrace.h:98: warning: excess elements in struct initializer
include/asm/ptrace.h:98: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:99: error: `EF_ZF' undeclared here (not in a function)
include/asm/ptrace.h:99: warning: excess elements in struct initializer
include/asm/ptrace.h:99: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:100: error: `EF_SF' undeclared here (not in a function)
include/asm/ptrace.h:100: warning: excess elements in struct initializer
include/asm/ptrace.h:100: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:101: error: `EF_TF' undeclared here (not in a function)
include/asm/ptrace.h:101: warning: excess elements in struct initializer
include/asm/ptrace.h:101: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:102: error: `EF_IE' undeclared here (not in a function)
include/asm/ptrace.h:102: warning: excess elements in struct initializer
include/asm/ptrace.h:102: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:103: error: `EF_DF' undeclared here (not in a function)
include/asm/ptrace.h:103: warning: excess elements in struct initializer
include/asm/ptrace.h:103: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:104: error: `EF_OF' undeclared here (not in a function)
include/asm/ptrace.h:104: warning: excess elements in struct initializer
include/asm/ptrace.h:104: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:105: error: `EF_IOPL' undeclared here (not in a function)
include/asm/ptrace.h:105: warning: excess elements in struct initializer
include/asm/ptrace.h:105: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:106: error: `EF_IOPL_RING0' undeclared here (not
in a function)
include/asm/ptrace.h:106: warning: excess elements in struct initializer
include/asm/ptrace.h:106: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:107: error: `EF_IOPL_RING1' undeclared here (not
in a function)
include/asm/ptrace.h:107: warning: excess elements in struct initializer
include/asm/ptrace.h:107: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:108: error: `EF_IOPL_RING2' undeclared here (not
in a function)
include/asm/ptrace.h:108: warning: excess elements in struct initializer
include/asm/ptrace.h:108: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:109: error: `EF_NT' undeclared here (not in a function)
include/asm/ptrace.h:109: warning: excess elements in struct initializer
include/asm/ptrace.h:109: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:110: error: `EF_RF' undeclared here (not in a function)
include/asm/ptrace.h:110: warning: excess elements in struct initializer
include/asm/ptrace.h:110: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:111: error: `EF_VM' undeclared here (not in a function)
include/asm/ptrace.h:111: warning: excess elements in struct initializer
include/asm/ptrace.h:111: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:112: error: `EF_AC' undeclared here (not in a function)
include/asm/ptrace.h:112: warning: excess elements in struct initializer
include/asm/ptrace.h:112: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:113: error: `EF_VIF' undeclared here (not in a function)
include/asm/ptrace.h:113: warning: excess elements in struct initializer
include/asm/ptrace.h:113: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:114: error: `EF_VIP' undeclared here (not in a function)
include/asm/ptrace.h:114: warning: excess elements in struct initializer
include/asm/ptrace.h:114: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:115: error: `EF_ID' undeclared here (not in a function)
include/asm/ptrace.h:115: warning: excess elements in struct initializer
include/asm/ptrace.h:115: warning: (near initialization for
`(anonymous).lock.wait_list.dp_node')
include/asm/ptrace.h:116: error: parse error before ';' token
arch/x86_64/kernel/vsyscall.c:81: error: `tv' undeclared here (not in
a function)
arch/x86_64/kernel/vsyscall.c:81: error: called object is not a function
arch/x86_64/kernel/vsyscall.c:81: error: `tz' undeclared here (not in
a function)
arch/x86_64/kernel/vsyscall.c:81: error: called object is not a function
arch/x86_64/kernel/vsyscall.c:81: warning: excess elements in struct initializer
arch/x86_64/kernel/vsyscall.c:81: warning: (near initialization for
`(anonymous)')
arch/x86_64/kernel/vsyscall.c:81: error: parse error before ':' token
arch/x86_64/kernel/vsyscall.c:81: warning: excess elements in struct initializer
arch/x86_64/kernel/vsyscall.c:81: warning: (near initialization for
`(anonymous)')
arch/x86_64/kernel/vsyscall.c:81: warning: excess elements in struct initializer
arch/x86_64/kernel/vsyscall.c:81: warning: (near initialization for
`(anonymous)')
arch/x86_64/kernel/vsyscall.c:81: error: parse error before ')' token
arch/x86_64/kernel/vsyscall.c:84: error: initializer element is not constant
arch/x86_64/kernel/vsyscall.c:84: error: (near initialization for
`__vsyscall_gtod_lock.lock')
arch/x86_64/kernel/vsyscall.c:86: error: `cycle_delta' undeclared here
(not in a function)
arch/x86_64/kernel/vsyscall.c:86: warning: excess elements in struct initializer
arch/x86_64/kernel/vsyscall.c:86: warning: (near initialization for
`__vsyscall_gtod_lock')
arch/x86_64/kernel/vsyscall.c:98: warning: type defaults to `int' in
declaration of `now'
arch/x86_64/kernel/vsyscall.c:98: error: initializer element is not constant
arch/x86_64/kernel/vsyscall.c:98: warning: data definition has no type
or storage class
arch/x86_64/kernel/vsyscall.c:99: warning: type defaults to `int' in
declaration of `cycle_delta'
arch/x86_64/kernel/vsyscall.c:100: error: initializer element is not constant
arch/x86_64/kernel/vsyscall.c:100: warning: data definition has no
type or storage class
arch/x86_64/kernel/vsyscall.c:103: warning: type defaults to `int' in
declaration of `nsec_delta'
arch/x86_64/kernel/vsyscall.c:103: error: initializer element is not constant
arch/x86_64/kernel/vsyscall.c:103: warning: data definition has no
type or storage class
arch/x86_64/kernel/vsyscall.c:104: warning: type defaults to `int' in
declaration of `nsec_delta'
arch/x86_64/kernel/vsyscall.c:104: error: redefinition of 'nsec_delta'
arch/x86_64/kernel/vsyscall.c:103: error: previous definition of
'nsec_delta' was here
arch/x86_64/kernel/vsyscall.c:104: error: initializer element is not constant
arch/x86_64/kernel/vsyscall.c:104: warning: data definition has no
type or storage class
arch/x86_64/kernel/vsyscall.c:107: warning: type defaults to `int' in
declaration of `tv'
arch/x86_64/kernel/vsyscall.c:107: error: incompatible types in initialization
arch/x86_64/kernel/vsyscall.c:107: error: initializer element is not constant
arch/x86_64/kernel/vsyscall.c:107: warning: data definition has no
type or storage class
arch/x86_64/kernel/vsyscall.c:108: error: parse error before '{' token
arch/x86_64/kernel/vsyscall.c:108: warning: type defaults to `int' in
declaration of `__rem'
arch/x86_64/kernel/vsyscall.c:108: error: conflicting types for '__rem'
arch/x86_64/kernel/vsyscall.c:108: error: previous declaration of
'__rem' was here
arch/x86_64/kernel/vsyscall.c:108: error: `__base' undeclared here
(not in a function)
arch/x86_64/kernel/vsyscall.c:108: warning: data definition has no
type or storage class
arch/x86_64/kernel/vsyscall.c:108: warning: type defaults to `int' in
declaration of `nsec_delta'
arch/x86_64/kernel/vsyscall.c:108: error: redefinition of 'nsec_delta'
arch/x86_64/kernel/vsyscall.c:104: error: previous definition of
'nsec_delta' was here
arch/x86_64/kernel/vsyscall.c:108: error: redefinition of 'nsec_delta'
arch/x86_64/kernel/vsyscall.c:104: error: previous definition of
'nsec_delta' was here
arch/x86_64/kernel/vsyscall.c:108: warning: data definition has no
type or storage class
arch/x86_64/kernel/vsyscall.c:108: warning: type defaults to `int' in
declaration of `__rem'
arch/x86_64/kernel/vsyscall.c:108: warning: data definition has no
type or storage class
arch/x86_64/kernel/vsyscall.c:108: error: parse error before '}' token
arch/x86_64/kernel/vsyscall.c:114: warning: type defaults to `int' in
declaration of `__ret'
arch/x86_64/kernel/vsyscall.c:114: warning: data definition has no
type or storage class
arch/x86_64/kernel/vsyscall.c:114: error: parse error before '}' token
arch/x86_64/kernel/vsyscall.c: In function `vgettimeofday':
arch/x86_64/kernel/vsyscall.c:146: warning: implicit declaration of
function `do_vgettimeofday'
make[1]: *** [arch/x86_64/kernel/vsyscall.o] Error 1
make: *** [arch/x86_64/kernel] Error 2
lightning linux #

Thanks for trying,
Mark
