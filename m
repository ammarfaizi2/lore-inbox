Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282435AbRK0Aap>; Mon, 26 Nov 2001 19:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282675AbRK0Aae>; Mon, 26 Nov 2001 19:30:34 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:59596 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S282435AbRK0AaS>; Mon, 26 Nov 2001 19:30:18 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "David S. Miller" <davem@redhat.com>
Date: Tue, 27 Nov 2001 11:29:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15362.56955.812017.103343@esther.cse.unsw.edu.au>
Cc: trond.myklebust@fys.uio.no, nfs@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: Fix knfsd readahead cache in 2.4.15
In-Reply-To: message from David S. Miller on Monday November 26
In-Reply-To: <15362.18626.303009.379772@charged.uio.no>
	<15362.53694.192797.275363@esther.cse.unsw.edu.au>
	<20011126.155347.45872112.davem@redhat.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 26, davem@redhat.com wrote:
>    From: Neil Brown <neilb@cse.unsw.edu.au>
>    Date: Tue, 27 Nov 2001 10:35:26 +1100 (EST)
>    
>    This is definately a bug, but I don't think it is quite as dramatic as
>    you suggest.
>    
>    The "struct raparms" that ra points to will almost always be the last
>    one on the list, so ra->p_next will almost always be NULL anyway.
>    Nevertheless, it is a bug and your fix looks good.
> 
> There are other problems remaining, this function is a logical
> mess.
> 
> 1) depth is computed in the loop, but thrown away.
>    It is basically reassigned to a constant before
>    being used to index the statistics it is for.

Only if the match is not found.  If it is found, then we "goto" over
the re-assignment and use the counted value.

> 
> 2) raparm_cache is reassigned, and since the ra param list is
>    NULL terminated this can make the list shorter and shorter
>    and shorter until it is one entry deep.

But it doesn't.
If the entry that was found is not at the head of the list, we delete
it from the list, and then insert it at the head of the list.  Nothing
gets lost.

Given that the stats on my machine still show that it is sometimes
finding entries in the last 10% of the 64 entry cache, I am quite
confident that there are atleast 58 entryies still in the cache.
Nothing has been lost.

I don't think your patch adds anything.
Re-writing the code to use list.h lists would probably be useful
But currently (except of the problem Trond found) the code is correct.

NeilBrown

> 
> Yikes :)
