Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVLNGrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVLNGrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 01:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVLNGrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 01:47:37 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:61802 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1751163AbVLNGrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 01:47:36 -0500
Message-ID: <439FBFFA.2070804@ru.mvista.com>
Date: Wed, 14 Dec 2005 09:47:22 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [patch 2.6.15-rc5-mm2] SPI, priority inversion
 tweak
References: <200512131028.49291.david-b@pacbell.net>
In-Reply-To: <200512131028.49291.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm...

>-	down(&lock);
>+	/* ... unless someone else is using the pre-allocated buffer */
>+	if (down_trylock(&lock)) {
>+		local_buf = kmalloc(SPI_BUFSIZ, GFP_KERNEL);
>+		if (!local_buf)
>+			return -ENOMEM;
>+	} else
>+		local_buf = buf;
>+
>  
>
Okay, so suppose we have two controller drivers working in two threads 
and calling write_then_read in such a way that the one called later has 
to allocate a new buffer. Suppose also that both controller drivers are 
working in PIO mode. In this situation you have one redundant kmalloc 
and two redundant memcpy's, not speaking about overhead brought up by 
mutexes. Bad!
So I still can't say I'm accepting this approach.

Worth mentioning is that the approach I propose is free from this drawback.

Vitaly
