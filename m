Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTI1MxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 08:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbTI1MxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 08:53:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65459 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262543AbTI1MxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 08:53:19 -0400
Date: Sun, 28 Sep 2003 13:53:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Oliver Pitzeier <oliver@linux-kernel.at>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928125318.GM7665@parcelfarce.linux.theplanet.co.uk>
References: <200309281216.h8SCGWsl026399@indianer.linux-kernel.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309281216.h8SCGWsl026399@indianer.linux-kernel.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 02:19:24PM +0200, Oliver Pitzeier wrote:
> Hi folks/Linus!
> 
> Linus Torvalds wrote:
> > Ok, too long between test5 and test6 again, so the patch is 
> > pretty big. Lots of driver updates and architectures fixed, 
> > but also lots of merges from Andrew Morton. Most notably 
> > perhaps Con's scheduler changes that have been discussed 
> > extensively and made it into the -mm tree for testing.
> 
> It work's on my Intel machine, but on Alpha, I get this:
> <snip>
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o: In function `try_to_wake_up':
> kernel/built-in.o(.text+0x438): undefined reference to `sched_clock'

Add
unsigned long long default_sched_clock(void)
{
	return (unsigned long long)jiffies * (1000000000 / HZ);
}

in kernel/sched.c and

#define sched_clock default_sched_clock

in include/asm-alpha/system.h

FWIW, the former should've been done from the very beginning and sched_clock
should've been made a weak alias for default_sched_clock.  That would avoid
the breakage of platforms original patch didn't update.

BTW, how about adding weak_alias(type, name, args, default_variant) to
compiler.h?  For most platforms it would be

#define weak_alias(type, name, args, default_variant) \
	type name args __attribute__((weak, alias(#default_variant)));

Note that we already have something similar - cond_syscall(name) would
become weak_alias(asmlinkage long, name, (void), sys_ni_syscall) and
platform-specific stuff could be taken from current definitions of this
beast.
