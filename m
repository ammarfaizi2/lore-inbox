Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVBYO22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVBYO22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 09:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVBYO22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 09:28:28 -0500
Received: from aun.it.uu.se ([130.238.12.36]:1457 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262707AbVBYO2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 09:28:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16927.13776.382746.406875@alkaid.it.uu.se>
Date: Fri, 25 Feb 2005 15:27:28 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ppc32 weirdness with gcc-4.0 in 2.6.11-rc4
In-Reply-To: <16926.63745.143566.413488@alkaid.it.uu.se>
References: <16924.59237.581247.498382@alkaid.it.uu.se>
	<1109210688.15027.2.camel@gaston>
	<16925.60927.49095.758660@alkaid.it.uu.se>
	<20050224160139.GF853@devserv.devel.redhat.com>
	<16926.63745.143566.413488@alkaid.it.uu.se>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson writes:
 > Jakub Jelinek writes:
 >  > On Thu, Feb 24, 2005 at 04:08:47PM +0100, Mikael Pettersson wrote:
 >  > > _However_, the 0k data message is due to a gcc-4.0 bug, and below
 >  > > you'll find a test program which illustrates it.
 >  > 
 >  > http://gcc.gnu.org/PR20196
 > 
 > Jakub's patch to gcc4 solved the mysterious "0k data" message,
 > but my eMac's USB is still dysfunctional. I'll try to look into
 > that next week.

CONFIG_USB_DEBUG gave the following dmesg diff between gcc-3.4.3 and 4.0.0:

@@ -118,6 +118,8 @@
 hub 1-0:1.0: Single TT
 hub 1-0:1.0: TT requires at most 8 FS bit times
 hub 1-0:1.0: power on to power good time: 20ms
+hub 1-0:1.0: hub controller current requirement: 0mA
+hub 1-0:1.0: 500mA bus power budget for children
 hub 1-0:1.0: local power source is good
 hub 1-0:1.0: enabling power on all ports
 ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)

There are several more of these diffs, and they are what's eventually
causing USB to label the hub as bus-powered and refuse to connect it.

The root problem is that code like:
    get_status(..., &status);
    cpu_to_le16s(&status);
    if ((status & (1 << BITNO)) == 0) { ... }
gets miscompiled so that the if statement triggers when it shouldn't.

Below is a standalone test program which reproduces the bug.
It does involve some PPC-specific asm(), so the bug may be
in gcc-4.0.0 or it may be in the asm() constraints.

/Mikael

/* gcc4bug2.c
 * Written by Mikael Pettersson <mikpe@csd.uu.se>, 2005-02-25.
 *
 * This program is abstracted from drivers/usb/core/hub.c in
 * the 2.6.11-rc5 Linux kernel sources.
 *
 * With gcc-3.4.3, gcc-3.3.5, or gcc-3.2.3, usb_configure()
 * correctly returns 0.
 *
 * With gcc-4.0.0 20050220, usb_configure() erroneously returns 1.
 * The error occurs at -O1 and higher. -O0 hides the error.
 *
 * All gcc versions were configured for powerpc-unknown-linux-gnu.
 */
#include <stdio.h>

extern __inline__ __attribute__((always_inline))
void st_le16(volatile unsigned short *addr, const unsigned val)
{
    __asm__ __volatile__ ("sthbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
}

static __inline__ __attribute__((always_inline))
void swab16s(unsigned short *addr)
{
    st_le16(addr, *addr);
}

unsigned short raw_hubstatus;

void usb_get_status(unsigned short *hubstatusp)
{
    *hubstatusp = raw_hubstatus;
}

int usb_configure(void)
{
    unsigned short hubstatus;

    usb_get_status(&hubstatus);
    swab16s(&hubstatus);
    return (hubstatus & 1) == 0;
}

int main(void)
{
    int ret;

    raw_hubstatus = 0x0300;
    ret = usb_configure();
    if (ret) {
	fprintf(stderr, "gcc bug! usb_configure() returned %d\n", ret);
	return 1;
    } else
	return 0;
}
