Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVHLGBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVHLGBg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 02:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHLGBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 02:01:35 -0400
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:33034 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932339AbVHLGBf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 02:01:35 -0400
Date: Fri, 12 Aug 2005 08:02:10 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [lm-sensors] I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050812080210.58573fe3.khali@linux-fr.org>
In-Reply-To: <20050812010759.GA11361@jupiter.solarsys.private>
References: <20050809231328.0726537b.khali@linux-fr.org>
	<20050812010759.GA11361@jupiter.solarsys.private>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> > My experimental patch follows. I have enabled the I2C block read
> > function for all VIA south bridges, so that it can be tested on all
> > chips. I'll restrict that after the test phase, of course.
> 
> I fired it up on one of the older chipsets...
> 
> # lspci
> (...)
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 23)
> (...)
> 00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)

Oh, you do have one of these old 596 chips. Interesting. Could you
possibly take a look at the i2c-viapro driver and comment on that part:

	if ((pci_read_config_word(pdev, id->driver_data, &vt596_smba)) ||
	    !(vt596_smba & 0x1)) {
		/* try 2nd address and config reg. for 596 */
		if (id->device == PCI_DEVICE_ID_VIA_82C596_3 &&
		    !pci_read_config_word(pdev, SMBBA2, &vt596_smba) &&
		    (vt596_smba & 0x1)) {
			smb_cf_hstcfg = 0x84;

It looks like a hack to me, and I was wondering if we could clean it up
(possibly by using pci quirks). I've not studied the problem in details
yet, but comments and help would be welcome, and the fact that you do
have a chip for testing will help anyway :)

> As you suspected, it didn't work.
> 
> # i2cdump -y 0 0x50 i
> Error: Block read failed, return code 0

Alright, it matches the datasheet and my expectations.

> I also found something interesting, by accident.  With a stock FC4
> kernel, the i2cdump clocked at 1.02s total.  With 2.6.13-rc6, it took
> 5.11s!  The only relevant difference that I can see is that the FC4
> kernel uses HZ of 1000 while my 2.6.13-rc6 kernel uses 100.  Because
> the i2c-viapro is a polling driver, it becomes slower as HZ decreases.

Absolutely true. This is what improved the speed of most SMBus drivers
in 2.6 when compared with 2.4: HZ=1000. Now we're stepping back a bit
with HZ=250.

> I.e. the improvement you are seeing with byte vs. block xfers is quite
> exaggerated because we poll the device relatively infrequently.  *All*
> the xfers are slower than they could be w/ a non-polling driver.

Oh well, even if we were using interrupts instead of polling, the block
transactions are still better as they are still twice as fast, would
generate less interrupts, and are generally less CPU-intensive. That
being said, I plan to implement interrupts in i2c-viapro at a later
time. I have no idea how to do that, but I'll take a look at what you
did in your i2c-i801 reimplementation, it should help. I simply seem to
remember that you expected problems for block transactions in interrupt
more, and don't know why exactly.

Maybe we can use interrupts for short commands and polling for big
transactions. I see no technical problem doing that - although this
would make the driver larger and more complex.

BTW, it would be great if you could finalize your i2c-i801
reimplementation so that we can add it to Linux 2.6. I remember it gave
me much better performance than the original one, and the code was
looking much nicer as well.

Thanks for the tests :)
-- 
Jean Delvare
