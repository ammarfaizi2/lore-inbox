Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269481AbUIRNJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269481AbUIRNJj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 09:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269479AbUIRNJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 09:09:38 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:51980 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269491AbUIRNJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 09:09:04 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Stas Sergeev <stsp@aknet.ru>
Subject: Re: ESP corruption bug - what CPUs are affected?
Date: Sat, 18 Sep 2004 16:08:53 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <4149D243.5050501@aknet.ru> <200409180104.09796.vda@port.imtp.ilyichevsk.odessa.ua> <414C14CD.7030200@aknet.ru>
In-Reply-To: <414C14CD.7030200@aknet.ru>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409181608.18440.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 September 2004 13:58, Stas Sergeev wrote:
> Hello.
>
> Denis Vlasenko wrote:
> >> This is what happens: CPU is doing IRET in 32bit mode.
> >> Stack layout:
> >
> > +20 (empty) <--- SS:ESP
> > +16 old_CS
> > +12 old_EIP
> >  +8 old_EFLAGS
> >  +4 old_SS
> >  +0 old_ESP
>
> JFYI, looks like you swapped CS<-->EIP and SS<-->ESP
> on your stack frame layout.

Hm. More than that. My figure is totally incorrect.
Corrected one:

+16 old_SS
+12 old_ESP
 +8 old_EFLAGS
 +4 old_CS
 +0 old_EIP <--- SS:ESP

Addresses grow from the bottom in this fig.
Note that offsets are always stored in lower address
relative to where selectors are stored.

> > If old_SS references 'small' data segment (16-bit one),
> > processor does not restore ESP from old_ESP.
> > It restores lower 16 bits only. Upper 16 bits are filled
> > with garbage (or just not modified at all?).
>
> Not modified at all, yes. That's why it is always
> greater than TASK_SIZE (0xc0000000) - it is still
> in a kernel space.
>
> > This works fine because processor uses SP, not ESP,
> > for subsequent push/pop/call/ret operations.
> > But if code uses full ESP, thinking that upper 16 bits are zero,
> > it will crash badly. Correct me if I'm wrong.
>
> That's correct. But you should note that the
> program not just "thinks" that the upper 16 bits
> are zero. It writes zero there itself, and a few
> instructions later - oops, it is no longer zero...
> My test-case does "hlt" to force the context switch,
> but in fact it is not necessary. I tried an
> empty loop instead of HLT. If the loop is long
> enough and some IRQ being handled by the kernel
> in a mean time, the ESP is corrupted. So the
> user-space never knows when exactly it gets corrupted.
> And, as I mentioned already, since the code is 32bit,
> it just does the things like "mov ebp,esp" and
> uses ebp to access the function params and locals,
> which crashes, or uses ESP directly to access
> something, etc.
>
> > Hmm. I think you need to *emulate* this IRET.
> > Is this IRET happens in kernel or in dosemu code?
>
> The problem happens only when iret is used to
> switch to another priv level. So it is the kernel's
> iret of course, something to the effect of entry.S:128
> I think. The control is transferred from kernel code
> to the DOS code directly. dosemu code is completely
> bypassed. dosemu have no chances to intercept that.
> The DOS program is running on its own (as long as
> it doesn't trigger an exception, or SIGALRM comes),
> and the CPU is corrupting its ESP in *any* place,
> since it happens when an external IRQ arrives.

Aha. The only way to sanely handle it is to
hack on entry.S I'm afraid. Something like rewriting
CS:EIP so that it returns to a small ring-3 trampoline
which clears upper 16 bits of ESP and jumps to original CS:EIP.

You may use ring-3 user stack as a place to save original CS:EIP,
and then just do RETF. This way, trampoline boils down to

	movzxl	%sp,%esp
	retf

which does not touch EFLAGS and you don't need to bother
with thinking about preserving it. IRET will restore it,
and trampoline wouldn't touch it anymore.

Now, how to detect when to use this? Hmm.... the simplest thing
is to check that

(old_ESP <= 0xffff) && !(old_EFLAGS & VM_MASK) && (descr_old_SS is 16bit one)

This will cost us only one comparison in the normal
path, because typically ESP of Linus executables
is greater than 0xffff.

P.S.

# gcc -o stk1 -O2 stk1.c
# ./stk1
old_ss=0x7b new_ss=0x7f
In sighandler: esp=bffffb30
old_esp=0xbffffb30 new_esp=0xc618fb30
BUG!

--
vda

