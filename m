Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946630AbWJSW5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946630AbWJSW5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 18:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946631AbWJSW5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 18:57:11 -0400
Received: from mga03.intel.com ([143.182.124.21]:11397 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1946630AbWJSW5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 18:57:10 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="133448879:sNHT33048785"
From: Jesse Barnes <jesse.barnes@intel.com>
To: David Miller <davem@davemloft.net>
Subject: Re: pci_fixup_video change blows up on sparc64
Date: Thu, 19 Oct 2006 15:58:05 -0700
User-Agent: KMail/1.9.4
Cc: eiichiro.oiwa.nm@hitachi.com, alan@redhat.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
References: <XNM1$9$0$4$$3$3$7$A$9002705U45372f1d@hitachi.com> <200610190952.22285.jesse.barnes@intel.com> <20061019.153814.59655968.davem@davemloft.net>
In-Reply-To: <20061019.153814.59655968.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610191558.06473.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 19, 2006 3:38 pm, David Miller wrote:
> > Right, I guess we should have been a bit more careful in making
> > this code generic.  At least ia64, i386 and x86_64 systems often
> > have video BIOSes in system memory at 0xc0000 (note that this isn't
> > in PCI space).
>
> Even if it is in system memory there, accessing physical RAM using
> ioremap() and asm/io.h accessors is not exactly legal.  On sparc64,
> for example, accessing physical RAM as if it were I/O memory will
> result in a BUS ERROR and in fact that's how the bootup crashes
> on sparc64 due to this changeset.

Good point, we shouldn't use ioremap for the system memory case at all.  
Should be __va or something I guess.

> Sparc64 systems do not reserve this area of physical ram for video
> ROM, and in fact it is very common and possible to have a system
> which there is not even physical RAM located at that physical
> address.
>
> The amount of platforms-specific assumptions made by this code is
> impressive, in fact :-)

No disagreement here...  people often make the mistake when looking at 
the PCI to PCI bridge spec that it also applies to host to PCI bridges.  
And having a video ROM at 0xc0000 is common, but certainly not 
universal.

> > It sounds like on your system the regular sysfs ROM mapping code
> > should be able to see the ROM, and this 0xc0000 mapping/copying
> > shouldn't be necessary.
>
> I'm pretty sure it should use the PCI ROM bar area, just like it
> always has until this change was installed.

Yeah, that's what sysfs will do by default, but this code is overriding 
it's default behavior because some host bridge bit is set, it appears.

> > Maybe we should conditionalize it, making it only available on
> > ia64, i386 and x86_64?  Then again, I think there are some embedded
> > platforms that could use this code too?
>
> This is what should happen, at the very least.

Sounds good to me, though I think we should also add the checks I 
mentioned in my other mail just to be extra robust (of course I don't 
have a system to test on, so I'm hoping Eiichiro can do it. :)

Jesse
