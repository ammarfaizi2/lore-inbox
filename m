Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWFHNab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWFHNab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 09:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWFHNab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 09:30:31 -0400
Received: from [213.91.247.3] ([213.91.247.3]:12037 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S1750831AbWFHNab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 09:30:31 -0400
Date: Thu, 8 Jun 2006 16:29:26 +0300
From: Alexander Atanasov <alex@ssi.bg>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, jordan.crouse@amd.com
Subject: Re: [PATCH] I2C block read
Message-Id: <20060608162926.625aad8b.alex@ssi.bg>
In-Reply-To: <20060607205025.b2529800.khali@linux-fr.org>
References: <20060607203357.64432ad8.alex@ssi.bg>
	<20060607194943.db8f1889.khali@linux-fr.org>
	<20060607210642.5cd59aba.alex@ssi.bg>
	<20060607205025.b2529800.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.1.5 (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,
On Wed, 7 Jun 2006 20:50:25 +0200
Jean Delvare wrote:

> As for the problem you encounter, it looks like a bug in the
> scx200_acb driver to me. It advertises the I2C_FUNC_SMBUS_BLOCK_DATA
> functionality, but due to its implementation it can only support SMBus
> block writes and not SMBus block reads. I see no reason why the chip
> itself couldn't do it, but right now the driver can't. The state
> machine the driver is based on would need some rework before the
> functionality can be added. In the meantime, the quickest fix is to
> 

	OK, i got it now.  Untested patch that should do it.
> 
> May I ask for what slave SMBus chip you need the SMBus block read
> transaction? It's only rarely used, so it could be that it's not what
> you need after all.

	It's custom developed board with using some motorola processor,
and the implementation there is buggy doesn't send the lenght but
this is fixable. So i'll have to fix the state machine after that.
Guy who is developing the board says that he doesn't get the ACK 
after the last byte is read too - one more thing to investigate.

Also i use some pc engines board which has geode cpu on it
and have two access busses one is at 0x820 and the second is at 0x810
but the second is not in the list of probed devices, can it be added?

> 
> The scx200_acb code would probably benefit from a general review. It
> looks to me like quick command with data bit == 1 would fail, for
> example. It's not a very popular transaction either, but i2c bus
> drivers should handle all transactions they advertise as supported.
> 

--
have fun,
alex

--- drivers/i2c/busses/scx200_acb.c.orig	2006-06-08 15:57:38.000000000 +0300
+++ drivers/i2c/busses/scx200_acb.c	2006-06-08 16:24:32.000000000 +0300
@@ -175,12 +175,22 @@
 			iface->state = state_read;
 		} else {
 			outb(iface->address_byte, ACBSDA);
-
 			iface->state = state_write;
 		}
 		break;
 
 	case state_read:
+		if (iface->len == 42) {
+			outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
+			iface->len = inb(ACBSDA);
+			if (iface->len > 31) {
+				dev_dbg(&iface->adapter.dev, "Invalid read lenght %d in state %s\n",
+					iface->len, scx200_acb_state_name[iface->state]);
+				errmsg = "Invalid read lenght";
+				goto error;
+			}
+			break;
+		}
 		/* Set ACK if receiving the last byte */
 		if (iface->len == 1)
 			outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
@@ -305,7 +315,11 @@
 		break;
 
 	case I2C_SMBUS_BLOCK_DATA:
-		len = data->block[0];
+		/* 42 is invalid lenght max 32, use it to get real lenght from data */
+		if (rw == I2C_SMBUS_READ)
+			len = 42;
+		else
+			len = data->block[0];
 		buffer = &data->block[1];
 		break;
 
