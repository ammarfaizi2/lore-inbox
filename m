Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUDAODX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 09:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbUDAODX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 09:03:23 -0500
Received: from mail1.slu.se ([130.238.96.11]:40886 "EHLO mail1.slu.se")
	by vger.kernel.org with ESMTP id S262915AbUDAODU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 09:03:20 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16492.7385.765579.771428@robur.slu.se>
Date: Thu, 1 Apr 2004 15:44:57 +0200
To: Andrea Arcangeli <andrea@suse.de>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
In-Reply-To: <20040331225259.GT2143@dualathlon.random>
References: <20040329222926.GF3808@dualathlon.random>
	<200403302005.AAA00466@yakov.inr.ac.ru>
	<20040330211450.GI3808@dualathlon.random>
	<20040330133000.098761e2.davem@redhat.com>
	<20040330213742.GL3808@dualathlon.random>
	<20040331171023.GA4543@in.ibm.com>
	<16491.4593.718724.277551@robur.slu.se>
	<20040331203750.GB4543@in.ibm.com>
	<20040331212817.GQ2143@dualathlon.random>
	<16491.18384.536778.338660@robur.slu.se>
	<20040331225259.GT2143@dualathlon.random>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea Arcangeli writes:

 > But I feel like we should change the softirq code so that the irqexit
 > runs only the softirq setup by the current (or nested) irq handler. This
 > way the timer irq will stop executing the softirqs posted by the network
 > stack and it may very well fix the problem completely. This definitely
 > will help fairness too.

 How would softirq's scheduled be softirq's be run? 

 For a definitive solution a think Alexey analysis make sense:

 "All of them happening outside of ksoftirqd are equally bad, unaccountable,
 uncontrollable and will show up in some situation."

FYI. I did some more experiments:

Simple sycall test: user app = ank-time-loop (does gettimeofday in a loop)
=========================================================================
Before

total    droppped tsquz    throttl  bh_enbl  ksoftird irqexit  other   
00000099 00000000 00000000 00000000 0000005d 00000005 000163a2 00000000
00000008 00000000 00000000 00000000 00000009 00000000 000162f6 00000000

ank-time-loop 

After 10 sec. 
000000c0 00000000 00000000 00000000 0000005d 00000005 0001c3d2 00000000
00000008 00000000 00000000 00000000 00000009 00000000 0001c2f3 00000000

So syscalls "in this context" seems to do_softirq() via irqexit.

Route DoS while BGP tables are loading. ank-time-loop is running.
================================================================
total    droppped tsquz    throttl  bh_enbl  ksoftird irqexit  other   
000000c2 00000000 00000000 00000000 00000042 00000005 0001aef8 00000000
00000008 00000000 00000000 00000000 00000017 00000001 0001adba 00000000

After run:
000b3a10 00000000 00000eda 00000000 000006f6 0000052e 00041c06 00000000
000b0500 00000000 00000ec1 00000000 0000075e 00000197 000419f2 00000000

Most softirq's are run from irqexit but we see local_bh_enable is running
softirq's too. And only a minority of softirq's is running under scheduler 
control. As discussed we before with 100Hz timer we would expect lower 
rates from irqexit.

Cheers.
						--ro

 
