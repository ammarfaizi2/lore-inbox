Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbUAJGD1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 01:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbUAJGD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 01:03:27 -0500
Received: from waste.org ([209.173.204.2]:4550 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264971AbUAJGDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 01:03:25 -0500
Date: Sat, 10 Jan 2004 00:03:15 -0600
From: Matt Mackall <mpm@selenic.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] arch-specific cond_syscall usage issues
Message-ID: <20040110060315.GZ18208@waste.org>
References: <20040110032915.GW18208@waste.org> <20040109193753.3c158b3b.akpm@osdl.org> <20040109212108.3d8f5e54.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109212108.3d8f5e54.zaitcev@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 09:21:08PM -0800, Pete Zaitcev wrote:
> On Fri, 9 Jan 2004 19:37:53 -0800
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  Experimenting with trying to use cond_syscall for a few arch-specific
> > >  syscalls, I discovered that it can't actually be used outside the file
> > >  in which sys_ni_syscall is declared because the assembler doesn't feel
> > >  obliged to output the symbol in that case:
> 
> > >  One arch (PPC) is apparently trying to use cond_syscall this way
> > >  anyway, though it's probably never been actually tested as the above
> > >  test was done on a PPC.
> > 
> > So why does the PPC kernel successfully link?
> 
> Perhaps it never was tested right when the change went in.

On closer inspection, PPC has this:

config PCI
        bool "PCI support" if 40x || 8260
        default y if !40x && !8260 && !8xx && !APUS
        default PCI_PERMEDIA if !4xx && !8260 && !8xx && APUS
        default PCI_QSPAN if !4xx && !8260 && 8xx

which suggests that non-PCI PPC are limited to very old and/or
embedded boxes. And indeed compiling it for one of these (...much time
elapses...) gets us:

arch/ppc/kernel/built-in.o(.data+0x380):arch/ppc/kernel/entry.S:
undefined reference to `sys_pciconfig_iobase'

> The patch is easy. The hard road would be to take it to binutils people
> like H.J.Lu and see what they say.

I believe Dave M mentioned that gcc uses weak symbols similarly, so
they've probably decided that the necessary smarts to do what we
originally wanted are too much trouble.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
