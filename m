Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbUDQX1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 19:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbUDQX1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 19:27:18 -0400
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:42637
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S264067AbUDQX1O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 19:27:14 -0400
From: "Shawn Starr" <shawn.starr@rogers.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [2.6.6-rc1-bk1][SMBUS/I2C PIIX4] - SMBus hangs during high CPU temperature report - Bug in SMBus driver or buggy hardware (IBM)?
Date: Sat, 17 Apr 2004 19:27:53 -0400
Message-ID: <000001c424d3$9c300a70$0200080a@panic>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [69.196.108.95] using ID <shawn.starr@rogers.com> at Sat, 17 Apr 2004 19:25:55 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After managing to get the lm80 sensor chip working on my IBM 300PL 6892-N2U
machine, I've reached problems with the SMBus hanging and not being able to
reset.

Below is some extra debugging I've added to try and force reset, then kill
the bus but it seems to be ignoring the requests. Is there a particular
reason the i2c-piix4 driver initially disables the SMBus aside from any
possible EEPROM corruption (not observed on this board, different Atmel
chip).

It would be great if someone from IBM could tell me if the SMBus on the
board is buggy. If I do a warm reboot, the bus returns to normal function.
I'm confused as why its not resetting or killing transactions on the bus
(perhaps my code is wrong?)


-- CODE --

        /* Make sure the SMBus host is ready to start transmitting */
        if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
                dev_dbg(&piix4_adapter.dev, "SMBus busy (%02x), "
                        "waiting... \n", temp);
                do {
                        i2c_delay(1);
                        temp = inb_p(SMBHSTSTS);
                        dev_dbg(&piix4_adapter.dev, "SMBus busy: Wait State:
%x\n", temp);
                        if (temp & 0x04) goto reset;

                } while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));

                /* If the SMBus is still busy, try to reset */
                if (timeout >= MAX_TIMEOUT) {
reset:
                        dev_err(&piix4_adapter.dev, "SMBus Timeout! "
                        "Trying to reset...\n");
                        /* outb_p(temp, SMBHSTSTS); */
                        i2c_delay(1);
                        outb_p(inb(SMBHSTSTS) | ~0x01e, SMBHSTSTS);
                        i2c_delay(1);
                        temp = inb_p(SMBHSTSTS);

                        outb_p(inb(SMBHSTCNT) | 0x02, SMBHSTCNT);
                        i2c_delay(1);
                        temp = inb_p(SMBHSTCNT);

                        dev_dbg(&piix4_adapter.dev, "SMBHSTCNT Status\n");
                        dev_dbg(&piix4_adapter.dev, "Status Bits:
KILLED=%x\n", (temp & 0x02 ? 1 : 0));
                        dev_dbg(&piix4_adapter.dev, "Status Bits:
INTERRUPT=%x\n", (temp & 0x01 ? 1 : 0));


Kernel log:

piix4-smbus 0000:00:02.3: Found 0000:00:02.3 device
piix4-smbus 0000:00:02.3: Using Interrupt SMI# for SMBus.
piix4-smbus 0000:00:02.3: SMBREV = 0x0
piix4-smbus 0000:00:02.3: SMBA = 0xFE00
i2c_adapter i2c-17: Registered as minor 17
i2c_adapter i2c-17: registered as adapter #17
i2c-core: driver lm80 registered.
i2c_adapter i2c-17: found normal i2c_range entry for adapter 17, addr 0028
i2c_adapter i2c-17: Transaction (pre): CNT=00, CMD=02, ADD=50, DAT0=01,
DAT1=00
i2c_adapter i2c-17: SMBus busy (01), waiting...
i2c_adapter i2c-17: SMBus busy: Wait State: 1
i2c_adapter i2c-17: SMBus Timeout! Trying to reset...
i2c_adapter i2c-17: SMBus busy: Wait State: 1
i2c_adapter i2c-17: Status Bits: FAILED=0
i2c_adapter i2c-17: Status Bits: COLLISION=0
i2c_adapter i2c-17: Status Bits: ERROR=0
i2c_adapter i2c-17: Status Bits: INTERRUPT=0
i2c_adapter i2c-17: Status Bits: BUSY=1
i2c_adapter i2c-17: piix4-i2c: Attempting to KILL transactions on SMBus!
i2c_adapter i2c-17: SMBHSTCNT Status
i2c_adapter i2c-17: Status Bits: KILLED=1
i2c_adapter i2c-17: Status Bits: INTERRUPT=0

i2c_adapter i2c-17: Status Bits: FAILED=0
i2c_adapter i2c-17: Status Bits: COLLISION=0
i2c_adapter i2c-17: Status Bits: ERROR=0
i2c_adapter i2c-17: Status Bits: INTERRUPT=0
i2c_adapter i2c-17: Status Bits: BUSY=1
i2c_adapter i2c-17: Failed! (01)

