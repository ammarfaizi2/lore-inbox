Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVAVCw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVAVCw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 21:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVAVCw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 21:52:28 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32861
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262649AbVAVCvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 21:51:51 -0500
Date: Sat, 22 Jan 2005 03:51:48 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wright <chrisw@osdl.org>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050122025148.GC11112@dualathlon.random>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random> <20050121205416.GA16915@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121205416.GA16915@elte.hu>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 09:54:16PM +0100, Ingo Molnar wrote:
> - the second barrier is the 'jail' of the ptraced task. Especially with
>   PTRACE_SYSCALL, the things a child ptraced process can do are
>   extremely limited, everything it tries to do will trap, the task will
>   suspend and the parent runs. The task is completely passive and ptrace
>   on that end is a pretty small engine that stops/traps/restarts user
>   processing without alot of frills.
> 
> historically there has been alot less problems with the second barrier. 
> (in fact i cannot remember even one security issue in that area.)

I agree there are less problems in that area.  But there's still a great
deal of complexity in ptrace that I preferred to keep it out of the
security equation.

uml can't run with seccomp, uml is forced to ptrace, it has to trap the
arguments and everything.

Once kernel CVS returns up, I'll get an email as soon as somebody
touches kernel/seccomp.c or the other files involved, and I can keep the
eye on the code and verify all modifications very quickly (plus there
will be very few modifications on those files, unlike for the ptrace
code that is much more under deveopment). Keeping ptrace under control
would be more costly on my side.

> i'm not forcing anyone to do anything, but i think the most logical
> solution is to use ptrace. It's there on every Linux box so your client
> can run even on 'older' Linux boxes. (You might want to detect in the
> client whether the OOM race is fixed in a kernel, but it should not be a
> truly big issue.) Waiting for any extra API to get significant userbase
> takes at least 1-2 years - while ptrace is here and available on every

Note that I'm not ready for production myself yet, I'm suggesting to
include this now, exactly to get some real userbase ready in 1-2 years.
And after that with trusted computing it'll take another few years
before the trusted Cpushare exchange can start in parallel to the
seccomp one.  My schedule is planned for a much longer timeframe, I
doubt anything significant could happen this year regardless of ptrace
or seccomp.

Plus I would never depend on the users to do the right thing (i.e. not
to run oom etc..). So I'm forced to wait the 1-2 years anyways either to
get seccomp merged, or to get your ptrace extension merged. If I use
ptrace, the current kernels can't prevent the Cpushare users to hurt
themself, so I won't allow current unpatched kernels to run.

I have no hurry, my first prio is to do everything safely, I don't care
to grow the userbase fast if I have to add some risk to the users to
do that.

Note also that all Cpushare client software that runs on the user
computers is GPL, in turn without pending patents and completely free
software, so you're very free to take it, rewrite it with ptrace, and
ship it to your users now. Even Microsoft can write its own Cpushare
client and ship it in Windows just fine.  You can fake the kernel
version to tell the server 2.6.11+seccom is running, despite 2.6.9 with
the insecure ptrace might be running instead (the Cpushare protocol does
most checks on the server side btw).  I have no control on that and as
long as I have no liability I'm fine (and I write in capital letters no
liability and no warranty in the account creation procedure of course).
But the client I will ship myself on cpushare.com will have security as
priority number 1 in mind, and in turn I can't allow it to run with the
current ptrace kernel code.

(however if you want to write your own client for your own OS, please
let me know privately, instead of faking the kernel version, that's
going to be more secure shall you need me to shutdown just your clients
because you found a security issue in your code)

If you noticed, I also made sure that after seccomp is enabled, it is
impossible to disable it:

	/* can set it only once to be even more secure */
	if (unlikely(tsk->seccomp_mode))
		return -EPERM;

This is a *major* feature. I'm sure we can hack ptrace for that too with
yet another patch, but isn't it so much simpler to merge seccomp to get
the highest degree of security? The only way an user can screw himself
with seccomp is to write the right bit in /dev/mem at the right bit
offset. And I exclude that can happen by mistake. I mean, it has a
lower probability than a ram bitflip ;).

> Linux box. If you require 'users' to go with a new (or worse: patched)
> kernel then you are creating a pretty significant artificial market
> penetration barrier for your application.

This is fine. It's a long term project, I don't care about the short
term, I only care that the users are as safe as possible.

> also, with more applications relying on ptrace it will become more
> tested, more robust and people will do speedups. I think the fact that
> UML uses ptrace is already a very good sign that it's robust for such
> purposes. (_Also_, if there's a security problem in the ptrace barrier,
> you'd like to know about it and fix it ASAP - SuSE ships UML, right?)

The implications of an UML bug are minor, compared to a seccomp bug that
affects Cpushare. To exploit an UML bug you've to find a uml system
first. To exploit a Cpushare bug you only need some money in PayPal
account. I rate the two with different priority. This is why I made it
possible to abort all present and future transactions anytime anywhere
by clicking a button on my triband cellphone. A seccomp bug would block
the system until I figure out an upgrade path, so I really don't want
having to find seccomp bugs _ever_ ;). If there's a ptrace bug affecting
UML, let's fix it ASAP, but let's not stop Cpushare completely in the
meantime ;).

> an additional idea: you could waitpid() from a 'watchdog' task, on the
> parent, and if the parent dies unexpectedly (you get a SIGCHLD) then you
> could immediately kill the child PID and log the incident. This still
> leaves a small window, but one that is probably quite hard to abuse,
> especially since the watchdog task will very likely have the highest
> priority amongst those tasks (due to sleeping almost always). The
> watchdog task would naturally be very small and hence there's near zero
> OOM risk for the watchdog task.

Correct in theory, but in practice what you say is true only unless the
OOM killer is buggy like in 2.6 mainline incidentally and kills too many
tasks (including init, ask Thomas).

> and yet another idea: if you make the ptrace task the leader of its own
> process group, then IIRC you will get a death signal delivered to the
	              ^^^^
> ptraced task if the parent dies prematurely. This should close the race
> pretty well too.

... unless during 2.7 somebody changes the signal code and breaks it.

But it's really the "IIRC" above that makes me not feel safe. If you're
not sure to recall correctly it means it's not obvious stuff. Seccomp is
obvious, there's no way you could ever add "IIRC" to the seccomp
security.

I believe only obvious stuff can go right. Murphy probably disagrees
even with this, but I'm confident of being able to screw Murphy by
keeping things obviously safe ;). Murphy can't add bugs if there are no
bugs in the code. It's not always possible to keep things obviously safe
(UML can't), Cpushare kernel-side is one exception and I'd like to take
advantage of it.

How can you get it wrong calculating 1+1? Do you know anybody getting
wrong 1+1=3 (eheh I'm kidding of course ;).

While if you compute something complex instead of 1+1, you'll start
people getting it wrong sometime, including myself, and that's the
people that will keep hacking on the same piece of the kernel in the
future.

So since I've a special requirements that I can accomplish in a isolated
place with zero runtime overhead, out of the development, I prefer to
take advantage of it. This isn't possible with UML.

Said that I agree in theory ptrace (after fixing the killing of the
parent in kernel space with zero window, and possibly after adding a
feature like -EPERM above) would work equally well too. But it just
doesn't seem worth it.

Note that as somebody else already said on l-k some time ago, a full
virtualization technology (like hardware emulation) is much more secure
than UML, exactly because it has fewer special cases, despite being very
complex too. I don't rate UML highly secure myself (there was at least
an exploit posted on bugtraq showing how to escape the uml jail some
time ago).

Thanks for the help.
