Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVA0QuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVA0QuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVA0QuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:50:15 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:5385 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262660AbVA0Qta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:49:30 -0500
Date: Thu, 27 Jan 2005 16:49:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, alexn@dsv.su.se,
       kas@fi.muni.cz, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050127164918.C3036@flint.arm.linux.org.uk>
Mail-Followup-To: Robert Olsson <Robert.Olsson@data.slu.se>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, alexn@dsv.su.se,
	kas@fi.muni.cz, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <20050123091154.GC16648@suse.de> <20050123011918.295db8e8.akpm@osdl.org> <20050123095608.GD16648@suse.de> <20050123023248.263daca9.akpm@osdl.org> <20050123200315.A25351@flint.arm.linux.org.uk> <20050124114853.A16971@flint.arm.linux.org.uk> <20050125193207.B30094@flint.arm.linux.org.uk> <20050127082809.A20510@flint.arm.linux.org.uk> <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16888.58622.376497.380197@robur.slu.se>; from Robert.Olsson@data.slu.se on Thu, Jan 27, 2005 at 01:56:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 01:56:30PM +0100, Robert Olsson wrote:
> 
> Andrew Morton writes:
>  > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
>  > >  ip_dst_cache        1292   1485    256   15    1
> 
>  > I guess we should find a way to make it happen faster.
>  
> Here is route DoS attack. Pure routing no NAT no filter.
> 
> Start
> =====
> ip_dst_cache           5     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
> 
> After DoS
> =========
> ip_dst_cache       66045  76125    256   15    1 : tunables  120   60    8 : slabdata   5075   5075    480
> 
> After some GC runs.
> ==================
> ip_dst_cache           2     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
> 
> No problems here. I saw Martin talked about NAT...

Yes, I can reproduce that same behaviour, where I can artificially
inflate the DST cache and the GC does run and trims it back down to
something reasonable.

BUT, over time, my DST cache just increases in size and won't trim back
down.  Not even by writing to the /proc/sys/net/ipv4/route/flush sysctl
(which, if I'm reading the code correctly - and would be nice to know
from those who actually know this stuff - should force an immediate
flush of the DST cache.)

For instance, I have (in sequence):

# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
581
ip_dst_cache        1860   1860    256   15    1 : tunables  120   60    0 : slabdata    124    124      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
717
ip_dst_cache        1995   1995    256   15    1 : tunables  120   60    0 : slabdata    133    133      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
690
ip_dst_cache        1995   1995    256   15    1 : tunables  120   60    0 : slabdata    133    133      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
696
ip_dst_cache        1995   1995    256   15    1 : tunables  120   60    0 : slabdata    133    133      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
700
ip_dst_cache        1995   1995    256   15    1 : tunables  120   60    0 : slabdata    133    133      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
718
ip_dst_cache        1993   1995    256   15    1 : tunables  120   60    0 : slabdata    133    133      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
653
ip_dst_cache        1993   1995    256   15    1 : tunables  120   60    0 : slabdata    133    133      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
667
ip_dst_cache        1956   1995    256   15    1 : tunables  120   60    0 : slabdata    133    133      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
620
ip_dst_cache        1944   1995    256   15    1 : tunables  120   60    0 : slabdata    133    133      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
623
ip_dst_cache        1920   1995    256   15    1 : tunables  120   60    0 : slabdata    133    133      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
8
ip_dst_cache        1380   1980    256   15    1 : tunables  120   60    0 : slabdata    132    132      0
# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo
86
ip_dst_cache        1375   1875    256   15    1 : tunables  120   60    0 : slabdata    125    125      0

so obviously the GC does appear to be working - as can be seen from the
number of entries in /proc/net/rt_cache.  However, the number of objects
in the slab cache does grow day on day.  About 4 days ago, it was only
about 600 active objects.  Now it's more than twice that, and it'll
continue increasing until it hits 8192, where upon it's game over.

And, here's the above with /proc/net/stat/rt_cache included:

# cat /proc/net/rt_cache|wc -l;grep ip_dst /proc/slabinfo; cat /proc/net/stat/rt_cache
61
ip_dst_cache        1340   1680    256   15    1 : tunables  120   60    0 : slabdata    112    112      0
entries  in_hit in_slow_tot in_no_route in_brd in_martian_dst in_martian_src  out_hit out_slow_tot out_slow_mc  gc_total gc_ignored gc_goal_miss gc_dst_overflow in_hlist_search out_hlist_search
00000538  005c9f10 0005e163 00000000 00000013 000002e2 00000000 00000005  003102e3 00038f6d 00000000 0007887a 0005286d 00001142 00000000 00138855 0010848d

notice how /proc/net/stat/rt_cache says there's 1336 entries in the
route cache.  _Where_ are they?  They're not there according to
/proc/net/rt_cache.

(PS, the formatting of the headings in /proc/net/stat/rt_cache doesn't
appear to tie up with the formatting of the data which is _really_
confusing.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
