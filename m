Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVCBTZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVCBTZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVCBTX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:23:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:7823 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262429AbVCBTUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:20:49 -0500
Date: Wed, 2 Mar 2005 13:20:43 -0600
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
Message-ID: <20050302192043.GJ1220@austin.ibm.com>
References: <422428EC.3090905@jp.fujitsu.com> <20050301144211.GI28741@parcelfarce.linux.theplanet.co.uk> <20050301192711.GE1220@austin.ibm.com> <42255971.4070608@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42255971.4070608@jp.fujitsu.com>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 03:13:05PM +0900, Hidetoshi Seto was heard to remark:

[ .. iochk_clear() and iochk_read() ...]

> And then, I don't think it need to have "pci" ... limitation of this
> API's target. It would not be match if there are a recoverable device
> over some PCI to XXX bridge, or if there are some special arch where
> don't have PCI but other recoverable bus system, or if future bus system
> doesn't called pci...
> Currently we would deal only pci, but in future possibly not.

OK, in that case, I like the names you picked.

> > Yes, they should be no-ops. save/restore interrupts would be a bad idea.
> 
> I expect that we should not do any operation requires enabled interrupt
> between iochk_clear and iochk_read. 

why? Maybe some specific pci chipset might need this, but in general,
I don't see why this should be assumed.  

> If their defaults are no-ops, device
> maintainers who develops their driver on not-implemented arch should be
> more careful. 

Why? People who write device drivers already know if/when they need to
disable interrupts, and so they already disable if they need it.  

If a specific arch is using a specific pci chipset that needs interrupts 
disabled in order to get io error info, then the arch-specific 
implementation can disable interrupts in iock_clear() ... But I can't 
imagine why one would want to make this the default behaviour for 
all arches that *don't* support io error checking ... 

(on ppc64, iochk_clear() would be a no-op, and iochk_read() would
check a flag and maybe call firmware, but would not otherwise have to
fiddle with interrupts).

--linas

p.s. I would like to have iochk_read() take struct pci_dev * as an
argument.  (I could store a pointer to pci_dev in the "cookie" but
that seems odd).
