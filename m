Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbTA0KbZ>; Mon, 27 Jan 2003 05:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbTA0KbZ>; Mon, 27 Jan 2003 05:31:25 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:35596 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S267083AbTA0KbY>; Mon, 27 Jan 2003 05:31:24 -0500
Date: Mon, 27 Jan 2003 13:40:10 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Martin Mares <mj@ucw.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, geert@linux-m68k.org,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
Message-ID: <20030127134010.C2569@jurassic.park.msu.ru>
References: <20030126181326.A799@localhost.park.msu.ru> <20030126214550.GB6873@ucw.cz> <1043624458.2755.37.camel@zion.wanadoo.fr> <20030127094645.GD604@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030127094645.GD604@ucw.cz>; from mj@ucw.cz on Mon, Jan 27, 2003 at 10:46:45AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 10:46:45AM +0100, Martin Mares wrote:
> > What about some kind of ioport_remap() that would take a pci_bus and an
> > port range as arguments ? If pci_bus is NULL, that would match a
> > "legacy" ISA bus (non-PCI machine or default ISA bus for machines where
> > that makes sense).
> > 
> > What do you think ?
> 
> Looks good, but maybe we should use some other functions than iob() et al.
> to do I/O on the remapped addresses.

What about this (what we'd have on alpha):

int
legacy_ioport_remap(struct resource *res)
{
	switch (res->start) {
	case 0x3c0:	/* VGA */
		res->start += pci_vga_hose->io_space->start;
		res->end += pci_vga_hose->io_space->start;
	case ???
		...
	default:
		return -ENODEV;
	}
	return request_resource(pci_vga_hose->io_space, res);
}

void
legacy_ioport_unmap(struct resource *res)
{
	release_resource(res);
}

Then vgacon.c would be changed like this:

...
-	request_resource(&ioport_resource, &vga_console_resource);
+	if (legacy_ioport_remap(&vga_console_resource) < 0)
+		goto failure;
...

And all in/out port calls would use respective resource.start+offset:
...
-	outb_p(6, 0x3ce)
+	outb_p(6, vga_console_resource.start + 0xe);

No need for other special IO functions then.

Ivan.
