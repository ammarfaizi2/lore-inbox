Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319066AbSH1WXC>; Wed, 28 Aug 2002 18:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319067AbSH1WXC>; Wed, 28 Aug 2002 18:23:02 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:26895 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319066AbSH1WXB>; Wed, 28 Aug 2002 18:23:01 -0400
Message-ID: <3D6D4DD0.1900B894@zip.com.au>
Date: Wed, 28 Aug 2002 15:25:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] mysterious tty deadlock
References: <20020828220114.GA878@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> One such stuck process had the following backtrace:
> 
> #0  schedule_timeout (timeout=-150765944) at timer.c:864

schedule_timeout is FASTCALL, which confuses gdb's stack crawler
somewhat.

> #1  0xc01a28a3 in uart_wait_until_sent (tty=0xf7669000, timeout=2147483647)
>     at core.c:1320

Might be a bit racy?

--- 2.5.32/drivers/serial/core.c~serial-race	Wed Aug 28 15:22:22 2002
+++ 2.5.32-akpm/drivers/serial/core.c	Wed Aug 28 15:22:26 2002
@@ -1315,13 +1315,14 @@ static void uart_wait_until_sent(struct 
 	 * 'timeout' / 'expire' give us the maximum amount of time
 	 * we wait.
 	 */
+	set_current_state(TASK_INTERRUPTIBLE);
 	while (!port->ops->tx_empty(port)) {
-		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(char_time);
 		if (signal_pending(current))
 			break;
 		if (time_after(jiffies, expire))
 			break;
+		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	set_current_state(TASK_RUNNING); /* might not be needed */
 }

.
