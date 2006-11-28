Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757386AbWK1Wwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757386AbWK1Wwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757377AbWK1WwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:52:25 -0500
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:22144 "EHLO
	lucian.tromer.org") by vger.kernel.org with ESMTP id S1757349AbWK1WwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:52:22 -0500
Message-ID: <456CBD50.70200@tromer.org>
Date: Wed, 29 Nov 2006 00:50:56 +0200
From: Eran Tromer <eran@tromer.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061107 Fedora/1.5.0.8-1.fc5 Thunderbird/1.5.0.8 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: linux-kernel@vger.kernel.org, David Wagner <daw@cs.berkeley.edu>
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu> <456C74F7.3060902@cfl.rr.com>
In-Reply-To: <456C74F7.3060902@cfl.rr.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-28 19:42, Phillip Susi wrote:

> what good does a non root user do by writing to random?  If it
> does not increase the entropy estimate, and it may not actually increase
> the entropy, why bother allowing it?

It is not guaranteed to actually increase the entropy, but it might. And
in case the entropy was previously overestimated, you will have gained
security.

Think of it this way: you can have several users feeding the entropy
pool, and it suffices that *any* of them is feeding strings with nonzero
entropy (with respect to the adversary) in order to get that gain.


That said, I don't feel comfortable about allowing untrusted users to
directly feed the entropy pool, as it can aggravate some failure modes.
To take an extreme example, suppose the adversary has somehow learned
the full state of the pool, i.e., the real entropy is 0, contrary to the
kernel's estimate.

Can things get any worse? Sure they can:

Thus far the adversary can mount attacks that require *known*
randomness. However, if he can now feed his own strings into the pool
mixer as an untrusted user, then he can achieve a *chosen* randomness,
and this undoubtedly enables a wider class of attacks (e.g., covert
channels).

Fully chosen randomness is unlikely here due to the SHA-1
postprocessing, but numerous bits in the next /dev/random read can be
fixed simply by exhaustive search. Worse yet, if the injected string is
mixed directly into the pool without cryptographic preprocessing, then
the exhaustive search can be done via off-line preprocessing: once the
primary pool is estimated to have full entropy, the /dev/random
algorithm lets you linearly manipulate the /dev/random pool into any
state. That's a nasty design flaw, BTW (see Gutterman et al., section 3).

Of course, in principle the same is possible by manipulating the
existing /dev/random event sources. But it's much harder to produce
bit-exact inputs through such indirect means.

  Eran
