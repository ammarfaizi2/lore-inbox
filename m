Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWC3Ou1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWC3Ou1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWC3Ou1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:50:27 -0500
Received: from [213.91.10.50] ([213.91.10.50]:26321 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S1750712AbWC3Ou1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:50:27 -0500
Date: Thu, 30 Mar 2006 16:45:57 +0200 (CEST)
To: linux-kernel@vger.kernel.org
Subject: Re: I2C SMBUS problem
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <raxzcViv.1143729957.8232100.khali@localhost>
In-Reply-To: <6d6a94c50603291915i67e1c960o17cc743efff33e74@mail.gmail.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Aubrey" <aubreylee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Thu, 30 Mar 2006 16:45:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Aubrey,

On 2006-03-30, Aubrey wrote:
> I'm writing a driver for ADI's chip AD7142, the following is the
> single register I2C write operation of it:
>
> [Write]
>
> (s)-(6-BIT device addr )-(W)-(ACK)- \
> (register addr[15:8])-(ACK)- \
> (register addr[7:0])-(ACK)- \
> (Write Data[15:8])-(ACK)- \
> (Write Data[7:0])-(ACK)-(P)

I guess you really mean 7-bit device address? That's what I2C/SMBus uses.

> I found it does not match any mode of the existing SMBUS specs.
> Because the number of the internal register exceeds 8-bit(approximate
> 600), the register address(command field) needs 2-byte.
>
> In the kernel, I found the doc about it. part of it is here:
> Documentation/i2c/smbus-protocol
> (...)
> I2C Block Write
> ===============
>
> The opposite of the Block Read command, this writes bytes to
> a device, to a designated register that is specified through the
> Comm byte. Note that command lengths of 0, 2, or more bytes are
> supported as they are indistinguishable from data.
>
> S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P
> ==============================
>
> As the doc mentioned, the [Comm] field can be 2 or more bytes. But
> this does not match the I2C driver code, see the file
> "drivers/i2c/i2c-core.c"
> ===============================================
> s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8
> command, u8 *values)
> s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
>                                   u8 length, u8 *values)
>
> The type of the parameter [command] of these two routines are "u8", I
> think that means you can't pass 2 or more bytes command to the
> routine.
>
> So this is my problem. Did I missing something?

You're mostly right. In fact, the documentation you pointed us to is
about the I2C protocol itself, not the kernel implementation. In the
kernel, we have helper functions for all the SMBus commands (SMBus is a
subset of I2C) and two very common non-SMBus transactions (1-byte
address block read, and 1-byte address block write). Other transactions
can still be done, but are almost never implemented in SMBus masters, so
they have no helper functions. You have to use the lower-level i2c
access interface.

> I may need to modify the common I2C SMBUS driver and finalize my chip
> driver. I want to know if it's acceptable.

You should be able to go with what the core offers. The transaction you
want to do is not an SMBus transaction, so you have to go with the i2c
access functions: i2c_transfer, i2c_master_send and i2c_master_recv. In
your case, i2c_master_send is the best choice.

Or you can use a trick and go with i2c_smbus_write_i2c_block_data after
all. The I2C protocol doesn't differenciate between register addresses
and written data, it's purely a matter of convention with the addressed
chip. So, you can see your transaction not as two register address bytes
followed by two data bytes, but as one register address byte followed by
three data bytes. It's really the same on the wire, and this fits well
in i2c_smbus_write_i2c_block_data.

I would go with i2c_master_send, unless you need some kind of SMBus
master compatibility (many SMBus masters implement I2C-like block
transfers). May I ask what i2c adapter driver you are using to talk to
your AD7142 chip?

--
Jean Delvare
