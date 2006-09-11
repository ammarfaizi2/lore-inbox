Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWIKKAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWIKKAv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWIKKAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:00:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:17064 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751323AbWIKKAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 06:00:50 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <1157969261.23085.108.camel@localhost.localdomain>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <1157965071.23085.84.camel@localhost.localdomain>
	 <1157966269.3879.23.camel@localhost.localdomain>
	 <1157969261.23085.108.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 19:59:37 +1000
Message-Id: <1157968778.3879.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd rather memcpy_to/from_io only made guarantees about the start/end of
> the transfer and not order of read/writes or size of read/writes. The
> reason being that a more restrictive sequence can be efficiently
> expressed using read/writefoo but the reverse is not true.

Ok, so we would define ordering on the first and last accesses (being
the first and last in ascending addresses order) and leave it free to
the implementation to do what it wants in between. Is that ok ?

> > > "Except where the underlying device is marked as cachable or
> > > prefetchable"
> > 
> > You aren't supposed to use MMIO accessors on cacheable memory, are you ?
> 
> Why not. Providing it is in MMIO space, consider ROMs for example or
> write path consider frame buffers.

If we consider cacheable accesses, we need to also provide cache
flushing primitives as MMIO devices are generally not coherent. Take for
example the case of the frame buffer: you may want to upload a texture,
and later use it with the engine. You need a way in between to make sure
all the cached dirty lines have been pushed to the device before you
start the engine. Since we provide no generically useable functions for
doing such cache coherency on MMIO space, I'd rather keep usage of MMIO
accessors on cacheable storage non-defined. That is add a simple note at
the top of the file that the rules defined here only apply to
non-cacheable mappings. Is that ok ?

> > with cacheable mappings of anything behind HT... I'd keep use of
> > cacheable mapping as an arch specific special case for now, and that
> > definitely doesn't allow for MMIO accessors ...
> 
> I'm describing existing semantics 8)

Well, there is no clear existing semantics, at least not global to all
archs for cacheable access to MMIO so yeah, let's say that ordering on
cacheable storage is left undefined :)

Ben.


