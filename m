Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317797AbSFMTBv>; Thu, 13 Jun 2002 15:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317798AbSFMTBu>; Thu, 13 Jun 2002 15:01:50 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:33409 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317797AbSFMTBu>; Thu, 13 Jun 2002 15:01:50 -0400
Date: Thu, 13 Jun 2002 21:01:30 +0200
From: Andi Kleen <ak@muc.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andi Kleen <ak@muc.de>, engler@csl.Stanford.EDU,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Message-ID: <20020613210130.A27417@averell>
In-Reply-To: <m3d6uvxdts.fsf@averell.firstfloor.org> <Pine.GSO.4.21.0206131420010.20315-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 08:26:54PM +0200, Alexander Viro wrote:
> Ugh...  OK, let me try again:
> 
> One bit of apriory information needed to get anything interesting from
> this analysis:  there is a set of mutually recursive functions (see above)
> and there is a limit (5) on the depth of recursion in that loop.
> 
> It has to be known to checker.  Explicitly, since
> 	a) automatically deducing it is not realistic
> 	b) cutting off the stuff behind that loop will cut off a _lot_ of
> things - both in filesystems and in VFS (and in block layer, while we are
> at it).
> 
> I'm not saying that checker can't be used for that analysis - it can, but
> naive approach (find recursive stuff and cut it off) will not be too

if you see all possible paths through the program as a tree which branches 
for every decision then you only need to cut off the branches that are 
actually pointing upward the tree again. This would still allow to follow
down into the callees of the recursive function because there should be 
at least one path that is non recursive (if not Checker should definitely
complain ;) 

e.g.
       ----<-----------------+
	   v                     |
 IF   TRUE                RECURSION
-------+------ some path ----+
       |
	  ELSE                    non recursive path 
       +-------------------------- other functions ---------->


Other functions can be still checked, you only need to prune the cycle.
I have no idea if checker's algorithms actually work like this, but I could
imagine that it would be one possible implementation.

-Andi

