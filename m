Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWGEVgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWGEVgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWGEVgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:36:37 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:53218 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964929AbWGEVgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:36:35 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>, Andrew Morton <akpm@osdl.org>
Subject: Re: ACPIPNP and too large IO resources
Date: Wed, 5 Jul 2006 15:36:30 -0600
User-Agent: KMail/1.8.3
Cc: Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       Adam Belay <ambx1@neo.rr.com>, Shaohua Li <shaohua.li@intel.com>,
       castet.matthieu@free.fr, linux-acpi@vger.kernel.org, uwe.bugla@gmx.de
References: <44AB608F.1060903@drzeus.cx> <200607051047.40734.bjorn.helgaas@hp.com> <44AC26DA.1010901@drzeus.cx>
In-Reply-To: <44AC26DA.1010901@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607051536.30771.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 July 2006 14:53, Pierre Ossman wrote:
> Bjorn Helgaas wrote:
> > It sounds like this might be the same problem as
> >     http://bugzilla.kernel.org/show_bug.cgi?id=6292
> >
> > In short, you probably have a bridge device that consumes the
> > entire 0x0-0xffff I/O port range and produces some or all of that
> > range for downstream PNP devices.  PNP doesn't know what to do
> > with these windows that are both consumed by the bridge and made
> > available to downstream devices, so it just marks them as being
> > already reserved.
> 
> Ah, that explains things.
> 
> > Matthieu Castet wrote a nice patch (attached) that makes PNP just
> > ignore those windows.  Can you try it and see whether it fixes
> > the problem you're seeing?  This patch is already in -mm, but not
> > yet in mainline.  We might need to consider this patch as
> > 2.6.18 material if it resolves your problem.  I suspect many
> > people will see the same problem.
> 
> The patch works nicely and removes all memory and io regions for the PCI
> bridge but for the range 0xcf8-0xcff.

Andrew, I think we should try again to push
pnpacpi-reject-acpi_producer-resources.patch to the mainline.

Pierre's report (starts here: http://lkml.org/lkml/2006/7/5/20)
is another instance of http://bugzilla.kernel.org/show_bug.cgi?id=6292.

I suspect that many PNP devices are broken in 2.6.17 because of
this problem.  Probably the only reason we haven't seen more
reports is that PNPACPI isn't turned on by default.  (Maybe
we should do that in -mm?)

You recently proposed pushing it:
    http://marc.theaimsgroup.com/?l=linux-acpi&m=115119275408021&w=2
Len initially nacked it, but I think the outcome of the discussion
is that Shaohua doesn't object to this patch.  He probably would
still like to blacklist PNP0A03, but that's an additional step we
don't have to take at the same time.

Bjorn
