Return-Path: <linux-kernel-owner+w=401wt.eu-S1422828AbWLPXg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422828AbWLPXg7 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 18:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWLPXg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 18:36:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53957 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422828AbWLPXg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 18:36:58 -0500
Date: Sat, 16 Dec 2006 15:36:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work (was: Linux 2.6.20-rc1)
In-Reply-To: <20061216230605.GA2789@melchior.yamamaya.is-a-geek.org>
Message-ID: <Pine.LNX.4.64.0612161518080.3479@woody.osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <20061216174536.GA2753@melchior.yamamaya.is-a-geek.org>
 <Pine.LNX.4.64.0612160955370.3557@woody.osdl.org>
 <20061216225338.GA2616@melchior.yamamaya.is-a-geek.org>
 <20061216230605.GA2789@melchior.yamamaya.is-a-geek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2006, Tobias Diedrich wrote:
>
> With commit b0268726 backed out, 2.6.20-rc1 boots fine.

Ok. It's sad, because that thing really did clean stuff up, and seemed 
like a nice and robust approach.

Your dmesg is kind of interesting:

..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 enabled(7)APIC error on CPU0: 04(40)
 .. failed

where that APIC error on CPU0 seems to be a "Send accept error" and "Send 
illegal vector" thing. I think we actually got the interrupt there, but 
because we had some APIC setup bug, we didn't accept it properly, and it 
resulted in that "APIC error" thing. Maybe. 

This is a long shot, but I wonder if we should _wait_ for the APIC to 
stabilize after we've unmasked the IRQ. Ie, if you could undo the back-out 
(going back to the broken situation), and try the patch below, and see if 
it makes a difference.

Unlikely, I know. I don't see anything wrong with the code, though, but 
maybe I'm just blind.

Eric, Andi, Yinghai, do you see anything here to explain why that commit 
breaks?

		Linus

---
diff --git a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
index 2a1dcd5..a8a09e0 100644
--- a/arch/x86_64/kernel/io_apic.c
+++ b/arch/x86_64/kernel/io_apic.c
@@ -294,7 +294,7 @@ static void add_pin_to_irq(unsigned int irq, int apic, int pin)
 
 DO_ACTION( __mask,             0, |= 0x00010000, io_apic_sync(entry->apic) )
 						/* mask = 1 */
-DO_ACTION( __unmask,           0, &= 0xfffeffff, )
+DO_ACTION( __unmask,           0, &= 0xfffeffff, io_apic_sync(entry->apic) )
 						/* mask = 0 */
 
 static void mask_IO_APIC_irq (unsigned int irq)
