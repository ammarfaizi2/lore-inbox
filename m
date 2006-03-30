Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWC3DPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWC3DPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 22:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWC3DPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 22:15:37 -0500
Received: from wproxy.gmail.com ([64.233.184.233]:16212 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751231AbWC3DPh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 22:15:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=la1YaKgcUkck4LKZyVtu8eJrh5YnhhY6OT3/Iq4KlW0aHiJ9eSRDMxo+eZx1cvjzEZTACgDxQlx5vekMxqeBFMK60xGdUObwpXTAks2jYO2AQu2Ginz0nKfc6jEgv48rCk/eqdDixNYRNRr+UarE4Gj6JPfL1b3LHTeYd1ge+y0=
Message-ID: <6d6a94c50603291915i67e1c960o17cc743efff33e74@mail.gmail.com>
Date: Thu, 30 Mar 2006 11:15:36 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: I2C SMBUS problem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm writing a driver for ADI's chip AD7142, the following is the
single register I2C write operation of it:

[Write]

(s)-(6-BIT device addr )-(W)-(ACK)- \
(register addr[15:8])-(ACK)- \
(register addr[7:0])-(ACK)- \
(Write Data[15:8])-(ACK)- \
(Write Data[7:0])-(ACK)-(P)

I found it does not match any mode of the existing SMBUS specs.
Because the number of the internal register exceeds 8-bit(approximate
600), the register address(command field) needs 2-byte.

In the kernel, I found the doc about it. part of it is here:
./Documentation/i2c/smbus-protocal

I2C Block Read (2 Comm bytes)
=============================

This command reads a block of bytes from a device, from a
designated register that is specified through the two Comm bytes.

S Addr Wr [A] Comm1 [A] Comm2 [A]
           S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P


I2C Block Write
===============

The opposite of the Block Read command, this writes bytes to
a device, to a designated register that is specified through the
Comm byte. Note that command lengths of 0, 2, or more bytes are
supported as they are indistinguishable from data.

S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P
==============================

As the doc mentioned, the [Comm] field can be 2 or more bytes. But
this does not match the I2C driver code, see the file
"drivers/i2c/i2c-core.c"
===============================================
s32 i2c_smbus_read_i2c_block_data(struct i2c_client *client, u8
command, u8 *values)
s32 i2c_smbus_write_i2c_block_data(struct i2c_client *client, u8 command,
                                   u8 length, u8 *values)

The type of the parameter [command] of these two routines are "u8", I
think that means you can't pass 2 or more bytes command to the
routine.

So this is my problem. Did I missing something?

I may need to modify the common I2C SMBUS driver and finalize my chip
driver. I want to know if it's acceptable.

Thanks for your hints and suggestions,

Regards,
-Aubrey
