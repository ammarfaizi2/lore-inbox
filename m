Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTEZWZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTEZWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:24:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10382 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262336AbTEZWV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:21:59 -0400
Date: Mon, 26 May 2003 15:34:15 -0700 (PDT)
Message-Id: <20030526.153415.41663121.davem@redhat.com>
To: zippel@linux-m68k.org
Cc: mika.penttila@kolumbus.fi, rmk@arm.linux.org.uk, akpm@digeo.com,
       hugh@veritas.com, LW@karo-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0305261414060.12110-100000@serv>
References: <3ED1A7E2.6080607@kolumbus.fi>
	<20030525.223655.123997551.davem@redhat.com>
	<Pine.LNX.4.44.0305261414060.12110-100000@serv>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roman Zippel <zippel@linux-m68k.org>
   Date: Mon, 26 May 2003 15:18:01 +0200 (CEST)
   
   I'd prefer not to do this at driver level at all and rather let the
   user of the data do it.

This is an easy thing to say, but you have to recognize that PIO
based data transfers must retain the EXACT behavior required of
real DMA transfers, which is that a subsequent user mapping of the
data must be able to see the data without an intervening
flush_dcache_page() or similar.

You can STILL optimize this the way you seem to want to.  The
update_mmu_cache() routing exists as a point at which you can
do such deferred situation-based flushing optimizations.

F.e. at ide_insw() time you mark pages as "might_need_flush" with
some bit in page->flags, we even have bits allocated for arch specific
use and we can allocate 1 or 2 more if you need them.  Then at
update_mmu_cache() time you check this bit and act accordingly.

This is exactly the kinds of things I expected platforms to do.
It took a while but even PPC moved all of their flush_icache_page()
stuff into update_mmu_cache() based delayed flush schemes.
