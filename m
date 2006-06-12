Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752006AbWFLOWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbWFLOWI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWFLOWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:22:08 -0400
Received: from [213.91.247.3] ([213.91.247.3]:19205 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S1752012AbWFLOWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:22:07 -0400
Date: Mon, 12 Jun 2006 17:16:35 +0300
From: Alexander Atanasov <alex@ssi.bg>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, jordan.crouse@amd.com
Subject: Re: [PATCH] I2C block read
Message-Id: <20060612171635.041eafe0.alex@ssi.bg>
In-Reply-To: <20060611153034.510cda48.khali@linux-fr.org>
References: <20060607203357.64432ad8.alex@ssi.bg>
	<20060607194943.db8f1889.khali@linux-fr.org>
	<20060607210642.5cd59aba.alex@ssi.bg>
	<20060607205025.b2529800.khali@linux-fr.org>
	<20060608162926.625aad8b.alex@ssi.bg>
	<20060611153034.510cda48.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.1.5 (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

On Sun, 11 Jun 2006 15:30:34 +0200
Jean Delvare wrote:

> Fix the scx200_acb state machine:
> 
> * Nack was sent one byte too late on reads >= 2 bytes.
> * Stop bit was set one byte too late on reads.
> * Stop bit was set one byte too late on writes.
> 
> Credits go to Thomas Andrews for finding and fixing the first
> two items.
> 
> Testers wanted! Not suitable for inclusion at this point.

	with the patch below i get the correct results.
the patch for testing and some changes for the block reads.
and the ACK seems working - i have some status bits
which get cleared on correct read (i.e. the ACK is sent) and i have them cleared.

> This sounds like your device is expecting an I2C block read rather
> than an SMBus block read. Both transactions look alike, what matters
> is that both sides of the transaction agree on which transaction type
> should be used. I2C block reads are more simple, the data bytes are
> returned directly (no length byte.)
> 
> As for ack problem, the patch above should hopefully fix it.

	SMBus read it's fixed now on the board. As for the ACK problem i think it is ok.

> The SC1100 WRAP boards are known to use base addresses 0x810 and
> 0x820. If the scx200_acb driver is built into the kernel, add the
> following parameter to your boot command line:
>   scx200_acb.base=0x810,0x820
> If the scx200_acb driver is built as a module, add the following line
> to the file /etc/modprobe.conf instead:
>   options scx200_acb base=0x810,0x820
> 
> There might be a way to have the driver auto-detect the correct
> address but I didn't have the time to look into it lately.

	that works. there is a probe function if there is nothing dangerous 
known at this address why it can not be auto probed. any pointers where
to check how to autodetect it ?


--
have fun,
alex

--- drivers/i2c/busses/scx200_acb.c.orig	2006-01-04 02:00:00.000000000 +0200
+++ drivers/i2c/busses/scx200_acb.c	2006-06-12 17:02:02.000000000 +0300
@@ -43,10 +43,11 @@
 MODULE_LICENSE("GPL");
 
 #define MAX_DEVICES 4
-static int base[MAX_DEVICES] = { 0x820, 0x840 };
+static int base[MAX_DEVICES] = { 0x810, 0x820, 0x840 };
 module_param_array(base, int, NULL, 0);
 MODULE_PARM_DESC(base, "Base addresses for the ACCESS.bus controllers");
 
+#define DEBUG
 #ifdef DEBUG
 #define DBG(x...) printk(KERN_DEBUG NAME ": " x)
 #else
@@ -116,6 +117,8 @@
 #define ACBCTL2		(iface->base + 5)
 #define    ACBCTL2_ENABLE	0x01
 
+#define EXPECT_LEN	42
+
 /************************************************************************/
 
 static void scx200_acb_machine(struct scx200_acb_iface *iface, u8 status)
@@ -178,29 +181,50 @@
 		break;
 
 	case state_read:
-		/* Set ACK if receiving the last byte */
-		if (iface->len == 1)
+		if (iface->len == EXPECT_LEN) {
+			/* 
+			 * Len = 1 is valid in the spec
+			 * and we must set ACK since the next
+			 * byte will be the last one
+			 * but how we know to send it
+			 * if we first read length ?
+			 */
+			outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
+
+			iface->len= inb(ACBSDA);
+			if (iface->len > 31) {
+				dev_dbg(&iface->adapter.dev, "Invalid read length %d in state %s\n",
+					iface->len, scx200_acb_state_name[iface->state]);
+				errmsg = "Invalid read length";
+				goto error;
+			}
+			/* the first byte in the buffer is expected to be the length */
+			*iface->ptr++ = iface->len;
+			DBG("Got BLOCK READ len=%d\n", iface->len); 
+			break;
+		}
+		/* Set ACK if _next_ byte will be the last one */
+		if (iface->len == 2)
 			outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
 		else
 			outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
 
-		*iface->ptr++ = inb(ACBSDA);
-		--iface->len;
-
-		if (iface->len == 0) {
+		if (iface->len == 1) {
 			iface->result = 0;
 			iface->state = state_idle;
 			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
 		}
 
+		*iface->ptr++ = inb(ACBSDA);
+		--iface->len;
+
 		break;
 
 	case state_write:
-		if (iface->len == 0) {
+		if (iface->len == 1) {
 			iface->result = 0;
 			iface->state = state_idle;
 			outb(inb(ACBCTL1) | ACBCTL1_STOP, ACBCTL1);
-			break;
 		}
 		
 		outb(*iface->ptr++, ACBSDA);
@@ -317,8 +341,13 @@
 	    	buffer = (u8 *)&cur_word;
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
-	    	len = data->block[0];
-	    	buffer = &data->block[1];
+		if (rw == I2C_SMBUS_READ) {
+			len = EXPECT_LEN;
+			buffer = &data->block[0];
+		} else {
+			len = data->block[0];;
+			buffer = &data->block[1];
+		}
 		break;
 	default:
 	    	return -EINVAL;
@@ -373,6 +402,9 @@
 	    	data->word = le16_to_cpu(cur_word);
 
 #ifdef DEBUG
+	if (size == I2C_SMBUS_BLOCK_DATA && rw == I2C_SMBUS_READ) {
+		len = buffer[0] + 1;
+	} 
 	DBG(": transfer done, result: %d", rc);
 	if (buffer) {
 		int i;
