Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbUKHQoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbUKHQoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 11:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUKHQn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:43:58 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:53774 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261855AbUKHPIf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 10:08:35 -0500
Date: Mon, 8 Nov 2004 16:02:36 +0100 (CET)
To: jpiszcz@lucidpixels.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 & adm1021 & i2c_piix4 temperature monitoring
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <UfARNKk2.1099926156.4923140.khali@gcu.info>
In-Reply-To: <Pine.LNX.4.61.0411080907500.10502@p500>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: sensors@Stimpy.netroedge.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Justin,

>I am monitoring the temperature sensors on my Dell GX1 box, and I get the
>following in dmesg:
>
>i2c_adapter i2c-0: Failed! (01)
>i2c_adapter i2c-0: Failed! (01)
>i2c_adapter i2c-0: Failed! (01)
>i2c_adapter i2c-0: Failed reset at end of transaction (01)
>i2c_adapter i2c-0: Failed! (01)
>i2c_adapter i2c-0: Failed! (01)
>i2c_adapter i2c-0: Failed! (01)
>i2c_adapter i2c-0: Failed! (01)
>i2c_adapter i2c-0: Failed reset at end of transaction (01)
>i2c_adapter i2c-0: Failed! (01)
>i2c_adapter i2c-0: Failed! (01)
>i2c_adapter i2c-0: Failed! (01)
>i2c_adapter i2c-0: Failed! (01)

First note that Dell systems are well known for their improperly
configured SMBus devices.

>Of course the ``secret'' to getting the temperature sensors to work on a
>Dell is two options when loading the i2c driver and the adm1024 driver.

I guess you really mean adm1021 here?

>   TYPE="/sbin/modprobe"
>
>   $TYPE i2c_piix4 force=1
>   $TYPE adm1021 read_only=1
>
>The force is required to enable it, otherwise I do not believe it even
>loads.

True, because Dell's BIOS won't configure it.

As noted in lm_sensors' documentation here:
  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/busses/i2c-piix4
you should be careful when using this option.

One possible cause for the trouble you experience would be that the
piix4's address happens to conflict with another device address on your
system. The driver should have complained if it were the case, but only
if the other device has a Linux driver. If, say, this is an I/O address
range the BIOS uses on its own, the i2c-piix4 driver may not know about
this. You can use "i2cdetect -l" (or browse /sys) to find out the
address the PIIX4 is using, as it shows in the I2C bus name.

One thing you could try would be to use the force_addr parameter of the
i2c-piix4 driver. As noted in the documentation, this is DANGEROUS so
you better be extremely careful if you do. Basically, you would force
the address to a supposedly unused address (check /proc/ioports for
ranges to NOT use). Address must be a multiple of 16.

Maybe you'll have better results when using this, maybe not. Please let
us know. Be warned that using an improper address may cause SEVERE
DAMAGE, and that there is unfortunately no way to know which addresses
are suitable.

See this thread:
  http://archives.andrew.net.au/lm-sensors/msg21973.html
Now, what you want to risk is left to you.

This post:
  https://bugzilla.redhat.com/bugzilla/long_list.cgi?buglist=73730
suggests that 0x6000 MIGHT be a good candidate.

BTW, you really should first try:
1* Upgrading BIOSes if possible.
2* Contacting Dell about the problem. This is really a BIOS issue, we may
try to work around it in the kernel but this is not where the original
problem lies.

>The read_only=1 is so it does not change the temperature range in the
>monitoring chip, if read_only=1 is not set and the machine gets hot, say
>from compiling the kernel, the machine shuts itself off.

This is theoretically not necessary anymore since Linux kernel 2.6.6
(where adm1021 chip init was reworked). Could you please try without it
and let us know how it goes?

As a side note, I think that we should get rid of that "read_only"
module parameter. It makes the code more complex with no obvious benefit
(assuming you'll confirm that you don't need it anymore). No other
hardware monitoring chip driver has this.

>My question is, why all the failed transactions?
>I graph the temperature without any issues (system and CPU) but I still
>get some of these in dmesg, any ideas?

I doubt that you really have no issue. Reads fail when you have a
"Failed! (01)" error. Since the adm1021 driver doesn't handle that
kind of error, this should result in bogus temperature readings
(typically -1).

Thanks,
--
Jean Delvare
