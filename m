Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUA0JF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 04:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbUA0JF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 04:05:56 -0500
Received: from svr44.ehostpros.com ([66.98.192.92]:32647 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263015AbUA0JFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 04:05:44 -0500
From: "Amit S. Kale" <amitkale@emsyssoft.com>
Organization: EmSysSoft
To: Tom Rini <trini@kernel.crashing.org>, George Anzinger <george@mvista.com>
Subject: Re: PPC KGDB changes and some help?
Date: Tue, 27 Jan 2004 14:35:19 +0530
User-Agent: KMail/1.5
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>
References: <200401212223.13347.amitkale@emsyssoft.com> <40158A88.7070007@mvista.com> <20040126220651.GE32525@stop.crashing.org>
In-Reply-To: <20040126220651.GE32525@stop.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401271435.19773.amitkale@emsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - emsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 Jan 2004 3:36 am, Tom Rini wrote:
> On Mon, Jan 26, 2004 at 01:45:44PM -0800, George Anzinger wrote:
> > Tom Rini wrote:
> > >>There is a real danger of passing signal info back to gdb as it will
> > >> want to try to deliver the signal which is a non-compute in most kgdbs
> > >> in the field.  I did put code in the mm-kgdb to do just this, but
> > >> usually the arrival of such a signal (other than SIGTRAP) is the end
> > >> of the kernel. All that is left is to read the tea leaves.
> > >
> > >The gdb I've been testing this with knows better than to try and send a
> > >singal back, so that's not a worry.  The motivation behind doing this
> > >however is along the lines of "if it ain't broke, don't remove it".  The
> > >original stub was getting all of this information correctly, so why stop
> > >doing it?
> >
> > You sure.  If so what gdb?  And how does it know?  I suppose you could
> > tell it with a script, but then what if one forgets?
>
> GNU gdb 6.0 (MontaVista 6.0-8.0.4.0300532 2003-12-24)
> Copyright 2003 Free Software Foundation, Inc.
> [snip]
>
> [New Thread 289]
>
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 289]
> 0x00000000 in ?? ()
> (gdb) c
> Continuing.
> Can't send signals to this remote system.  SIGSEGV not sent.

This is because gdb tries packet "C" first. If that fails, which is the case 
with kgdb, it falls back to packet "c". It doesn't need packet "C" for 
SIGTRAP as it's used for breakpoints and single stepping and shouldn't be 
delivered to a debuggee.

SIGSEGV has to be actually delivered to an application for it to die. A user 
has a choice of correcting a bug on the fly and let the application continue 
without segfaulting. It can tell gdb to continue the debugee without a 
signal. It doesn't apply in case of kernel, so it's not a bug. Kernel anyway 
"delivers" the signal, that is, continues with a panic once kgdb returns. We 
don't offer a user the choice of correcting a segfault on the fly.

>
> Noting that 0x0 is correct as the code that triggered this was:
> static void (*dummy)(struct pt_regs *regs);
> int drop_kgdb(void) {
>         struct pt_regs regs;
>         memset(&regs, 0, sizeof(regs));
>         dummy(&regs);
>
>         return 0;
> }
> module_init(drop_kgdb);
>
> --
> Tom Rini
> http://gate.crashing.org/~trini/
>
> ** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

-- 
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)

