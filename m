Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVBXXDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVBXXDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVBXXCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:02:47 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:61396 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262547AbVBXXCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:02:32 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Adam Belay <abelay@novell.com>
Subject: Re: [RFC] PCI bridge driver rewrite
Date: Thu, 24 Feb 2005 15:02:14 -0800
User-Agent: KMail/1.7.2
Cc: Jon Smirl <jonsmirl@gmail.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
References: <1109226122.28403.44.camel@localhost.localdomain> <9e473391050223224532239c9d@mail.gmail.com> <1109228638.28403.71.camel@localhost.localdomain>
In-Reply-To: <1109228638.28403.71.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502241502.15163.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, February 23, 2005 11:03 pm, Adam Belay wrote:
> Yeah, actually I've been thinking about this issue a lot.  I think it
> would make a lot of sense to export this sort of thing under the
> "pci_bus" class in sysfs.  The ISA enable bit should probably also be
> exported.  Furthermore, we should be verifying the BIOS's configuration
> of VGA and ISA.  I'll try to integrate this in my future releases.  I
> appreciate the code.
>
> I also have a number of resource management plans for the VGA enable bit
> that I'll get into in my next set of patches.

Keep in mind that the interface above is probably specific to PCI to PCI 
bridges since there's a spec for that.  Host to PCI bridges may implement 
their own methods for VGA routing and legacy port access.

> > Jesse can comment on the specific support needed for multiple legacy IO
> > spaces.
>
> That would be great.  Most of my experience has been with only a couple
> legacy IO port ranges passing through the bridge.

Well, I'll give you one, somewhat perverse, example.  On SGI sn2 machines, 
each host<->pci bridge (either xio<->pci or numalink<->pci) has two pci 
busses and some additional host bus ports.  The bridges are capable of 
generating low address bus cycles on both busses simultaneously, so we can do 
ISA memory access and legacy port I/O on every bus in the system at the same 
time.

The main host chipset has no notion of VGA or legacy routing though, so doing 
a port access to say 0x3c8 is ambiguous--we need a bus to target (though the 
platform code could provide a 'default' bus for such accesses to go to, this 
may be what VGA or legacy routing means for us under your scheme).  Likewise, 
accessing ISA memory space like 0xa0000 needs a bus to target.

It would be nice if this sort of thing was taken into account in your new 
model, so that for example we could have the vgacon driver talking to 
multiple different VGA cards at the same time.

Thanks,
Jesse
