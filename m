Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTIOO6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbTIOO6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:58:40 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:50316 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S261440AbTIOO6h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:58:37 -0400
Message-ID: <3F65D41F.4020606@terra.com.br>
Date: Mon, 15 Sep 2003 12:00:47 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: rmk@arm.linux.org.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial/core.c: Unneeded memory barriers and cleanup
Content-Type: multipart/mixed;
 boundary="------------090004000702080404060305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090004000702080404060305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

	Hi Russell,

	Patch against 2.6-test5.

	Kills a unneeded set_current_state (TASK_RUNNING) after 
schedule_timeout and replaces a TASK_RUNNING settings with 
non-memory-barrier versions.

	On uart_suspend_port, that set state thing isn't needed if 
schedule_timeout was executed..but I couldn't come up with a (clean) 
fix for that, since we need to execute ops->shutdown. So I just 
replace it with __set_current_state so It's just an attribution and 
it's not that expensive.

	Feel free to tell me I screwed up :)

	Thanks,

Felipe

--------------090004000702080404060305
Content-Type: text/plain;
 name="core-state.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="core-state.patch"

--- drivers/serial/core.c.orig	2003-09-15 11:49:50.000000000 -0300
+++ drivers/serial/core.c	2003-09-15 11:53:13.000000000 -0300
@@ -1022,7 +1022,7 @@
 		cprev = cnow;
 	}
 
-	current->state = TASK_RUNNING;
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&state->info->delta_msr_wait, &wait);
 
 	return ret;
@@ -1277,7 +1277,6 @@
 		if (state->close_delay) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(state->close_delay);
-			set_current_state(TASK_RUNNING);
 		}
 	} else if (!uart_console(port)) {
 		uart_change_pm(state, 3);
@@ -1345,11 +1344,11 @@
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(char_time);
 		if (signal_pending(current))
-			break;
+			return;
 		if (time_after(jiffies, expire))
-			break;
+			return;
 	}
-	set_current_state(TASK_RUNNING); /* might not be needed */
+	__set_current_state(TASK_RUNNING); /* might not be needed */
 }
 
 /*
@@ -1480,7 +1479,7 @@
 		if (signal_pending(current))
 			break;
 	}
-	set_current_state(TASK_RUNNING);
+	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&info->open_wait, &wait);
 
 	state->count++;
@@ -1899,7 +1898,7 @@
 				set_current_state(TASK_UNINTERRUPTIBLE);
 				schedule_timeout(10*HZ/1000);
 			}
-			set_current_state(TASK_RUNNING);
+			__set_current_state(TASK_RUNNING);
 
 			ops->shutdown(port);
 		}

--------------090004000702080404060305--

