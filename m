Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVCDB0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVCDB0G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVCDBWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 20:22:34 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:20621 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262840AbVCDBTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:19:15 -0500
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20050303164520.0c0900df.akpm@osdl.org>
References: <1109869828.2908.18.camel@mindpipe>
	 <20050303164520.0c0900df.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 20:19:08 -0500
Message-Id: <1109899148.3630.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 16:45 -0800, Andrew Morton wrote:
> If efi_enabled is true and efi_set_rtc_mmss(xtime.tv_sec) returns zero, the
> new code will run set_rtc_mmss(xtime.tv_sec) whereas the old code won't.

Argh, I should know better then to send patches before having coffee.

Here's a new patch.  Still ugly, but might be a worthwhile cleanup.

Lee

--- linux-2.6.11-rc4-V0.7.39-02/arch/i386/kernel/time.c	2005-02-14 18:10:49.000000000 -0500
+++ linux-2.6.11-rc4/arch/i386/kernel/time.c	2005-03-03 20:15:39.000000000 -0500
@@ -254,16 +254,12 @@
 			>= USEC_AFTER - ((unsigned) TICK_SIZE) / 2 &&
 	    (xtime.tv_nsec / 1000)
 			<= USEC_BEFORE + ((unsigned) TICK_SIZE) / 2) {
-		/* horrible...FIXME */
+	        last_rtc_update = xtime.tv_sec;
 		if (efi_enabled) {
-	 		if (efi_set_rtc_mmss(xtime.tv_sec) == 0)
-				last_rtc_update = xtime.tv_sec;
-			else
-				last_rtc_update = xtime.tv_sec - 600;
-		} else if (set_rtc_mmss(xtime.tv_sec) == 0)
-			last_rtc_update = xtime.tv_sec;
-		else
-			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
+		    if (efi_set_rtc_mmss(xtime.tv_sec))
+			last_rtc_update -= 600;
+		} else if (set_rtc_mmss(xtime.tv_sec))
+			last_rtc_update -= 600;
 	}
 
 	if (MCA_bus) {


