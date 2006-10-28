Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751854AbWJ1GIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWJ1GIh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 02:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWJ1GIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 02:08:37 -0400
Received: from colo.lackof.org ([198.49.126.79]:60107 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751854AbWJ1GIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 02:08:36 -0400
Date: Sat, 28 Oct 2006 00:08:33 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Message-ID: <20061028060833.GC5560@colo.lackof.org>
References: <20061026191131.003f141d@localhost.localdomain> <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz> <20061027113908.4a82c28a.akpm@osdl.org> <20061027114144.f8a5addc.akpm@osdl.org> <20061027114237.d577c153.akpm@osdl.org> <1161989970.16839.45.camel@localhost.localdomain> <20061027160626.8ac4a910.akpm@osdl.org> <20061028050905.GB5560@colo.lackof.org> <20061027221925.1041cc5e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027221925.1041cc5e.akpm@osdl.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 10:19:25PM -0700, Andrew Morton wrote:
> > > It would be nice to express those dependencies in some clearer and less
> > > fragile manner than link order.  I guess finer-grained initcall levels
> > > would do that, but it doesn't scale very well.
> > 
> > Would making use of depmod data be a step in the right direction?
> 
> Nope.  The linkage-order problem is by definition applicable to
> linked-into-vmlinux code, not to modules.

But wouldn't the same concept apply to non-module symbols that
are tagged with EXPORT_SYMBOL()?
Maybe I'm just showing my ignorance about kernel linking here...

> > ie nic driver calls extern function (e.g. pci_enable_device())
> > and therefore must depend on module which provides that function.
> > 
> > My guess is this probably isn't 100% sufficient to replace all initcall
> > levels.  But likely sufficient within a given initcall level.
> > My main concern are circular dependencies (which are rare).
> 
> The simplest implementation of "A needs B to have run" is for A to simply
> call B, and B arranges to not allow itself to be run more than once.

Yes. we already have code like this in the kernel.
e.g. superio support in drivers/parisc.

> But that doesn't work in the case "A needs B to be run, but only if B is
> present".

I was thinking of "A is present and calls into module B, therefore B needs
to init first". In this case, A won't care if B is really present or not.
A depends on B to figure that out at runtime. If B is not configured into
the kernel, A won't ever call B since the "function" will be a NOP.
(e.g. #ifndef CONFIG_B/#define b_service() /* NOP */ /#endif)
 

>  Resolving this one would require something like a fancy
> "synchronisation object" against which dependers and dependees can register
> interest, and a core engine which takes care of the case where a depender
> registers against something which no dependees have registered.

I guess I was wondering if the kernel link step could use symbol information
in a similar way the kernel module autoloader uses depmod info. But other
parts of the kernel might not be as modular as most of the IO subsystems
are.

I'm not looking for ways to make the process more complicated for
the people maintaining code. Keeping the registrations of dependencies
up-to-date manually would just be another PITA.

...
> > I thought parallel PCI and SCSI probing on system with multiple NICs and
> > "SCSI" storage requires udev to create devices with consistent naming.
> 
> For some reason people get upset when we rename all their devices.  They're
> a humourless lot.

Hey! I resemble that remark! ;)

(yeah, I've been a victim of that problem way too many times.)

thanks,
grant
