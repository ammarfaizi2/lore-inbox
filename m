Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSKVKGG>; Fri, 22 Nov 2002 05:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSKVKGG>; Fri, 22 Nov 2002 05:06:06 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:19974 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261346AbSKVKGE>; Fri, 22 Nov 2002 05:06:04 -0500
Date: Fri, 22 Nov 2002 10:13:01 +0000
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021122101301.GB1508@reti>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <20021120160259.GW806@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120160259.GW806@nic1-pc.us.oracle.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 08:03:00AM -0800, Joel Becker wrote:
> 	Hmm, what is the intended future interaction of DM and MD?  Two
> ways at the same problem?  Just curious.


There are a couple of good arguments for moving the _mapping_ code
from md into dm targets:

1) Building a mirror is essentially just copying large amounts of data
   around, exactly what is needed to implement move functionality for
   arbitrarily remapping volumes.  (see
   http://people.sistina.com/~thornber/pvmove_outline.txt).

   So I've always had every intention of implementing a mirror target
   for dm.

2) Extending raid 5 volumes becomes very simple if they are dm targets
   since you just add another segment, this new segment could even
   have different numbers of stripes.  eg,


       old volume                             new volume
   +--------------------+      +--------------------+--------------------+
   | raid5 across 3 LVs |   => | raid5 across 3 LVs | raid5 across 5 LVs |
   +--------------------+      +--------------------+--------------------+

   Of course this could be done ATM by stacking 'bottom LVs' -> mds ->
   'top LV', but that does create more intermediate devices and
   sacrifices space to the md metadata (eg, LVM has its own metadata
   and doesn't need md to duplicate it).

MD would continue to exist as a seperate driver, it needs to read and
write the md metadata at the beginning of the physical volumes, and
implement all the nice recovery/hot spare features.  ie. dm does the
mapping, md implements the policies by driving dm appropriately.  If
other volume managers such as EVMS or LVM want to implement features
not provided by md, they are free to drive dm directly.

I don't think it's a huge amount of work to refactor the md code, and
now might be the right time if Neil is already changing things.  I
would be more than happy to work on this if Neil agrees.

- Joe

