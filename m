Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266268AbUAVQGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 11:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266282AbUAVQGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 11:06:32 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:42639 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S266268AbUAVQG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 11:06:29 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>,
       Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: PPC KGDB changes and some help?
Date: Thu, 22 Jan 2004 21:36:10 +0530
User-Agent: KMail/1.5
Cc: KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
References: <20040120172708.GN13454@stop.crashing.org> <30216351-4CEF-11D8-A2A1-000A95A0560C@us.ibm.com> <20040122154529.GE15271@stop.crashing.org>
In-Reply-To: <20040122154529.GE15271@stop.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401222136.10887.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 Jan 2004 9:15 pm, Tom Rini wrote:
> On Thu, Jan 22, 2004 at 09:25:19AM -0600, Hollis Blanchard wrote:
> > On Jan 22, 2004, at 9:07 AM, Tom Rini wrote:
> > >On Wed, Jan 21, 2004 at 03:12:25PM -0800, George Anzinger wrote:
> > >>A question I have been meaning to ask:  Why is the arch/common
> > >>connection
> > >>via a structure of addresses instead of just calls?  I seems to me
> > >>that
> > >>just calling is a far cleaner way to do things here.  All the struct
> > >>seems
> > >>to offer is a way to change the backend on the fly.  I don't thing we
> > >>ever
> > >>want to do that.  Am I missing something?
> > >
> > >I imagine it's a style thing.  I don't have a preference either way.
> >
> > I think we in PPC land have gotten used to that "style" because we have
> > one kernel that supports different "platforms", i.e. it selects the
> > appropriate code at runtime as George says. In general that's a little
> > bit slower and a little bit bigger.
> >
> > Unless you need to choose among PPC KGDB functions at runtime, which I
> > don't think you do, you don't need it...
>
> That's certainly true, so if (and if I understand Georges question
> right) Amit wants to change kgdb_arch into a set of required functions,
> with stubs in, say, kernel/kgdbdummy.c, (and just keep the flags / etc
> in the struct), that's fine with me.

The penalty of keeping them consolidated in a structure isn't so high. I 
prefer to keep them that way. I'll work on reducing number of initialization 
functions, though.

I have to do something about early connect though. Powerpc kgdb on 8260 is 
definitely capable of starting debugging right at architecture setup time. 
It's just that kgdbstub.c isn't ready yet.

How about changing the code in kgdbstub to allow kgdb to be configured in one 
of the following ways:
Late kgdb - kgdb comes up after smp_init in the kernel boot sequence. kgdb8250 
can be used with more flexibility through kernel command line options. One 
can boot a kgdb kernel without activating kgdb. Works with the interface 
chosen by kernel command line (kgdb8250 and kgdbeth for the moment).

Command line flexibilty is of great help if you have to test on 2-3 servers (I 
used to do that a lot at Veritas). The same kernel can be compiled with 
drivers needed by all of them plus kgdb. Command line options choose port no 
and speeds depending on machine hardware connections. I guess it's of little 
use on embedded systems where usually a new kernel has to be compiled for 
each board.

Early kgdb - kgdb comes up right at the begining of start_kernel at the cost 
of flexibility. It doesn't show any messages such as "waiting for gdb". All 
configurations have to be compiled in through menuconfig. Once a kernel is 
built, it'll always run with kgdb and with 8250 at a fixed port and speed.

i386 architecture will support both kgdb configuration.
KGDB in powerpc 8260 will be of early kgdb type. Other powerpc arches (550 etc 
will depend on whether the interface can be initialized early or later)
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

