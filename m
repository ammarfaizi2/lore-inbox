Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262408AbVAZJWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262408AbVAZJWw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 04:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbVAZJWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 04:22:52 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:48586 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262410AbVAZJWa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 04:22:30 -0500
Date: Wed, 26 Jan 2005 10:17:27 +0100 (CET)
To: greg@kroah.com, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] I2C: Prevent buffer overflow on SMBus block read in i2c-viapro
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <btE2IXvS.1106731047.5606340.khali@localhost>
In-Reply-To: <20050125224258.GA18228@kroah.com>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Linus Torvalds" <torvalds@osdl.org>, "Sergey Vlasov" <vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg, all,

> Hm, all distros leave the i2c-dev /dev nodes writable only by root, so
> this isn't that "big" of an issue.

Agreed. Non-root write access to these devices would probably be a
security issue per se anyway, buffer overflow or not. However, I can't
tell if e.g. some embedded systems wouldn't set a particular group on
these device files and allow write access to this group, so as to allow
some daemon to write data to an EEPROM or something similar. This is why
I thought I better warn and push the patch upstream. I wasn't exactly
requesting 2.6.10.1 to be released ;)

On second thought, I doubt that embedded designs would rely on a VIA Pro
chip anyway. But you never know.

> > @@ -268,6 +268,8 @@
> >  		break;
> >  	case VT596_BLOCK_DATA:
> >  		data->block[0] = inb_p(SMBHSTDAT0);
> > +		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
> > +			data->block[0] = I2C_SMBUS_BLOCK_MAX;
>
> But data->block[0] just came from the hardware, right?  Not from a user.

True, except that with a write access to the device file and depending on
the client chip, the user might have just programmed the chip for it to
answer with this specific value. See right below.

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
<- length byte (1 <= N <= 32)
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

Thanks,
--
Jean Delvare
