Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbUCaUjz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 15:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUCaUjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 15:39:55 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:8073 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262470AbUCaUjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 15:39:45 -0500
Date: Thu, 1 Apr 2004 02:07:50 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Andrea Arcangeli <andrea@suse.de>, "David S. Miller" <davem@redhat.com>,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       paulmck@us.ibm.com, akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040331203750.GB4543@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040329222926.GF3808@dualathlon.random> <200403302005.AAA00466@yakov.inr.ac.ru> <20040330211450.GI3808@dualathlon.random> <20040330133000.098761e2.davem@redhat.com> <20040330213742.GL3808@dualathlon.random> <20040331171023.GA4543@in.ibm.com> <16491.4593.718724.277551@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16491.4593.718724.277551@robur.slu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 08:46:09PM +0200, Robert Olsson wrote:
Content-Description: message body text
> Before run
> 
> total    droppped tsquz    throttl  bh_enbl  ksoftird irqexit  other   
> 00000000 00000000 00000000 00000000 000000e8 0000017e 00030411 00000000
> 00000000 00000000 00000000 00000000 000000ae 00000277 00030349 00000000
> 
> After DoS (See description from previous mail)
> 
> total    droppped tsquz    throttl  bh_enbl  ksoftird irqexit  other    
> 00164c55 00000000 000021de 00000000 000000fc 0000229f 0003443c 00000000
> 001695e7 00000000 0000224d 00000000 00000162 0000236f 000342f7 00000000
> 
> So the major part of softirq's are run from irqexit and therefor out of 
> scheduler control. This even with RX polling (eth0, eth2) We still have 
> some TX interrupts plus timer interrupts now at 1000Hz. Which probably 
> reduces the number of softirq's that ksoftirqd runs.

So, NAPI or not we get userland stalls due to packetflooding.

Looking at some of the old patches we discussed privately, it seems
this is what was done earlier -

1. Use rcu-softirq.patch which provides call_rcu_bh() for softirqs
   only.

2. Limit non-ksoftirqd softirqs - get a measure of userland stall (using
   an api rcu_grace_period(cpu)) and if it is too long, expire
   the timeslice of the current process  and start sending everything to 
   ksoftirqd.

By reducing the softirq time at the back of a hardirq or local_bh_enable(),
we should be able to bring a bit more fairness. I am working on the
patches, will test and publish later. 

Thanks
Dipankar
