Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbSLRD44>; Tue, 17 Dec 2002 22:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbSLRD44>; Tue, 17 Dec 2002 22:56:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44813 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266271AbSLRD4z>; Tue, 17 Dec 2002 22:56:55 -0500
Date: Tue, 17 Dec 2002 20:05:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFFED33.2020201@transmeta.com>
Message-ID: <Pine.LNX.4.44.0212171956170.1230-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, H. Peter Anvin wrote:
> Ulrich Drepper wrote:
> >
> > That's good to know but not what I meant.
> >
> > I referred to syscall/sysret opcodes.  They are broken in their own way
> > (destroying ecx on kernel entry) but at least they preserve eip.
> >
>
> Destroying %ecx is a lot less destructive than destroying %eip and %esp...

Actually, as far as the kernel is concerned, they are about equally bad.

Destroying %eip is the _least_ bad register to destroy, since the kernel
can control that part, and it is trivial to just have a single call site.

But destroying %esp or %ecx is pretty much totally equivalent - it
destroys one user mode register, and it doesn't really matter _which_ one.
In both cases 32 bits of user information is destroyed, and they are 100%
equivalent as far as the kernel is concerned.

On intel with sysenter, destroying %esp means that we have to save the
value in %ebp, and we thus lose argument 6.

On AMD, %ecx is destroyed on entry, which means that we lose argument 2
(which i smore important than arg6, but that only means that the AMD
trampoline will have to move the old value of %ecx into %ebp, at which
point the two approaches are again exactly the same).

In either case, one GP register is irrevocably lost, which means that
there are only 5 GP registers left for arguments. And thus both Intel and
AMD will have _exactly_ the same problem with six-argument system calls.

The _sane_ thing to do would have been to save the old user %esp/%eip on
the kernel stack. Preferably together with %eflags and %ss and %cs, just
for completeness. That stack save part is _not_ the expensive or complex
part of a "int 0x80" or long call (the _complex_ part is all the stupid
GDT/IDT lookups and all the segment switching crap).

In short, both AMD and Intel optimized away too much.

The good news is that since both of them suck, it's easier to make the
six-argument decision. Since six arguments are problematic for all major
"fast" system calls, my executive decision is to just say that
six-argument system calls will just have to continue using the old and
slower system call interface. It's kind of a crock, but it's simply due to
silly CPU designers.

			Linus

