Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWFAMkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWFAMkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 08:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWFAMkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 08:40:41 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:3217 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750769AbWFAMkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 08:40:40 -0400
Date: Thu, 1 Jun 2006 21:37:30 +0900
From: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
To: vgoyal@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
Message-Id: <20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <20060531154322.GA8475@in.ibm.com>
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>
	<20060530145658.GC6536@in.ibm.com>
	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>
	<20060531154322.GA8475@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 11:43:22 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> On Wed, May 31, 2006 at 06:20:45PM +0900, Akiyama, Nobuyuki wrote:
> > Hello Vivek-san,
> > 
> > On Tue, 30 May 2006 10:56:58 -0400
> > Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > 
> > > On Tue, May 30, 2006 at 06:33:59PM +0900, Akiyama, Nobuyuki wrote:
> > > > Hello,
> > > > 
> > > > The panic notifier(i.e. panic_notifier_list) does not be called
> > > > if kdump is activated because crash_kexec() does not return.
> > > > And there is nothing to notify of crash before crashing by SysRq-c.
> > > > 
> > > > Although notify_die() exists, the function depends on architecture.
> > > > If notify_die() is added in panic and SysRq respectively like existing
> > > > implementation, the code will be ugly.
> > > > I think that adding a generic hook in crash_kexec() is better to simplify
> > > > the code. The panic_notifier_list-user will have nothing to do.
> > > > If you want to catch SysRq, use the crash_notifier_list.
> > > > 
> > > 
> > > What's the use of introducing crash_notifier_list? Who is going to use
> > > it for what purpose?
> > > 
> > > Probably we don't want to create any such infrastructure because carries
> > > the risk of hanging in between and reducing the reliability of dump 
> > > operation.
> > 
> > I really understand what you concern about.
> > But a certain program indeed needs some processing before
> > crashing even if panic occurs.
> > Now standard kernel includes some panic_notifier_list-user,
> > these are the familiar examples.
> 
> I see the panic_notifier_list but I am afraid that we can not afford
> to send the crash/panic notifications if system admin has chosen to load
> the kdump kernel and has decided to take a dump in case of a crash event.
> This might very seriously compromise the reliability of kdump. IIRC, we
> recently saw an issue with powerpc where we did not even start booting into
> the second kernel as system lost way somewhere while handling notifiers.
> 
> So far on a panic event kernel only used to display the panic string
> and halt the system but now it tries to do much more. That is boot
> into the second kernel and caputure the dump. Of course, one can argue
> that I want to implement a different policy in case of system crash. In
> that case probably we should not load the kdump kernel at all.
> 
> panic_notifier_list helps in this regard that multiple subsystem can
> register their own policy and policy will be excuted in the registered
> priority order. Given the nature of kdump, I feel it is kind of 
> mutually exclusive and can not co-exist with other policies. Otherwise, we 
> will end up calling all other policies first and trigger booting into
> the second kernel last. This is equivalent to giving higher priority to
> all other policies and least priority to kdump.

I think crash_kexec() is the best point to simplify notifier-call.
If the notifier is bad implementation, kdump reliability may
be decreased. But the risk depends on notifier quality.
I think it is not bad that we have the opportunity to call notifier.
As you say, current panic_notifier_list may not be suitable
because that was implemented before kdump merged.

You accept if panic_notifier_list is dropped from crash_notify()
like below(not complete patch)? If one want to catch panic
and SysRq event before crashing, crash_notifier_list can be used.

------ 
-void crash_kexec(struct pt_regs *regs)
+static void notify_crash(int type, void *v)
+{
+	raw_notifier_call_chain(&crash_notifier_list, type, v);
+}
+
+void crash_kexec(int type, struct pt_regs *regs, void *v)
 {
 	struct kimage *image;
 	int locked;
@@ -1061,6 +1072,7 @@ void crash_kexec(struct pt_regs *regs)
 			struct pt_regs fixed_regs;
 			crash_setup_regs(&fixed_regs, regs);
 			machine_crash_shutdown(&fixed_regs);
+			notify_crash(type, v);
 			machine_kexec(image);
 		}
 		xchg(&kexec_lock, 0);
------ 

> > 
> > As other example, a cluster support software needs to clean up
> > current environment and to take over immediately.  > To do so, the cluster software immediately and surely want to
> > know the current node dies.
> > Some mission critical systems demand to start taking over
> > within a few milli-second after the system dies.
> > 
> 
> I am no failover expert, but a quick thought suggests me that doing
> anything after the panic is not reliable. So should't all failover
> mechanisms depend on auto detecting that failure has occurred instead
> of failing system informing that I am about to fail so you better take
> over. Something like syncying two systems with a hearbeat message kind
> of thing and if main node fails, it will stop generating hearbeat
> messages and spare node will take over.

You are right, but that mechanism waists very long time.
The probability that fail in informing spare node of death is lower
than you think.

Regards,

Akiyama, Nobuyuki

