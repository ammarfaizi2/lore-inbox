Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUL2VnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUL2VnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 16:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUL2VnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 16:43:10 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:24752 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261426AbUL2VnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 16:43:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=izpZLbpyn+1H6I8A/gjAnW7WLmWwuNf9Y6FHnSU/WfzCk8aAbxpdT125dLm+Ymm4UVen5XjIIdrYsPkAigBPloKQkp9XvIz2mwtgB0vl3sw5Oxl30bUfm4ZNbclSByMdqJMKoS3IVXY/IEirUY2pgase3V8Pda9Q0pJsibabFpc=
Message-ID: <530468570412291343d1478cf@mail.gmail.com>
Date: Wed, 29 Dec 2004 14:43:00 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ptrace single-stepping change breaks Wine
Cc: Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
In-Reply-To: <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_740_20045067.1104356580651"
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <20041120214915.GA6100@tesore.ph.cox.net>
	 <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
	 <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org>
	 <53046857041229114077eb4d1d@mail.gmail.com>
	 <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_740_20045067.1104356580651
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 29 Dec 2004 12:04:57 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> On Wed, 29 Dec 2004, Jesse Allen wrote:
> > > So does removing the conditional TF clear make everything work again?
> > >
> >
> > Yes, as long as TIF_SINGLESTEP is not set in set_singlestep().
> 
> That may be a clue, if only because that makes absolutely _zero_ sense.
> 
> Setting TIF_SINGLESTEP shouldn't actually matter in this case, since we
> set the TRAP_FLAG in eflags by hand anyway (and that's what TIF_SINGESTEP
> will just re-do when returning to user space).
> 
> What TIF_SINGLESTEP _does_ do, however, is change how some other issues
> are reported to user space. In particular, it causes system call tracing
> (see arch/i386/kernel/ptrace.c: do_syscall_trace), and maybe it is _that_
> that messes up Wine.
> 
> So instead of removing the setting of TIF_SINGLESTEP in set_singlestep(),
> can you test whether removing the _testing_ of it in do_syscall_trace()
> makes things happier for you? Hmm?
> 

Yes, doing that does work.  But I still have to remove the conditional
TF clear.  Here's the diff now to show you.

Jesse

------=_Part_740_20045067.1104356580651
Content-Type: text/x-diff; name="reverse_thread_flag_test.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="reverse_thread_flag_test.diff"

--- linux/arch/i386/kernel/ptrace.c=092004-12-29 14:10:34.000000000 -0700
+++ linux-mod/arch/i386/kernel/ptrace.c=092004-12-29 14:22:33.000000000 -07=
00
@@ -568,8 +568,7 @@
 =09=09=09audit_syscall_exit(current, regs->eax);
 =09}
=20
-=09if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
-=09    !test_thread_flag(TIF_SINGLESTEP))
+=09if (!test_thread_flag(TIF_SYSCALL_TRACE))
 =09=09return;
 =09if (!(current->ptrace & PT_PTRACED))
 =09=09return;
--- linux/arch/i386/kernel/signal.c=092004-12-29 14:10:34.000000000 -0700
+++ linux-mod/arch/i386/kernel/signal.c=092004-12-29 14:23:04.000000000 -07=
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

------=_Part_740_20045067.1104356580651--
