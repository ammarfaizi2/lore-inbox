Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946658AbWJSXRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946658AbWJSXRt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946659AbWJSXRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:17:49 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:53472
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1946658AbWJSXRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:17:48 -0400
Date: Thu, 19 Oct 2006 16:17:49 -0700 (PDT)
Message-Id: <20061019.161749.08321831.davem@davemloft.net>
To: jesse.barnes@intel.com
Cc: eiichiro.oiwa.nm@hitachi.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: pci_fixup_video change blows up on sparc64
From: David Miller <davem@davemloft.net>
In-Reply-To: <200610191558.06473.jesse.barnes@intel.com>
References: <200610190952.22285.jesse.barnes@intel.com>
	<20061019.153814.59655968.davem@davemloft.net>
	<200610191558.06473.jesse.barnes@intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Barnes <jesse.barnes@intel.com>
Date: Thu, 19 Oct 2006 15:58:05 -0700

> On Thursday, October 19, 2006 3:38 pm, David Miller wrote:
> > > Right, I guess we should have been a bit more careful in making
> > > this code generic.  At least ia64, i386 and x86_64 systems often
> > > have video BIOSes in system memory at 0xc0000 (note that this isn't
> > > in PCI space).
> >
> > Even if it is in system memory there, accessing physical RAM using
> > ioremap() and asm/io.h accessors is not exactly legal.  On sparc64,
> > for example, accessing physical RAM as if it were I/O memory will
> > result in a BUS ERROR and in fact that's how the bootup crashes
> > on sparc64 due to this changeset.
> 
> Good point, we shouldn't use ioremap for the system memory case at all.  
> Should be __va or something I guess.

That's one part, but this won't update all the pci_map_rom() callers
who use asm/io.h accessors on the mapping they get back.  Even
pci_read_rom() in the sysfs code this change was aimed at uses
memcpy_fromio().

Also, as an aside, if we're on a system where the x86 BIOS is unlikely
to be executed anyways, we should always use the PCI ROM bar mapping
to access the video card's ROM.
