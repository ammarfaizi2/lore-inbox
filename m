Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbUL2Tl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUL2Tl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 14:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUL2Tl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 14:41:29 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:1712 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261405AbUL2Tky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 14:40:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=NXBgLXAs2pJsVLTObPU+X7xIYNAtmPxM1roEtjvmCxzv+koGMFN59y/AZhp1pNz8yMWOVY6243P12D1HqGZoHXkB5Q4N1DwBbn6kbaCXZgDM6L6PuOPYcwu8U/ohqK7uM8uCPMFMm+iqD0k54NgcwSfqPyccAZCEcj0DRBBEpfI=
Message-ID: <53046857041229114077eb4d1d@mail.gmail.com>
Date: Wed, 29 Dec 2004 12:40:53 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
In-Reply-To: <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_728_14148962.1104349253222"
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net>
	 <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
	 <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_728_14148962.1104349253222
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 29 Dec 2004 10:53:54 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> Ok, I don't remember the context from the Wine lists (and it's not clear
> from the older emails I was cc'd on), so the "#3 signal.c" change
> description is a bit too vague. Jesse, willing to just point to the exact
> diff that you need to make Warcraft work for you (and then maybe Thomas
> Sailer can verify whether that part is indeed the one that causes him
> problems).

I have attached the diff attached in this message for the lkml.

> 
> The code in question now does
> 
>         /*
>          * Iff TF was set because the program is being single-stepped by a
>          * debugger, don't save that information on the signal stack.. We
>          * don't want debugging to change state.
>          */
>         eflags = regs->eflags;
>         if (current->ptrace & PT_DTRACE)
>                 eflags &= ~TF_MASK;
>         err |= __put_user(eflags, &sc->eflags);
> 
> and I guess it originally never cleared it. True?

Yes.

> 
> So does removing the conditional TF clear make everything work again?
> 

Yes, as long as TIF_SINGLESTEP is not set in set_singlestep(). 
set_singlestep also sets PT_DTRACE, so as it now is, a call to the
set_singlestep function will make this condition true clearing TF when
run.  So both the conditional TF clear and setting TIF_SINGLESTEP
needs to be removed, like I show in the diff.   Making these changes
returns the code to a 2.6.8-ish resemblence.

For the wine people, I will try to upload the seh debug channel logs
as soon as possible.

Jesse

------=_Part_728_14148962.1104349253222
Content-Type: text/x-diff; name="ptrace-reverse.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="ptrace-reverse.diff"

diff -u linux/arch/i386/kernel/ptrace.c linux-mod/arch/i386/kernel/ptrace.c
--- linux/arch/i386/kernel/ptrace.c=092004-12-09 15:24:07.000000000 -0700
+++ linux-mod/arch/i386/kernel/ptrace.c=092004-12-25 16:09:52.000000000 -07=
00
@@ -142,7 +142,7 @@
 {
 =09long eflags;
=20
-=09set_tsk_thread_flag(child, TIF_SINGLESTEP);
+//=09set_tsk_thread_flag(child, TIF_SINGLESTEP);
 =09eflags =3D get_stack_long(child, EFL_OFFSET);
 =09put_stack_long(child, EFL_OFFSET, eflags | TRAP_FLAG);
 =09child->ptrace |=3D PT_DTRACE;
@@ -153,7 +153,7 @@
 =09if (child->ptrace & PT_DTRACE) {
 =09=09long eflags;
=20
-=09=09clear_tsk_thread_flag(child, TIF_SINGLESTEP);
+//=09=09clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 =09=09eflags =3D get_stack_long(child, EFL_OFFSET);
 =09=09put_stack_long(child, EFL_OFFSET, eflags & ~TRAP_FLAG);
 =09=09child->ptrace &=3D ~PT_DTRACE;
diff -u linux/arch/i386/kernel/signal.c linux-mod/arch/i386/kernel/signal.c
--- linux/arch/i386/kernel/signal.c=092004-12-09 15:24:07.000000000 -0700
+++ linux-mod/arch/i386/kernel/signal.c=092004-12-25 16:10:10.000000000 -07=
00
@@ -299,8 +299,8 @@
 =09 * don't want debugging to change state.
 =09 */
 =09eflags =3D regs->eflags;
-=09if (current->ptrace & PT_DTRACE)
-=09=09eflags &=3D ~TF_MASK;
+//=09if (current->ptrace & PT_DTRACE)
+//=09=09eflags &=3D ~TF_MASK;
 =09err |=3D __put_user(eflags, &sc->eflags);
 =09err |=3D __put_user(regs->esp, &sc->esp_at_signal);
 =09err |=3D __put_user(regs->xss, (unsigned int __user *)&sc->ss);

------=_Part_728_14148962.1104349253222--
