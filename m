Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263013AbUKTQRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbUKTQRd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbUKTQRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:17:33 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:23441 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263013AbUKTQQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:16:50 -0500
Message-ID: <419F6DEB.6030606@colorfullife.com>
Date: Sat, 20 Nov 2004 17:16:43 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: wait_event_interruptible() seems non-atomic
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

>I would like to also lock Buffer_lock around BufRP != BufWP, but don't see a
>way on how to accomplish this.
>
>  
>
This is not a problem: You compare BufRP and BufWP twice: once within 
wait_event_interruptible (without locking) and again a second test in 
your uif_read function with locking.
You are right that the test within wait_event_interruptible is 
optimistic: a concurrent uif_read could read the new data before the 
initial uif_read has a chance to acquire the BufferLock. But it doesn't 
matter: AFAICS the test is optimistic, it can't happen that BufRP and WP 
are actually different and wait_event sleeps. And the external loop 
within uif_read() just loops if the race that you describe happened.

Btw, could you post a link to the complete driver when asking questions? 
For example the use of down_interruptible() looks wrong to me, I'd use 
plain down().

--
    Manfred
