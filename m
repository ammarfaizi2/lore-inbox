Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311262AbSDDT4z>; Thu, 4 Apr 2002 14:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311418AbSDDT4q>; Thu, 4 Apr 2002 14:56:46 -0500
Received: from daimi.au.dk ([130.225.16.1]:53974 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S311262AbSDDT4l>;
	Thu, 4 Apr 2002 14:56:41 -0500
Message-ID: <3CACAFF3.B27C40B8@daimi.au.dk>
Date: Thu, 04 Apr 2002 21:56:35 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-12smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: stas.orel@mailcity.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre4-ac4
In-Reply-To: <3CACA4CB.9010301@yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev wrote:
> 
> Hello.
> 
> Kasper Dupont wrote:
> >> Linux 2.4.19pre4-ac4
> >    > o       Fix an additional vm86 case                     (Stas Sergeev)
> >    >         | Check DOSemu again and this code wants some good review
> >    [...]
> This patch have nothing to do with your
> and Manfred's exception handling fixes.
> You can find it here if you want to have
> a look:
> http://dosemu.sourceforge.net/~stas/traps.diff

Thanks, I haven't seen the patch before. I guess you are
right that it is not related to our fixes.

> It prevents Oops in some cases, esp. if the
> invalid instruction is executed in vm86.

Fine.

> 
> > I do consider the simplification to be safe.
> >    In that case the macro would get to look like this:
> >    #define CHECK_IF_IN_TRAP \
> >            if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
> >                    newflags |= TF_MASK;
> I think you are right: already popped value must
> not make sense in the stack and even if it does,
> it seems to be even better if the TF is not set
> there, so that we have the value exactly which was
> pushed.

I agree, I just didn't want to change it without knowing
if anything relied on that. BTW, is this feature something
Linux specific or should it be compatible with something
else?

> 
> > This is assuming Stas' way to use the macro. However since it
> >    looks like Stas' use the old macro, I think his code is buggy.
> The real bug was that set_vflags_long/short were used before
> the registers are changed, but they could return to
> userspace via set_IF() leaving the instuction executed
> only partially (not executed at all). This rendered vm86()
> disfunctional so that dosemu fails to even start in pre3-ac6.

Now, I start wondering why I didn't experience any problems.
(I tried another emulator, I don't yet understand what's
the difference.) But I see the problem, I wasn't considering
that set_vflags_* could return to userspace. 

> I have moved them down to fix the problem.
> The macro was forgotten to update:(
> 
> > And BTW does anybody happen to
> >    know some software actually using the feature implemented by
> >    CHECK_IF_IN_TRAP?
> dosemu's dosdebug uses it for force trace over iret
> and probably nobody else.
> 
> > I would appreachiate some comments on this subject.
> I think that your simplification for this macro is
> the best fix if someone really wants to use this
> dosdebug's traceing feature.

I have written, but not yet tested a patch:
http://www.daimi.au.dk/~kasperd/linux_kernel/vm86.2.4.19-pre4-ac4.patch

diff -Nur linux.old/arch/i386/kernel/vm86.c linux.new/arch/i386/kernel/vm86.c
--- linux.old/arch/i386/kernel/vm86.c	Thu Apr  4 13:29:56 2002
+++ linux.new/arch/i386/kernel/vm86.c	Thu Apr  4 13:28:41 2002
@@ -7,7 +7,8 @@
 /*
  *  Bugfixes Copyright 2002 by Manfred Spraul and
  *  Kasper Dupont <kasperd@daimi.au.dk>
- *
+ *  Simplifications Copyright 2002 by Stas Sergeev
+ *  and Kasper Dupont
  */
 
 #include <linux/errno.h>
@@ -602,7 +603,7 @@
 
 #define CHECK_IF_IN_TRAP \
 	if (VMPI.vm86dbg_active && VMPI.vm86dbg_TFpendig) \
-		pushw(ssp,sp,popw(ssp,sp, regs, VM86_SIGSEGV) | TF_MASK, regs, VM86_SIGSEGV);
+		newflags |= TF_MASK;
 #define VM86_FAULT_RETURN \
 	if (VMPI.force_return_for_pic  && (VEFLAGS & (IF_MASK | VIF_MASK))) \
 		return_to_32bit(regs, VM86_PICRETURN); \

And I have put all the recent changes of vm86.c together
in one (also untested) patch:
http://www.daimi.au.dk/~kasperd/linux_kernel/vm86.2.4.18-3.patch

> Thank you.

You too.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
