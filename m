Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbTFGGvh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 02:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTFGGvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 02:51:37 -0400
Received: from palrel13.hp.com ([156.153.255.238]:45457 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262578AbTFGGvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 02:51:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16097.36514.763047.738847@napali.hpl.hp.com>
Date: Sat, 7 Jun 2003 00:05:06 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, manfred@colorfullife.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
In-Reply-To: <20030606.234401.104035537.davem@redhat.com>
References: <16096.16492.286361.509747@napali.hpl.hp.com>
	<20030606.003230.15263591.davem@redhat.com>
	<200306062013.h56KDcLe026713@napali.hpl.hp.com>
	<20030606.234401.104035537.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 06 Jun 2003 23:44:01 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  DaveM> But on an IOMMU system, we could end up mapping to the same
  DaveM> bogus DMA address.

Ah, yes, just changing the buffer address doesn't guarantee a
different bus address.  I missed that.

  DaveM> So we have to solve this problem by keeping the existng bad
  DaveM> mapping, doing a new DMA mapping, then trowing away the old
  DaveM> one.

But you're creating a new mapping for the old buffer.  What if you had
a DMA API implementation which consolidates multiple mapping attempts
of the same buffer into a single mapping entry (along with a reference
count)?  That would break the workaround.

Isn't the proper fix to (a) get a new buffer, (b) create a mapping for
the new buffer, (c) destroy the mapping for the old buffer.  That
should guarantee a different bus address, no matter what the
DMA-mapping implementation.

Plus then you don't have to rely on PCI_DMA_BUS_IS_PHYS.

	--david
