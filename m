Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVAFJTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVAFJTO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbVAFJTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:19:14 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:58603 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262787AbVAFJTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:19:08 -0500
Date: Thu, 6 Jan 2005 10:19:05 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>
Subject: improved wait_8254_wraparound()
Message-ID: <20050106091903.GC728@mail.13thfloor.at>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Pavel Machek <pavel@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hopefully 'better' fix for broken Intel Mercury/Neptune in
wait_8254_wraparound() ...

Rationale:

changing HZ to higher values (like 5k,10k or 20k) will hang
machines using wait_8254_wraparound() indefinitely, because
a suboptimal workaround for buggy Intel Mercury/Neptune 
chipsets is in place.

this was tested on several machines, unfortunately none
with a broken Intel Mercury/Neptune chipset, and it works
fine with various HZ values ...

please consider for inclusion or further testing ...

TIA,
Herbert


Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

diff -NurpP --minimal 
--- linux-2.6.10/arch/i386/kernel/apic.c	2004-12-25 01:54:43.000000000 +0100
+++ linux-2.6.10-fixed/arch/i386/kernel/apic.c	2005-01-02 10:57:33.000000000 +0100
@@ -877,23 +877,18 @@ static unsigned int __init get_8254_time
 /* next tick in 8254 can be caught by catching timer wraparound */
 static void __init wait_8254_wraparound(void)
 {
-	unsigned int curr_count, prev_count=~0;
-	int delta;
+	unsigned int curr_count, prev_count;
 
 	curr_count = get_8254_timer_count();
-
 	do {
 		prev_count = curr_count;
 		curr_count = get_8254_timer_count();
-		delta = curr_count-prev_count;
 
-	/*
-	 * This limit for delta seems arbitrary, but it isn't, it's
-	 * slightly above the level of error a buggy Mercury/Neptune
-	 * chipset timer can cause.
-	 */
+		/* workaround for broken Mercury/Neptune */
+		if (prev_count >= curr_count + 0x100)
+			curr_count = get_8254_timer_count();
 
-	} while (delta < 300);
+	} while (prev_count >= curr_count);
 }
 
 /*

