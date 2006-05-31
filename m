Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWEaSK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWEaSK5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWEaSK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:10:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:40935 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751220AbWEaSK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:10:56 -0400
Date: Wed, 31 May 2006 11:43:22 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
Message-ID: <20060531154322.GA8475@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com> <20060530145658.GC6536@in.ibm.com> <20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 06:20:45PM +0900, Akiyama, Nobuyuki wrote:
> Hello Vivek-san,
> 
> On Tue, 30 May 2006 10:56:58 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > On Tue, May 30, 2006 at 06:33:59PM +0900, Akiyama, Nobuyuki wrote:
> > > Hello,
> > > 
> > > The panic notifier(i.e. panic_notifier_list) does not be called
> > > if kdump is activated because crash_kexec() does not return.
> > > And there is nothing to notify of crash before crashing by SysRq-c.
> > > 
> > > Although notify_die() exists, the function depends on architecture.
> > > If notify_die() is added in panic and SysRq respectively like existing
> > > implementation, the code will be ugly.
> > > I think that adding a generic hook in crash_kexec() is better to simplify
> > > the code. The panic_notifier_list-user will have nothing to do.
> > > If you want to catch SysRq, use the crash_notifier_list.
> > > 
> > 
> > What's the use of introducing crash_notifier_list? Who is going to use
> > it for what purpose?
> > 
> > Probably we don't want to create any such infrastructure because carries
> > the risk of hanging in between and reducing the reliability of dump 
> > operation.
> 
> I really understand what you concern about.
> But a certain program indeed needs some processing before
> crashing even if panic occurs.
> Now standard kernel includes some panic_notifier_list-user,
> these are the familiar examples.

I see the panic_notifier_list but I am afraid that we can not afford
to send the crash/panic notifications if system admin has chosen to load
the kdump kernel and has decided to take a dump in case of a crash event.
This might very seriously compromise the reliability of kdump. IIRC, we
recently saw an issue with powerpc where we did not even start booting into
the second kernel as system lost way somewhere while handling notifiers.

So far on a panic event kernel only used to display the panic string
and halt the system but now it tries to do much more. That is boot
into the second kernel and caputure the dump. Of course, one can argue
that I want to implement a different policy in case of system crash. In
that case probably we should not load the kdump kernel at all.

panic_notifier_list helps in this regard that multiple subsystem can
register their own policy and policy will be excuted in the registered
priority order. Given the nature of kdump, I feel it is kind of 
mutually exclusive and can not co-exist with other policies. Otherwise, we 
will end up calling all other policies first and trigger booting into
the second kernel last. This is equivalent to giving higher priority to
all other policies and least priority to kdump.

> 
> As other example, a cluster support software needs to clean up
> current environment and to take over immediately.  > To do so, the cluster software immediately and surely want to
> know the current node dies.
> Some mission critical systems demand to start taking over
> within a few milli-second after the system dies.
> 

I am no failover expert, but a quick thought suggests me that doing
anything after the panic is not reliable. So should't all failover
mechanisms depend on auto detecting that failure has occurred instead
of failing system informing that I am about to fail so you better take
over. Something like syncying two systems with a hearbeat message kind
of thing and if main node fails, it will stop generating hearbeat
messages and spare node will take over.

Thanks
Vivek
