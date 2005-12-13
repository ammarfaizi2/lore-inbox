Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVLMWP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVLMWP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVLMWP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:15:29 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:37224 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1030246AbVLMWP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:15:28 -0500
Message-ID: <439F47F1.1060909@ru.mvista.com>
Date: Wed, 14 Dec 2005 01:15:13 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051213195317.29cfd34a.vwool@ru.mvista.com> <200512131101.02025.david-b@pacbell.net>
In-Reply-To: <200512131101.02025.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>That's not "core" in the normal "everyone must use this" sense.
>Even the folk that do use synchronous transfers aren't always
>going to use that particular codepath.
>  
>
Lemme explain once more why what you have is a lot worse than what I 
suggest.
Take for instance spi_w8r8 function used in lotsa places in the drivers 
you and Stephen have posted.
This function has a) *implicit memcpy* inherited from 
spi_write_then_read b) *implicit priority inversion* inherited from the 
same place.
On the other hand, any smart enough SPI controller driver wouldn't ever 
want to send and receive one byte via DMA, especially chaining messages 
because the overhead will be great; memcpy's also adding overhead. It's 
gonna use PIO instead.
So this is a serious reason to let controller driver decide things 
related to memory allocation. It doesn't concern only static-allocated 
buffers but also, say, stack-allocated (used in your core in many 
places). And controller driver needs something to track whether it has 
allocated a buffer for transfer for DMA safety or not. Don't you want a 
linked list of  allocated buffers in the controller driver?! And the 
flag I'm adding within the patch does that with minimal intrusion to 
your core.

Hope that helps understand my reasons.

Vitaly
