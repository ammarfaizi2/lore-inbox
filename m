Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVLRUkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVLRUkt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 15:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVLRUkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 15:40:49 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:6041 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751046AbVLRUks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 15:40:48 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI core: turn transfers to be linked list
Date: Sun, 18 Dec 2005 12:40:46 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <43A480C0.9080201@ru.mvista.com>
In-Reply-To: <43A480C0.9080201@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512181240.46841.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 17 December 2005 1:18 pm, Vitaly Wool wrote:
> Greetings,
> 
> the patch attached changes the way transfers are chained in the SPI 
> core. Namely, they are turned into linked lists instead of array. The 
> reason behind is that we'd like to be able to use lightweight memory 
> allocation  mechanism to use it in interrupt context. 

Hmm, color me confused.  Is there something preventing a driver from
having its own freelist (or whatever), in cases where kmalloc doesn't
suffice?  If not, why should the core change?  And what sort of driver
measurements are you doing, to conclude that kmalloc doesn't suffice?


> An example of such  
> kind of mechanism can be found in spi-alloc.c file in our core. The 
> lightweightness is achieved by the knowledge that all the blocks to be 
> allocated are of the same size. 

I'd have said that since this increases the per-transfer costs (to set
up and manage the list memberships) you want to increase the weight of
that part of the API, not decrease it.  ;)

Note that your current API maps to mine roughly by equating

	allocate your spi_msg 
	allocate my { spi_message + one spi_transfer }

So if you're doing one allocation anyway, you already have the relevant
linked list (in spi_message) and pre-known size.  So this patch wouldn't
improve any direct translation of your driver stack.


> We'd like to use this allocation  
> technique for both message structure and transfer structure The problem 
> with the current code is that transfers are represnted as an array so it 
> can be of any size effectively.

Could you elaborate on this problem you perceive?  This isn't the only
driver API in Linux to talk in terms of arrays describing transfers,
even potentially large arrays.

Consider how "struct scatterlist" is used, and how USB manages the
descriptors for isochronous transfers.  They don't use linked lists
there, and haven't seemed to suffer from it.

- Dave
