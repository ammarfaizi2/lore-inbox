Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWGLXnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWGLXnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWGLXnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:43:46 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:52205
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S932262AbWGLXnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:43:45 -0400
Date: Thu, 13 Jul 2006 01:44:41 +0200
From: andrea@cpushare.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Message-ID: <20060712234441.GA9102@opteron.random>
References: <20060629192121.GC19712@stusta.de> <200607102159.11994.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060711041600.GC7192@opteron.random> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712210545.GB24367@opteron.random> <1152741776.22943.103.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152741776.22943.103.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 11:02:56PM +0100, Alan Cox wrote:
> Actually measuring time through the network is extremely doable given
> enough samples as is communication through delay perturbation. A good
> viterbi encoder/decoder will fish a signal out of very high noise. Yes
> you pay a lot in data rate at that point but it works.

Currently the bandwidth is free, I'll charge for the transaction
associated bandwidth only if I'm forced to (which would happen quickly
if people starts doing the above ;).

The way the current transactions are running as we speak, is not like
in a full peer to peer system. It's half peer to peer, a trusted node
always sits in between buyer and seller. I need this for a multitude
of reasons (I could offload the middle node in a p3p system that is
reliable as long as only 1 of the 3 is malicious but it's certainly
more secure if the node in the middle is fully trusted so I'll try to
avoid that). So if you are right, my trusted node will simply add
/dev/urandom delay as needed before forwarding any packet, to prevent
any meaningful measurement. Any network side channel can be solved in
a few liner patch and very quickly.

Theoretically speaking everything is possible, but pratically speaking
I will defer any further thought about this 10 years in the future
because I think it's impossible to measure any signal with nanosecond
frequency, over a connection with millisecond resolution passing
through a randomization of tcp/ip kernel code, slowdown of the python
interpreter and kernel pipes until it finally reaches the seccomp
bytecode and then same way backwards. (plus virtualization on vista)

I rate the network side channel even less probable than the TSC one
(which is purely theoretical too like Andi can certainly confirm).

> Anyway at the point you pass the bytecode through a processing filter
> you don't need SECCOMP because your filter can remove any syscall
> attempts. 

Even if I wanted to run the filtered (but originally untrusted)
bytecode out of any jail, I need the NX bit to do that, and I don't
have it in a large part of the (currently tiny) userbase. In the
previous email I wasn't accurate saying self modifying code is only
possible on the stack, obviously it's possibly in the heap too, so not
even the non-executable-stack patches could help. SECCOMP is the only
feasible basic mode to cover all systems >=i686 (I don't support i586
and lower because I think it's not worth the bandwidth they would
generate, and if I'm wrong I can add them later, ia64 is also not
supported and that has higher prio if something).

Security is about having tons of things to break before you gain ring
0 privilege. It'd be totally wrong in security terms to remove
zerocost SECCOMP (or trusted-xen) just because you added a further
security measure on top of seccomp (or xen). It's like leaving the
door of your apartment open just because you enabled the security
alarm (you want to do both don't you?).

The more security you have the better, especially when it's zero cost
like seccomp.

Furthermore the filter would need to know about all archs and
bytecodes in the world, arch details and all possible ways to enter
kernel, it would need to be maintained out of sync with the kernel
development and it would be of an huge complexity compared to the few
liner seccomp patch (all high risk stuff compared to SECCOMP).
