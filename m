Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130202AbRCCBGq>; Fri, 2 Mar 2001 20:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130206AbRCCBG1>; Fri, 2 Mar 2001 20:06:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54405 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S130202AbRCCBGW>;
	Fri, 2 Mar 2001 20:06:22 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15008.17278.154154.210086@pizda.ninka.net>
Date: Fri, 2 Mar 2001 17:06:06 -0800 (PST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>, <linux-kernel@vger.kernel.org>
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <19350125045212.2780@mailhost.mipsys.com>
In-Reply-To: <15006.44863.375642.847562@pizda.ninka.net>
	<19350125045212.2780@mailhost.mipsys.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt writes:
 > What I call ISA IOs here doesn't necessarily mean there's an ISA bridge
 > on the PCI.

Ok.

 > On PPC, we don't have an "IO" space neither, all we have is a range of
 > memory addresses that will cause IO cycles to happen on the PCI bus.

This is precisely what the "next MMAP is XXX space" ioctl I've
suggested is for.  I think I've addressed this concern in my
proposal already.  Look:

	fd = open("/proc/bus/pci/${BUS}/${DEV}", ...);
	if (fd < 0)
		return -errno;
	err = ioctl(fd, PCI_MMAP_IO, 0);
	if (err < 0) {
		close(fd);
		return -errno;
	}
	ptr = mmap(NULL, pdev->bar[3].size, PROT_READ | PROT_WRITE,
		   MAP_PRIVATE, fd, pdev->bar[3].start);

Something like that.

 > Without that, we need to create new versions of inb/outb that take a bus
 > number.

No, don't do this, it is evil.  Use mappings, specify the device
related info somehow when creating the mapping (in the userspace
variant you do this by openning a specific device to mmap, in the
kernel variant you can encode the bus/dev/etc. info in the device's
resource and decode this at ioremap() time, see?).

Later,
David S. Miller
davem@redhat.com

