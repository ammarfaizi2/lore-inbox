Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267730AbUH2LYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267730AbUH2LYo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 07:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267732AbUH2LYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 07:24:44 -0400
Received: from clusterfw.beeline3G.net ([217.118.66.232]:6597 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S267730AbUH2LX5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 07:23:57 -0400
Date: Sun, 29 Aug 2004 15:17:12 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@lst.de>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
Message-ID: <20040829111711.GI5108@backtop.namesys.com>
References: <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <1093527307.11694.23.camel@leto.cs.pocnet.net> <20040826134034.GA1470@lst.de> <1093528683.11694.36.camel@leto.cs.pocnet.net> <412E786E.5080608@namesys.com> <16687.9051.311225.697109@thebsh.namesys.com> <412F7A59.8060508@namesys.com> <16687.33718.571411.76990@thebsh.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16687.33718.571411.76990@thebsh.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 10:55:50PM +0400, Nikita Danilov wrote:
> Hans Reiser writes:
>  > Nikita Danilov wrote:
>  > 
>  > >Hans Reiser writes:
>  > > > Christophe Saout wrote:
>  > > > 
>  > > > >
>  > > > >
>  > > > >I don't know, ask Hans. How could the VFS know it a filesystem wants to
>  > > > >do something specific with a file that is completely transparent to the
>  > > > >VFS?
>  > > > >
>  > > > >  
>  > > > >
>  > > > To know what method to use, you must determine the pluginid, and then 
>  > > > find the method within that plugin for that vfs operation.
>  > > > 
>  > > > As for overhead, well, who eats whose dust in the benchmarks....?
>  > >
>  > >Whoever sponsors the benchmark usually wins. Had you forgotten that
>  > >mongo setup used by http://www.namesys.com/benchmarks.html was specially
>  > >`tuned' to reach peak reiser4 performance? Remember why you decided to
>  > >turn OVERWRITE and MODIFY phases off? People on #reiser4 report 90
>  > >_second_ stalls with reiser4 under high io loads (large atom is
>  > >obviously being flushed and everyone waits on it...). In my opinion, it
>  > >is such things that are of utmost importance for real reiser4
>  > >acceptance, not how to name `metas' sub-directory.
>  > >
>  > >Nikita.
>  > >
>  > >
>  > >  
>  > >
>  > If you ask real users, they say that reiser4 is fast, and their 
>  > experience matches our benchmark.  You can criticize the benchmark if 
> 
> They experience 90 second stalls. And please, do not tell me how fast
> reiser4 is, I spent a lot of time working with it, and I know very well
> when it's fast, and when it's deadly slow.
> 
>  > you want, but then you should run your own and publish it.
> 
> I did, after which you told me to turn OVERWRITE and MODIFY phases off,
> beause performance was horrible.

Hmm, I think not the modify/overwrite phases performance were the problem.  The
modify and overwrite mongo phases fragment the filesystem too much, it had a
bad effect visible in the read phase and even in delete phase.  

We measured/optimized read performance  in assumption that fs is not
fragmented, why we should measure bad effect of overwrite instead?  

other fs do not relocate already allocated blocks, negative effect of 
file set overwrite is zero for them.  We could do the same for reiser4
by tuning flush algorithm and journal blocks allocation.

If users want to see read and delete performance as they are, overwrite phase
should be excluded, at least until we teach flush algorithm to not break good
block allocation.

If one wants to measure overwite performance, it is easy to enable overwrite
phase in mongo, but read and delete speed will be affected (it was so when I
tried to optimize delete).

> I not criticizing mongo benchmark per se. I think that it is
> fundamentally wrong to use results that were deliberatly manipulated to
> get best appearance to reiser4 (by omitting work-loads where it performs
> poorly) as an argument. It's not clear who will, according to your
> colorful expression, `eat dust' as a result of this. 
> Or do you think
> that users never overwrite of modify files in real life?

not whole file set.  I mean it is unusual to overwrite all files in the fs.

>  > The 90 second stalls, those should be fixed by debugging copy on capture 
>  > and turning it on, yes?  You can hardly claim I failed to push for the 
> 
> No. I described so many times to you, why COC is ineffectual here.

There are other ideas :) but, it seems to me, if we will focus on benchmarks,
we never complete plugins, metafiles and other useful things.  What I want
from reiser4 is a possiblity to encrypt and compress ~/Mail/ :).

> 
>  > Hans
> 
> Nikita.

-- 
Alex.
