Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274279AbRI3XtL>; Sun, 30 Sep 2001 19:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274285AbRI3XtC>; Sun, 30 Sep 2001 19:49:02 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:57631 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274279AbRI3Xso>; Sun, 30 Sep 2001 19:48:44 -0400
From: sduchene@mindspring.com
Date: Sun, 30 Sep 2001 19:49:09 -0400
To: linux-kernel@vger.kernel.org
Subject: PNPBios & lm_sensors don't mix on 440GX w/2.4.9-ac18
Message-ID: <20010930194909.Y14910@lapsony.mydomain.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I updated a system with a Intel 440GX (Lancewood) motherboard to 2.4.9-ac18
and normally I have PNP support turned on. Later I updated to the current i2c and
lm_sensors code and discovered that the PNPBios support allocates IO port 0x1040.
Since the i2c-piix4 wants to use the same port range, this module would not load
on the system. A modprobe of i2c-piix4 resulted in:

test:/usr/local/src/lm_sensors2 # modprobe i2c-piix4
/lib/modules/2.4.9-ac18/kernel/drivers/i2c/i2c-piix4.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.9-ac18/kernel/drivers/i2c/i2c-piix4.o: insmod /lib/modules/2.4.9-ac18/kernel/drivers/i2c/i2c-piix4.o failed
/lib/modules/2.4.9-ac18/kernel/drivers/i2c/i2c-piix4.o: insmod i2c-piix4 failed

Using insmod and force=1 gave:

test:/usr/local/src/lm_sensors2 # insmod /lib/modules/2.4.9-ac18/kernel/drivers/i2c/i2c-piix4.o force=1
/lib/modules/2.4.9-ac18/kernel/drivers/i2c/i2c-piix4.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters

The entry in dmesg for these operations was:

i2c-piix4.o version 2.6.1 (20010830)
i2c-piix4.o: Found PIIX4 device
i2c-piix4.o: SMB region 0x1040 already in use!
i2c-piix4.o: Device not detected, module not inserted.

So I then looked at the /proc/ioports entries:

04d0-04d1 : PNP0401
0c00-0c3f : Intel Corporation 82371AB PIIX4 ACPI
  0c00-0c3f : PNP0401
0ca0-0ca3 : PNP0401
0cb8-0cbf : PNP0401
0cf8-0cff : PCI conf1
1000-103f : PNP0401
1040-105f : Intel Corporation 82371AB PIIX4 ACPI
  1040-104f : PNP0401

When I recompiled the kernel without PNP support altogether the module loaded
just fine and then the ioports entries looked like:

0c00-0c3f : Intel Corporation 82371AB PIIX4 ACPI
0cf8-0cff : PCI conf1
1040-105f : Intel Corporation 82371AB PIIX4 ACPI
  1040-1047 : piix4-smbus

and the dmesg output for the i2c stuff was:

i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-piix4.o version 2.6.1 (20010830)
i2c-piix4.o: Found PIIX4 device
i2c-core.o: adapter SMBus PIIX4 adapter at 1040 registered as adapter 0.
i2c-piix4.o: SMBus detected and initialized
i2c-proc.o version 2.6.1 (20010830)
lm75.o version 2.6.1 (20010830)
i2c-core.o: driver LM75 sensor chip driver registered.
i2c-core.o: client [LM75 chip] registered to adapter [SMBus PIIX4 adapter at 1040](pos. 0).

Not sure if this is expected behavior but thought I would report it here.
-- 
Steven A. DuChene	sad@ale.org
			linux-clusters@mindspring.com
			sduchene@mindspring.com

	http://www.mindspring.com/~sduchene/
