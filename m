Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266662AbRHAWyu>; Wed, 1 Aug 2001 18:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbRHAWyk>; Wed, 1 Aug 2001 18:54:40 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:64248 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266662AbRHAWyd>; Wed, 1 Aug 2001 18:54:33 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108012253.f71MrxGO007546@webber.adilger.int>
Subject: Re: repeated failed open()'s results in lots of used memory [Was: [Fwd:
 memory consumption]]
In-Reply-To: <3B688480.7090704@starentnetworks.com> "from Brian Ristuccia at
 Aug 1, 2001 06:36:48 pm"
To: Brian Ristuccia <bristuccia@starentnetworks.com>
Date: Wed, 1 Aug 2001 16:53:59 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        djohnson@starentnetworks.com
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Ristuccia writes:
> Andreas Dilger wrote:
> > You are probably creating negative dentries.  Check /proc/slabinfo for
> > the number of dentries, and it will confirm this.  I'm not sure why
> > that would cause swapping, but then again I haven't checked the policy
> > for shrinking the dentry cache recently, and there have been a number
> > of changes in that area lately.
> 
> Yow! Right on. On 2.2.19 and 2.4.7, the  line for dentry_cache in 
> /proc/slabinfo skyrockets while the test program is running. Also, on 
> 2.2.19 but not 2.4.7 the line for size-32 climbs steadily at around the 
> same pace as dentry_cache when the test program is running. After I stop 
> the test program, the number slowly declines as other processes allocate 
> memory.

So it is identified, but still probably needs to be fixed in some way.
Otherwise, you could potentially have DOS from someone trying to read
or create files, even if they don't have write permission _anywhere_
on the system.

Looking at the code, it appears that if we call shrink_dcache_memory()
from while trying to allocate memoty for a filesystem, it returns
without doing anything, to avoid a deadlock.  Al Viro and/or Marcelo
Tosatti probably know how to fix this.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

