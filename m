Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946601AbWJSWiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946601AbWJSWiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946602AbWJSWiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:38:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:163
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946601AbWJSWiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:38:13 -0400
Date: Thu, 19 Oct 2006 15:38:14 -0700 (PDT)
Message-Id: <20061019.153814.59655968.davem@davemloft.net>
To: jesse.barnes@intel.com
Cc: eiichiro.oiwa.nm@hitachi.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: pci_fixup_video change blows up on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <200610190952.22285.jesse.barnes@intel.com>
References: <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com>
	<20061019.013732.30184567.davem@davemloft.net>
	<200610190952.22285.jesse.barnes@intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Barnes <jesse.barnes@intel.com>
Date: Thu, 19 Oct 2006 09:52:21 -0700

> On Thursday, October 19, 2006 1:37 am, David Miller wrote:
> > Also, and more importantly, you cannot use the 0xc0000 address in a
> > raw way like this.  There are multiple PCI domains possible in a
> > given system, and the 0xc0000 address you wish to use must be
> > relative to that PCI domain.
> >
> > Therefore, in the presence of multiple PCI domains:
> >
> > 	x = ioremap(0xc0000, ...);
> >
> > doesn't make any sense, is extremely non-portable, and will crash
> > on many non-x86 systems.
> 
> Right, I guess we should have been a bit more careful in making this 
> code generic.  At least ia64, i386 and x86_64 systems often have video 
> BIOSes in system memory at 0xc0000 (note that this isn't in PCI space).  

Even if it is in system memory there, accessing physical RAM using
ioremap() and asm/io.h accessors is not exactly legal.  On sparc64,
for example, accessing physical RAM as if it were I/O memory will
result in a BUS ERROR and in fact that's how the bootup crashes
on sparc64 due to this changeset.

Sparc64 systems do not reserve this area of physical ram for video
ROM, and in fact it is very common and possible to have a system
which there is not even physical RAM located at that physical address.

The amount of platforms-specific assumptions made by this code is
impressive, in fact :-)

> It sounds like on your system the regular sysfs ROM mapping code should 
> be able to see the ROM, and this 0xc0000 mapping/copying shouldn't be 
> necessary.

I'm pretty sure it should use the PCI ROM bar area, just like it
always has until this change was installed.

> Maybe we should conditionalize it, making it only available on ia64, 
> i386 and x86_64?  Then again, I think there are some embedded platforms 
> that could use this code too?

This is what should happen, at the very least.
