Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287111AbRL3OnK>; Sun, 30 Dec 2001 09:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287267AbRL3OnB>; Sun, 30 Dec 2001 09:43:01 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:59665 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S287111AbRL3Omm>; Sun, 30 Dec 2001 09:42:42 -0500
Date: Sun, 30 Dec 2001 14:42:35 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix serial close hang
Message-ID: <20011230144235.B9625@flint.arm.linux.org.uk>
In-Reply-To: <20011230135249.A9625@flint.arm.linux.org.uk> <20011230141731.GA7314@elfie.cavy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011230141731.GA7314@elfie.cavy.de>; from hd@cavy.de on Sun, Dec 30, 2001 at 03:17:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30, 2001 at 03:17:31PM +0100, Heinz Diehl wrote:
> serial.c:3131: state' undeclared (first use in this function)

Whoops.  This should fix it.

--- orig/include/linux/serialP.h	Sat Jul 21 10:47:15 2001
+++ linux/include/linux/serialP.h	Sun Dec 30 13:09:27 2001
@@ -70,7 +70,7 @@
 	int			x_char;	/* xon/xoff character */
 	int			close_delay;
 	unsigned short		closing_wait;
-	unsigned short		closing_wait2;
+	unsigned short		closing_wait2; /* obsolete */
 	int			IER; 	/* Interrupt Enable Register */
 	int			MCR; 	/* Modem control register */
 	int			LCR; 	/* Line control register */
--- orig/drivers/char/serial.c	Sun Dec 30 13:37:23 2001
+++ linux/drivers/char/serial.c	Sun Dec 30 13:49:27 2001
@@ -3095,36 +3095,52 @@
 
 	sstate = rs_table + line;
 	sstate->count++;
-	if (sstate->info) {
-		*ret_info = sstate->info;
-		return 0;
-	}
+	info = sstate->info;
+
+	/*
+	 * If the async_struct is already allocated, do the fastpath.
+	 */
+	if (info)
+		goto out;
+
 	info = kmalloc(sizeof(struct async_struct), GFP_KERNEL);
 	if (!info) {
 		sstate->count--;
 		return -ENOMEM;
 	}
+
 	memset(info, 0, sizeof(struct async_struct));
 	init_waitqueue_head(&info->open_wait);
 	init_waitqueue_head(&info->close_wait);
 	init_waitqueue_head(&info->delta_msr_wait);
 	info->magic = SERIAL_MAGIC;
 	info->port = sstate->port;
+	info->hub6 = sstate->hub6;
 	info->flags = sstate->flags;
-	info->io_type = sstate->io_type;
-	info->iomem_base = sstate->iomem_base;
-	info->iomem_reg_shift = sstate->iomem_reg_shift;
 	info->xmit_fifo_size = sstate->xmit_fifo_size;
+	info->state = sstate;
 	info->line = line;
+	info->iomem_base = sstate->iomem_base;
+	info->iomem_reg_shift = sstate->iomem_reg_shift;
+	info->io_type = sstate->io_type;
 	info->tqueue.routine = do_softint;
 	info->tqueue.data = info;
-	info->state = sstate;
+
 	if (sstate->info) {
 		kfree(info);
-		*ret_info = sstate->info;
-		return 0;
+		info = sstate->info;
+	} else {
+		sstate->info = info;
+	}
+
+out:
+	/*
+	 * If this is the first open, copy over some timeouts.
+	 */
+	if (sstate->count == 1) {
+		info->closing_wait = sstate->closing_wait;
 	}
-	*ret_info = sstate->info = info;
+	*ret_info = info;
 	return 0;
 }
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

