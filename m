Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVCGXny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVCGXny (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVCGXnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:43:13 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:11483 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261983AbVCGXd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:33:27 -0500
Message-ID: <422CE4BF.5090600@acm.org>
Date: Mon, 07 Mar 2005 17:33:19 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] NMI/CMOS RTC race fix for x86-64
References: <422CA1FA.1010903@acm.org> <m1ll8zmfzc.fsf@muc.de> <422CBE9F.1090906@acm.org> <20050307215300.GA36024@muc.de>
In-Reply-To: <20050307215300.GA36024@muc.de>
Content-Type: multipart/mixed;
 boundary="------------080905070709090703070508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080905070709090703070508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch is attached.  Thanks.

-Corey

Andi Kleen wrote:

>>>But in this case it isnt. Instead of all this complexity 
>>>just remove the NMI reassert code from the NMI handler.
>>>It is oudated and mostly useless on modern systems anyways.
>>>
>>>
>>>      
>>>
>>"mostly useless" and "completely useless" are two different things.
>>    
>>
>
>It's completely useless (double checked the AMD8111 and ICH5 data sheets)
>
>There is nothing that should ever clear the NMI bit in this register.
>In fact the ICH5 datasheet even explicitely says software should
>never touch this bit. 
>
>It may have some meaning in ancient ISA chipsets, but that is 
>of no concern on x86-64.
>
>  
>
>>Do you want me to submit a patch that simply removes this?
>>    
>>
>
>Yes, please.
>
>-Andi
>  
>


--------------080905070709090703070508
Content-Type: text/plain;
 name="nmicmos_x86_64_race.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmicmos_x86_64_race.diff"

This patch fixes a race between the CMOS clock setting and the NMI
code.  The NMI code indiscriminatly sets index registers and values
in the same place the CMOS clock is set.  If you are setting the
CMOS clock and an NMI occurs, Bad values could be written to or
read from the CMOS RAM, or the NMI operation might not occur
correctly.

Resetting the NMI is not required on x86_64 (in fact, it should
not be done according to the ICH5 documentation).  This patch
simply removes the useless code.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.11-mm1/arch/x86_64/kernel/traps.c
===================================================================
--- linux-2.6.11-mm1.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.11-mm1/arch/x86_64/kernel/traps.c
@@ -620,15 +620,6 @@
 		mem_parity_error(reason, regs);
 	if (reason & 0x40)
 		io_check_error(reason, regs);
-
-	/*
-	 * Reassert NMI in case it became active meanwhile
-	 * as it's edge-triggered.
-	 */
-	outb(0x8f, 0x70);
-	inb(0x71);		/* dummy */
-	outb(0x0f, 0x70);
-	inb(0x71);		/* dummy */
 }
 
 asmlinkage void do_int3(struct pt_regs * regs, long error_code)

--------------080905070709090703070508--
