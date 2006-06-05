Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751188AbWFEP0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWFEP0E (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 11:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWFEP0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 11:26:04 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:61859 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751158AbWFEP0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 11:26:02 -0400
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug, take 2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
        james.steward@dynamicratings.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
In-Reply-To: <20060605144456.GA26666@flint.arm.linux.org.uk>
References: <1149392479501-git-send-email-htejun@gmail.com>
	 <20060604204444.GF4484@flint.arm.linux.org.uk>
	 <20060604222347.GG4484@flint.arm.linux.org.uk>
	 <1149517656.3489.15.camel@mulgrave.il.steeleye.com>
	 <20060605144456.GA26666@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 10:24:44 -0500
Message-Id: <1149521085.3489.24.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 15:44 +0100, Russell King wrote:
> Hence I find your comment "There are two cases where devices kmap a
> user page into kernel space and then proceed to read from or write to
> it" to be misleading - at the exact point in time that the device
> driver is manipulating the data in that page, it is not a user page.

zero copy doesn't quite follow that ownership model.  We don't really do
anything to block user access to the page while I/O is underway (the
only time we actually do this is the nopage stuff)  if the user wants do
do something stupid like write to a page they've asked us to read data
into, the resulting coherency cockup is their lookout, and which data
actually ends up in the page undefined.  So, both the user and the
kernel mappings exist on the page while it's undergoing kmap and
modification.

However, regardless of whether it's mapped into user space or not, even
if it were later going to be mapped at a non-congruent user address, the
kernel mappings have to be flushed to make the data written via them
visible to the user (and, for a VIPT cache, they have to be flushed
before the mapping is torn down otherwise we might not have the PTE to
flush them via ...)

James


