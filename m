Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbUDANRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUDANRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:17:08 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:61912
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262899AbUDANQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:16:58 -0500
Date: Thu, 1 Apr 2004 15:16:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, paulmck@us.ibm.com, akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040401131657.GB18585@dualathlon.random>
References: <20040331225259.GT2143@dualathlon.random> <200404010643.KAA08190@yakov.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404010643.KAA08190@yakov.inr.ac.ru>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 10:43:45AM +0400, kuznet@ms2.inr.ac.ru wrote:
> What's about some accounting do_softirq() in some way as a starting point?
> F.e. one way is to account all timer ticks happened while do_softirq()
> to ksoftirqd instead of current process (I am not sure that this is even
> possible without race conditions). Or something like that.

This sounds reasonable. However as a start I was thinking at having
hardirq run only the softirq they posted actively, and local_bh_enable
run only the softirq that have been posted by the critical section (not
from hardirqs happening on top of it). And leave everything else for
ksoftirqd. this will complicate the bitmask setting and bitmask
management but it sounds doable.

This will still leave some unfariness under an irq driven flood (partly
a feature to provide as usual the lowest possible latency for stuff like
not busy routers where NAPI isn't needed) but at least it avoids hardirq
to overload excessively the task that happens to run with bh disabled
most of the time, and it will^Wshould allow NAPI to offload the softirq
to ksoftirqd completely.

comments?
