Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751818AbWJ1FWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWJ1FWy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 01:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbWJ1FWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 01:22:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49592 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751818AbWJ1FWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 01:22:53 -0400
Date: Fri, 27 Oct 2006 22:19:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall
 levels
Message-Id: <20061027221925.1041cc5e.akpm@osdl.org>
In-Reply-To: <20061028050905.GB5560@colo.lackof.org>
References: <20061027012058.GH5591@parisc-linux.org>
	<20061026182838.ac2c7e20.akpm@osdl.org>
	<20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027172219.GC30416@elf.ucw.cz>
	<20061027113908.4a82c28a.akpm@osdl.org>
	<20061027114144.f8a5addc.akpm@osdl.org>
	<20061027114237.d577c153.akpm@osdl.org>
	<1161989970.16839.45.camel@localhost.localdomain>
	<20061027160626.8ac4a910.akpm@osdl.org>
	<20061028050905.GB5560@colo.lackof.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 23:09:05 -0600
Grant Grundler <grundler@parisc-linux.org> wrote:

> On Fri, Oct 27, 2006 at 04:06:26PM -0700, Andrew Morton wrote:
> > On Fri, 27 Oct 2006 23:59:30 +0100
> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > 
> > > Ar Gwe, 2006-10-27 am 11:42 -0700, ysgrifennodd Andrew Morton:
> > > > IOW, we want to be multithreaded _within_ an initcall level, but not between
> > > > different levels.
> > > 
> > > Thats actually insufficient. We have link ordered init sequences in
> > > large numbers of driver subtrees (ATA, watchdog, etc). We'll need
> > > several more initcall layers to fix that.
> > > 
> > 
> > It would be nice to express those dependencies in some clearer and less
> > fragile manner than link order.  I guess finer-grained initcall levels
> > would do that, but it doesn't scale very well.
> 
> Would making use of depmod data be a step in the right direction?

Nope.  The linkage-order problem is by definition applicable to
linked-into-vmlinux code, not to modules.

> ie nic driver calls extern function (e.g. pci_enable_device())
> and therefore must depend on module which provides that function.
> 
> My guess is this probably isn't 100% sufficient to replace all initcall
> levels.  But likely sufficient within a given initcall level.
> My main concern are circular dependencies (which are rare).

The simplest implementation of "A needs B to have run" is for A to simply
call B, and B arranges to not allow itself to be run more than once.

But that doesn't work in the case "A needs B to be run, but only if B is
present".  Resolving this one would require something like a fancy
"synchronisation object" against which dependers and dependees can register
interest, and a core engine which takes care of the case where a depender
registers against something which no dependees have registered.

The mind boggles.

> > But whatever.  I think multithreaded probing just doesn't pass the
> > benefit-versus-hassle test, sorry.   Make it dependent on CONFIG_GREGKH ;)
> 
> Isn't already? :)
> 
> I thought parallel PCI and SCSI probing on system with multiple NICs and
> "SCSI" storage requires udev to create devices with consistent naming.

For some reason people get upset when we rename all their devices.  They're
a humourless lot.

