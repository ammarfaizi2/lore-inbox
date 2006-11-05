Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965839AbWKEEje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965839AbWKEEje (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 23:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965841AbWKEEje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 23:39:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:37602 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965839AbWKEEjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 23:39:33 -0500
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0611042013400.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain>
	 <20061104140559.GC19760@flint.arm.linux.org.uk>
	 <1162678639.28571.63.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org>
	 <1162689005.28571.118.camel@localhost.localdomain>
	 <1162697533.28571.131.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org>
	 <1162699255.28571.150.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611042013400.25218@g5.osdl.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 15:38:57 +1100
Message-Id: <1162701537.28571.156.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The _only_ reason to use "ioread32be()" would be because the machine is 
> actually natively BE, and you want to avoid swab. That's kind of the point 
> of using "be32_to_cpu(__raw_readl(addr)))" like we do now - it will do the 
> byte swap only if it's necessary.
> 
> In contrast, your "swab(readl())" does _two_ byteswaps - once to turn it 
> into LE, then to turn it back into BE.

I'm not doing a swab(readl()), I'm doing a swab(insl()) and have the
arch provide a native BE accessor for readl_be(). The idea is that I
don't want to add _be accessors for PIO and PIO is slow anyway. But I'm
providing one for MMIO, along with the repeat versions. Have a second
look. 

> So if we can't just rip it out, then we sure as hell shouldn't replace it 
> with something that is obviously worse either.
> 
> In other words - I don't see the reasoning here again. You seem to want to 
> make the code just worse. 

Wait, let's make thing clear, there are 2 things here:

 - MMIO : For that, I'm providing readw_be etc... which my patch defines
based on __raw_* just as your suggest, I'm just adding a way for the
arch to provide its own.

 - PIO : This is broken -now-. The current code doesn't swap at all in
the PIO case, thus you get LE result when using ioread32be() on PIO. I
propose to fix that with swab() because PIO sucks already, there is no
"__raw" for PIO and it doesn't deserve new accessors nor speed.

Cheers,
Ben.


