Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUFRF7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUFRF7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 01:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbUFRF7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 01:59:52 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:30745 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264994AbUFRF7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 01:59:34 -0400
Date: Thu, 17 Jun 2004 22:59:09 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
Message-ID: <20040618055909.GA13007@sgi.com>
References: <1087481331.2210.27.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087481331.2210.27.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 09:08:51AM -0500, James Bottomley wrote:
> Background:
> 
> We have a large number of devices in scsi: aacraid, aic7xxx, qla1280,
> qla2xxx which can all do full 64 bit DMA, but which pay a performance
> penalty for using the larger descriptors (aic7xxx is stranger in that it
> has three modes of operation: 32 bit, 39 bit and 64 bit each with an
> increasing performance penalty).
> 
> What all these devices would like to do is instead of simply trying the
> 64 bit mask first and having the platform accept it, even if it only has
> < 4GB of memory, they'd like to be able to have the platform tell them,
> given my current dma mask setting, what's the actual number of bits you
> need me to DMA to.
> 
> This is precisely what the API would do.  It would return a bit mask
> (never over the current dma_mask) that the platform considers optimal. 
> The platform has complete freedom in this: it may return a mask covering
> the total physical memory, or a mask covering all the bits it needs
> setting for some weird numa scheme.
> 
> If the driver decides to use the mask, it would do another
> dma_set_mask() to confirm it (this gives the platform the opportunity if
> it so chooses to return a mask that doesn't quite cover memory, but
> would be more optimal...say for platforms that have all memory under 4GB
> bar one small chunk at 64GB or something).
> 
> Once the driver has the platform's optimal mask, it can use this to
> decide on the correct descriptor size.
> 
> Comments?
> 
> James


Sounds good.  But I'm curious why you make the driver call dma_set_mask()
twice.

I.e., why not

	mask = dma_get_required_mask(...)
	
	if (mask < (1ull << 32)) {
		dma_set_mask(... 32bit)
		use_dac = 0;
	}
	else {
		dma_set_mask(... 64 bit)
		use_dac = 1;
	}


Are there cases you're thinking of where the platform's required mask
would vary depending on the current mask?

jeremy
