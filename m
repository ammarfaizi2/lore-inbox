Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbUL3AuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUL3AuJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUL3AsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:48:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:49119 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261470AbUL3Aoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:44:32 -0500
Date: Wed, 29 Dec 2004 16:44:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesse Allen <the3dfxdude@gmail.com>
cc: Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <530468570412291343d1478cf@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <20041120214915.GA6100@tesore.ph.cox.net>  <41A251A6.2030205@wanadoo.fr> 
 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>  <1101161953.13273.7.camel@littlegreen>
  <1104286459.7640.54.camel@gamecube.scs.ch>  <1104332559.3393.16.camel@littlegreen>
  <Pine.LNX.4.58.0412291047120.2353@ppc970.osdl.org> 
 <53046857041229114077eb4d1d@mail.gmail.com>  <Pine.LNX.4.58.0412291151080.2353@ppc970.osdl.org>
 <530468570412291343d1478cf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="19447976-1389717727-1104367445=:2353"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--19447976-1389717727-1104367445=:2353
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Wed, 29 Dec 2004, Jesse Allen wrote:
> > 
> > So instead of removing the setting of TIF_SINGLESTEP in set_singlestep(),
> > can you test whether removing the _testing_ of it in do_syscall_trace()
> > makes things happier for you? Hmm?
> > 
> 
> Yes, doing that does work.  But I still have to remove the conditional
> TF clear.  Here's the diff now to show you.

Ok. That's a good piece of information. 

I don't actually understand why do_syscall_trace() does that 
TIF_SINGLESTEP test in the first place, since the ptrace_notify() should 
happen as part of the _normal_ TIF_SINGLESTEP handling, afaiks. No 
apparent need to do it in syscall tracing, and do_syscall_trace() does 
that bogus fake signal sending.

Hmm.. That TF_SINGLESTEP test was added by Davide Libenzi in August, and I
think Davide had some test for exactly this. Davide? Can you recall why
you did this in the system call tracing code, rather than depend on the
regular TIF_SINGLESTEP handling in arch/i386/kernel/signal.c:
do_notify_resume()?

(Jesse's patch re-appended here in-line for Davide's "reading pleasure").

That still leaves the problem of the clearing of TF_MASK. I _appears_ that 
the problem is that TF was set both by Wine doing a PTRACE_SINGLESTEP 
(since PT_DTRACE is set) _and_ the application having TF enabled in eflags 
from before (since it seems to want to keep it enabled).

How about something like the attachment for the TF_MASK issue (replacing
your "don't clear" code)? The comments should make the intention pretty
obvious, but I have equally obviously not actually _tested_ any of this..

		Linus

---
--- linux/arch/i386/kernel/ptrace.c	2004-12-29 14:10:34.000000000 -0700
+++ linux-mod/arch/i386/kernel/ptrace.c	2004-12-29 14:22:33.000000000 -0700
@@ -568,8 +568,7 @@
 			audit_syscall_exit(current, regs->eax);
 	}
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    !test_thread_flag(TIF_SINGLESTEP))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
--- linux/arch/i386/kernel/signal.c	2004-12-29 14:10:34.000000000 -0700
+++ linux-mod/arch/i386/kernel/signal.c	2004-12-29 14:23:04.000000000 -0700
@@ -299,8 +299,8 @@
 	 * don't want debugging to change state.
 	 */
 	eflags = regs->eflags;
-	if (current->ptrace & PT_DTRACE)
-		eflags &= ~TF_MASK;
+//	if (current->ptrace & PT_DTRACE)
+//		eflags &= ~TF_MASK;
 	err |= __put_user(eflags, &sc->eflags);
 	err |= __put_user(regs->esp, &sc->esp_at_signal);
 	err |= __put_user(regs->xss, (unsigned int __user *)&sc->ss);
--19447976-1389717727-1104367445=:2353
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=tf-diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0412291644050.2353@ppc970.osdl.org>
Content-Description: 
Content-Disposition: attachment; filename=tf-diff

PT09PT0gYXJjaC9pMzg2L2tlcm5lbC9wdHJhY2UuYyAxLjI4IHZzIGVkaXRl
ZCA9PT09PQ0KLS0tIDEuMjgvYXJjaC9pMzg2L2tlcm5lbC9wdHJhY2UuYwky
MDA0LTExLTIyIDA5OjQ0OjUyIC0wODowMA0KKysrIGVkaXRlZC9hcmNoL2kz
ODYva2VybmVsL3B0cmFjZS5jCTIwMDQtMTItMjkgMTY6NDI6MDQgLTA4OjAw
DQpAQCAtMTQyLDE4ICsxNDIsMzEgQEANCiB7DQogCWxvbmcgZWZsYWdzOw0K
IA0KKwkvKg0KKwkgKiBBbHdheXMgc2V0IFRJRl9TSU5HTEVTVEVQIC0gdGhp
cyBndWFyYW50ZWVzIHRoYXQgDQorCSAqIHdlIHNpbmdsZS1zdGVwIHN5c3Rl
bSBjYWxscyBldGMuLiANCisJICovDQogCXNldF90c2tfdGhyZWFkX2ZsYWco
Y2hpbGQsIFRJRl9TSU5HTEVTVEVQKTsNCisNCisJLyoNCisJICogSWYgVEYg
d2FzIGFscmVhZHkgc2V0LCBkb24ndCBkbyBhbnl0aGluZyBlbHNlDQorCSAq
Lw0KIAllZmxhZ3MgPSBnZXRfc3RhY2tfbG9uZyhjaGlsZCwgRUZMX09GRlNF
VCk7DQorCWlmIChmbGFncyAmIFRSQVBfRkxBRykNCisJCXJldHVybjsNCiAJ
cHV0X3N0YWNrX2xvbmcoY2hpbGQsIEVGTF9PRkZTRVQsIGVmbGFncyB8IFRS
QVBfRkxBRyk7DQogCWNoaWxkLT5wdHJhY2UgfD0gUFRfRFRSQUNFOw0KIH0N
CiANCiBzdGF0aWMgdm9pZCBjbGVhcl9zaW5nbGVzdGVwKHN0cnVjdCB0YXNr
X3N0cnVjdCAqY2hpbGQpDQogew0KKwkvKiBBbHdheXMgY2xlYXIgVElGX1NJ
TkdMRVNURVAuLi4gKi8NCisJY2xlYXJfdHNrX3RocmVhZF9mbGFnKGNoaWxk
LCBUSUZfU0lOR0xFU1RFUCk7DQorDQorCS8qIEJ1dCB0b3VjaCBURiBvbmx5
IGlmIGl0IHdhcyBzZXQgYnkgdXMuLiAqLw0KIAlpZiAoY2hpbGQtPnB0cmFj
ZSAmIFBUX0RUUkFDRSkgew0KIAkJbG9uZyBlZmxhZ3M7DQogDQotCQljbGVh
cl90c2tfdGhyZWFkX2ZsYWcoY2hpbGQsIFRJRl9TSU5HTEVTVEVQKTsNCiAJ
CWVmbGFncyA9IGdldF9zdGFja19sb25nKGNoaWxkLCBFRkxfT0ZGU0VUKTsN
CiAJCXB1dF9zdGFja19sb25nKGNoaWxkLCBFRkxfT0ZGU0VULCBlZmxhZ3Mg
JiB+VFJBUF9GTEFHKTsNCiAJCWNoaWxkLT5wdHJhY2UgJj0gflBUX0RUUkFD
RTsNCg==

--19447976-1389717727-1104367445=:2353--
