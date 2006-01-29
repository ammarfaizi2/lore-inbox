Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWA2Fi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWA2Fi2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 00:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWA2Fi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 00:38:28 -0500
Received: from cantor2.suse.de ([195.135.220.15]:202 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750831AbWA2Fi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 00:38:27 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Date: Sun, 29 Jan 2006 06:38:17 +0100
User-Agent: KMail/1.8
Cc: Benjamin LaHaise <bcrl@kvack.org>, dada1@cosmosbay.com, kiran@scalex86.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org, shai@scalex86.org,
       netdev@vger.kernel.org, pravins@calsoftinc.com,
       linux-arch@vger.kernel.org
References: <20060126185649.GB3651@localhost.localdomain> <20060129004459.GA24099@kvack.org> <20060128165549.262f2b90.akpm@osdl.org>
In-Reply-To: <20060128165549.262f2b90.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601290638.18630.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-arch]

On Sunday 29 January 2006 01:55, Andrew Morton wrote:
> Benjamin LaHaise <bcrl@kvack.org> wrote:
> > On Sat, Jan 28, 2006 at 01:28:20AM +0100, Eric Dumazet wrote:
> > > We might use atomic_long_t only (and no spinlocks)
> > > Something like this ?
> >
> > Erk, complex and slow...  Try using local_t instead, which is
> > substantially cheaper on the P4 as it doesn't use the lock prefix and act
> > as a memory barrier.  See asm/local.h.
>
> local_t isn't much use until we get rid of asm-generic/local.h.  Bloaty,
> racy with nested interrupts.

It is just implemented wrong. It should use 
local_irq_save()/local_irq_restore() instead. But my bigger problem
with local_t is these few architectures (IA64, PPC64) who implement it 
with atomic_t. This means we can't replace local statistics counters
with local_t because it would be regression for them. I haven't done the
benchmarks yet, but I suspect both IA64 and PPC64 really should
just turn off interrupts.

-Andi
