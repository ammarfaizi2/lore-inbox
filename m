Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288656AbSADOvg>; Fri, 4 Jan 2002 09:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288659AbSADOv1>; Fri, 4 Jan 2002 09:51:27 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31859 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288656AbSADOvR>; Fri, 4 Jan 2002 09:51:17 -0500
Date: Fri, 4 Jan 2002 15:51:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: vanl@megsinet.net, andihartmann@freenet.de, riel@conectiva.com.br,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020104155122.O1561@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com> <3C2F04F6.7030700@athlon.maya.org> <3C309CDC.DEA9960A@megsinet.net> <20011231185350.1ca25281.skraw@ithnet.com> <3C351012.9B4D4D6@megsinet.net> <20020104151438.M1561@athlon.random> <20020104152409.0fd8a101.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020104152409.0fd8a101.skraw@ithnet.com>; from skraw@ithnet.com on Fri, Jan 04, 2002 at 03:24:09PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 03:24:09PM +0100, Stephan von Krawczynski wrote:
> On Fri, 4 Jan 2002 15:14:38 +0100
> Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > On Fri, Jan 04, 2002 at 01:33:21PM +0100, Stephan von Krawczynski wrote:
> > > On Thu, 03 Jan 2002 20:14:42 -0600
> > > "M.H.VanLeeuwen" <vanl@megsinet.net> wrote:
> > > 
> > > And there is another difference here:
> > > 
> > > +       if (max_mapped <= 0 && nr_pages > 0)
> > > +               swap_out(priority, gfp_mask, classzone);
> > > +
> > > 
> > > It sounds reasonable _not_ to swap in case of success (nr_pages == 0).
> > > To me this looks pretty interesting. Is something like this already in -aa?
> > > This patch may be worth applying in 2.4. It is small and looks like the
> right> > thing to do.
> > 
> > -aa swapout as soon as max_mapped hits zero. So it basically does it
> > internally (i.e. way more times) and so it will most certainly be able
> > to sustain an higher swap transfer rate. You can check with the mtest01
> > -w test from ltp.
> 
> Hm, but do you think this is really good in overall performance, especially the
> frequent cases where no swap should be needed _at all_ to do a successful
> shrinking? And - as can be viewed in Martins tests - if you have no swap at

the common case is that max_mapped doesn't reach zero, so either ways
(mainline or -aa) it's the same (i.e. no special exit path).

> all, you seem to trigger OOM earlier through the short path exit in shrink,
> which is a obvious nono. I would state it wrong to fix the oom-killer for this
> case, because it should not be reached at all.

Correct. Incidentally swap or no swap doesn't make any difference on the
exit-path of shrink_cache in -aa (furthmore if swap is full or if everything is
unfreeable I stop wasting an huge amount of time on the swap_out path at the
first failure, this allows graceful oom handling or it would nearly deadlock
there trying tp swap unfreeable stuff at every max_mapped reached). In -aa
max_mapped doesn't influcence in any way the exit path of shrink_cache.
max_mapped only controls the swapout-frequency. See:

		if (!page->mapping || page_count(page) > 1) {
			spin_unlock(&pagecache_lock);
			UnlockPage(page);
		page_mapped:
			if (--max_mapped < 0) {
				spin_unlock(&pagemap_lru_lock);

				shrink_dcache_memory(vm_scan_ratio, gfp_mask);
				shrink_icache_memory(vm_scan_ratio, gfp_mask);
#ifdef CONFIG_QUOTA
				shrink_dqcache_memory(vm_scan_ratio, gfp_mask);
#endif

				if (!*failed_swapout)
					*failed_swapout = !swap_out(classzone);

				max_mapped = orig_max_mapped;
				spin_lock(&pagemap_lru_lock);
			}
			continue;
			
		}

So it should work just fine as far I can tell.

Andrea
