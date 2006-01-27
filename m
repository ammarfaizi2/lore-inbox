Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWA0OFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWA0OFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWA0OFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:05:03 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:43432 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1750987AbWA0OFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:05:01 -0500
Date: Fri, 27 Jan 2006 16:04:57 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, tony@atomide.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] bitmap: multiword allocations and region restructuring.
Message-ID: <20060127140457.GA29632@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
	James Bottomley <James.Bottomley@SteelEye.com>, tony@atomide.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch set implements a number of patches to clean up and
restructure the bitmap region code, in addition to extending the
interface to support multiword spanning allocations.

The current implementation (before this patch set) is limited by only
being able to allocate pages <= BITS_PER_LONG, as noted by the
strategically positioned BUG_ON() at lib/bitmap.c:752:

        /* We don't do regions of pages > BITS_PER_LONG.  The
	 * algorithm would be a simple look for multiple zeros in the
	 * array, but there's no driver today that needs this.  If you
	 * trip this BUG(), you get to code it... */
        BUG_ON(pages > BITS_PER_LONG);

As I seem to have been the first person to trigger this, the result ends
up being the following patch set with the help of Paul Jackson.

The final patch in the series eliminates quite a bit of code duplication,
so the bitmap code size ends up being smaller than the current
implementation as an added bonus.

After these are applied, it should already be possible to do multiword
allocations with dma_alloc_coherent() out of ranges established by
dma_declare_coherent_memory() on x86 without having to change any of the code,
and the SH store queue API will follow up on this as the other user that needs
support for this.

---

 include/linux/bitmap.h |    3 
 lib/bitmap.c           |  371 ++++++++++++++++++++++++++++---------------------
 2 files changed, 218 insertions(+), 156 deletions(-)
