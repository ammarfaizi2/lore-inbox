Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbTDGPRE (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTDGPRE (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:17:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56590 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263027AbTDGPRC (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 11:17:02 -0400
Date: Mon, 7 Apr 2003 08:27:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] avoid scribbling in IDT with high interrupt count.
In-Reply-To: <Pine.LNX.4.50.0304070049400.2268-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0304070818340.26364-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Apr 2003, Zwane Mwaikambo wrote:
>
> On systems with high interrupt counts we end up overshooting the 
> interrupt[] array and dumping garbage entry points into the idt. This 
> patch checks for out of bounds access during ioapic setup as well as 
> returning -ENOSPC when we run out of vectors to assign in 
> assign_irq_vector, thus allowing us to remove the panic and boot a 320 
> interrupt source system with 2.5.66.

Zwane - is there any reason we couldn't just start re-using irq vector
offsets when this happens? We already re-use the vectors themselves, so 
restarting the offset pointer shouldn't really _change_ anything.

In other words, I'm wondering if this simpler patch wouldn't be sufficient 
instead?

Can you please test this, and re-submit (and if you can explain why your 
patch is better, please do so - I have nothing fundamentally against it, I 
just want to understand _why_ the complexity is needed).

Thanks,

		Linus

--- 1.58/arch/i386/kernel/io_apic.c	Thu Mar 20 03:11:41 2003
+++ edited/arch/i386/kernel/io_apic.c	Mon Apr  7 08:25:48 2003
@@ -1110,12 +1110,9 @@
 		goto next;
 
 	if (current_vector > FIRST_SYSTEM_VECTOR) {
-		offset++;
+		offset = (offset+1) & 7;
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
-
-	if (current_vector == FIRST_SYSTEM_VECTOR)
-		panic("ran out of interrupt sources!");
 
 	IO_APIC_VECTOR(irq) = current_vector;
 	return current_vector;

