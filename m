Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266516AbUBLQxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266518AbUBLQxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:53:25 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:24242 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S266516AbUBLQxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:53:01 -0500
Date: Thu, 12 Feb 2004 09:52:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/6] A different KGDB stub
Message-ID: <20040212165259.GP19676@smtp.west.cox.net>
References: <20040212000237.GA19676@smtp.west.cox.net> <20040211162756.12bb19e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211162756.12bb19e8.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 04:27:56PM -0800, Andrew Morton wrote:

> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> > Hi Andrew.  As a reply to this message, I'm going to send you patches to
> > replace George's KGDB with a version that is Amit Kale's work, with a
> > number of additional cleanups (that I'll put in his CVS ASAP).  There
> > are 6 different patches:
> > core.patch: All of the non-arch specific bits, that aren't drivers.
> > 8250.patch: The i/o driver for KGDB, via a standard PC uart.
> > kgdboe.patch: The i/o driver for KGDB, via netpoll.
> > i386.patch: The i386-specific code, tested.
> > ppc32.patch: The ppc32-specific code, tested.
> > x86_64.patch: The x86_64-specific bits, untested.
> 
> OK.
> 
> > With this, there's a few design questions I have.  First, as I've done
> > things right now, a breakpoint at the first line of C code is untested.
> > It should work, but I have a question of how we want to handle setting
> > up the pointer to our i/o functions (if we have a pointer).  There's a
> > couple of ways that this could be solved, with pros and cons.  For
> > example, if we want to allow for both serial and enet to be used in the
> > same kernel, we could default to setting this pointer to the 8250
> > version, and allow for kgdb_arch_init to override (as PPC sometimes
> > does).  This is what I've done for now, but I don't know if I like how
> > it looks or not. If we don't care about allowing for > 1 i/o driver, we
> > can simply drop kgdb_serial as a function pointer and just call
> > kgdb_getDebugChar/kgdb_putDebugChar/etc.  Or someone else can suggest an
> > better way.
> 
> I don't think runtime selection is very important, personally.  You tend to
> get things set up with a serial cable or ethernet and just leave it that
> way.  Given that you need to recompile the kernel anyway, I'd say that
> Kconfig-time selection is acceptable.

I'll start on that then.

> > Next, what features of George's version are a must-have?  And what that
> > we have now, can we drop?  For example, up until I started working on
> > kgdboe+netpoll, I found KGBB_CONSOLE quite handy.  Now, I'm very happy
> > with netconsole, so I don't have a strong attachment to KGDB_CONSOLE
> > anymore.  But it's not much code anyhow.  And of course, what could be
> > done better?
> 
> I use KGDB_CONSOLE occasionally, although that's only when I can't stomach
> the thought of using minicom ;)
> 
> A few things which I believe have debatable value are:
> 
> CONFIG_KGDB_MORE
> CONFIG_KGDB_OPTIONS
> CONFIG_NO_KGDB_CPUS
> CONFIG_KGDB_TS
> CONFIG_STACK_OVERFLOW_TEST
> CONFIG_KGDB_SYSRQ		(Just turn it on by default?)
> 
> I have never used (or, as far as I know, needed) any of the above.

I think CONFIG_KGDB_SYSRQ can die since with the 8250 and enet drivers
you can try and connect at any point, which will schedule a breakpoint
and you can get in like that.  As for NO_KGDB_CPUS, I'm not entirely
certain why this can't go away and there'd be an array of NR_CPUS in
size.

-- 
Tom Rini
http://gate.crashing.org/~trini/
