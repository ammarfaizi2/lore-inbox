Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbSAECU5>; Fri, 4 Jan 2002 21:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287456AbSAECUr>; Fri, 4 Jan 2002 21:20:47 -0500
Received: from mail1.mx.voyager.net ([216.93.66.200]:4625 "EHLO
	mail1.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S287450AbSAECUi>; Fri, 4 Jan 2002 21:20:38 -0500
Message-ID: <3C3662D4.58A347E7@megsinet.net>
Date: Fri, 04 Jan 2002 20:20:04 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Stephan von Krawczynski <skraw@ithnet.com>, andihartmann@freenet.de,
        riel@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com> <3C2F04F6.7030700@athlon.maya.org> <3C309CDC.DEA9960A@megsinet.net> <20011231185350.1ca25281.skraw@ithnet.com> <3C351012.9B4D4D6@megsinet.net> <20020104151438.M1561@athlon.random> <20020104152409.0fd8a101.skraw@ithnet.com> <20020104155122.O1561@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Fri, Jan 04, 2002 at 03:24:09PM +0100, Stephan von Krawczynski wrote:
> > On Fri, 4 Jan 2002 15:14:38 +0100
> > Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > On Fri, Jan 04, 2002 at 01:33:21PM +0100, Stephan von Krawczynski wrote:
> > > > On Thu, 03 Jan 2002 20:14:42 -0600
> > > > "M.H.VanLeeuwen" <vanl@megsinet.net> wrote:
> > > >
> > > > And there is another difference here:
> > > >
> > > > +       if (max_mapped <= 0 && nr_pages > 0)
> > > > +               swap_out(priority, gfp_mask, classzone);
> > > > +
> > > >
> > > > It sounds reasonable _not_ to swap in case of success (nr_pages == 0).
> > > > To me this looks pretty interesting. Is something like this already in -aa?
> > > > This patch may be worth applying in 2.4. It is small and looks like the
> > right> > thing to do.
> > >
> > > -aa swapout as soon as max_mapped hits zero. So it basically does it
> > > internally (i.e. way more times) and so it will most certainly be able
> > > to sustain an higher swap transfer rate. You can check with the mtest01
> > > -w test from ltp.
> >
> > Hm, but do you think this is really good in overall performance, especially the
> > frequent cases where no swap should be needed _at all_ to do a successful
> > shrinking? And - as can be viewed in Martins tests - if you have no swap at
> 
> the common case is that max_mapped doesn't reach zero, so either ways
> (mainline or -aa) it's the same (i.e. no special exit path).
> 
> > all, you seem to trigger OOM earlier through the short path exit in shrink,
> > which is a obvious nono. I would state it wrong to fix the oom-killer for this
> > case, because it should not be reached at all.
> 
> Correct. Incidentally swap or no swap doesn't make any difference on the
> exit-path of shrink_cache in -aa (furthmore if swap is full or if everything is
> unfreeable I stop wasting an huge amount of time on the swap_out path at the
> first failure, this allows graceful oom handling or it would nearly deadlock
> there trying tp swap unfreeable stuff at every max_mapped reached). In -aa
> max_mapped doesn't influcence in any way the exit path of shrink_cache.
> max_mapped only controls the swapout-frequency. See:
> 
>                 if (!page->mapping || page_count(page) > 1) {
>                         spin_unlock(&pagecache_lock);
>                         UnlockPage(page);
>                 page_mapped:
>                         if (--max_mapped < 0) {
>                                 spin_unlock(&pagemap_lru_lock);
> 
>                                 shrink_dcache_memory(vm_scan_ratio, gfp_mask);
>                                 shrink_icache_memory(vm_scan_ratio, gfp_mask);
> #ifdef CONFIG_QUOTA
>                                 shrink_dqcache_memory(vm_scan_ratio, gfp_mask);
> #endif
> 
>                                 if (!*failed_swapout)
>                                         *failed_swapout = !swap_out(classzone);
> 
>                                 max_mapped = orig_max_mapped;
>                                 spin_lock(&pagemap_lru_lock);
>                         }
>                         continue;
> 
>                 }
> 
> So it should work just fine as far I can tell.
> 
> Andrea

OK, here is RMAP 10c and RC2AA2 as well with the same load as previously used.

System: SMP 466 Celeron 192M RAM, ATA-66 40G IDE

Each run after clean & cache builds has 1 more setiathome client running upto a
max if 8 seti clients.  No, this isn't my normal way of running setiathome, but
each instance uses a nice chunk of memory.

Andrea, is there a later version of aa that I could test?

Martin


                STOCK KERNEL    MH KERNEL       STOCK + SWAP    MH + SWAP       RMAP 10c        RC2AA2
                (no swap)       (no swap)                                       (no swap)       (no swap)

CLEAN
BUILD   real    7m19.428s       7m19.546s       7m26.852s       7m26.256s       7m46.760s       7m17.698s
        user    12m53.640s      12m50.550s      12m53.740s      12m47.110s      13m2.420s       12m33.440s
        sys     0m47.890s       0m54.960s       0m58.810s       1m1.090s        1m7.890s        0m53.790s
                                                1.1M swp        0M swp

CACHE
BUILD   real    7m3.823s        7m3.520s        7m4.040s        7m4.266s        7m16.386s       7m3.209s
        user    12m47.710s      12m49.110s      12m47.640s      12m40.120s      12m56.390s      12m46.200s
        sys     0m46.660s       0m46.270s       0m47.480s       0m51.440s       0m55.200s       0m46.450s
                                                1.1M swp        0M swp

SETI 1
        real    9m51.652s       9m50.601s       9m53.153s       9m53.668s       10m8.933s       9m51.954s
        user    13m5.250s       13m4.420s       13m5.040s       13m4.470s       13m16.040s      13m19.310s
        sys     0m49.020s       0m50.460s       0m51.190s       0m50.580s       1m1.080s        0m51.800s
                                                1.1M swp        0M swp

SETI 2
        real    13m9.730s       13m7.719s       13m4.279s       13m4.768s       OOM KILLED      13m13.181s
        user    13m16.810s      13m15.150s      13m15.950s      13m13.400s      kdeinit         13m0.640s
        sys     0m50.880s       0m50.460s       0m50.930s       0m52.520s                       0m48.840s
                                                5.8M swp        1.9M swp

SETI 3
        real    15m49.331s      15m41.264s      15m40.828s      15m45.551s      NA              15m52.202s
        user    13m22.150s      13m21.560s      13m14.390s      13m20.790s                      13m21.650s
        sys     0m49.250s       0m49.910s       0m49.850s       0m50.910s                       0m52.410s
                                                16.2M swp       3.1M swp
SETI 4
        real    OOM KILLED      19m8.435s       19m5.584s       19m3.618        NA              19m24.081s
        user    kdeinit         13m24.570s      13m24.000s      13m22.520s                      13m20.140s
        sys                     0m51.430s       0m50.320s       0m51.390s                       0m52.810s
                                                18.7M swp       8.3M swp

SETI 5
        real    NA              21m35.515s      21m48.543s      22m0.240s       NA              22m10.033s
        user                    13m9.680s       13m22.030s      13m28.820s                      13m12.740s
        sys                     0m49.910s       0m50.850s       0m52.270s                       0m52.180s
                                                31.7M swp       11.3M swp

SETI 6
        real    NA              24m37.167s      25m5.244s       25m13.429s      NA              25m25.686s
        user                    13m7.650s       13m26.590s      13m32.640s                      13m21.610s
        sys                     0m51.390s       0m51.260s       0m52.790s                       0m49.590s
                                                35.3M swp       17.1M swp

SETI 7
        real    NA              28m40.446s      28m3.612s       28m12.981s      NA             VM: killing process cc1
        user                    13m16.460s      13m26.130s      13m31.520s
        sys                     0m57.940s       0m52.510s       0m53.570s
                                                38.8M swp       25.4M swp

SETI 8
        real    NA              29m31.743s      31m16.275s      32m29.534s      NA
        user                    13m37.610s      13m27.740s      13m33.630s
        sys                     1m4.450s        0m52.100s       0m54.140s
                                (NO SWAP ;)     41.5M swp       49.7M swp
