Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277573AbRJRDZH>; Wed, 17 Oct 2001 23:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277576AbRJRDYx>; Wed, 17 Oct 2001 23:24:53 -0400
Received: from patan.Sun.COM ([192.18.98.43]:14064 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S277573AbRJRDYK>;
	Wed, 17 Oct 2001 23:24:10 -0400
Message-ID: <3BCE4AA7.EBF134DC@sun.com>
Date: Wed, 17 Oct 2001 20:21:11 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andre@linux-ide.org
Subject: Re: [PATCH] IDE initialization fix
In-Reply-To: <Pine.LNX.4.10.10110162223350.2087-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> > for chipsets does not get called.  I'll speak specifically about the CSB5.
> > The CSB5 in non-native mode has a PCI irqline register forced to 0.  The
> > PCI probe then skips it's PCI init and it never gets called.


OK!  This is what I have learned.  The ide-pci init code has one case that
isn't caught.  Perhaps you can clarify what it means, for me.

* If an IDE controller has a PCI IRQ and has class code bit 0x5 set, it is
100% native.

* CSB5 _CAN_NOT_ have a PCI IRQ assigned (RO register).

* CSB5 spec clearly indicates that you can turn on class code bits 0x5 for
native mode operation.

* My system has the native mode bits turned on, but not an IRQ.  The driver
incorrectly drops this case into teh "bad irq" case.

* Solution: cleanup probe to something like:

if ((is_storage_ide || is_storage_other) && native_bits && pciirq) {
        /* 100% native mode */
        init_chipset();
} else if ((is_storage_ide || is_storage_other) && native_bits) {
        /* native mode */
        init_chipset();
} else if (is_storage_ide || is_storage_other) {
        /* non-native mode */
        init_chipset();
} else {
        /* what here ?!?! */
}

or simpler:

if (is_storage_ide || is_storage_other) {
	if (native_bits && pciirq) {
		/* 100% native mode */
	} else if (native_bits) {
		/* plain-old native mode */
	} else {
		/* non-native mode */
	}
	init_chipset();
} else {
	/* what here?!? */
}


What do you think of this case?  The other alternative is to turn OFF
native bits on any CSB5, since it can't have a PCI IRQ assigned.

Please let me know, and I'll work up and test a patch.

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
