Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757402AbWKWQAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757402AbWKWQAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757401AbWKWQAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:00:12 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:33739 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1757400AbWKWQAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:00:10 -0500
Subject: Re: [PATCH] Kill dma_is_consistent()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <20061123150312.GA32406@linux-mips.org>
References: <20061123150312.GA32406@linux-mips.org>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 09:59:33 -0600
Message-Id: <1164297574.2829.9.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 15:03 +0000, Ralf Baechle wrote:
> dma_is_consistent() is ill-designed in that it does not have a struct device
> argument which makes proper support for systems that consist of a mix of
> coherent and non-coherent DMA devices hard.

At the time the interface was designed, the general consensus was that
it was easier to recognise incoherent memory regions by their address
range than by which device they came from.  The main proponent of this
being arm, if I remember rightly.

>   There also is just a single
> user, a BUG_ON() call in the 53c700.c SCSI driver so removing instead of
> fixing it up seems to be the thing to do.

Really, no, this is a bad idea.  However, if you want to make it per
device as well as per dma_addr_t, please feel free ... the patch will be
marginally smaller than the one you just submitted ...

> -	/* all of these offsets are L1_CACHE_BYTES separated.  It is fatal
> -	 * if this isn't sufficient separation to avoid dma flushing issues */
> -	BUG_ON(!dma_is_consistent(pScript) && L1_CACHE_BYTES < dma_get_cache_alignment());

Really, this is a good BUG_ON; it detects a condition that would cause
incredibly subtle and extremely hard to diagnose data corruption
problems in the driver caused by mixed cacheline incoherency.  It's the
price I paid in the driver for having my data separations for the
mailboxes determined at compile time rather than runtime.  If you want
to take this out, we need to use dma_get_cache_alignment() to determine
the mailbox separations and set them up accordingly at runtime.

James


