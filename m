Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315091AbSFOCo6>; Fri, 14 Jun 2002 22:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSFOCo5>; Fri, 14 Jun 2002 22:44:57 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:53914 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314929AbSFOCo4>;
	Fri, 14 Jun 2002 22:44:56 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15626.43392.825029.986506@argo.ozlabs.ibm.com>
Date: Sat, 15 Jun 2002 12:42:08 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
        Subject:Re:2.5.20@samba.org, -@samba.org, Xircom@samba.org,
        PCI@samba.org, Cardbus@samba.org, doesn't@samba.org, work@samba.org
In-Reply-To: <Pine.LNX.4.44.0206141134210.872-100000@home.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> > Unknown bridge resource 0: assuming transparent
> > Unknown bridge resource 1: assuming transparent
> > Unknown bridge resource 2: assuming transparent
> 
> This is the problem.

BTW, this "assuming transparent" bit continually causes us problems on
RS/6000 machines that have a PCI-PCI bus.  If none of the cards behind
the bridge have any I/O resources, the firmware will set up the bridge
with the I/O window closed, by setting the base register to one more
than the limit register, which is correct according to the Intel
document describing PCI-PCI bridges.

Then the bridge probing code comes along and says "assuming
transparent", which is wrong.  The aperture is closed and the bridge
should have no I/O space resource.

I would really like the relevant code in pci_read_bridge_bases to look
like this:

	if ((base || limit) && base <= limit) {
		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
		res->start = base;
		res->end = limit + 0xfff;
		res->name = child->name;
	} else if (base == limit + 0x1000) {
		/* Firmware/BIOS has deactivated this window */
		res->start = res->end = 0;
		res->flags = 0;
		printk(KERN_ERR "Bridge %s resource %d was deactivated by"
		       " firmware\n", dev->slot_name, 0);
	} else {
		/*
		 * Ugh. We don't know enough about this bridge. Just assume
		 * that it's entirely transparent.
		 */
		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 0);
		child->resource[0] = child->parent->resource[0];
	}

The (base || limit) part instead of just testing base is needed
because we sometimes get PCI-PCI bridges that are legitimately set up
with the bridge having an aperture starting at I/O address 0.

IIRC someone told me that we had to do the "assuming transparent" bit
because of buggy PCI-PCI bridges used on some PCs.  Can anyone
enlighten me on the details of that?

Paul.
