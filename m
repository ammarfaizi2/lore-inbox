Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWFVAcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWFVAcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWFVAcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:32:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:54993 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932143AbWFVAcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:32:11 -0400
Date: Wed, 21 Jun 2006 20:31:49 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc[56]-mm*: pcmcia "I/O resource not free"
Message-ID: <20060622003149.GB25514@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060615162859.GA1520@hexapodia.org> <20060617100327.e752b89a.akpm@osdl.org> <20060620211723.GA28016@hexapodia.org> <20060620150317.746372c5.akpm@osdl.org> <20060621065036.GR2038@hexapodia.org> <20060621004630.bb5eb68a.akpm@osdl.org> <20060621171048.GS2038@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621171048.GS2038@hexapodia.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 10:10:48AM -0700, Andy Isaacson wrote:
> On Wed, Jun 21, 2006 at 12:46:30AM -0700, Andrew Morton wrote:
> > > [ 2034.060000] pcmcia: registering new device pcmcia0.0
> > > [ 2034.060000] PM: Adding info for pcmcia:0.0
> > > [ 2035.976000] conflict: PCI IO[0->ffff]
> > > [ 2035.976000] hwif_request_region: single-byte request for ide2
> > > [ 2035.976000]  [<c0257386>] hwif_request_region+0xa6/0xb0
> [snip]
> > > [ 2035.976000] ide2: I/O resource 0xF8B0200E-0xF8B0200E not free.
> > > [ 2035.976000] ide2: ports already in use, skipping probe
> > 
> > hm.  It appears to have decided that 0 < 0xF8B0200E < 0xffff, which is
> > clever of it.
> > 
> > Does it help if you set CONFIG_RESOURCES_32BIT?
> 
> Nope, same conflict with CONFIG_RESOURCES_32BIT set.  You're right, it
> is deciding that 0xF8B0200E conflicts with that range:
> 
> conflict: PCI IO[0->ffff] conflicts with ide2[f8b3c00e->f8b3c00e]
> 
> Looking at the code, I don't understand how this could have worked in
> -rc6; __request_resource hasn't changed, and it says
> 
>     167         if (end < start)
>     168                 return root;
>     169         if (start < root->start)
>     170                 return root;
>     171         if (end > root->end)
>     172                 return root;
> 
> If root-> start == 0 and root->end == 0xffff, we should always hit line
> 172, unless sign extension is in effect... and all the variables are
> unsigned long in -rc6, so that doesn't make sense.
> 

I think this makes sense. We are hitting line 172 in case of -mm because
f8b3c00e is not a valid io port at all. Maximum valid value can be 0xffff.
So _request_region considers this to be a conflict and returns.
 
It succeeds in -rc6 because ide code is requesting a valid ioport region
ide2[310e->310e].

So __request_region() code seems to be fine. Problem seems to be that
why do we get an invalid ioport range in following call.

addr = hwif->io_ports[IDE_CONTROL_OFFSET];

Either hwif pointer is bad or somehow the location it is pointing to
is corrupt or something else. Can you do some more tracing on hwif.

Thanks
Vivek
