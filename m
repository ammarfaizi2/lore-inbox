Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUANNFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 08:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266309AbUANNFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 08:05:40 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:18051 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S266304AbUANNFe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 08:05:34 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: George Anzinger <george@mvista.com>, Matt Mackall <mpm@selenic.com>
Subject: Re: kgdb cleanups
Date: Wed, 14 Jan 2004 18:34:51 +0530
User-Agent: KMail/1.5
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
References: <20040109183826.GA795@elf.ucw.cz> <20040112064923.GX18208@waste.org> <40045AC7.2070300@mvista.com>
In-Reply-To: <40045AC7.2070300@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401141834.51536.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 Jan 2004 2:23 am, George Anzinger wrote:
> Matt Mackall wrote:
> > On Sun, Jan 11, 2004 at 09:41:57PM -0800, George Anzinger wrote:
> >>For the internal kgdb stuff I have created kdgb_local.h which I intended
> >> to be local to the workings of kgdb and not to contain anything a user
> >> would need.
> >
> > Agreed, I just haven't touched it since you last mentioned it.
> >
> >>>+struct kgdb_hook {
> >>>+	char *sendbuf;
> >>>+	int maxsend;
> >>
> >>I don't see the need of maxsend, or sendbuff, for that matter, as kgdb
> >> uses it now (for the eth code) it is redundant, in that the eth putchar
> >> also does the same thing as is being done in the kgdb_stub.c code.  I
> >> think this should be removed from the stub and the limit in the ethcode
> >> relied upon.
> >
> > Fair enough.
> >
> >>>void
> >>>putDebugChar(int c)
> >>>{
> >>>-	if (!kgdboe) {
> >>>-		tty_putDebugChar(c);
> >>>-	} else {
> >>>-		eth_putDebugChar(c);
> >>>-	}
> >>>+	if (kh)
> >>>+		kh->putchar(c);
> >>>}
> >>
> >>I was thinking that this might read something like:
> >>         if (xxx[kh].putchar(c))
> >>                xxx[kh].putchar(c);
> >>
> >>One might further want to do something like:
> >>         if (!xxx[kh].putchar(c))
> >>                kh = 0;
> >>
> >>In otherwords, an array (xxx must, of course, be renamed) of stuct
> >>kgdb_hook (which name should also be changed to relate to I/O,
> >>kgdb_IO_hook, for example). Then reserve entry 0 for the rs232 I/O code.
> >
> > Dunno about that. Probably should work more like the console code,
> > whoever registers first wins. Early boot will probably be the
> > exclusive province of serial for a while yet, but designing it in is
> > probably short-sighted.
> >
> >> An alternate possibility is an array of pointer to struct kgdb_hook
> >> which allows one to define the struct contents as below and to build the
> >> array, all at compile/link time.  A legal entry MUST define get and put,
> >> but why not define them all, using dummy functions for the ones that
> >> make no sense in a particular interface.
> >
> > Throwing all the stubs in a special section could work well too. Then
> > we could add an avail() function so that early boot debugging could
> > discover if each one was available. The serial code could use this to
> > kickstart itself while the eth code could test a local initialized
> > flag and say "not a chance". Which gives us all the architecture to
> > throw in other trivial interfaces (parallel, bus-snoopers, etc.).
>
> I am thinking of something more like what was done with the x86 timer code.
> Each timer option sets up a structure with an array of pointers to each
> option. There it is done at compile time, and the runtime code tries each. 
> There it is done in order, but here we want to do it a bit differently.
>
> Maybe we could have an "available" flag or just assume that the address
> being !=0 for getdebugchar means it is "available".  I think there should
> be a prefered intface set at config time.  Possibly over ride this with the
> command line.  Then have a back up order in case kgdb wants to communicate
> prior to the prefered one being available.
>
> We would also have a rule that the command line over ride only works if
> communication has not yet been established.  Here, we would also like
> control from gdb/kgdb so we could switch to a different interface, but
> under gdb control at this point.  Either a maintaince command or setting
> the "channel" with a memory modify command.  We would want this to take
> effect only after the current command is acknowledged.

I have something similar in my patches.
Each interface has kgdb_hook function, which returns failure if an interface 
isn't ready.
-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

