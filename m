Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVA3NYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVA3NYO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 08:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVA3NYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 08:24:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53009 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261700AbVA3NYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 08:24:02 -0500
Date: Sun, 30 Jan 2005 13:23:43 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "David S. Miller" <davem@davemloft.net>, Robert.Olsson@data.slu.se,
       akpm@osdl.org, torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050130132343.A25000@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	Robert.Olsson@data.slu.se, akpm@osdl.org, torvalds@osdl.org,
	alexn@dsv.su.se, kas@fi.muni.cz, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
References: <20050124114853.A16971@flint.arm.linux.org.uk> <20050125193207.B30094@flint.arm.linux.org.uk> <20050127082809.A20510@flint.arm.linux.org.uk> <20050127004732.5d8e3f62.akpm@osdl.org> <16888.58622.376497.380197@robur.slu.se> <20050127164918.C3036@flint.arm.linux.org.uk> <20050127123326.2eafab35.davem@davemloft.net> <20050128001701.D22695@flint.arm.linux.org.uk> <20050127163444.1bfb673b.davem@davemloft.net> <20050128085858.B9486@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050128085858.B9486@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Fri, Jan 28, 2005 at 08:58:59AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 08:58:59AM +0000, Russell King wrote:
> On Thu, Jan 27, 2005 at 04:34:44PM -0800, David S. Miller wrote:
> > On Fri, 28 Jan 2005 00:17:01 +0000
> > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > Yes.  Someone suggested this evening that there may have been a recent
> > > change to do with some IPv6 refcounting which may have caused this
> > > problem.  Is that something you can confirm?
> > 
> > Yep, it would be this change below.  Try backing it out and see
> > if that makes your leak go away.
> 
> Thanks.  I'll try it, but:
> 
> 1. Looking at the date of the change it seems unlikely.  The recent
>    death occurred with 2.6.10-rc2, booted on 29th November and dying
>    on 19th January, which obviously predates this cset.
> 2. It'll take a couple of days to confirm the behaviour of the dst cache.

I have another question whether ip6_output.c is the problem - the leak
is with ip_dst_cache (== IPv4).  If the problem were ip6_output, wouldn't
we see ip6_dst_cache leaking instead?

Anyway, I've produced some code which keeps a record of the __refcnt
increments and decrements, and I think it's produced some interesting
results.  Essentially, I'm seeing the odd dst entry with a __refcnt of
14000 or so (which is still in active use, so probably ok), and a number
with 4, 7, and 13 which haven't had the refcount touched for at least 14
minutes.

One of these were created via ip_route_input_slow(), the other three via
ip_route_output_slow().  That isn't significant on its own.

However, whenever ip_copy_metadata() appears in the refcount log, I see
half the number of increments due to that still remaining to be
decremented (see the output below).  0 = "mark", positive numbers =
increment refcnt this many times, negative numbers = decrement refcnt
this many times.

I don't know if the code is using fragment lists in ip_fragment(), but
on reading the code a question comes to mind: if we have a list of
fragments, does each fragment skb have a valid (and refcounted) dst
pointer before ip_fragment() does it's job?  If yes, then isn't the
first ip_copy_metadata() in ip_fragment() going to overwrite this
pointer without dropping the refcount?

All that said, it's probably far too early to read much into these
results - once the machine has been running for more than 19 minutes
and has a significant number of "stuck" dst cache entries, I think
it'll be far more conclusive.  Nevertheless, it looks like food for
thought.

dst pointer: creation time (200Hz jiffies) last reference time (200Hz jiffies)
c1c66260: ffff6c79 ffff879d:
	location count	function
        c01054f4 0      dst_alloc
        c0114a80 1      ip_route_input_slow
        c00fa95c -18    __kfree_skb
        c0115104 13     ip_route_input
        c011ae1c 8      ip_copy_metadata
        c01055ac 0      __dst_free
	untracked counts
        : 0
	total
	= 4
  next=c1c66b60 refcnt=00000004 use=0000000d dst=24f45cc3 src=0f00a8c0

c1c66b60: ffff20fe ffff5066:
        c01054f4 0      dst_alloc
        c01156e8 1      ip_route_output_slow
        c011b854 6813   ip_append_data
        c011c7e0 6813   ip_push_pending_frames
        c00fa95c -6826  __kfree_skb
        c011c8fc -6813  ip_push_pending_frames
        c0139dbc -6813  udp_sendmsg
        c0115a0c 6814   __ip_route_output_key
        c013764c -2     ip4_datagram_connect
        c011ae1c 26     ip_copy_metadata
        c01055ac 0      __dst_free
        : 0
	= 13
  next=c1c57680 refcnt=0000000d use=00001a9e dst=bbe812d4 src=bae812d4

c1c66960: ffff89ac ffffa42d:
        c01054f4 0      dst_alloc
        c01156e8 1      ip_route_output_slow
        c011b854 3028   ip_append_data
        c0139dbc -3028  udp_sendmsg
        c011c7e0 3028   ip_push_pending_frames
        c011ae1c 8      ip_copy_metadata
        c00fa95c -3032  __kfree_skb
        c011c8fc -3028  ip_push_pending_frames
        c0115a0c 3027   __ip_route_output_key
        c01055ac 0      __dst_free
        : 0
	= 4
  next=c16d1080 refcnt=00000004 use=00000bd3 dst=bbe812d4 src=bae812d4

c16d1080: ffff879b ffff89af:
        c01054f4 0      dst_alloc
        c01156e8 1      ip_route_output_slow
        c011b854 240    ip_append_data
        c011c7e0 240    ip_push_pending_frames
        c00fa95c -247   __kfree_skb
        c011c8fc -240   ip_push_pending_frames
        c0139dbc -240   udp_sendmsg
        c0115a0c 239    __ip_route_output_key
        c011ae1c 14     ip_copy_metadata
        c01055ac 0      __dst_free
        : 0
	= 7
  next=c1c66260 refcnt=00000007 use=000000ef dst=bbe812d4 src=bae812d4


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
