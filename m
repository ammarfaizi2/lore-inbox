Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVAWUDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVAWUDe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 15:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVAWUDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 15:03:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13839 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261347AbVAWUD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 15:03:26 -0500
Date: Sun, 23 Jan 2005 20:03:15 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050123200315.A25351@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
	alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <20050121161959.GO3922@fi.muni.cz> <1106360639.15804.1.camel@boxen> <20050123091154.GC16648@suse.de> <20050123011918.295db8e8.akpm@osdl.org> <20050123095608.GD16648@suse.de> <20050123023248.263daca9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050123023248.263daca9.akpm@osdl.org>; from akpm@osdl.org on Sun, Jan 23, 2005 at 02:32:48AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2005 at 02:32:48AM -0800, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > But I'm still stuck with all of my ram gone after a
> >  600MB fillmem, half of it is just in swap.
> 
> Well.  Half of it has gone so far ;)
> 
> > 
> >  Attaching meminfo and sysrq-m after fillmem.
> 
> (I meant a really big fillmem: a couple of 2GB ones.  Not to worry.)
> 
> It's not in slab and the pagecache and anonymous memory stuff seems to be
> working OK.  So it has to be something else, which does a bare
> __alloc_pages().  Low-level block stuff, networking, arch code, perhaps.
> 
> I don't think I've ever really seen code to diagnose this.
> 
> A simplistic approach would be to add eight or so ulongs into struct page,
> populate them with builtin_return_address(0...7) at allocation time, then
> modify sysrq-m to walk mem_map[] printing it all out for pages which have
> page_count() > 0.  That'd find the culprit.

I think I may be seeing something odd here, maybe a possible memory leak.
The only problem I have is wondering whether I'm actually comparing like
with like.  Maybe some networking people can provide a hint?

Below is gathered from 2.6.11-rc1.

bash-2.05a# head -n2 /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>
bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
115
ip_dst_cache         759    885    256   15    1
bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
117
ip_dst_cache         770    885    256   15    1
bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
133
ip_dst_cache         775    885    256   15    1
bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
18
ip_dst_cache         664    885    256   15    1
bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
20
ip_dst_cache         664    885    256   15    1
bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
22
ip_dst_cache         673    885    256   15    1
bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
23
ip_dst_cache         670    885    256   15    1
bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
24
ip_dst_cache         675    885    256   15    1
bash-2.05a# cat /proc/net/rt_cache | wc -l; grep ip_dst /proc/slabinfo
24
ip_dst_cache         669    885    256   15    1

I'm fairly positive when I rebooted the machine a couple of days ago,
ip_dst_cache was significantly smaller for the same number of lines in
/proc/net/rt_cache.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
