Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315563AbSECGKe>; Fri, 3 May 2002 02:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315565AbSECGKd>; Fri, 3 May 2002 02:10:33 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:35104 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315563AbSECGKc>; Fri, 3 May 2002 02:10:32 -0400
Date: Fri, 3 May 2002 08:10:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020503081051.T11414@dualathlon.random>
In-Reply-To: <20020502180632.I11414@dualathlon.random> <20020502204136.M11414@dualathlon.random> <20020502191903.GL32767@holomorphy.com> <E173MEW-00027y-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 09:27:00PM +0200, Daniel Phillips wrote:
> On Thursday 02 May 2002 21:19, William Lee Irwin III wrote:
> > On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
> > > Dropping the loop when discontigmem is enabled is much more interesting
> > > optimization of course.
> > > Andrea
> > 
> > Absolutely; I'd be very supportive of improvements for this case as well.
> > Many of the systems with the need for discontiguous memory support will
> > also benefit from parallelizations or other methods of avoiding references
> > to remote nodes/zones or iterations over all nodes/zones.
> 
> Which loop in which function are we talking about?

the pgdat loops. example, this could be optimized for the 99% of userbase to:

	do {
                zonelist_t *zonelist = pgdat->node_zonelists + (GFP_USER & GFP_ZONEMASK);
                zone_t **zonep = zonelist->zones;
                zone_t *zone;

                for (zone = *zonep++; zone; zone = *zonep++) {
                        unsigned long size = zone->size;
                        unsigned long high = zone->pages_high;
                        if (size > high)
                                sum += size - high;
                }
	
#ifdef CONFIG_DISCONTIGMEM
		pgdat = pgdat->node_next;
	} while (pgdat);
#else
	} while (0)
#endif

so allowing the compiler to remove a branch and a few instructions from
the asm, but it would be a microoptimization not visible in benchmarks,
I'm not actually suggesting that mostly for code clarity, branch
prediction should also take it right if it starts to be executed
frequently (hopefully the asm is large enough that it doesn't get
confused by the inner loop that is quite near).

Andrea
