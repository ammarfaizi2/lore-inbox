Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWGIMrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWGIMrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 08:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWGIMrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 08:47:25 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:16911 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030480AbWGIMrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 08:47:24 -0400
Message-ID: <44B0FAD5.7050002@argo.co.il>
Date: Sun, 09 Jul 2006 15:47:17 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Mark Lord <lkml@rtr.ca>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <1152418768.4128.21.camel@localhost.localdomain>
In-Reply-To: <1152418768.4128.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jul 2006 12:47:19.0250 (UTC) FILETIME=[D0840B20:01C6A355]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>
> > I didn't suggest the compiler could or should do it, just that it would
> > be possible (for the _user_) to write portable ISO C code to access PCI
> > mmio registers, if volatile's implementation serialized access.
>
> That isn't possible neither. How to actually serialize access can
> require different set of primitives depending on the storage class of
> the memory you are accessing, which the C compiler has 0 knowledge
> about. (For example, cacheable storage vs. write-through vs.
> non-cacheable guarded vs. non-cacheable non-guarded on powerpc, there
> are different issues on other architectures).
>

Okay.  I guess this limits portable volatile to main memory.  Thanks for 
the clarification.

> > With the current implementation of volatile in gcc, it is impossible -
> > you need to resort to inline assembly for some architectures, which is
> > not an ISO C feature.
>
> ISO C has never been about writing device drivers. There is simply no
> choice here. You need an atchitecture specific set of accessors. If you
> want portable code, then pick a library like libpci and make sure it
> contains all you need on all the architectures you need. Then write
> portable code on top of it.
>

Indeed, I see no other way now.

> > And I'm not suggesting that it would be a good idea to use volatile 
> even
> > if it was corrected - it would have to take a worst-case approach and
> > thus would generate very bad code.
>
> So what is the point ?
>

Volatile is useful for non device driver work, for example VJ-style 
channels.  A portable volatile can help to code such things in a 
compiler-neutral and platform-neutral way.  Linux doesn't care about 
compiler neutrality, being coded in GNU C, and about platform 
neutrality, having a per-arch abstraction layer, but other programs may 
wish to run on multiple compilers and multiple platforms without 
per-platform glue layers.

Adding barriers to volatile can take it from dangerously useless to 
somewhat* useful.  Not for Linux, but other projects do exist.

* possibly barriers are still required, if volatile data points to 
non-volatile data.

-- 
error compiling committee.c: too many arguments to function

