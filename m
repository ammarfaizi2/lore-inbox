Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbSI0Jyu>; Fri, 27 Sep 2002 05:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbSI0Jyu>; Fri, 27 Sep 2002 05:54:50 -0400
Received: from [217.167.51.129] ([217.167.51.129]:16349 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261682AbSI0Jyt>;
	Fri, 27 Sep 2002 05:54:49 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Andre Hedrick" <andre@linux-ide.org>,
       "David S. Miller" <davem@redhat.com>
Cc: <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: [RFC] {read,write}s{b,w,l} or iobarrier_*()
Date: Fri, 27 Sep 2002 11:59:48 +0200
Message-Id: <20020927095948.5033@192.168.4.1>
In-Reply-To: <Pine.LNX.4.10.10209261951560.13669-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10209261951560.13669-100000@master.linux-ide.org>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Now if we expand the issue into Jeff's world of the net-stack drivers, he
>banged me over the head with the issue of "pci-posting delays".  Ben got
>his shots in also about the issue, too.  Thus the resulting io_barrier
>additions by Ben to the original ATA-driver transformation, can be extened
>to the Net-Drivers.  Oh and the slope is increasing fast now.

Actually, the iobarrier is a slightly different issue, it's not
related pci posting delays. (The only sane way to deal with them
is to do a read() from the same bus path).

The iobarrier's are a CPU-specific things that basically tell the
CPU not to re-order accesses around the barrier. This is necessary
for reads & writes to IO locations to be done in the order they
are written and not be speculated on CPUs that can do that sort
of things (PPC is one). By default, IO macros like {in,out}* and
{read,write}* do that implicitely (at least the PPC impl. of them
does the barriers) in addition to byteswap. But the raw_* versions
that we would need to avoid byteswap in implementing MMIO insw/outsw
also don't do the barriers, thus the macro I had to add.

Anyway, looks like we finally agree on getting {read,write}s{b,w,l}
in. I'll post a patch implementing them for PPC by tomorrow. That
will make things easier for IDE and possibly other drivers as well.

BTW. Jeff: the tulip patch don't really need those explicit
barriers from what I understand of it, you can probably merge the
patch without them.

Ben.





