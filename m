Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbTBUHRP>; Fri, 21 Feb 2003 02:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267208AbTBUHRP>; Fri, 21 Feb 2003 02:17:15 -0500
Received: from ns.suse.de ([213.95.15.193]:16912 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267206AbTBUHRN>;
	Fri, 21 Feb 2003 02:17:13 -0500
Date: Fri, 21 Feb 2003 08:27:19 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, sim@netnation.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Message-ID: <20030221072719.GD25144@wotan.suse.de>
References: <p73r8a3xub5.fsf@amdsimf.suse.de> <20030220092043.GA25527@netnation.com> <20030220093422.GA16369@wotan.suse.de> <20030220.202438.10564686.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220.202438.10564686.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 08:24:38PM -0800, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: Thu, 20 Feb 2003 10:34:22 +0100
> 
>    On Thu, Feb 20, 2003 at 01:20:43AM -0800, Simon Kirby wrote:
>    > Hmm...and this is considered desired behavior?  It seems like an odd way
>    > of handling packets intended to test latency and reliability. :)
>    
>    IP is best-effort. Dropping packets in odd cases to make locking simpler
>    is not unreasonable. Would you prefer an slower kernel?
> 
> True.
> 
> But this is a quality of implementation issue and I doubt the kernel
> would be slower if we fixed this silly behavior.
> 
> Frankly, the locking is due to lazyness, rather than a specific design
> decision.  So let's fix it.

For icmp_xmit_lock it can be only done in a limited fashion - you are
always restricted by the buffer size of the ICMP socket. Also I don't 
know how to lock the socket from BH context nicely - the only simple way
probably is the trick from the retransmit timer to just try again
in a jiffie, but could have nasty queueing up under high load.

Fixing the error drop behaviour of TCP will be somewhat nasty too.

In both cases you'll need a retry timer (unreliable) or an dedicated ICMP 
backlog (complicated)

-Andi
