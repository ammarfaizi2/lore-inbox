Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUIOMbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUIOMbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUIOMay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:30:54 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:55469 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S265487AbUIOMao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:30:44 -0400
Date: Wed, 15 Sep 2004 14:29:20 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, an.li.wang@intel.com
Subject: truncate shows non zero data beyond the end of the inode with MAP_SHARED
Message-ID: <20040915122920.GA4454@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been told we're not posix compliant the way we handle MAP_SHARED
on the last page of the inode. Basically after we map the page into
userspace people can make the data beyond the i_size non-zero and we
should clear it in the transition from page_mapcount 1 -> 0.  The bug
is that if you truncate-extend, the new data will not be guaranteed to
be zero.

msync + power outage and writing to the page with sys_write at the same
time it's being mapped (and in turn queueing it for pdflush writeout)
are the two worst offeners. To fix those we'd need to mark the pte
readonly, flush the tlb with a worst-case IPI broadcast, writepage, then
mark the pte read-write and flush the tlb again with another IPI
broadcast.

That is going to have a significant cost methinks. So maybe we shouldn't
fix it after all...
