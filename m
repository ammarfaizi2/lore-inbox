Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVAHIio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVAHIio (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVAHIg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:36:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:3206 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261906AbVAHFsh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:37 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627753411@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:35 -0800
Message-Id: <11051627751088@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.445.4, 2004/12/15 11:37:45-08:00, khali@linux-fr.org

[PATCH] I2C: i2c-algo-bit should support I2C_FUNC_I2C

> Very few drivers seem to support the I2C_FUNC_I2C functionality, is
> there a reason for that?

Yes, most bus drivers are for SMBus, not I2C, masters. SMBus is a subset
of I2C. These SMBus master are fully I2C-capable, although in most cases
it doesn't matter. Most chip drivers are for SMBus clients as well.
Almost all hardware monitoring chips are SMBus devices. So it's not
surprising not to see I2C_FUNC_I2C widely used.

> I have an I2C bus on my platform constructed from a couple of GPIO lines
> using the i2c-algo-bit driver. The device on the bus is a DS1307 I2C RTC
> and the driver for that currently checks for
> 	I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_WRITE_BYTE
> however the datasheet suggests it is a simple i2c device with none of
> this smbus stuff, Russell King queried this here
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=2021/1

First, note that all SMBus commands are valid I2C transfers. In fact,
the SMBus specification doesn't do much except put names on specific I2C
transfers, and sometimes give meanings to the data being transfered. As
a result, "I2C" clients, although not specifically SMBus-compatible, may
enjoy SMBus commands such as SMBUS_READ_BYTE, SMBUS_READ_BYTE_DATA and
SMBUS_WRITE_BYTE_DATA. One typical example of that are EEPROMs and the
eeprom driver. It relies on i2c_smbus_write_byte and i2c_smbus_read_byte
(BTW I just noticed that it doesn't properly check for these
functionalities... have to fix that) because it's so much easier to call
these standard functions than rewrite I2C code manually. Also, this let
us access the EEPROMs on SMBus (non-I2C) busses.

Now, note that Russell is not quite correct in is assertion: "Do we
really require SMBUS functionality, or is i2c functionality sufficient?"
It's actually the other way around. SMBus puts restrictions on what a
valid I2C transfer is. "Do we need the full I2C functionality or is the
SMBus subset sufficient?" would make more sense.

As for the exact functionality you need to check, let's just see how you
access the bus. As far as I can see (providing that the code below
Russell's comments is still valid), you rely on:
 * i2c_smbus_write_byte_data
 * i2c_smbus_read_byte_data
 * i2c_transfer

So yo *need* to check for the availability of I2C_FUNC_SMBUS_BYTE_DATA
on the adapter (which is part of I2C_FUNC_SMBUS_EMUL so any bus driver
using that, including any relying on i2c-algo-bit, will work with your
client driver) for the first two. And you also need to check for
I2C_FUNC_I2C for the third one.

Of course, any adapter with I2C_FUNC_I2C will be able to do SMBus byte
data transfers, but since you do not use i2c_transfer to do them, you
need to check the functionality separately (I think).

Also, I think that what you do with i2c_transfer is similar to
I2C_FUNC_SMBUS_READ_I2C_BLOCK, which is supported by some SMBus
(non-I2C) masters. If you convert your code to use
i2c_smbus_read_i2c_block_data, then you don't rely on the full I2C
capatbilities of the bus, which means that your chip driver will be
useable on more plateforms. That said, note that this feature is
unimplemented on most SMBus master drivers as of now, and broken on a
number of others (but I guess we would start paying more attention to
them if there were more users for this function).

> If I change it to a check for I2C_FUNC_I2C and change the algo-bit
> driver to declare I2C_FUNC_I2C then the driver continues to work fine.

You are right that i2c-algo-bit should declare itself I2C_FUNC_I2C
capable. I even think that every bus being I2C_FUNC_SMBUS_EMUL capable
is very likely to be I2C_FUNC_I2C capable. This means that other
algorithms (ite, pcf, maybe pca) could most probably be declared
I2C_FUNC_I2C capable as well. Can anyone confirm?

> Given the above, is the following patch appropriate, or is there
> something about the relationship between i2c and smbus that I don't
> understand.

I admit that the relationship between I2C and SMBus is somewhat tricky,
it took me some time to get it and even then I am sometimes not sure to
understand exactly what implies what ;) So we cannot blame you for not
getting it at first. I hope I helped make things a little clearer. If
not I welcome questions.

Whether or not you change your code to use SMBus only in your driver to
make it more widely useable, your patch to i2c-algo-bit is valid, I am
signing it too and will apply it to the 2.4 version of the driver as
well.

Signed-off-by: Ian Campbell <icampbell@arcom.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/algos/i2c-algo-bit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
--- a/drivers/i2c/algos/i2c-algo-bit.c	2005-01-07 14:55:58 -08:00
+++ b/drivers/i2c/algos/i2c-algo-bit.c	2005-01-07 14:55:58 -08:00
@@ -511,8 +511,8 @@
 
 static u32 bit_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR | 
-	       I2C_FUNC_PROTOCOL_MANGLING;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | 
+	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 

