Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261975AbTCZTXV>; Wed, 26 Mar 2003 14:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261979AbTCZTXV>; Wed, 26 Mar 2003 14:23:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12811 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261975AbTCZTXR>; Wed, 26 Mar 2003 14:23:17 -0500
Date: Wed, 26 Mar 2003 19:34:27 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [BK PULL] PCMCIA changes
Message-ID: <20030326193427.B8871@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull bk://bk.arm.linux.org.uk/linux-2.5-pcmcia

to include PCMCIA changes listed below.  Patches for each cset will
follow on LKML.

Please note that I haven't been able to thoroughly test just these
patches as a stand alone set since yenta.c needs further patches to
make it usable on my ARM Cardbus machine.

A subset of these, from 1.889.359.1 to 1.889.359.7 have been in
2.5.65-mm for a while, along with an additional pcmcia patch.  This
additional patch has been dropped due to reported problems.  Since
we now have the PCI changes in place, 1.889.359.8 is included, which
converts cardbus to use more of the PCI layer.

Also, hch sent me a Makefile cleanup, which appears as the last cset.

The whole patch was sent for the -ac and -mm trees on Monday, but
there haven't been any new -ac trees released, and it seems to have
been missed for -mm, although Alan says: "mae darnau pcmcia edrych
iawn / the pcmcia patches look fine".

I am currently receiving a number of requests to get this merged.

This will update the following files:

 drivers/char/pcmcia/synclink_cs.c |    3 
 drivers/isdn/hisax/elsa_cs.c      |    7 
 drivers/isdn/hisax/sedlbauer_cs.c |    7 
 drivers/pci/Makefile              |    3 
 drivers/pcmcia/Kconfig            |    4 
 drivers/pcmcia/Makefile           |   69 ++++-----
 drivers/pcmcia/cardbus.c          |  195 +++++---------------------
 drivers/pcmcia/cistpl.c           |  281 ++++++++++++++++----------------------
 drivers/pcmcia/cs.c               |   36 +---
 drivers/pcmcia/cs_internal.h      |    7 
 drivers/pcmcia/hd64465_ss.c       |   32 ----
 drivers/pcmcia/i82092.c           |   88 -----------
 drivers/pcmcia/i82092aa.h         |    2 
 drivers/pcmcia/i82365.c           |   77 ----------
 drivers/pcmcia/pci_socket.c       |   20 --
 drivers/pcmcia/pci_socket.h       |    2 
 drivers/pcmcia/ricoh.h            |    2 
 drivers/pcmcia/rsrc_mgr.c         |  273 ++++++++++++++++++++++++++----------
 drivers/pcmcia/sa1100_generic.c   |   54 -------
 drivers/pcmcia/tcic.c             |   85 -----------
 drivers/pcmcia/ti113x.h           |    6 
 drivers/pcmcia/yenta.c            |   63 --------
 drivers/scsi/pcmcia/nsp_cs.c      |    3 
 include/pcmcia/bus_ops.h          |  154 --------------------
 include/pcmcia/cs.h               |    1 
 include/pcmcia/ss.h               |    3 
 26 files changed, 416 insertions, 1061 deletions

through these ChangeSets:

<hch@com.rmk.(none)> (03/03/24 1.889.359.9)
	[PCMCIA] drivers/pcmcia/Makefile tidyups
	
	(1) use the builtin foo-$(BAR) mechanism of the 2.5 kbuild
	(2) align all += foo.o statements

<rmk@flint.arm.linux.org.uk> (03/03/23 1.889.359.8)
	[PCMCIA] pcmcia-10: Make cardbus use the new PCI functionality.
	
	Now that we have the critical PCI changes in place, we can convert
	cardbus to use this PCI functionality.  This allows us to scan
	behind PCI to PCI bridges on cardbus cards, and setup the bus
	resources using the generic PCI support code.
	
	Note that drivers/pci/setup-bus.c needs to be built when hotplug
	(ie, cardbus) is enabled.

<rmk@flint.arm.linux.org.uk> (03/03/23 1.889.359.7)
	[PCMCIA] pcmcia-8/9: Clean up CIS setup.
	
	- Re-order functions in cistpl.c.
	- Combine setup_cis_mem and set_cis_map into one function.
	- Move cis_readable(), checksum() and checksum_match() into rsrc_mgr.c
	- Only pass the socket structure to validate_mem()
	- Remove socket_info_t *vs variable, and the race condition along
	  with it.
	- Pass the socket_info_t through validate_mem(), do_mem_probe() and
	  inv_probe() to these functions.
	- Call cis_readable() and checksum_match() directly from
	  do_mem_probe().

<rmk@flint.arm.linux.org.uk> (03/03/22 1.889.359.6)
	[PCMCIA] pcmcia-7: Remove cb_enable() and cb_disable()
	
	Remove support for the old PCMCIA cardbus clients - all cardbus
	drivers should be converted to be full-class PCI citizens.

<rmk@flint.arm.linux.org.uk> (03/03/18 1.889.359.5)
	[PCMCIA] pcmcia-6: s/CONFIG_ISA/CONFIG_PCMCIA_PROBE/
	
	Remove the dependence of the PCMCIA layer on CONFIG_ISA - introduce
	CONFIG_PCMCIA_PROBE to determine whether we need the resource
	handling code.  This prevents oopsen on SA11x0 and similar platforms
	which use statically mapped, non-windowed sockets.

<rmk@flint.arm.linux.org.uk> (03/03/18 1.889.359.4)
	[PCMCIA] pcmcia-5: Add locking to resource manager.
	
	Add an element of locking to the resource manager - don't allow
	the PCMCIA resource lists to be changed while the pcmcia code is
	scanning them.

<rmk@flint.arm.linux.org.uk> (03/03/17 1.889.359.3)
	[PCMCIA] pcmcia-4: introduce SOCKET_CARDBUS_CONFIG
	
	Cardbus uses socket->cb_config to detect when the cardbus card has
	been initialised.  Since cb_config will eventually die, we need a
	solution - introduce the SOCKET_CARDBUS_CONFIG flag, which is set
	once we have initialised the cardbus socket.

<rmk@flint.arm.linux.org.uk> (03/03/17 1.889.359.2)
	[PCMCIA] pcmcia-3: Remove bus_ops abstractions.
	
	Remove bus_* abstractions from PCMCIA core and PCMCIA drivers; they
	are unused.

<rmk@flint.arm.linux.org.uk> (03/03/17 1.889.359.1)
	[PCMCIA] pcmcia-2: Remove get_io_map and get_mem_map socket methods.
	
	get_io_map and get_mem_map PCMCIA socket methods are never called
	by the PCMCIA core code.  They are therefore dead code, and can be
	removed.


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

