Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSHAPqt>; Thu, 1 Aug 2002 11:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315463AbSHAPqt>; Thu, 1 Aug 2002 11:46:49 -0400
Received: from daimi.au.dk ([130.225.16.1]:34961 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315457AbSHAPqs>;
	Thu, 1 Aug 2002 11:46:48 -0400
Message-ID: <3D49588D.8B1FA19E@daimi.au.dk>
Date: Thu, 01 Aug 2002 17:49:33 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: stas.orel@mailcity.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
References: <Pine.LNX.3.95.1020801105021.26692A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 1 Aug 2002, Kasper Dupont wrote:
> 
> > Stas Sergeev wrote:
> > >
> > > Hello.
> > >
> > > According to this:
> > > http://support.intel.com/design/intarch/techinfo/Pentium/instrefi.htm#89126
> > > AC flag is cleared by an INT
> > > instruction executed in real mode.
> > > The attached patch implements that
> > > functionality and solves some
> > > problems recently discussed in
> > > dosemu mailing list.
> >
> > This sounds a little strange to me. AC is in the upper 16 bit
> > of the EFLAGS register, so it is not saved on an interrupt
> > where only lower 16 bits is saved. This means that when we
> > clear it on the interrupt, the value will be lost for good.
> >
> 
> Alignment-check does not exist in real mode. Therefore AC flags
> mean nothing.

Dunno, I didn't verify that.

> In fact, you can't even access more than 16 bits
> of the flags register in real mode, even by playing tricks
> (pushf pushes only 16 bits, even if you prefix it with 0x66).

Ehrm, on my CPU (AMD K6/2) pushf and popf does use all 32 bits
of the flag register when prefixed with 0x66 in real mode. And
the emulation of those instructions in the Linux kernel does
that too. Any documentatin on an implementation doing otherwise?

> 
> > I can see the spec says it, so we'd better do that. But does
> > the spec make any sense? And does the CPU really loose the
> > AC flag on every interrupt in real mode?
> >

I just verified, yes the AC flag does get cleared.

> 
> Sure, there is no alignment check in real mode. You can access
> anything at any offset and an offset running off the end wraps
> back through zero.

Did you test that with AC enabled?

> 
> > A few other things got me wondering, it says there is tested
> > for enough space in the stack. Does this mean something like
> > if (SP<6) trap(); ? If it does, we should change do_int to
> > actually do this. And how should we actually trap if there
> > is not enough space for pushing values?
> >
> 
> If you execute an INT without enough stack, i.e., the SP
> gets pushed through zero, as long as nobody trashed its values,
> it will be poped back through zero on the IRET. Obviously a
> coding bug, but it will still work.

That is also what I believed, but the specification obviously
says something else.

> 
> > And does this testing apply to other instructions as well?
> >
> > And it also says the IDT size is tested. But does that
> > concept even exist in real mode?
> >
> 
> The IDT actually exists in real mode, and its layout is what
> defines the interrupt table starting at offset 0. In fact, when
> a BIOS needs to transition from/to/back 16/32/16 mode, it saves
> the 16-bit table SIDT, so it can restore it with LIDT later.

Does that mean you can setup a 32 bit interrupt table in
real mode????

> 
> > And finally, why do we have a 32 bit IRET instruction, but
> > no 32 bit INT instruction? Is that really correct?
> >
> 
> Int NN only references an interrupt number. In 32-bit mode, it
> is a 32-bit interrupt which gets completed with a 32-bit IRET.
> That number 'NN', references the entries in an IDT.

I was talking about real mode where it seems we have a
32-bit IRET instruction. At least that is what the kernel
emulates.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
