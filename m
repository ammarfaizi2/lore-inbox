Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUACQak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 11:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUACQak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 11:30:40 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:30925 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S263580AbUACQai
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 11:30:38 -0500
Date: Sat, 3 Jan 2004 10:30:23 -0600
From: John Lash <jlash@speakeasy.net>
To: Alex Buell <alex.buell@munted.org.uk>
Cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively
 enough  on low-memory PCs
Message-Id: <20040103103023.77bf91b5.jlash@speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk>
References: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk>
X-Mailer: Sylpheed version 0.9.6claws71 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jan 2004 11:35:36 +0000 (GMT)
Alex Buell <alex.buell@munted.org.uk> wrote:

> I've just run across a problem with 2.4.x (and probably 2.6.x as well, if
> reports I've see are correct). When updatedb is run overnight, it builds
> up large amounts of inode_cache and dentry_cache. This is a big problem on
> low memory boxes as those caches are not being reclaimed aggressively
> enough, which means the box will be constantly swapping if it runs out of
> free memory. I've looked at archives and I find that there's similar
> reports going back to 2.4.16, and doesn't seem to have been solved as this
> problem is apparently in 2.6.0 as well!
>  
> The only solution I've found so far is to run L*rry McV*y's lmdd to force
> reclaimation of those caches but this isn't ideal. What patches are out
> there that solves this problem?
> 

After taking the 30 minute tour of the 2.6.0 dcache code, one thing that seems
possible is shrink_dcache_memory() is causing you the problem. It is doing some
manipulation of the nr_unused value to prevent all unused dcache entries from
being removed and thereby blowing away all recently used entries as well as the
ones that are really stale.

As it stands, it will maintain as many unused entries as there are used entries.
If this low memory system las a large, stable, number of inuse dentry objects,
the unused entries will match it thereby holding double the memory and possibly
causing the problem you see.

here are the lines I mean:
	nr_unused = dentry_stat.nr_unused;
	nr_used = dentry_stat.nr_dentry - nr_unused;
	if (nr_unused < nr_used * unused_ratio)
		return 0;
	return nr_unused - nr_used * unused_ratio;  /* unused_ratio = 1 at the top of
the fn */

Check on your system, /proc/sys/fs/dentry-state, first two values appear to be
nr_dentry and nr_unused. Plug those values into the above code and if you get
something around zero, that's why the memory is stuck.

A couple of solutions come to mind. The one I like best would be to adjust the
above code to make it conscious of the total memory in the system and keep
nr_unused to a reasonable percentage. Another is to allow unused_ratio to be
less than 1, Possibly some/proc entry to lower it (.5, .25, whatever), or to
avoid the float, provide another  parameter to do an integer divisor for
unused_ratio. Something like:

	nr_unused - nr_used * unused_ratio / ratio_fraction

If that's not why the memory is stuck, then it's something deeper in the reclaim
code. Either way, I'd be curious to know what you find. Depending on what your
system shows, I could provide a patch to try some things out.

--john


> Thanks,
> Alex.
> -- 
> http://www.munted.org.uk
> 
> Your mother cooks socks in hell
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
