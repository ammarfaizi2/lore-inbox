Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbTKMLQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTKMLQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:16:59 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:54968 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263904AbTKMLQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:16:56 -0500
Message-ID: <3FB36823.7000806@cyberone.com.au>
Date: Thu, 13 Nov 2003 22:16:51 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: AS spin lock bugs
References: <20031113103823.GB4441@suse.de> <20031113105223.GC4441@suse.de> <3FB36419.2040101@cyberone.com.au> <20031113110143.GE4441@suse.de> <20031113111042.GG4441@suse.de>
In-Reply-To: <20031113111042.GG4441@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jens Axboe wrote:

>On Thu, Nov 13 2003, Jens Axboe wrote:
>
>>On Thu, Nov 13 2003, Nick Piggin wrote:
>>
>>>
>>>Jens Axboe wrote:
>>>
>>>
>>>>On Thu, Nov 13 2003, Jens Axboe wrote:
>>>>
>>>>
>>>>>@@ -959,12 +960,12 @@
>>>>>	if (!aic)
>>>>>		return;
>>>>>
>>>>>-	spin_lock(&aic->lock);
>>>>>+	spin_lock_irqsave(&aic->lock, flags);
>>>>>	if (arq->is_sync == REQ_SYNC) {
>>>>>		set_bit(AS_TASK_IORUNNING, &aic->state);
>>>>>		aic->last_end_request = jiffies;
>>>>>	}
>>>>>-	spin_unlock(&aic->lock);
>>>>>+	spin_unlock_irqrestore(&aic->lock, flags);
>>>>>
>>>>>	put_io_context(arq->io_context);
>>>>>}
>>>>>
>>>>>
>>>>BTW, this looks bogus. Why do you need any locking there?
>>>>
>>>>
>>>To prevent a request completion on another queue on another CPU from
>>>racing with request insertion: last_end_request is undefined if the
>>>flag is not set. I guess you could flip the statements and put a
>>>smp_mb between them. Probably not worth the trouble though.
>>>
>>No better to make it explicit, probably doesn't matter much in
>>real-life. Thanks for the clarifications.
>>
>
>Ah, it would be clearer as:
>
>	if (arq->is_sync == REQ_SYNC) {
>		spin_lock(&aic->lock);
>		set_bit(AS_TASK_IORUNNING, &aic->state);
>		aic->last_end_request = jiffies;
>		spin_unlock(&aic->lock);
>	}
>
>Then it doesn't need comments :)
>

Yeah thats was a bit silly of me I see why you got confused. I
have actually fixed this up in mm3. So it should get through to
Linus sometime after 2.6.0.


