Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUFKIfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUFKIfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 04:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUFKIfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 04:35:44 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12716 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261439AbUFKIfe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 04:35:34 -0400
In-Reply-To: <20040609130406.7942507c@lembas.zaitcev.lan>
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF0EE62CAE.0C17152B-ON42256EB0.002E89AA-42256EB0.002F37DC@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 11 Jun 2004 10:35:44 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 11/06/2004 10:35:26
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> > --- linux-2.6/arch/s390/kernel/compat_wrapper.S          Mon Jun  7
16:07:24 2004
> > +++ linux-2.6-s390/arch/s390/kernel/compat_wrapper.S           Mon Jun
7 16:07:53 2004
> > @@ -1097,6 +1097,8 @@
> >          lgfr        %r4,%r4                                   # int
> >          llgtr             %r5,%r5                                   #
struct compat_timespec *
> >          llgtr             %r6,%r6                                   #
u32 *
> > +        lgf         %r0,164(%r15)                       # int
> > +        stg         %r0,160(%r15)
> >          jg          compat_sys_futex        # branch to system call
> >
> >          .globl            sys32_setxattr_wrapper
>
> Is it just me, or this could he above stand a use of STACK_FRAME_OVERHEAD
> instead of 160? I envision a time when Ulrich Weigand comes out with
> a gcc -fkernel, and at that time we'll need all such references
> configurable.
No, the offset of the arguments > 5 on the stack is 96 bytes on 31 bit and
160 bytes on 64 bit, period. This won't change because it is ABI relevant.

> > diff -urN linux-2.6/include/asm-s390/ptrace.h linux-2.6-s390/include/asm-s390/ptrace.h
> > --- linux-2.6/include/asm-s390/ptrace.h            Mon May 10 04:32:54 2004
> > +++ linux-2.6-s390/include/asm-s390/ptrace.h             Mon Jun  7 16:07:53 2004
> > @@ -303,6 +303,7 @@
> >   */
> >  struct pt_regs
> >  {
> > +        unsigned long args[1];
> >          psw_t psw;
>
> This worries me, together with
>    (__u32*)((addr_t) &__KSTK_PTREGS(child)->psw
>
> Why not to place the necessary word outside of the struct?
> It just logically doesn't belong. Might be just as easy to
> do that mvc to other place.
Well my first implementation had the arguments outside the pt_regs. But
I came to the conclusion that this is wrong. First of all pt_regs is
supposed to describe what is put on the stack during a system call and
this includes the additional parameter. The second, more important
thing is that without a structure describing exactly what's put on the
stack it is impossible for lcrash or crash to decode the system entry
stack frame. This is something we definitly want to have.
I though about the implications of the pt_regs changes for some time.
Since the pt_regs structure is solely used to put the register on the
kernel stack I don't see a problem. Every other structure is independent
of it (at least in the 2.6 kernels).

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


