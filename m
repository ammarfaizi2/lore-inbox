Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUF3NRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUF3NRW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266665AbUF3NRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:17:22 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:44209 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266669AbUF3NRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:17:02 -0400
Subject: Re: [RFC] Buggy e100.c on ARM / DMA sync interfaces
From: James Bottomley <James.Bottomley@steeleye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20040630104900.A11109@flint.arm.linux.org.uk>
References: <20040630104900.A11109@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Jun 2004 08:16:48 -0500
Message-Id: <1088601411.2084.9.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This can't work - and I suspect anyone using the *dma_sync* functions
> will be in for the same problem.  Why?
> 
> Cache lines.  They have a defined size and are not merely a single byte
> or a single word.  If you modify even one single bit, you stand the
> chance of writing back the whole cache line, possibly overwriting data
> which the device has updated since the cache line was read.

Hang on, the PCI (and DMA) API explicitly states that to call sync on a
dma mapped area, you must do it for the *whole* of the area.  The API's
also transfer ownership of the area (i.e. only the device *or* the
driver may touch it depending on who has the ownership). This is
designedly to get us out of cache line interference problems.

So the particular problem here is an incorrect *abuse* of the API. 
There is a section in the black magic part of the DMA API that allows
you partially to sync a mapped area (dma_sync_single_range).  However,
it's in the experts only section and it explains that if you do this,
you're responsible for preventing cache line interference and provides
another API (dma_get_cache_alignment) explicitly so the driver knows
what the cache line boundaries are.

> Therefore, if you're going to use the dma_sync functions to modify data
> owned by the remote device, you _must_ stop the remote device accessing
> the surrounding data _before_ touching it.

Precisely, hence the ownership concept.

> With the above code on ARM, it effectively means that we will read the
> whole struct rfd and some other data into cache, modify the command
> field, and then write _at least_ the whole struct rfd back out, all
> with the chip's DMA still running.
> 
> _That_ can't be good.
> 
> Note - I'm not saying that this is the cause of the above problem, but
> that this is something I have spotted while reading through the driver
> to ascertain why it possibly could not be working.
> 
> Comments?

Clearly the e100 needs fixing.  Either by migrating it to the expert
API. Or, in this case, could we not just pad the structure with
appropriate L1_CACHE_ALIGNMENT tags?

James


