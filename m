Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272002AbTG2SJb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 14:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272010AbTG2SJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 14:09:31 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:30343 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S272002AbTG2SJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 14:09:28 -0400
Message-ID: <3F26B850.10600@colorfullife.com>
Date: Tue, 29 Jul 2003 20:09:20 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] select fix
References: <UTC200307291412.h6TECwA17034.aeb@smtp.cwi.nl>            <20030729103630.7fb415cb.akpm@osdl.org> <200307291748.h6THma3o007162@turing-police.cc.vt.edu>
In-Reply-To: <200307291748.h6THma3o007162@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Tue, 29 Jul 2003 10:36:30 PDT, Andrew Morton said:
>
>  
>
>>>-	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
>>>+	if (!tty->stopped && tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
>>> 		mask |= POLLOUT | POLLWRNORM;
>>>      
>>>
>>Manfred sent a patch through esterday which addresses it this way:
>>
>>-	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
>>+	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS &&
>>+			tty->driver->write_room(tty) > 0)
>>
>>Any preferences?
>>    
>>
>
>Would including all 3 conditions make sense?  Not sure if it should be A&B&C, or
>A&(B|C) though, but it certainly smells like the write_room() and tty->stopped
>checks are covering 2 different corner cases....
>  
>
No. select() and write() must agree when -EAGAIN happens.
write() will fail if write_room() returns 0. Additionally, we want to 
delay wakeups a bit, to reduce context switches.
The problem is that the console driver implements stopping by returning 
0 from ->write_room() - therefore "less than WAKEUP_CHARS in buffer" is 
not equivalent to "write will not return -EAGAIN", and thus user space 
loops. My patch fixes that by checking ->write_room() in normal_poll.

Perhaps the Right Thing (tm) is
 >    if (tty->driver->write_room(tty) > WAKEUP_CHARS)
 >        mask |= POLLOUT | POLLWRNORM;

but I simply to not understand the tty layer at all, thus I proposed the 
minimal patch.

--
    Manfred

