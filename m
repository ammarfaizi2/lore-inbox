Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265882AbTIJWeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 18:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265830AbTIJWdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 18:33:11 -0400
Received: from port-212-202-40-6.reverse.qsc.de ([212.202.40.6]:1920 "EHLO
	schillernet.dyndns.org") by vger.kernel.org with ESMTP
	id S265883AbTIJW02 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 18:26:28 -0400
Date: Wed, 10 Sep 2003 22:26:20 +0000 (UTC)
Message-Id: <20030910.222620.730549923.rene.rebe@gmx.net>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: dmasound_pmac (2.4.x{,-benh}) does not restore mixer during
 PM-wake
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <1063221565.678.2.camel@gaston>
References: <20030910.211509.184824199.rene.rebe@gmx.net>
	<1063221565.678.2.camel@gaston>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Wed, 10 Sep 2003 21:19:25 +0200,
    Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > The code in tas3004_leave_sleep() looks ok so ... any idea (maybe I
> > need to add a printk do test if it is really called?)?
> 
> Either that or we need some delay after powering the chip back
> up and before we can write to its mixer ?

Ok, here we go:

...
PCI: Enabling bus mastering for device 10:18.0
host/usb-ohci.c: USB continue: usb-10:18.0 from host wakeup
PCI: Enabling bus mastering for device 10:19.0
host/usb-ohci.c: USB continue: usb-10:19.0 from host wakeup
eth0: resuming
adb: starting probe task...
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
ADB mouse at 3, handler set to 4 (trackpad)
adb: finished probe task...
RxR: 1
RxR: 2
tas: I2C byte write failed
udio jack plugged, muting speakers.
eth0: Link is up at 100 Mbps, half-duplex.
...
#
(I overread the "tas: I2C byte write failed" before ...)

Where I instrumented the code with:

static int
tas3004_leave_sleep(struct tas3004_data_t *self)
{
        unsigned char mcr = (1<<6)+(2<<4)+(2<<2);

        printk("RxR: 1\n");

        if (!self)
                return -1;

        printk("RxR: 2\n");

        /* Make sure something answers on the i2c bus */
        if (tas3004_write_register(self, TAS3004_REG_MCR, &mcr,
            WRITE_NORMAL | FORCE_WRITE) < 0)
                return -1;

        printk("RxR: 3\n");

so hm?!? - is the wakeup order of the devices incorrect (i2c needs to
be before damsound_pmac ...)?

> ben.

Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene.rebe@gmx.net
http://www.rocklinux.org http://www.rocklinux.net/people/rene
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene

