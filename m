Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbWIJBR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbWIJBR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 21:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWIJBR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 21:17:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:3735 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965073AbWIJBR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 21:17:56 -0400
Subject: Re: TG3 data corruption (TSO ?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, mchan@broadcom.com,
       segher@kernel.crashing.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
In-Reply-To: <1157848698.6877.113.camel@localhost.localdomain>
References: <9EAEC3B2-260E-444E-BCA1-3C9806340F65@kernel.crashing.org>
	 <1157745256.5344.8.camel@rh4>
	 <1157751962.31071.102.camel@localhost.localdomain>
	 <20060909.022228.41644790.davem@davemloft.net>
	 <1157841367.31071.182.camel@localhost.localdomain>
	 <1157848698.6877.113.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 11:17:32 +1000
Message-Id: <1157851052.31071.187.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > semantics. At least what is implemented currently on PowerPC is the
> > __raw_* versions which not only have no barriers at all (they don't even
> > order between MMIOs, for example, readl might cross writel), and do no
> > endian swap. Quite a mess of semantics if you ask me... Then there has
> 
> __writel/__readl seems more in keeping for just not locking.

Not locking... you mean not ordering I suppose. Ok, so the question is
no ordering at all (that is even between MMIO read/writes, thus a
__readl can cross a __writel), or just no ordering between MMIO and
cacheable storage ?

It's an important difference and both have their use. For example, on
PowerPC, if I completely remove barriers, I get the first semantic and I
get the ability to write combine on non-cacheable storage as a benefit
(provided we add an ioremap_wc or such, as the Guarded bit we set on
normal non-cacheable space does also prevent write combining on most
implementations). However, if I keep at least ordering between MMIOs,
then I leave an eieio in there, which is not nearly as expensive than a
full sync but will not order cacheable cs. non-cacheable. However, it
will also prevent write combine as far as I remember.

Ben.


