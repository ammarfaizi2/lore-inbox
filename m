Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292935AbSCDWIU>; Mon, 4 Mar 2002 17:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292932AbSCDWIJ>; Mon, 4 Mar 2002 17:08:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28754 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292923AbSCDWHv>; Mon, 4 Mar 2002 17:07:51 -0500
Date: Mon, 4 Mar 2002 23:06:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, riel@conectiva.com.br,
        phillips@bonn-fries.net, davidsen@tmr.com, mfedyk@matchmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020304230603.O20606@dualathlon.random>
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com><190330000.1015261149@flay> <20020304191804.2e58761c.skraw@ithnet.com> <203430000.1015267614@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203430000.1015267614@flay>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 10:46:54AM -0800, Martin J. Bligh wrote:
> >> 2) We can do local per-node scanning - no need to bounce
> >> information to and fro across the interconnect just to see what's
> >> worth swapping out.
> > 
> > Well, you can achieve this by "attaching" the nodes' local memory 
> > (zone) to its cpu and let the vm work preferably only on these attached 
> > zones (regarding the list scanning and the like). This way you have no 
> > interconnect traffic generated. But this is in no way related to rmap.
> >
> >> I can't see any way to fix this without some sort of rmap - any
> >> other suggestions as to how this might be done?
> > 
> > As stated above: try to bring in per-node zones that are preferred by their cpu. This can work equally well for UP,SMP and NUMA (maybe even for cluster).
> > UP=every zone is one or more preferred zone(s)
> > SMP=every zone is one or more preferred zone(s)
> > NUMA=every cpu has one or more preferred zone(s), but can walk the whole zone-list if necessary.
> >
> > Preference is implemented as simple list of cpu-ids attached to every 
> > memory zone.  This is for being able to see the whole picture. Every 
> > cpu has a private list of (preferred) zones which is used by vm for the 
> > scanning jobs (swap et al). This way there is no need to touch interconnection. 
> > If you are really in a bad situation you can alway go back to the global 
> > list and do whatever is needed.
> 
> As I understand the current code (ie this may be totally wrong ;-) ) I think 
> we already pretty much have what you're suggesting. There's one (or more) 
> zone per node chained off the pgdata_t, and during memory allocation we 
> try to scan through the zones attatched to the local node first. The problem 

yes, also make sure to keep this patch from SGI applied, it's very
important to avoid memory balancing if there's still free memory in the
other zones:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre1aa1/20_numa-mm-1

It should apply cleanly on top of my vm-28.

> seems to me to be that the way we do current swap-out scanning is virtual, 
> not physical, and thus cannot be per zone => per node.

actually if you do process bindings the pte should be all allocated
local to the node if numa is enabled, and if there's no binding, no
matter if you have rmap or not, the ptes can be spread across the whole
system (just like the physical pages in the inactive/active lrus,
because they're not per-node).

Andrea
