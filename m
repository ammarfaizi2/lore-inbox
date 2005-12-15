Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965156AbVLOGsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965156AbVLOGsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 01:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbVLOGsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 01:48:18 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:1909 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S965156AbVLOGsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 01:48:18 -0500
Message-ID: <43A1118E.9040608@ru.mvista.com>
Date: Thu, 15 Dec 2005 09:47:42 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051214171842.GB30546@kroah.com> <43A05C32.3070501@ru.mvista.com> <200512141102.53599.david-b@pacbell.net>
In-Reply-To: <200512141102.53599.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>No, "stupid drivers will suffer"; nothing new.  Just observe
>how the ads7846 touchscreen driver does small async transfers.
>  
>
One cannot allocate memory in interrupt context, so the way to go is 
allocating it on stack, thus the buffer is not DMA-safe.
Making it DMA-safe in thread that does the very message processing is a 
good way of overcoming this.
Using preallocated buffer is not a good way, since it may well be 
already used by another interrupt or not yet processed by the worker 
thread (or tasklet, or whatever).
The way it's done in this ads7846 driver  is not quite acceptable. 
Losing the transfer if the previous one is still processed is *not* the 
way to go in some cases. One can not predict how many transfers are 
gonna be dropped due to "previous trransfer is being processed" problem, 
it depends on the system load. And though it's not a problem for 
touchscreen, it *will* be a problem if it were MMC, for instance.

Vitaly
