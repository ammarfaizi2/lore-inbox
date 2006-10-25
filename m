Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWJYPL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWJYPL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 11:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWJYPL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 11:11:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:44257 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932439AbWJYPL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 11:11:27 -0400
Date: Wed, 25 Oct 2006 10:11:24 -0500
To: Ananda Raju <Ananda.Raju@neterion.com>
Cc: Wen Xiong <wenxiong@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] s2io: add PCI error recovery support
Message-ID: <20061025151123.GF6360@austin.ibm.com>
References: <78C9135A3D2ECE4B8162EBDCE82CAD77DC1C9B@nekter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78C9135A3D2ECE4B8162EBDCE82CAD77DC1C9B@nekter>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 02:29:33AM -0400, Ananda Raju wrote:
> Hi, 
> 
> s2io_card_down() will do few BAR0 read/write. As per
> pci-error-recovery.txt Documentation we are not supposed to do any new
> IO in error_detected(). 

Hmm, actually, its harmless to do further i/o. The s2io driver barks
(as it should) because the result of reads is always 0xffffffff.

> Can you try using 
> 
> atomic_set(&sp->card_state, CARD_DOWN); 
> 
> instead of s2io_card_down().

I will try that. I was mostly concerned that s2io_card_down()
also may do some other "important" things with regards to the driver
state, things which might be needed to keep the down-up sequence
symmetrical. I wasn't sure, so I took the conservative route.

> Also we have to add following if statement in beginning of s2io_isr().
> 
> if (atomic_read(&nic->card_state) == CARD_DOWN)
> 	return IRQ_NOTHANDLED.

Right! Will revise this patch shortly.

> If it is ok to do BAR0 read/write in error_detected() then patch is OK. 

Its OK on pSeries, and I beleive it will be OK on PCIE, but I do
not quite know enough about actual PCIE chipsets.

--linas

