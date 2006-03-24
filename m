Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWCXNta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWCXNta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 08:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWCXNta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 08:49:30 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:40080 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932325AbWCXNta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 08:49:30 -0500
Date: Fri, 24 Mar 2006 14:49:17 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@suse.de>
cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] use select for GART_IOMMU to enable AGP
In-Reply-To: <200603241351.29195.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0603241413590.16802@scrub.home>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <p73odzw59ct.fsf@verdi.suse.de>
 <Pine.LNX.4.64.0603241335140.16802@scrub.home> <200603241351.29195.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 24 Mar 2006, Andi Kleen wrote:

> > I don't see how this is/was possible, if GART_IOMMU was enabled so was AGP 
> > (and AGP_AMD64). That hasn't changed with the patch.
> 
> That was/is a bug that was originally introduced in the 2.4->2.6 Kconfig conversion.
> The code was designed to handle it and did in 2.4.

It's debatable whether it's really a bug in the conversion.

2.4 does this:

if [ "$CONFIG_GART_IOMMU" = "y" ]; then
   bool '/dev/agpgart (AGP Support)' CONFIG_AGP
else
   tristate '/dev/agpgart (AGP Support)' CONFIG_AGP
fi

Dynamically changing the symbol type isn't supported anymore and it works 
in 2.4 only by accident (e.g. it breaks the old xconfig).

If we really want to do something like this we had to introduce two 
different symbols. Something like:

config GART_IOMMU
	....

config AGP_BOOL
	bool "builtin AGP support"
	depends on GART_IOMMU
	select AGP
	select AGP_AMD64
	help
	  Our IOMMU code sucks. :-)

We could also just remove the select/default and add a comment after 
AGP_AMD64 depending on "AGP && GART_IOMMU && AGP_AMD64=m" saying that this 
configuration disables IOMMU support for it and be done with it.
Another alternative is to fix the code to reinitialize the iommu stuff 
when agp module is loaded.

bye, Roman
