Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992749AbWJTVlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992749AbWJTVlN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992751AbWJTVlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:41:13 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:41348 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S2992746AbWJTVlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:41:11 -0400
Date: Fri, 20 Oct 2006 22:41:22 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061020214122.GA29237@linux-mips.org>
References: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org> <20061020.123635.95058911.davem@davemloft.net> <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org> <20061020.125851.115909797.davem@davemloft.net> <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org> <20061020205929.GE8894@flint.arm.linux.org.uk> <Pine.LNX.4.64.0610201408070.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201408070.3962@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 02:12:11PM -0700, Linus Torvalds wrote:

> > Well, looking at do_wp_page() I'm now quite concerned about ARM and COW.
> > I can't see how this code could _possibly_ work with a virtually indexed
> > cache as it stands.  Yet, the kernel does appear to work.
> 
> It really shouldn't need any extra code, exactly because by the time it 
> hits any page-fault, the caches had better be in sync with the physical 
> page contents _anyway_ (yes, being virtual, the caches will _duplicate_ 
> the contents, but since the pages are read-only, that aliasing should be 
> perfectly fine).

Until yesterday I also thought multiple read-only copies wouldn't do any
harm.  Well, until I learned about the wonderful behaviour of the PA8800
caches.  PA8800 has VIPT primary caches, PIPT secondary caches.  And the
sinister part - caches are exclusive, that is a cacheline is either in
L1 or L2 but never in both and can migrate between L1 and L2.  Now
onsider the following scenario:

 o physical address P is mapped to two aliasing addresses V1 and V2
 o a load from V1 results in a clean line in L1 caching P at index V1.
 o a store to V2 results in a clean line in L1 caching P at index V2.
 o the line at V2 is getting written back to memory.
 o a victim replacement of the line at V1 results in the _clean_ line
   migrating back from L1 to L2.

-> another read from V2 will return stale data.

As consequence flush_cache_mm() on PA (or at least PA8800) currently blows
away the entire cache, as Kyle McMartin just told me.  The whole 1.5MB L1
and 32MB of L2 making fork an ultraheavy operation.

> It's just that we weren't quite careful enough at that time (and even 
> then, that would only matter for some really really unlikely and strange 
> situations that only happen when you fork() from a _threaded_ environment, 
> so it shouldn't be anything you'd notice under normal load).
> 
> I think.

The flush is there since a very long time.  I have it in my tree since
~ 2.1.36 and I get the feeling anybody every has been seriously revisited
the issue since.

  Ralf
