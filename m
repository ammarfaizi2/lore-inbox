Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWFGSuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWFGSuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWFGSuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:50:35 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:49415 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751258AbWFGSue
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:50:34 -0400
Date: Wed, 7 Jun 2006 20:50:25 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Alexander Atanasov <alex@ssi.bg>
Cc: linux-kernel@vger.kernel.org, "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: [PATCH] I2C block read
Message-Id: <20060607205025.b2529800.khali@linux-fr.org>
In-Reply-To: <20060607210642.5cd59aba.alex@ssi.bg>
References: <20060607203357.64432ad8.alex@ssi.bg>
	<20060607194943.db8f1889.khali@linux-fr.org>
	<20060607210642.5cd59aba.alex@ssi.bg>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Adding Jordan Crouse in the loop, he's working on the scx200_acb driver
these days.

> I use SMBus block read with scx200_acb as a bus it uses the lenght
> which is as i say uninitialized and tries to read a number of random bytes
> from the board i use. And it doesn't return the lenght as a first byte,
> so the drivers reads until it gets an oops. Which in turn makes me wonder
> why with this patch i correcly receive the number of bytes i pass,
> looking at the driver i can not see that it gets the lenght from the read data.
> I don't know well SMBus/I2C specs but read with buffer and no lenght 
> doesn't look sane to me. So how should this be fixed?

There _is_ a length, it's just decided by the target chip rather than
the host. It makes some sense when you think about it, even if it is a
bit susprising at first, I agree. The length is limited to 32 bytes as
per the SMBus specification, so it's safe. I invite you to read the
SMBus 2.0 specification [1] for more details if you're interested.

As for the problem you encounter, it looks like a bug in the scx200_acb
driver to me. It advertises the I2C_FUNC_SMBUS_BLOCK_DATA
functionality, but due to its implementation it can only support SMBus
block writes and not SMBus block reads. I see no reason why the chip
itself couldn't do it, but right now the driver can't. The state
machine the driver is based on would need some rework before the
functionality can be added. In the meantime, the quickest fix is to
have the driver only advertise the functionalities it actually supports:


The scx200_acb advertises SMBus block transactions as supported. In
fact, it supports SMBus block writes, but not SMBus block reads which
are more complex to implement.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/busses/scx200_acb.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc6.orig/drivers/i2c/busses/scx200_acb.c	2006-06-07 18:13:53.000000000 +0200
+++ linux-2.6.17-rc6/drivers/i2c/busses/scx200_acb.c	2006-06-07 20:29:27.000000000 +0200
@@ -308,6 +308,12 @@
 		break;
 
 	case I2C_SMBUS_BLOCK_DATA:
+		/* Sanity check */
+		if (rw == I2C_SMBUS_READ) {
+			dev_warn(&adapter->dev, "SMBus block read is not "
+				 "supported!\n");
+			return -EINVAL;
+		}
 		len = data->block[0];
 		buffer = &data->block[1];
 		break;
@@ -372,7 +378,7 @@
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
-	       I2C_FUNC_SMBUS_BLOCK_DATA;
+	       I2C_FUNC_SMBUS_WRITE_BLOCK_DATA;
 }
 
 /* For now, we only handle combined mode (smbus) */


May I ask for what slave SMBus chip you need the SMBus block read
transaction? It's only rarely used, so it could be that it's not what
you need after all.

The scx200_acb code would probably benefit from a general review. It
looks to me like quick command with data bit == 1 would fail, for
example. It's not a very popular transaction either, but i2c bus
drivers should handle all transactions they advertise as supported.

[1] http://www.smbus.org/specs/

-- 
Jean Delvare
