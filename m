Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbULVDpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbULVDpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 22:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbULVDpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 22:45:24 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:5086 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261950AbULVDpL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 22:45:11 -0500
Message-ID: <41C8EDD9.7070007@verizon.net>
Date: Tue, 21 Dec 2004 22:45:29 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Domen Puncer <domen@coderock.org>
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: lcd: fix memory leak, code cleanup
References: <20041221015120.29110.98832.48706@localhost.localdomain> <20041221120607.GA30293@nd47.coderock.org>
In-Reply-To: <20041221120607.GA30293@nd47.coderock.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Tue, 21 Dec 2004 21:45:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Domen Puncer wrote:
> On 20/12/04 19:50 -0600, James Nelson wrote:
> 
>>This patch addresses the following issues:
>>
>>Fix log-spamming and cryptic error messages, and add KERN_ constants.
>>Convert some ints to unsigned ints.
>>Add checks for CAP_SYS_ADMIN for FLASH_Burn and FLASH_Erase ioctls.
>>Identify use of global variable.
>>Fix memory leak in FLASH_Burn ioctl.
>>Fix error return codes in lcd_ioctl().
>>Move variable "index" in lcd_ioctl() to smaller scope to reduce memory usage.
>>Convert cli()/sti() to spin_lock_irqsave()/spin_unlock_irqrestore().
>>Fix legibility issues in FLASH_Burn ioctl.
>>
> 
> 
> 
>>-				cli();
>>+				spin_lock_irqsave(&lcd_lock, flags);
>> 				for (index = 0; index < (128); index++) {
>> 
>> 					WRITE_FLASH(kFlash_Addr1,
>>@@ -480,32 +485,30 @@
>> 						    kFlash_Data2);
>> 					WRITE_FLASH(kFlash_Addr1,
>> 						    kFlash_Prog);
>>-					*((volatile unsigned char *)
>>-					  burn_addr) =
>>-		 (volatile unsigned char) rom[index];
>>-
>>-					while ((!dqpoll
>>-						(burn_addr,
>>-						 (volatile unsigned char)
>>-						 rom[index]))
>>-					       && (!timeout(burn_addr))) {
>>-					}
>>+					*((volatile unsigned char *)burn_addr) =
>>+					  (volatile unsigned char) rom[index];
>>+
>>+					while ((!dqpoll (burn_addr,
>>+						(volatile unsigned char)
>>+						rom[index])) &&
>>+						(!timeout(burn_addr))) { }
>> 					burn_addr++;
>> 				}
>>-				restore_flags(flags);
>>-				if (*
>>-				    ((volatile unsigned char *) (burn_addr
>>-								 - 1)) ==
>>-				    (volatile unsigned char) rom[index -
>>-								 1]) {
>>+				spin_unlock_irqrestore(&lcd_lock, flags);
> 
> 
> 
> Although this will work, i think local_irq_{disable,enable} is the right
> solution (we don't protect any data, just make sure timings are right).
> 

Since the Cobalt systems are single-processor, there's no functional difference 
between disabling global and local interrupts.

> For making it SMP safe, easiest/sane solution seems semaphore in
> lcd_dev, which is down_interruptible(), at beginning of read, write
> and ioctl.
> 
> Comments?
> 
> 
> 	Domen
>

True, but it would requre making struct lcd_display a global variable, and involve 
reworking just about the whole driver, since it is declared as a local variable in 
individual ioctl case statements, and others use the variable defined at the top 
of the ioctl function.  OTOH, it would reduce stack usage...

I was trying to minimize any mucking about with the functional parts of the 
driver, since I don't have the hardware to test it.

Since ioctls are still protected by the BKL right now (and this thing is pretty 
much nothing but an ioctl interface), I don't see too much of a problem with this 
driver.  More complete drivers, however, would definitely benefit from it, and is 
something I'll keep in mind.

Jim
