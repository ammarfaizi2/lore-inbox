Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270383AbTHQR1u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 13:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270444AbTHQR1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 13:27:50 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:38918 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S270383AbTHQR1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 13:27:48 -0400
Subject: Re: [BUG] slab debug vs. L1 alignement
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Manfred Spraul <manfred@colorfullife.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 17 Aug 2003 12:27:41 -0500
Message-Id: <1061141263.2139.33.camel@fuzzy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps we should remind ourselves what the alignment rules actually are
for kmalloc:

1) No two kmalloc allocations may share cache lines (otherwise data
corruption will result).
2) kmalloc should be on a power of two alignment consistent with the
widest processor data access requirements.

Now note that 1) is optional (but an efficiency speed up) for a coherent
architecture.  It is an *absolute requirement* for a non-coherent
architecture.

2) is essentially what's causing Ben the problems.  His driver appears
to be insisting that DMA be a full PCI cache line width.  I can see
arguments for making this a driver problem.

However, as far as the redzoning issue goes, I think in order to avoid
cache line interference, the redzone should be sized to be a cache line
width, at least on non-coherent architectures.

In theory, the above should solve everyone's problems.

As far as I/O from user land goes (especially to tape), the users
usually can work out the alignment constraints and act accordingly.  I'm
agnostic as to whether we should fail (with an error indicating
alignment problems) or rebuffer causing inefficiency in throughput in
the misaligned case.

James



