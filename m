Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWFKNah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWFKNah (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 09:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWFKNah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 09:30:37 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:50193 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751276AbWFKNah
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 09:30:37 -0400
Date: Sun, 11 Jun 2006 15:30:34 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Alexander Atanasov <alex@ssi.bg>
Cc: linux-kernel@vger.kernel.org, "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: [PATCH] I2C block read
Message-Id: <20060611153034.510cda48.khali@linux-fr.org>
In-Reply-To: <20060608162926.625aad8b.alex@ssi.bg>
References: <20060607203357.64432ad8.alex@ssi.bg>
	<20060607194943.db8f1889.khali@linux-fr.org>
	<20060607210642.5cd59aba.alex@ssi.bg>
	<20060607205025.b2529800.khali@linux-fr.org>
	<20060608162926.625aad8b.alex@ssi.bg>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

> > As for the problem you encounter, it looks like a bug in the
> > scx200_acb driver to me. It advertises the I2C_FUNC_SMBUS_BLOCK_DATA
> > functionality, but due to its implementation it can only support SMBus
> > block writes and not SMBus block reads. I see no reason why the chip
> > itself couldn't do it, but right now the driver can't. The state
> > machine the driver is based on would need some rework before the
> > functionality can be added. In the meantime, the quickest fix is to
> 
> 	OK, i got it now.  Untested patch that should do it.

It won't work. There are bugs in the state machine which need to be
fixed before any block transaction will work (be it I2C or SMBus.)

Fix the scx200_acb state machine:

* Nack was sent one byte too late on reads >= 2 bytes.
* Stop bit was set one byte too late on reads.
* Stop bit was set one byte too late on writes.

Credits go to Thomas Andrews for finding and fixing the first
two items.

Testers wanted! Not suitable for inclusion at this point.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/busses/scx200_acb.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- linux-2.6.17-rc6.orig/drivers/i2c/busses/scx200_acb.c	2006-06-11 14:54:02.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/scx200_acb.c	2006-06-11 14:55:23.000000000 +0200
@@ -184,29 +184,28 @@
 		break;
 
 	case state_read:
-		/* Set ACK if receiving the last byte */
-		if (iface->len == 1)
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


> > May I ask for what slave SMBus chip you need the SMBus block read
> > transaction? It's only rarely used, so it could be that it's not what
> > you need after all.
> 
> 	It's custom developed board with using some motorola processor,
> and the implementation there is buggy doesn't send the lenght but
> this is fixable. So i'll have to fix the state machine after that.
> Guy who is developing the board says that he doesn't get the ACK 
> after the last byte is read too - one more thing to investigate.

This sounds like your device is expecting an I2C block read rather than
an SMBus block read. Both transactions look alike, what matters is that
both sides of the transaction agree on which transaction type should be
used. I2C block reads are more simple, the data bytes are returned
directly (no length byte.)

As for ack problem, the patch above should hopefully fix it.

> Also i use some pc engines board which has geode cpu on it
> and have two access busses one is at 0x820 and the second is at 0x810
> but the second is not in the list of probed devices, can it be added?

There is a module parameter which can be used for that. From an
upcoming documentation update for the scx200_acb driver:

The SC1100 WRAP boards are known to use base addresses 0x810 and 0x820.
If the scx200_acb driver is built into the kernel, add the following
parameter to your boot command line:
  scx200_acb.base=0x810,0x820
If the scx200_acb driver is built as a module, add the following line to
the file /etc/modprobe.conf instead:
  options scx200_acb base=0x810,0x820

There might be a way to have the driver auto-detect the correct address
but I didn't have the time to look into it lately.

> --- drivers/i2c/busses/scx200_acb.c.orig	2006-06-08 15:57:38.000000000 +0300
> +++ drivers/i2c/busses/scx200_acb.c	2006-06-08 16:24:32.000000000 +0300
> @@ -175,12 +175,22 @@
>  			iface->state = state_read;
>  		} else {
>  			outb(iface->address_byte, ACBSDA);
> -
>  			iface->state = state_write;
>  		}
>  		break;
>  
>  	case state_read:
> +		if (iface->len == 42) {
> +			outb(inb(ACBCTL1) & ~ACBCTL1_ACK, ACBCTL1);
> +			iface->len = inb(ACBSDA);
> +			if (iface->len > 31) {
> +				dev_dbg(&iface->adapter.dev, "Invalid read lenght %d in state %s\n",
> +					iface->len, scx200_acb_state_name[iface->state]);
> +				errmsg = "Invalid read lenght";
> +				goto error;
> +			}
> +			break;
> +		}
>  		/* Set ACK if receiving the last byte */
>  		if (iface->len == 1)
>  			outb(inb(ACBCTL1) | ACBCTL1_ACK, ACBCTL1);
> @@ -305,7 +315,11 @@
>  		break;
>  
>  	case I2C_SMBUS_BLOCK_DATA:
> -		len = data->block[0];
> +		/* 42 is invalid lenght max 32, use it to get real lenght from data */
> +		if (rw == I2C_SMBUS_READ)
> +			len = 42;
> +		else
> +			len = data->block[0];
>  		buffer = &data->block[1];
>  		break;
>  

I get the idea, something of that kind might work once the rest is
fixed. Of course we want to define a nice constant instead of
hardcoding 42, and also note that length is spelled length.

-- 
Jean Delvare
