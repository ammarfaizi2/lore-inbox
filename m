Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133107AbRDLO5H>; Thu, 12 Apr 2001 10:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133114AbRDLO46>; Thu, 12 Apr 2001 10:56:58 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:33294 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S133107AbRDLO4w>;
	Thu, 12 Apr 2001 10:56:52 -0400
Date: Thu, 12 Apr 2001 11:56:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: memory usage - dentry_cacheg
In-Reply-To: <20010412114617.051FE723C@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.21.0104121154420.18260-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Ed Tomlinson wrote:

> I have been playing around with patches that fix this problem.  What
> seems to happen is that the VM code is pretty efficent at avoiding the
> calls to shrink the caches.  When they do get called its a case of to
> little to late.  This is espically bad in lightly loaded systems.  
> The following patch helps here.  I also have a more complex version
> that uses autotuning, but would rather push the simple code, _if_ it
> does the job.

I like this patch. The thing I like most is that it tries to free
from this cache if there is little activity, not when we are low
on memory and it is physically impossible to get rid of the cache.

Remember that evicting early from the inode and dentry cache doesn't
matter since we can easily rebuild this data from the buffer and page
cache.

> -------------
>  --- linux.ac3.orig/mm/vmscan.c Sat Apr  7 15:20:49 2001
> +++ linux/mm/vmscan.c   Sat Apr  7 12:37:27 2001
> @@ -997,6 +997,21 @@
>                  */
>                 refill_inactive_scan(DEF_PRIORITY, 0);
> 
> +               /*
> +                * Here we apply pressure to the dcache and icache.
> +                * The nr_inodes and nr_dentry track the used part of
> +                * the slab caches.  When there is more than X% objs free
> +                * in these lists, as reported by the nr_unused fields,
> +                * there is a very good chance that shrinking will free
> +                * pages from the slab caches.  For the dcache 66% works,
> +                * and 80% seems optimal for the icache.
> +                */
> +
> +               if ((dentry_stat.nr_unused+(dentry_stat.nr_unused>>1)) > dentry_stat.nr_dentry)
> +                       shrink_dcache_memory(DEF_PRIORITY, GFP_KSWAPD);
> +               if ((inodes_stat.nr_unused+(inodes_stat.nr_unused>>2)) > inodes_stat.nr_inodes)
> +                       shrink_icache_memory(DEF_PRIORITY, GFP_KSWAPD);
> +
>                 /* Once a second, recalculate some VM stats. */
>                 if (time_after(jiffies, recalc + HZ)) {
>                         recalc = jiffies;
> -------------
> 
> Ed Tomlinson
> 
> Alexander Viro wrote:
> > 
> > On Wed, 11 Apr 2001, Andreas Dilger wrote:
> > 
> >> I just discovered a similar problem when testing Daniel Philip's new ext2
> >> directory indexing code with bonnie++.  I was running bonnie under single
> >> user mode (basically nothing else running) to create 100k files with 1 data
> >> block each (in a single directory).  This would create a directory about
> >> 8MB in size, 32MB of dirty inode tables, and about 400M of dirty buffers.
> >> I have 128MB RAM, no swap for the testing.
> >> 
> >> In short order, my single user shell was OOM killed, and in another test
> >> bonnie was OOM-killed (even though the process itself is only 8MB in size).
> >> There were 80k entries each of icache and dcache (38MB and 10MB respectively)
> >> and only dirty buffers otherwise.  Clearly we need some VM pressure on the
> >> icache and dcache in this case.  Probably also need more agressive flushing
> >> of dirty buffers before invoking OOM.
> > 
> > We _have_ VM pressure there. However, such loads had never been used, so
> > there's no wonder that system gets unbalanced under them.
> > 
> > I suspect that simple replacement of goto next; with continue; in the
> > fs/dcache.c::prune_dcache() may make situation seriously better.
> > 
> > Al
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

