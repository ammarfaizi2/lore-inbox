Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbULaJsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbULaJsC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 04:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbULaJrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 04:47:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:13249 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261831AbULaJqS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 04:46:18 -0500
Date: Fri, 31 Dec 2004 01:46:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Nelson <james4765@verizon.net>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       james4765@verizon.net
Subject: Re: [PATCH] esp: Make driver SMP-correct
Message-Id: <20041231014611.003281e5.akpm@osdl.org>
In-Reply-To: <20041231014403.3309.58245.96163@localhost.localdomain>
References: <20041231014403.3309.58245.96163@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Nelson <james4765@verizon.net> wrote:
>
> This is an attempt to make the esp serial driver SMP-correct.  It also removes
>  some cruft left over from the serial_write() conversion.

>From a quick scan:

- startup() does multiple sleeping allocations and request_irq() under
  spin_lock_irqsave().  Maybe fixed by this:

--- 25/drivers/char/esp.c~esp-make-driver-smp-correct-fixes	2004-12-31 01:40:57.987232152 -0800
+++ 25-akpm/drivers/char/esp.c	2004-12-31 01:42:21.444544712 -0800
@@ -851,16 +851,14 @@ static int startup(struct esp_struct * i
 	int	retval=0;
         unsigned int num_chars;
 
-	spin_lock_irqsave(&info->irq_lock, flags);
-
 	if (info->flags & ASYNC_INITIALIZED)
-		goto out;
+		goto out_unlocked;
 
 	if (!info->xmit_buf) {
 		info->xmit_buf = (unsigned char *)get_zeroed_page(GFP_KERNEL);
 		retval = -ENOMEM;
 		if (!info->xmit_buf)
-			goto out;
+			goto out_unlocked;
 	}
 
 #ifdef SERIAL_DEBUG_OPEN
@@ -907,7 +905,7 @@ static int startup(struct esp_struct * i
 					&info->tty->flags);
 			retval = 0;
 		}
-		goto out;
+		goto out_unocked;
 	}
 
 	if (!(info->stat_flags & ESP_STAT_USE_PIO) && !dma_buffer) {
@@ -926,6 +924,8 @@ static int startup(struct esp_struct * i
 			
 	}
 
+	spin_lock_irqsave(&info->irq_lock, flags);
+
 	info->MCR = UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2;
 	serial_out(info, UART_ESI_CMD1, ESI_WRITE_UART);
 	serial_out(info, UART_ESI_CMD2, UART_MCR);
@@ -965,7 +965,9 @@ static int startup(struct esp_struct * i
 
 	info->flags |= ASYNC_INITIALIZED;
 	retval = 0;
-out:	spin_unlock_irqrestore(&info->irq_lock, flags);
+out:
+	spin_unlock_irqrestore(&info->irq_lock, flags);
+out_unocked:
 	return retval;
 }
 
_


- startup() calls change_speed() under info->irq_lock, but change_speed()
  also takes info->irq_lock.  Instant deadlock on driver initialisation.

The driver needs more serious surgery than this.
