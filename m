Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUCXXdj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUCXXdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:33:39 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:943
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262238AbUCXXdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:33:38 -0500
Date: Thu, 25 Mar 2004 00:34:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, tiwai@suse.de,
       Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040324233430.GJ2065@dualathlon.random>
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com> <20040323123105.GI22639@dualathlon.random> <20040323124002.GH3676@in.ibm.com> <20040323125044.GL22639@dualathlon.random> <20040324172657.GA1303@us.ibm.com> <20040324175142.GW2065@dualathlon.random> <20040324213914.GD4539@in.ibm.com> <20040324225326.GH2065@dualathlon.random> <20040324231145.GB12035@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324231145.GB12035@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 04:41:45AM +0530, Dipankar Sarma wrote:
> That was not 16 callbacks per tick, it was 16 callbacks in one
> batch of a single softirq. And then I reschedule the RCU tasklet

sorry so you're already using tasklets in current code? I misunderstood
the current code then.

> to process the rest. I am planning to vary this and see if we
> should do even less per softirq.

yes, I think 16 is too much, the softirq code should just retry 10
times, summing up to 160 callbacks. After you re-arm the tasklet the
first time, all other rearmed invocations should probably execute less
callbacks than 16.

it greatly depends on the number of times we retry a softirq before
giving up and offloading the work to ksoftirqd, that number is 10
currently (see MAX_SOFTIRQ_RESTART). The bigger that number, the less
callbacks you can execute per tasklet.
