Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVK1Nqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVK1Nqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 08:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVK1Nqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 08:46:43 -0500
Received: from hera.kernel.org ([140.211.167.34]:2771 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932100AbVK1Nqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 08:46:43 -0500
Date: Mon, 28 Nov 2005 06:04:46 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, bharata@in.ibm.com
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-ID: <20051128080446.GA23516@logos.cnet>
References: <20051123131417.GH24091@fi.muni.cz> <20051123110241.528a0b37.akpm@osdl.org> <20051123202438.GE28142@fi.muni.cz> <20051123123531.470fc804.akpm@osdl.org> <20051124083141.GJ28142@fi.muni.cz> <20051127084231.GC20701@logos.cnet> <20051127203924.GE27805@fi.muni.cz> <20051127160207.GE21383@logos.cnet> <20051127152108.11f58f9c.akpm@osdl.org> <20051128131648.GG19307@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128131648.GG19307@fi.muni.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Nov 28, 2005 at 02:16:48PM +0100, Jan Kasprzak wrote:
> Andrew Morton wrote:
> : Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> : >
> : > It does seem to scan SLABs intensively:
> : >
> : It might be worth trying the below.  Mainly for the debugging check.
> : 
> 	I have compiled a new kernel - 2.6.15-rc2 with the patch you
> recommended and with the slab statistics patch Marcelo mentioned.
> I have add the oprofile support, but apart from that it is the same
> kernel. It seems that the kswapd system time peaks has disappeared,
> or at least they are much lower - kswapd0 has eaten ~3 minutes from
> 11 hours of uptime (in one of my previous mails I found that it used
> to be 117 minutes after ~10 hours of uptime). On my MRTG graphs
> at http://www.linux.cz/stats/mrtg-rrd/cpu.html some _small_ peaks
> can be seen at 15 minutes after every odd-numbered hour. I have booted
> this kernel around 2am local time.
> 
> 	I have no unusual error messages in dmesg output, so this must
> be this part of the patch:
> 
> : +		/*
> : +		 * Avoid risking looping forever due to too large nr value:
> : +		 * never try to free more than twice the estimate number of
> : +		 * freeable entries.
> : +		 */
> : +		if (shrinker->nr > max_pass * 2)
> : +			shrinker->nr = max_pass * 2;

Yep, great.

> 
> 	The shrinker statistics displayed in /proc/slabinfo are
> # egrep '^(inode|dentry)_cache' /proc/slabinfo
> inode_cache         1338   1380    600    6    1 : tunables   54   27    8 : slabdata    230    230      0 : shrinker stat 261765504 16831100
> dentry_cache       40195  49130    224   17    1 : tunables  120   60    8 : slabdata   2890   2890    204 : shrinker stat 57946368 28877600

Interesting, the success/attempt reclaim ratio for the dentry cache is
about 1/2 (pretty good), while the inode cache ratio is 1/15 (not so good).

I wonder why prune_icache() does not move inodes with positive i_count
to inode_inuse list, letting iput() take care of moving to unused
once the count reaches zero.

                inode = list_entry(inode_unused.prev, struct inode, i_list);
                if (inode->i_state || atomic_read(&inode->i_count)) {
                        list_move(&inode->i_list, &inode_unused);
                        continue;
                }

Couldnt it be 
			list_move(&inode->i_list, &inode_inuse);

?





