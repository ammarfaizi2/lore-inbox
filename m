Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTDVAHU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 20:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbTDVAHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 20:07:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60172 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262763AbTDVAHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 20:07:18 -0400
Date: Tue, 22 Apr 2003 01:19:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCMCIA updates
Message-ID: <20030422011920.D30774@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A request for Linus to pull a set of PCMCIA changes has been made.  You
can get the patch from:

  http://patches.arm.linux.org.uk/pcmcia-20030421.diff

Much of this stuff has been aired on the linux-pcmcia list (iirc care of
lists.infradead.org)

This will update the following files:

 drivers/net/wireless/orinoco_cs.c |    1 
 drivers/pcmcia/cs.c               |  827 +++++++++++++++++++++++++++-----------
 drivers/pcmcia/cs_internal.h      |   18 
 drivers/pcmcia/rsrc_mgr.c         |   20 
 include/pcmcia/bus_ops.h          |    2 
 include/pcmcia/driver_ops.h       |    2 
 include/pcmcia/ds.h               |    2 
 7 files changed, 617 insertions, 255 deletions

through these ChangeSets:

<proski@org.rmk.(none)> (03/04/21 1.1122)
	[PCMCIA] validate_mem uses uninitialized memory.
	
	Patch from Pavel Roskin.
	
	If I compile a recent 2.5.x kernel without CONFIG_ISA defined, I get
	an oops in validate_mem().  Stack trace contains 0x6b6b6b6 - a clear
	sign that freed memory is being accessed.
	
	It's the second validate_mem() in drivers/pcmcia/rsrc_mgr.c - the one
	used when CONFIG_PCMCIA_PROBE is not defined.  It turns out the memory
	is freed in do_mem_probe() when it's called from validate_mem().
	
	The solution is to use the same trick as in the first validate_mem().
	This problem is quite serious and it's not specific to the plx9052
	driver.  I see it with yenta_socket as well.

<linux@de.rmk.(none)> (03/04/19 1.1121)
	[PCMCIA] remove unused files [Christoph Hellwig]
	
	From Christoph Hellwig
	
	There's no need to keep the stubs around.

<linux@de.rmk.(none)> (03/04/19 1.1120)
	[PCMCIA] Fix compilation of cardmgr [Pavel Roskin]
	
	From Pavel Roskin
	
	ds.h should not be including linux/device.h when compiling userspace
	code.

<rmk@flint.arm.linux.org.uk> (03/04/19 1.1119)
	[PCMCIA] Bring in PCMCIA work queue and state machine.
	
	This cset fixes the boot-time deadlock which occurs when a Cardbus
	card is inserted.  The deadlock occurs because:
	
	- the ds module is inserted
	- ds registers a driver model interface for pcmcia socket drivers,
	  which takes the global devclass_sem.
	- ds causes the pcmcia core to evaluate the status of the sockets,
	  and perform "card insertion" processing if cards are present.
	- this processing detects a cardbus card, and calls the cardbus code
	  to scan pci devices, and add them to the device tree.
	- each device gets passed to the device model's class layer, which
	  tries to take devclass_sem.  However, we locked it while
	  initialising the ds module -> deadlock.
	
	We fix this by making the card insertion/removal asynchronous to the
	initialisation thread by using a work queue.  However, since we will
	be calling drivers, which may want to use workqueue services, we
	need to use a separate workqueue.
	
	We also bring in a state machine to handle the card insertion,
	removal, suspend and reset code.  This ensures that two operations
	can not run against a single socket at the same time.
	
	Unfortunately, the workqueue model has an annoying feature which
	causes it to we spawn N threads, one for each CPU in the system,
	when we create our work queue.  This is rather overkill.


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

