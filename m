Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbUJaRvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUJaRvx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 12:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUJaRvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 12:51:53 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:781 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261386AbUJaRvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 12:51:18 -0500
Date: Sun, 31 Oct 2004 17:51:14 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Serial updates
Message-ID: <20041031175114.B17342@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's a major serial update.  Items covered in this update:

- unuse register_serial/unregister_serial.
  Instead, please use serial8250_register_port() and
  serial8250_unregister_port() to talk to the 8250 driver.

  The old interfaces have several restrictions:
  1. do not allow the struct device associated with a port to be known
     to the tty layer.
  2. have various restrictions on the size of IO addresses (see the
     HIGH_BITS_OFFSET stuff - which incidentally 8250_pnp got wrong.)

- provide a mechanism for 8250 platform ports to be dynamically
  registered.  We do this via platform devices - either one or
  multiple platform devices.  You can have none, one, or as many
  as you desire.  8250.c couldn't care.

- any ports listed in include/asm-*/serial.h will still be
  intialised in preference to platform device based ports for the
  time being.  It is intended that everyone will move to using
  the platform device method.

- this means that CONFIG_SERIAL_8250_NR_UARTS slightly changes
  definition.  It is the number of _extra_ ports above those in
  include/asm-*/serial.h that 8250.h will support.  If you have
  removed all ports from include/asm-*/serial.h, then it is
  obviously the total number of ports that 8250.c will support,
  and you need to make sure that it's large enough for your
  platform.

- ppc64 broke in this merge.  That's expected because I backed out
  benh's changes to the serial drivers.  A "get you working again"
  patch is with benh as of last night pending his attention.

The patch is about 50K, so won't fit through lkml, and is available
here instead:

  http://www.arm.linux.org.uk/~rmk/misc/linus-serial.diff

People who should test this patch as a minimum:

 - ia64 people (ACPI port discovery)
 - parisc people (GSC port discovery)
 - pnp using people

Once this lot is in, I'll be following up with a set of patches which
removes the serial device tables in include/asm-arm/arch-*/serial.h.

Diffstat and changeset log follow:

 drivers/serial/8250.c        |  371 +++++++++++++++++++++++--------------------
 drivers/serial/8250.h        |   74 ++++++++
 drivers/serial/8250_acorn.c  |   60 +++---
 drivers/serial/8250_acpi.c   |   74 +++-----
 drivers/serial/8250_pci.c    |    6 
 drivers/serial/8250_pnp.c    |   34 +--
 drivers/serial/au1x00_uart.c |   17 -
 drivers/serial/serial_core.c |   83 +--------
 drivers/serial/serial_cs.c   |   28 +--
 include/linux/8250.h         |   75 --------
 include/linux/serial_8250.h  |   28 +++
 include/linux/serial_core.h  |   10 -
 12 files changed, 420 insertions(+), 440 deletions(-)

through these ChangeSets:

<rmk@flint.arm.linux.org.uk> (04/10/31 1.2354)
	[SERIAL] Fix deadlock on removal of 8250 module.
	
	We must unregister all serial ports before driver_unregister()
	can complete.  This means that we must unregister all ports in
	serial8250_remove, including our legacy ISA ports.  We flag this
	special cleanup operation by setting serial8250_isa_devs to NULL
	and not handling our own platform device any differently from
	any others.

<rmk@flint.arm.linux.org.uk> (04/10/31 1.2353)
	[SERIAL] Don't detect console availability using port->ops.
	
	Use !iobase && !membase rather than !ops for console port
	availability.

<rmk@flint.arm.linux.org.uk> (04/10/31 1.2352)
	[SERIAL] 8250_acpi: Convert to use serial8250_{un,}register_port.

<rmk@flint.arm.linux.org.uk> (04/10/31 1.2351)
	[SERIAL] Don't use UPF_AUTOPROBE, fix two build problems.
	
	The curse of the missing __devexit_p() returns, and asm-*/ obviously
	marks the end of the comment.

<rmk@flint.arm.linux.org.uk> (04/10/31 1.2350)
	[SERIAL] 8250_pnp: Convert to use serial8250_{un,}register_port.

<rmk@flint.arm.linux.org.uk> (04/10/31 1.2349)
	[SERIAL] serial_cs: Convert to use serial8250_{un,}register_port.

<rmk@flint.arm.linux.org.uk> (04/10/31 1.2348)
	[SERIAL] 8250: Warn when ports with zero base_baud are registered.

<rmk@flint.arm.linux.org.uk> (04/10/31 1.2347)
	[SERIAL] 8250_acorn: Convert to use serial8250_{un,}register_port.

<rmk@flint.arm.linux.org.uk> (04/10/30 1.2345)
	[SERIAL] Undo "get_legacy_serial_ports" patch for PPC.
	
	This patch conflicts with work to properly integrate the device model
	into the serial layer, and provide architectures with a *clean* way
	to tell 8250.c about their serial ports at run time.

<rmk@flint.arm.linux.org.uk> (04/10/30 1.2026.4.8)
	[SERIAL] 8250: prevent ports with zero clocks being registered.

<rmk@flint.arm.linux.org.uk> (04/10/30 1.2026.4.7)
	[SERIAL] 8250: add probe and remove device driver methods.
	
	This change allows platform devices named "serial8250" to provide
	lists of serial ports to the 8250 driver at runtime, in addition to
	the hard coded table in include/asm-*/serial.h.
	
	The next step is to deprecate the tables in serial.h.

<rmk@flint.arm.linux.org.uk> (04/10/30 1.2026.4.6)
	[SERIAL] 8250: Add platform device for ISA 8250-compatible devices.
	
	Add a platform device for ISA 8250-compatible serial devices listed
	in the table in include/asm-*/serial.h.  Arrange for unregistered
	serial devices to be owned by this device.
	
	This enables power management for ISA 8250 devices, and starts to
	opens the way for architectures to dynamically provide their own
	lists of 8250 devices via platform device(s).

<rmk@flint.arm.linux.org.uk> (04/10/30 1.2026.4.5)
	[SERIAL] Re-order 8250 serial driver initialisation/finalisation.
	
	Only register the 8250 serial driver with the device model after
	registering and setting up our internal uart ports.  Do the reverse
	on module finalisation.

<rmk@flint.arm.linux.org.uk> (04/10/30 1.2026.4.4)
	[SERIAL] 8250: move basic initialisation of 8250 ports.
	
	This moves the basic initialisation of 8250 ports from
	serial8250_register_ports() into serial8250_isa_init_ports()

<rmk@flint.arm.linux.org.uk> (04/10/30 1.2026.4.3)
	[SERIAL] 8250: Fix resource handling.
	
	serial8250_request_std_resource() is now responsible for claiming
	the standard resources, _and_ calling ioremap if necessary.
	serial8250_release_std_resource() performs the complementary function
	in its entirety.
	serial8250_*_rsa_resource() perform the similar operations for RSA
	ports, with the exception that RSA ports can only be mapped into IO
	space.

<rmk@flint.arm.linux.org.uk> (04/10/30 1.2026.4.2)
	[SERIAL] Clean up serial_core.c write functions.
	
	Since the tty layer now takes care of user space writes,
	__uart_user_write() and associated temporary buffer and temporary
	buffer semaphore have all become unnecessary.  There's also little
	point in having __uart_kern_write() separate from uart_write(), so
	combine the two together.
	
	Adrian Bunk kindly provided the patch to remove __uart_user_write().
	The rest of the work is rmk's.
	
	Signed-off-by: Adrian Bunk
	Signed-off-by: Russell King <rmk@arm.linux.org.uk>

<arjan@nl.rmk.(none)> (04/10/24 1.2026.4.1)
	[SERIAL] Remove dead code.
	
	serial8250_get_irq_map is no longer used anywhere in the kernel (it
	used to be used by the isapnp code but isn't anymore) so it's dead
	code, below is a patch to remove this.



-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
