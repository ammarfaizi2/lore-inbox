Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965357AbWJ3RY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbWJ3RY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbWJ3RY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:24:59 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:49846 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S965357AbWJ3RY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:24:58 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Peter Pearse <peter.pearse@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 4/7][PATCH] AMBA DMA: Add a driver module for the DMA controller.
X-Message-Flag: Warning: May contain useful information
References: <CAM-OWA1NTX9gHWdm4j00000005@cam-owa1.Emea.Arm.com>
	<1162210434.2948.13.camel@laptopd505.fenrus.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 30 Oct 2006 09:24:57 -0800
In-Reply-To: <1162210434.2948.13.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Mon, 30 Oct 2006 13:13:54 +0100")
Message-ID: <ada3b95yavq.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 30 Oct 2006 17:24:58.0148 (UTC) FILETIME=[52ABE640:01C6FC48]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > this looks very very wrong to me.

Yes, the module reference counting needs to be completely redone.
This try_find_module() function is only used as:

 > +	pl080_driver.drv.owner = try_find_module(MODULE_NAME);

which as far as I can see should just be

	pl080_driver.drv.owner = THIS_MODULE;

But there's also stuff like

 > +static int pl080_request(dmach_t cnum, dma_t * cdata){
 > +	int retval = -EINVAL;
 > +
 > +	/* Increase the usage */
 > +	if(try_module_get(pl080_driver.drv.owner)){
 > +		retval = 0;
 > +	}

which of course can never work -- this is inside the pl080 module so
it's already too late to take a reference.

The module refcounting just needs to be rethought.

 - R.
