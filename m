Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268798AbUI3IGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268798AbUI3IGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 04:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268781AbUI3IGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 04:06:45 -0400
Received: from ozlabs.org ([203.10.76.45]:22989 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268836AbUI3IGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 04:06:35 -0400
Date: Thu, 30 Sep 2004 18:05:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>, Olaf Hering <olh@suse.de>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Improved VSID allocation algorithm
Message-ID: <20040930080510.GH21889@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Anton Blanchard <anton@samba.org>, Olaf Hering <olh@suse.de>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <20040913041119.GA5351@zax> <20040929194730.GA6292@suse.de> <20040930064037.GA3167@krispykreme.ozlabs.ibm.com> <20040930070151.GG21889@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930070151.GG21889@zax>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 05:01:51PM +1000, David Gibson wrote:
> On Thu, Sep 30, 2004 at 04:40:37PM +1000, Anton Blanchard wrote:
> >  
> > > This patch went into 2.6.9-rc2-bk2, and my p640 does not boot anymore.
> > > Hangs after 'returning from prom_init', wants a power cycle.
> > 
> > How much memory do you have? We might be filling up a hpte bucket
> > completely with certain amounts of memory.
> 
> Bugger, bugger, bugger bugger.  That's it.  Just ran 4GB linear
> mapping with 4k pages through by hash scattering simulator - max
> bucket load is 2 with the old algo and 16 with the new one.  Well, we
> just found the first case where the new algorithm scatters
> significantly worse than the old one.  It would be something this
> dire, wouldn't it.

Ok, after some more investigations, I think I've come to a theoretical
understanding of why this is happening.  The problem is that
VSID_MULTIPLIER is too close to (1<<28), i.e. too close to all-1s.
That means the differences between the VSIDs for the 16 segments in
the linear mapping are all either in the high bits - where they get
truncated my the size of the hash table - or in the low bits, where
they get masked by the vpn component of the hash (it cycles through
every possible value in the low 16 bits).  We crucially need the bits
in the middle to be different - with an order 19 hash table, we only
have three significant bits to play with..

Fortunately, I think it's not too hard to fix.  Olaf, can you try
changing VSID_MULTIPLIER in include/asm-ppc64/mmu.h to 200730139,
instead of the current value.  According to my hash simulator that
should fix the problem for you (and work out to larger amounts of RAM,
too).

I'll push a patch for this tomorrow - the fact that this has come up
suggest to me that I need to think a little deeper about the rationale
for picking VSID_MULTIPLIER.

NB, I'm assuming this is a pSeries machine we're talking about - just
changing VSID_MULTIPLIER is not sufficient on an iSeries machine.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
