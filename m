Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUGAWmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUGAWmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266358AbUGAWmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:42:49 -0400
Received: from mail.shareable.org ([81.29.64.88]:16046 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266353AbUGAWmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:42:47 -0400
Date: Thu, 1 Jul 2004 23:40:16 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
       Matthew Wilcox <matthew@wil.cx>,
       Grant Grundler <grundler@parisc-linux.org>,
       parisc-linux@parisc-linux.org,
       Richard Curnow <Richard.Curnow@superh.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linuxsh-shmedia-dev@lists.sourceforge.net,
       Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Comparing PROT_EXEC-only pages on different CPUs
Message-ID: <20040701224016.GB7928@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha and IA64 are the only Linux architecture where PROT_EXEC by
itself results in exec-only pages.  Interestingly, the hardware of
some other architectures _could_ implement exec-only pages, but they
chose not to:

    The PA-RISC pgtable.h says:

        "We could have an execute only page using "gateway - promote
	to priv level 3", but that is kind of silly. So, the way
	things are defined now, we must always have read permission
	for pages with execute permission. For the fun of it we'll go
	ahead and support write only pages."

    Richard Curnow working on the SH64 port says:

        "Although the hardware is capable of distinguish R and X, the kernel
        always allows R if X is specified to mmap().  This is for 2 reasons :

           1. jump tables for switch() get embedded into the code in
              32-bit (SHmedia) mode
           2. constant pools embedded in the code in 16-bit
              (SHcompact, i.e. SH-4 compatible) mode

        so in practice an exec-only page is pretty useless to a
        typical userland program."

Richard raises an interesting point: exec-only pages are useless if
the code needs to read jump tables and constant pools.  It seems very
likely Alpha and IA64 have these.

The point is: should the automatic addition of read permission be
kernel policy (as on SH64 and PA-RISC), or should it be for userspace
policy to get right as real code probably needs it (as on Alpha and IA64)?

Does anyone think there's a "right" behaviour which current
or future Linux ports should try to conform to?  Should any of the
current ones be changed?

I'm just making sure all 4 know about each others behaviour before I
wash my hands of this observation. :)

Cheers,
-- Jamie
