Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTLOOgb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 09:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTLOOgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 09:36:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11650 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263639AbTLOOg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 09:36:29 -0500
Date: Mon, 15 Dec 2003 09:37:20 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Joshua Schmidlkofer <kernel@pacrimopen.com>
cc: John Bradford <john@grabjohn.com>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
In-Reply-To: <1071296320.16407.17.camel@menion.home>
Message-ID: <Pine.LNX.4.53.0312150921340.9281@chaos>
References: <16345.51504.583427.499297@l.a> <yw1xd6auyvac.fsf@kth.se> 
 <Pine.LNX.4.53.0312121000150.10423@chaos>  <200312121928.hBCJSLBs000384@81-2-122-30.bradfords.org.uk>
  <Pine.LNX.4.53.0312121435570.1356@chaos> <1071296320.16407.17.camel@menion.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, Joshua Schmidlkofer wrote:

> > Yes, and I recall we agreed to disagree where the FDC stop must
> > be put, but we both agreed that it must be stopped. I still contend
> > that since the Linux startup code takes control away from the BIOS,
> > it's that codes responsibility to turn OFF things that the BIOS
> > might have left ON.
> >
> > Funny thing. It's so trivial, anybody/everybody could turn the
> > floppy motor off, but all the fingers point to somebody else's
> > code.
> >
> > It's a bug in Linux, not in a boot-loader. That bug was covered up
> > until the FDC code got modularized. Once we were able to compile
> > a kernel without the FDC, the bug was exposed. So, I suggest that
> > we just fix the bug and be done with it. It's not a performance
> > problem, the write to the port occurs exactly once during the nest
> > 999 days of up-time. It's just an attempt to make a mountain out
> > of a mole-hill.
>
>
> We have had (do have?) several cases of optional "this workaround", or
> "that workaround" as per-hardware config options.  If this is that
> objectionable for genral consumption then someone ought to submit a
> patch to do the dirty deed but put it in as a configurable workaround
> (CONFIG_TURNFLOPPYOFF=Y/N), and leave it at that. [For maximum
> perversity, it could also be a MODULE.] This does not affect everyone
> right?  I have never tried booting w/o the floppy module, so I really
> don't know about my system.
>

Well It's NOT a workaround. In the IBM/Intel/PC platform, the
floppy motor is turned OFF in a simple timer-queue that runs
off the PIT Channel 0. If some operating system decides to tear
down that queue, it MUST perform the function(s) that the
queue was performing or else it's a BUG, plain and simple.
This long-time BUG was hidden as long as the floppy-disk
code remained in the kernel. Now, since the floppy disk
code is no longer permanently coded into the kernel, the
BUG is exposed. Failure to fix this known BUG, in spite of
the patches sent, is an obvious example of child-like
misbehavior.

Again, the patch is provided:

--- linux-2.4.22/arch/i386/boot/setup.S.orig	Tue Oct  7 09:24:33 2003
+++ linux-2.4.22/arch/i386/boot/setup.S	Fri Dec 12 09:52:32 2003
@@ -777,6 +777,10 @@
 	movb	$0xFB, %al			# mask all irq's but irq2 which
 	outb	%al, $0x21			# is cascaded

+	movw	$0x3f2, %dx
+	xorb	%al, %al			# Turn OFF FDC motor
+	outb	%al, %dx
+
 # Well, that certainly wasn't fun :-(. Hopefully it works, and we don't
 # need no steenking BIOS anyway (except for the initial loading :-).
 # The BIOS-routine wants lots of unnecessary data, and it's less




Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


