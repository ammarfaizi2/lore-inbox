Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWFURKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWFURKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 13:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWFURKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 13:10:50 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:16438 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S932276AbWFURKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 13:10:49 -0400
Date: Wed, 21 Jun 2006 10:10:48 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc[56]-mm*: pcmcia "I/O resource not free"
Message-ID: <20060621171048.GS2038@hexapodia.org>
References: <20060615162859.GA1520@hexapodia.org> <20060617100327.e752b89a.akpm@osdl.org> <20060620211723.GA28016@hexapodia.org> <20060620150317.746372c5.akpm@osdl.org> <20060621065036.GR2038@hexapodia.org> <20060621004630.bb5eb68a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621004630.bb5eb68a.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 12:46:30AM -0700, Andrew Morton wrote:
> > [ 2034.060000] pcmcia: registering new device pcmcia0.0
> > [ 2034.060000] PM: Adding info for pcmcia:0.0
> > [ 2035.976000] conflict: PCI IO[0->ffff]
> > [ 2035.976000] hwif_request_region: single-byte request for ide2
> > [ 2035.976000]  [<c0257386>] hwif_request_region+0xa6/0xb0
[snip]
> > [ 2035.976000] ide2: I/O resource 0xF8B0200E-0xF8B0200E not free.
> > [ 2035.976000] ide2: ports already in use, skipping probe
> 
> hm.  It appears to have decided that 0 < 0xF8B0200E < 0xffff, which is
> clever of it.
> 
> Does it help if you set CONFIG_RESOURCES_32BIT?

Nope, same conflict with CONFIG_RESOURCES_32BIT set.  You're right, it
is deciding that 0xF8B0200E conflicts with that range:

conflict: PCI IO[0->ffff] conflicts with ide2[f8b3c00e->f8b3c00e]

Looking at the code, I don't understand how this could have worked in
-rc6; __request_resource hasn't changed, and it says

    167         if (end < start)
    168                 return root;
    169         if (start < root->start)
    170                 return root;
    171         if (end > root->end)
    172                 return root;

If root-> start == 0 and root->end == 0xffff, we should always hit line
172, unless sign extension is in effect... and all the variables are
unsigned long in -rc6, so that doesn't make sense.

Rebooting into -rc6 with some debugging...

-andy
