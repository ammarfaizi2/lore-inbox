Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263678AbVBCSn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263678AbVBCSn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVBCRyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:54:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:17832 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263672AbVBCRlY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:24 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Prevent buffer overflow on SMBus block read in
In-Reply-To: <11074523382272@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:38:59 -0800
Message-Id: <11074523394125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2047, 2005/02/03 00:31:16-08:00, khali@linux-fr.org

[PATCH] I2C: Prevent buffer overflow on SMBus block read in

Hi Greg, Linus, all,

I just hit a buffer overflow while playing around with i2cdump and
i2c-viapro through i2c-dev. This is caused by a missing length check on
a buffer operation when doing a SMBus block read in the i2c-viapro
driver. The problem was already known and had been fixed upon report by
Sergey Vlasov back in August 2003 in lm_sensors (2.4 kernel version of
the driver) but for some reason it was never ported to the 2.6 kernel
version.

I am not a security expert but I would guess that such a buffer overflow
could possibly be used to run arbitrary code in kernel space from user
space through i2c-dev. The severity obviously depends on the permisions
set on the i2c device files in /dev. Maybe it wouldn't be a bad idea to
push this patch upstream rather sooner than later.

While I was at it, I also changed a similar size check (for SMBus block
write this time) in the same driver to use the correct constant
I2C_SMBUS_BLOCK_MAX instead of its current numerical value. This doesn't
change a thing at the moment but prevents another potential buffer
overflow in case the value of I2C_SMBUS_BLOCK_MAX were to be changed in
the future (admittedly unlikely though).

> Now if we have broken hardware, then we might have a problem here, but
> otherwise I don't see it as a security issue right now.

It doesn't take broken hardware.

(Warning: I am going technical at this point, people not interested in
the gory details of the I2C and SMBus protocols should better stop here
;))

It just depends on what part of the SMBus and I2C specifications a given
client chip supports. SMBus block reads are no different from SMBus byte
reads, except that the master (here the VIA Pro) goes on reading after
the first byte sent by the slave (which could be about anything, from
hardware monitoring chip to EEPROM). In that respect, it also doesn't
much differ from the I2C block read, which also starts in the exact same
way. The difference between SMBus block read and I2C block read is that
the first byte returned by the slave on SMBus block read is supposed to
be the remaining number of data byte to be sent, while this is simply
the first data byte for I2C block reads.

To make it clearer, here comes the detail of the byte read, SMBus block
read and I2C block read commands (-> means from master to slave, <-
means from slave to master). See the official specifications for I2C and
SMBus for nicer graphics and additional details.

Byte read:
-> client address, write mode
-> register address
-> client address, read mode
<- data byte

SMBus block read:
-> client address, write mode
-> register address
-> client address, read mode
<- length byte (1 <=3D N <=3D 32)
<- first byte
<- next byte
<- ...
<- last (Nth) byte

I2C block read:
-> client address, write mode
-> register address
-> client address, read mode
<- first byte
<- next byte
<- ...
<- last byte

In each case, the *master* decides when to stop the transfer, not the
slave.

There are two consequences for us here:

1* The client chip cannot differenciate between byte read and SMBus block
read until after it sent a first byte - which basically means that a
given register address is specified to be read with either command, not
both, and not using the correct one returns bogus results. i2c-dev
allows arbitrary commands so it is possible to ask for a SMBus block
read on a register that expects a simple byte read. The client
innocently will answer with the register value - which the master will
interpret as a length, and the master will then request that many
additional data bytes. If the client features autoincrement in this
register address range, it will most likely provide the value of the
next registers, if not it will dumbly return the same register value
again and again.

This illustrates the fact that it doesn't take a broken chip to cause a
buffer overflow. It only takes a SMBus block read command on a register
for which the client did not expect it (and almost no client actually
supports SMBus block reads at the moment). If it happens that the
register value was greater than 32, the buffer overflow will occur
(without Sergey's fix, that is). So, with write access to the i2c
device files, it is actually very easy to trigger the buffer overflow,
providing there is at least one chip on the VIA Pro SMBus.

2* A client chip can obviously only implement SMBus block read or I2C
block read for a given register address, since the sequence sent by the
master is exactly the same. Not a big deal since a client chip is
designed either as an I2C slave or as a SMBus slave. However the master
doesn't know this, and i2c-dev allows arbitrary commands, so it is
possible to use an SMBus block read on an I2C slave which expected
instead an I2C block read, causing weird results.

EEPROMs are such I2C slaves and they support I2C block reads. Now,
imagine that a non-write-protected EEPROM hangs on my VIA Pro SMBus (a
memory module SPD EEPROM would probably do), and for some reason i2c-dev
gives me access to it. I can write arbitrary bytes to the EEPROM using
simple byte writes. I could write the following bytes, in order, at some
location: 0x80, 34 null bytes, 94 bytes of nasty code. Then, still
through i2c-dev, I request a SMBus block read from the same location.
The EEPROM will answer as if it were an I2C block read (it can't
differenciate and doesn't support SMBus block reads anyway), i.e. it
will return as many bytes as requested, in order. The VIA Pro master
will however interpret the first byte (0x80) as a length, and will read
128 bytes from the EEPROM, 34 of which will fill the data buffer, and 94
will overflow. Providing I know how the kernel works, these 94 bytes
could be used for doing presumably bad things.

This illustrates the fact that the user may actually control the buffer
overflow, indirectly, depending on what hardware is present on the bus.
EEPROMs are the most obvious way to do it, but some hardware monitoring
chips have RAM arrays that could presumably be used in a similar way.

As a conclusion, I definitely agree that this buffer overflow isn't easy
to exploit, as it takes a particular combination of hardware and
non-standard permissions on i2c device files, and also requires very
good knowledge of the I2C and SMBus protocols; it is not impossible
though.


Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-viapro.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	2005-02-03 09:34:40 -08:00
+++ b/drivers/i2c/busses/i2c-viapro.c	2005-02-03 09:34:40 -08:00
@@ -233,8 +233,8 @@
 			len = data->block[0];
 			if (len < 0)
 				len = 0;
-			if (len > 32)
-				len = 32;
+			if (len > I2C_SMBUS_BLOCK_MAX)
+				len = I2C_SMBUS_BLOCK_MAX;
 			outb_p(len, SMBHSTDAT0);
 			i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 			for (i = 1; i <= len; i++)
@@ -268,6 +268,8 @@
 		break;
 	case VT596_BLOCK_DATA:
 		data->block[0] = inb_p(SMBHSTDAT0);
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
+			data->block[0] = I2C_SMBUS_BLOCK_MAX;
 		i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 		for (i = 1; i <= data->block[0]; i++)
 			data->block[i] = inb_p(SMBBLKDAT);

