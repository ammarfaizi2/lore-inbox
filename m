Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTEZImu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 04:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTEZImu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 04:42:50 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59913 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264328AbTEZImt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 04:42:49 -0400
Date: Mon, 26 May 2003 09:55:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       LW@KARO-electronics.de, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
Message-ID: <20030526095551.C4417@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
	LW@KARO-electronics.de, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@suse.de>
References: <20030523175413.A4584@flint.arm.linux.org.uk> <Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain> <20030523112926.7c864263.akpm@digeo.com> <20030523193458.B4584@flint.arm.linux.org.uk> <1053919171.14018.2.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053919171.14018.2.camel@rth.ninka.net>; from davem@redhat.com on Sun, May 25, 2003 at 08:19:32PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 08:19:32PM -0700, David S. Miller wrote:
> Oh yes, this part is.  If you don't ensure this, everything
> breaks.
> 
> At the end of an I/O operation, say to a page cache page, that
> data ought to be visible equally to a userspace vs. a kernel
> space mapping to that page.
> 
> For example, this is why we use language about "cpu visibility" in the
> DMA api documentation and not "kernel cpu visibility" :-)  And because
> PIO transfers are basically pseudo-DMA they need to make the same exact
> guarentees.
> 
> If you've been living in a world where you didn't think this is
> necessary, I certainly feel bad for you :-)

Ok, so the flush_dcache_page() interface looses this; the original
placement of the flush_page_to_ram() ensured that data written by
device drivers was visible to user space.

Maybe the BIO layer can handle this - the same problem exists when
(and if) BIO uses a bounce buffer, so it would have to be handled
there.  Jens?

Lothar - can you confirm that your problem vanishes when you turn off
write allocation on the caches please?  (cachepolicy=writeback)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

