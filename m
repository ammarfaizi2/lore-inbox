Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVA3PfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVA3PfA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 10:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVA3PfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 10:35:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4878 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261712AbVA3Pe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 10:34:58 -0500
Date: Sun, 30 Jan 2005 15:34:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>, Robert.Olsson@data.slu.se,
       akpm@osdl.org, torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050130153449.B25000@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	Robert.Olsson@data.slu.se, akpm@osdl.org, torvalds@osdl.org,
	alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <20050125193207.B30094@flint.arm.linux.org.uk> <20050127082809.A20510@flint.arm.linux.org.uk> <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127123326.2eafab35.davem@davemloft.net> <20050128001701.D22695@flint.arm.linux.org.uk> <20050127163444.1bfb673b.davem@davemloft.net> <20050128085858.B9486@flint.arm.linux.org.uk> <20050130132343.A25000@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050130132343.A25000@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Jan 30, 2005 at 01:23:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 01:23:43PM +0000, Russell King wrote:
> Anyway, I've produced some code which keeps a record of the __refcnt
> increments and decrements, and I think it's produced some interesting
> results.  Essentially, I'm seeing the odd dst entry with a __refcnt of
> 14000 or so (which is still in active use, so probably ok), and a number
> with 4, 7, and 13 which haven't had the refcount touched for at least 14
> minutes.

An hour or so goes by.  I now have 14 dst cache entries with non-zero
refcounts, and these have the following properties:

* The five from before (with counts 13, 14473, 4, 4, 7 respectively):
  + all remain unfreed.
  + show precisely no change in the refcounts.
  + the refcount has not been touched for more than an hour.
* They have all been touched by ip_copy_metadata.
* Their remaining refcounts are precisely half the number of
  ip_copy_metadata calls in every instance.

No entries with a refcount of zero contain ip_copy_metadata() and do
appear in /proc/net/rt_cache.

The following may also be a pointer - from /proc/net/snmp:

Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails FragOKs FragFails FragCreates
Ip: 1 64 140510 0 0 36861 0 0 93549 131703 485 0 21 46622 15695 21 21950 0 0

Since FragCreates is 0, this means that we are using the frag_lists
rather than creating our own fragments (and indeed the first
ip_copy_metadata() call rather than the second in ip_fragment()).

I think the case against the IPv4 fragmentation code is mounting.
However, without knowing what the expected conditions for this code,
(eg, are skbs on the fraglist supposed to have NULL skb->dst?) I'm
unable to progress this any further.  However, I think it's quite
clear that there is something bad going on here.

Why many more people aren't seeing this I've no idea.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
