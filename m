Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbVLNNul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVLNNul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbVLNNul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:50:41 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:48237 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S964772AbVLNNuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:50:40 -0500
Message-ID: <43A0230B.1040904@ru.mvista.com>
Date: Wed, 14 Dec 2005 16:50:03 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051213195317.29cfd34a.vwool@ru.mvista.com> <200512131101.02025.david-b@pacbell.net> <20051213191531.GA13751@kroah.com>
In-Reply-To: <20051213191531.GA13751@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Tue, Dec 13, 2005 at 11:01:01AM -0800, David Brownell wrote:
>  
>
>>It's way better to just insist that all I/O buffers (in all
>>generic APIs) be DMA-safe.  AFAICT that's a pretty standard
>>rule everywhere in Linux.
>>    
>>
>
>I agree.
>  
>
Well, why then David doesn't insist on that in his own code?
His synchronous transfer functions are allocating transfer buffers on 
stack which is not DMA-safe.
Then he starts messing with allocate-or-use-preallocated stuff etc. etc.
Why isn't he just kmalloc'ing/kfree'ing buffers each time these 
functions are called (as he proposes for upper layer drivers to do)?
That's a significant inconsistency. Is it also the thing you agree with?

And they way he does it implies redundant memcpy's and kmalloc's: 
suppose we have two controller drivers working in two threads and 
calling write_then_read in such a way that the one called later has to 
allocate a new buffer. Suppose also that both controller drivers are 
working in *PIO* mode. In this situation you have one redundant kmalloc 
and two redundant memcpy's, not speaking about overhead brought up by 
mutexes.

The thing is that only controller driver is aware whether DMA is needed 
or not, so it's controller driver that should work it out.
Requesting all the buffers to be DMA-safe will make a significant 
performance drop on all small transfers!

Vitaly
