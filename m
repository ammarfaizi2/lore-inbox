Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbULXALt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbULXALt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 19:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbULXALt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 19:11:49 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:26041 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261237AbULXALp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 19:11:45 -0500
Date: Fri, 24 Dec 2004 01:11:44 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: apic and 8254 wraparound ...
Message-ID: <20041224001144.GA5192@mail.13thfloor.at>
Mail-Followup-To: Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo! Folks!

I was investigating why linux-2.6.10-rc3 wasn't booting
with HZ set to higher values (like 5k,10k or 20k) on
certain machines/configurations and I tracked that down
to the wait_8254_wraparound() which does the following:

/* next tick in 8254 can be caught by catching timer wraparound */
static void __init wait_8254_wraparound(void)
{
        unsigned int curr_count, prev_count=~0;
        int delta;

        curr_count = get_8254_timer_count();

        do {
                prev_count = curr_count;
                curr_count = get_8254_timer_count();
                delta = curr_count-prev_count;

        /*
         * This limit for delta seems arbitrary, but it isn't, it's
         * slightly above the level of error a buggy Mercury/Neptune
         * chipset timer can cause.
         */

        } while (delta < 300);
}

further investigation showed that the inital value for
the timer is lower than 300 for higher HZ values, so
the kernel keeps spinning in this loop (which can be 
easily fixed by 'adjusting' the limit), but I ask myself, 
if this check can be simplified ...

I don't know what kind of errors the buggy Mercury/
Neptune chipset timers can cause, maybe they need some
special handling, but from the available code, what 
about something like this:


@@ -878,22 +878,14 @@ static unsigned int __init get_8254_time
 static void __init wait_8254_wraparound(void)
 {
 	unsigned int curr_count, prev_count=~0;
-	int delta;
 
 	curr_count = get_8254_timer_count();
 
 	do {
 		prev_count = curr_count;
 		curr_count = get_8254_timer_count();
-		delta = curr_count-prev_count;
 
-	/*
-	 * This limit for delta seems arbitrary, but it isn't, it's
-	 * slightly above the level of error a buggy Mercury/Neptune
-	 * chipset timer can cause.
-	 */
-
-	} while (delta < 300);
+	} while (curr_count <= prev_count);
 }
 
 /*


TIA,
Herbert

