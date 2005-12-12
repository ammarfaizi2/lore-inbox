Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVLLVgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVLLVgU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVLLVgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:36:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:47307 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932095AbVLLVgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:36:19 -0500
Date: Mon, 12 Dec 2005 13:15:54 -0800
From: Greg KH <gregkh@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ak@muc.de,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 2/4] i386/x86-64: Implement fallback for PCI mmconfig to type1
Message-ID: <20051212211553.GA29112@suse.de>
References: <20051212192030.873030000@press.kroah.org> <20051212200123.GC27657@kroah.com> <20051212202643.GG9286@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212202643.GG9286@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 01:26:43PM -0700, Matthew Wilcox wrote:
> On Mon, Dec 12, 2005 at 12:01:23PM -0800, Greg Kroah-Hartman wrote:
> > When there is no entry for a bus in MCFG fall back to type1.  This is
> > especially important on K8 systems where always some devices can't be
> > accessed using mmconfig (in particular the builtin northbridge doesn't
> > support it for its own devices)
> [...]
> > -static int pci_conf1_read(unsigned int seg, unsigned int bus,
> > +int pci_conf1_read(unsigned int seg, unsigned int bus,
> 
> I don't like this at all.  We already have a mechanism to use different
> accessors per-bus (bus->ops->read()); calling the type1 accessors from
> the mmconfig accessors just seems wrong.

>From what I can tell, it's too late in the callstack for us to change
the read ops for this device to be the other one.  The problem is (and
Andi can correct me if I'm wrong), some boxes basically have incomplete
MCFG acpi tables (the tables do not describe all PCI busses that are
present in the box).  But we don't realize this until we are about to do
the read function.

I remember I looked into trying to set this up at probe/init time, and
it was almost impossible to do so, due to the structure of the code.

However, I might have missed something, and if you can point how to do
this easier, please do.

As it is, this patch is needed to fix boxes that do not work at all with
the current kernel.

thanks,

greg k-h
