Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVL0R2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVL0R2F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbVL0R2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:28:04 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:20309 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751130AbVL0R2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:28:03 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH] SPI: turn transfers from arrays to linked lists
Date: Tue, 27 Dec 2005 09:27:55 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
References: <20051223170619.55ef439d.vwool@ru.mvista.com>
In-Reply-To: <20051223170619.55ef439d.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512270927.55331.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 December 2005 6:06 am, Vitaly Wool wrote:
> Hi,
> 
> the patch inlined is changing the SPI core and its users to have
> transfers in the SPI message structure as linked list not as an array,

It basically looks OK.  I've updated it a bit, and will include an
updated version in any future updates of mine.  (Right now I have
to merge your second version with my updated one ... )

So we'll be well on the way to agreeing on a single SPI framework
to evolve and integrate against.  


> -	req->msg.transfers = req->xfer;
> -	req->msg.n_transfer = 6;
> +	for (i = 0; i < 6; i++)
> +		list_add_tail(&req->xfer[i].link, &req->msg.transfers);

More expensive, but not in a way that will often matter much.  That
one's part of one-time init, for example.  And the attached code
uses the spi_message_add_tail(transfer, message) you had mentioned.


> +	DECLARE_SPI_MESSAGE(m);

The updated code has only an spi_message_init() function.


>  
> -		for (;;t++) {
> +		list_for_each_entry (t, &m->transfers, link) {...}

...

> -		tmp = m->n_transfer - 1;
> -		tmp = m->transfers[tmp].cs_change;
> +		if (t)
> +			tmp = t->cs_change;

Bug:  "t" is non-null but invalid there.  (Fixed.)

