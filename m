Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbULRDqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbULRDqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 22:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbULRDqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 22:46:31 -0500
Received: from out012pub.verizon.net ([206.46.170.137]:9601 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S262831AbULRDq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 22:46:26 -0500
Message-ID: <41C3A827.9090301@verizon.net>
Date: Fri, 17 Dec 2004 22:46:47 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Dittmer <jdittmer@ppp0.net>
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] esp: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
References: <20041217231915.14919.49991.15433@localhost.localdomain> <41C385FC.3010109@ppp0.net>
In-Reply-To: <41C385FC.3010109@ppp0.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.220.243] at Fri, 17 Dec 2004 21:46:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> James Nelson wrote:
> 
>>This is an attempt to make the esp driver SMP-correct.
> 
> 
> You're trying to protect the info data, correct? Could you please
> add a comment to the locks which data structures need to be
> protected by them?!
> Just blindly replacing cli/sti with spin_(un)lock doesn't make it
> SMP save.
> 

*sigh* Thought it wouldn't be that easy.



> 
>>diff -urN --exclude='*~' linux-2.6.10-rc3-mm1-original/drivers/char/esp.c linux-2.6.10-rc3-mm1/drivers/char/esp.c
>>--- linux-2.6.10-rc3-mm1-original/drivers/char/esp.c	2004-12-03 16:52:13.000000000 -0500
>>+++ linux-2.6.10-rc3-mm1/drivers/char/esp.c	2004-12-17 18:11:31.275037730 -0500
>>@@ -212,14 +214,14 @@
>> 	if (serial_paranoia_check(info, tty->name, "rs_stop"))
>> 		return;
>> 	
>>-	save_flags(flags); cli();
>>+	spin_lock_irqsave(&esp_lock, flags);
> 
> 
> info can change between return and lock
> 

Okay.  I see what you are talking about.  I'll dig into it tomorrow (after some 
sleep).

OTOH, this would have been SMP-incorrect even before cli()/sti() was dropped in 2.5 .

> 
>> 	if (info->IER & UART_IER_THRI) {
>> 		info->IER &= ~UART_IER_THRI;
>> 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
>> 		serial_out(info, UART_ESI_CMD2, info->IER);
>> 	}
>> 
>>-	restore_flags(flags);
>>+	spin_unlock_irqrestore(&esp_lock, flags);
>> }
>> 
>> static void rs_start(struct tty_struct *tty)
>>@@ -230,13 +232,13 @@
>> 	if (serial_paranoia_check(info, tty->name, "rs_start"))
>> 		return;
>> 	
>>-	save_flags(flags); cli();
>>+	spin_lock_irqsave(&esp_lock, flags);
> 
> 
> same here.
> 
> 
>> 	if (info->xmit_cnt && info->xmit_buf && !(info->IER & UART_IER_THRI)) {
>> 		info->IER |= UART_IER_THRI;
>> 		serial_out(info, UART_ESI_CMD1, ESI_SET_SRV_MASK);
>> 		serial_out(info, UART_ESI_CMD2, info->IER);
>> 	}
>>-	restore_flags(flags);
>>+	spin_unlock_irqrestore(&esp_lock, flags);
>> }
>> 
>> /*
> 
> 
> Didn't read the rest. Are you sure you didn't introduce a deadlock in
> the interrupt handler? {transmit,receiver}_chars_{pio,dma} also try to take
> the lock.
> 

Hm.  I made the assumption (silly me) that the code was inherently SMP-correct, 
and just needed the function calls replaced.

Live and learn.

Jim

> Jan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

