Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUAKOfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbUAKOfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:35:16 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:15299 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265887AbUAKOfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 09:35:06 -0500
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
From: James Bottomley <James.Bottomley@steeleye.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Jesse Barnes <jbarnes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, jeremy@sgi.com,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20040108184406.GA29210@colo.lackof.org>
References: <20040107175801.GA4642@sgi.com>
	<20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk>
	<20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com>
	<20040108063829.GC22317@colo.lackof.org> <20040108173655.GA11168@sgi.com> 
	<20040108184406.GA29210@colo.lackof.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Jan 2004 09:34:19 -0500
Message-Id: <1073831663.1983.19.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-08 at 13:44, Grant Grundler wrote:
> I haven't studied "part II" closely enough to figure out if adding
> pci_sync_consistent() would outright replace much of the DMA-API
> interface. The main issue is cacheline ownership.
> 
> pci_sync_consistent() needs to indicate CPU wants ownership of outstanding
> cachelines vs IO device wanting to own them.
> SN2 doesn't care about the latter case since it's "mostly coherent".
> SN2 just needs to flush in-flight DMA and it's coherent again.
> But older non-coherent platforms do care.
> 
> I trust James understands this better than I given the fun
> he's had with old parisc HW (715/50).

Sorry for being a bit late...I was travelling and didn't have the time
to go over the whole thread until now.

Let me clarify what Part II of the DMA-API is about: it's for drivers
who may be required to operate both on hardware that has a coherency
domain and hardware that hasn't.

Its design is primarily to be as efficient as possible on coherency
domain hardware.

I think it can do exactly what you want for the RO case, because it was
tailored for almost precisely this problem (guaranteeing mailbox
reads/writes become coherent).  I think dma_cache_sync() corresponds
almost exactly to the semantics you would require of
pci_sync_coherent().

Of course, it's not the whole solution because even on hardware without
a coherency domain, PIO reads/writes are still coherent.

James


