Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUEGUCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUEGUCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUEGUCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:02:19 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43918
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263167AbUEGT7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 15:59:05 -0400
Date: Fri, 7 May 2004 21:59:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Jack Steiner <steiner@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RCU scaling on large systems
Message-ID: <20040507195906.GI3829@dualathlon.random>
References: <20040501120805.GA7767@sgi.com> <20040501211704.GY1445@holomorphy.com> <20040507175358.GD3829@dualathlon.random> <20040507181706.GR1397@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040507181706.GR1397@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 11:17:06AM -0700, William Lee Irwin III wrote:
> On Sat, May 01, 2004 at 02:17:04PM -0700, William Lee Irwin III wrote:
> >> Would something like this help cacheline contention? This uses the
> >> per_cpu data areas to hold per-cpu booleans for needing switches.
> >> Untested/uncompiled.
> >> The global lock is unfortunately still there.
> 
> On Fri, May 07, 2004 at 07:53:58PM +0200, Andrea Arcangeli wrote:
> > I'm afraid this cannot help, the rcu_cpu_mask and the mutex are in the same
> > cacheline, so it's not just about the global lock being still there,
> > it's about the cpumask being in the same cacheline with the global lock.
> 
> Hmm. I can't quite make out what you're trying to say. If it were about
> the cpumask sharing the cacheline with the global lock, then the patch
> would help, but you say it should not. I don't care much about the

Since cpumask and global lock are on the same cacheline, and the global
lock still force that cacheline to bounce, it shouldn't make any
difference to remove the cpumask from that global cacheline, by the time
you take the lock you have the cacheline local and in the next
nanosecond you can use the cpumask zerocost. I understood the real cost
is the bouncing of _such_ cacheline across all 512 cpus and the global
lock will still generates it as far as I can tell. Though I'm mostly
guessing, I certainly wouldn't be against trying your patch, I was just
afraid it cannot help.
