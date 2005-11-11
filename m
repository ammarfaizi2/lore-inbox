Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVKKDJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVKKDJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVKKDJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:09:16 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:9607 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932298AbVKKDJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:09:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Nwmly+wGdiPNqiq15ynJ5s/gxpMjaBjG/52g3ugoTxZ3rrYK4GeeUBclbX/zbhVh9smxC7O9IEPxgQ9/E4idbFr5tvmHcIwIPyVNdExVMP5yFfhoOZ1uZLY0RSknz+upyMJ8mj2RtMk8JSdv4unQmx59IMO1xASguYIq7sdiK6s=
Date: Thu, 10 Nov 2005 22:09:37 -0500
From: Florin Malita <fmalita@gmail.com>
To: akpm@osdl.org, rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Subject: [PATCH] sa1100 serial: sa1100_start_tx spinlock recursion
Message-Id: <20051110220937.4e26592e.fmalita@gmail.com>
X-Mailer: Sylpheed version 2.1.2 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial core aquires the port spinlock before calling
port->ops->start_tx(), so sa1100_start_tx() shouldn't try to lock it
again.

BUG: spinlock recursion on CPU#0, init/1
 lock: c0205f20, .magic: dead4ead, .owner: init/1, .owner_cpu: 0
[<c0022cdc>] (dump_stack+0x0/0x14) [<c00dc338>] (spin_bug+0x0/0xbc)   
[<c00dc6b0>] (_raw_spin_lock+0x0/0x170)  r8 = 00000007  r7 = C02FE0070                                                   
[<c018a2a8>] (_spin_lock_irqsave+0x0/0x24)  r4 = C0205F20 
[<c0112110>] (sa1100_start_tx+0x0/0x40)  r4 = C038C000    
[<c010ee38>] (__uart_start+0x0/0x5c) [<c010ee94>] (uart_start+0x0/0x3 
[<c010f1d0>] (uart_write+0x0/0xdc) [<c00fee34>] (write_chan+0x0/0x370 



Signed-off-by: Florin Malita <fmalita@gmail.com>
----
diff --git a/drivers/serial/sa1100.c b/drivers/serial/sa1100.c
--- a/drivers/serial/sa1100.c
+++ b/drivers/serial/sa1100.c
@@ -156,7 +156,7 @@ static void sa1100_stop_tx(struct uart_p
 }
 
 /*
- * interrupts may not be disabled on entry
+ * port locked and interrupts disabled
  */
 static void sa1100_start_tx(struct uart_port *port)
 {
@@ -164,11 +164,9 @@ static void sa1100_start_tx(struct uart_
 	unsigned long flags;
 	u32 utcr3;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
 	utcr3 = UART_GET_UTCR3(sport);
 	sport->port.read_status_mask |= UTSR0_TO_SM(UTSR0_TFS);
 	UART_PUT_UTCR3(sport, utcr3 | UTCR3_TIE);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 /*

