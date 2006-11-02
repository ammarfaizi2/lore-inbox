Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752711AbWKBIMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbWKBIMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbWKBIMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:12:42 -0500
Received: from www.osadl.org ([213.239.205.134]:53683 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1752711AbWKBIMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:12:41 -0500
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required)
	[2.6.18-rc4-mm1]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1162452676.15900.287.camel@localhost.localdomain>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de>
	 <1162417916.15900.271.camel@localhost.localdomain>
	 <20061102001838.GA911@rhlx01.hs-esslingen.de>
	 <1162452676.15900.287.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 09:14:23 +0100
Message-Id: <1162455263.15900.320.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 08:31 +0100, Thomas Gleixner wrote:
> Does it resume normal operation after the "ACPI: lapic on CPU 0 stops in
> C2[C2]" message ?
> 
> It is easy to fix by marking all AMDs broken again, but I really want to
> avoid this.

Doo, found a brown paperbag bug.

Index: linux-2.6.19-rc4-mm1/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.19-rc4-mm1.orig/drivers/acpi/processor_idle.c	2006-11-02 08:01:52.000000000 +0100
+++ linux-2.6.19-rc4-mm1/drivers/acpi/processor_idle.c	2006-11-02 09:09:23.000000000 +0100
@@ -575,8 +575,8 @@ static void acpi_processor_idle(void)
 	 */
 	if (pr->power.timer_state_unstable <
 	    pr->power.timer_broadcast_on_state) {
-		pr->power.timer_state_unstable =
-			pr->power.timer_broadcast_on_state;
+		pr->power.timer_broadcast_on_state =
+			pr->power.timer_state_unstable;
 		acpi_propagate_timer_broadcast(pr);
 	}
 


