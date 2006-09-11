Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWIKIfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWIKIfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWIKIfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:35:09 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3296 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751263AbWIKIfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:35:07 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <1157947414.31071.386.camel@localhost.localdomain>
References: <1157947414.31071.386.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 09:57:51 +0100
Message-Id: <1157965071.23085.84.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 14:03 +1000, ysgrifennodd Benjamin Herrenschmidt:
> be interleaved when reaching the host PCI controller (and thus the

"a host PCI controller". The semantics with multiple independant PCI
busses are otherwise evil.

>  1- {read,write}{b,w,l,q} : Those accessors provide all MMIO ordering
> requirements. They are thus called "fully ordered". That is #1, #2 and
> #4 for writes and #1 and #3 for reads. 

#4 may be incredibly expensive on NUMA boxes.

>  3- memcpy_to_io, memcpy_from_io: #1 semantics apply (all MMIO loads or
> stores are performed in order to each other). #2+#4 (stores) or #3

What is "in order" here. "In ascending order of address" would be
tighter.

>  1- __{read,write}{b,w,l,q} : Those accessors provide only ordering rule
> #1. That is, MMIOs are ordered vs. each other as issued by one CPU.
> Barriers are required to ensure ordering vs. memory and vs. locks (see
> "Barriers" section). 

"Except where the underlying device is marked as cachable or
prefetchable"

Q2:
> coherency domain. If we decide not to, then an explicit barrier will
> still be needed in most drivers before spin_unlock(). This is the
> current mmiowb() barrier that I'm proposing to rename (section * III *).

I think we need mmiowb() still anyway (for __writel etc)

> If we decide to not enforce rule #4 for ordered accessors, and thus
> require the barrier before spin_unlock, the above trick, could still be
> implemented as a debug option to "detect" the lack of appropriate
> barriers.

This I think is an excellent idea.

> [* Question 3] If we decide that accessors of Class 1 do not provide rule
> #4, then this barrier is to be used for all classes of accessors, except
> maybe PIO which should always be fully ordered.

On x86 PIO (outb/inb) etc are always ordered and always stall until the
cycle completes on the device.

> [* Question 5] Should we document the rules for memory-memory barriers
> here as well ? (and give examples, like live updating of a network
> driver ring descriptor entry)
> 

Update the existing docs


