Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318472AbSGZUhf>; Fri, 26 Jul 2002 16:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318474AbSGZUhf>; Fri, 26 Jul 2002 16:37:35 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:36497 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318472AbSGZUhe>;
	Fri, 26 Jul 2002 16:37:34 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 26 Jul 2002 14:33:45 -0600
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix APM notify of apmd for on-AC/on-battery transitions
Message-ID: <20020726143345.E13656@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem with Sony Vaio laptops where they don't notify
the kernel of power source change events.  That means apmd is never told
and many of the apmd features can't be used.

The Sony Vaio that I have doesn't send APM events to the kernel telling it
about 'going on battery' or 'going on AC power' events.  It will register
them correctly if they're queried but it won't asynchronously send an event
so the kernel never tells apmd about it.

This patch fixes the situation by checking against the last known power
state (and power source) in the check_status() call.

This was tested on a Sony Vaio z505js, model PCG-5201 and it works
beautifully.  I'm told other Vaio notebooks have this same problem.  Now,
Vaio users can setup apmd to aggressively try to save power when on battery
or perform other crazy tasks.

This patch is against v2.4.16 but applies to newer kernels as well.

diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	Fri Jul 26 14:29:55 2002
+++ b/arch/i386/kernel/apm.c	Fri Jul 26 14:29:55 2002
@@ -1313,6 +1313,34 @@
 			break;
 		}
 	}
+
+	/*
+	 * The Sony Vaio doesn't seem to want to send us a notify
+	 * about AC line power status changes.  So, we have to keep track
+	 * of it by hand and emulate it here.
+	 *   -- Cort <cort@fsmlabs.com>
+	 */
+	if ( is_sony_vaio_laptop ) {
+		static int last_status = 0;
+		u_short status, bat, life;
+
+		/* get the current power state */
+		if ( apm_get_power_status(&status, &bat, &life) !=
+		     APM_SUCCESS ) {
+			printk("%s:%s error checking power status\n",
+			       __FILE__,__FUNCTION__);
+		}
+		
+		/* has the status changed since we were last here? */
+		if (((status >> 8) & 0xff) != last_status) {
+			last_status = (status >> 8) & 0xff;
+			
+			/* fake a APM_POWER_STATUS_CHANGE event */
+			send_event(APM_POWER_STATUS_CHANGE);
+			queue_event(APM_POWER_STATUS_CHANGE, NULL);
+		}
+		
+	}
 }
 
 static void apm_event_handler(void)
