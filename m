Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbSIWVXB>; Mon, 23 Sep 2002 17:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbSIWVXA>; Mon, 23 Sep 2002 17:23:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59665 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261392AbSIWVW7>;
	Mon, 23 Sep 2002 17:22:59 -0400
Message-ID: <3D8F874B.3070301@mandrakesoft.com>
Date: Mon, 23 Sep 2002 17:27:39 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Quick aic7xxx bug hunt...
References: <20020923180017.GA16270@sexmachine.doom> <2539730816.1032808544@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:
> On some motherboards with some chipsets, you can get these messages if
> another busmaster (say an IDE drive or a sound card) is hogging the bus.
> Usually this is with a VIA chipset.  Its not clear why the aic7xxx_old
> driver would behave differently other than it disables memory write
> and invalidate PCI transactions on this chip.  The new driver doesn't
> need that work around.


Justin,

One thing I notice is at least one PCI posting bug.  When using MMIO 
(write[bwlq] under Linux), you _must_ use a read[bwlq] to flush the 
write to PCI, if you wish to ensure the write posts at a certain point 
in the code.

Here is the example PCI posting bug, in ahc_clear_critical_section:
>                 ahc_outb(ahc, HCNTRL, ahc->unpause);
>                 do {
>                         ahc_delay(200);
>                 } while (!ahc_is_paused(ahc));

As you can see, there is no read before the udelay(), which is very 
wrong on modern CPUs with write posting...  that's definitely a driver 
bug that will bite you on modern x86 motherboards [and is totally broken 
on ia64 and other platforms].

Please let me know if you have further questions on PCI write posting...

	Jeff



