Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbTI0Lzc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 07:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTI0Lzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 07:55:32 -0400
Received: from havoc.gtf.org ([63.247.75.124]:35471 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262425AbTI0Lz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 07:55:26 -0400
Date: Sat, 27 Sep 2003 07:55:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.6.x net driver updates
Message-ID: <20030927115525.GA26903@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix the build.  Only thing left not building is g_ncr5380...



Linus, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5

This will update the following files:

 drivers/usb/net/Makefile.mii      |    6 
 drivers/net/Kconfig               |   11 
 drivers/net/Makefile              |   28 --
 drivers/net/e100/e100.h           |    1 
 drivers/net/e100/e100_config.c    |    2 
 drivers/net/e100/e100_config.h    |    1 
 drivers/net/e100/e100_main.c      |   49 +---
 drivers/net/e1000/e1000.h         |    8 
 drivers/net/e1000/e1000_ethtool.c |   14 -
 drivers/net/e1000/e1000_hw.c      |   39 +--
 drivers/net/e1000/e1000_hw.h      |    2 
 drivers/net/e1000/e1000_main.c    |   90 ++++---
 drivers/net/e1000/e1000_osdep.h   |    2 
 drivers/net/hamradio/baycom_epp.c |    4 
 drivers/net/pcmcia/Kconfig        |    1 
 drivers/net/pcmcia/smc91c92_cs.c  |    8 
 drivers/net/sk98lin/skdim.c       |    5 
 drivers/net/sk98lin/skge.c        |  103 +++-----
 drivers/net/sk98lin/skproc.c      |  463 ++++++++++++++++----------------------
 drivers/net/tulip/Kconfig         |    1 
 drivers/net/wan/sealevel.c        |   36 +-
 drivers/net/wan/z85230.c          |   58 ++--
 drivers/net/wireless/orinoco.c    |    4 
 drivers/usb/net/Kconfig           |    2 
 24 files changed, 447 insertions(+), 491 deletions(-)

through these ChangeSets:

<bunk@fs.tum.de> (03/09/27 1.1371)
   [PATCH] select MII
   
   The patch below switches MII to be select'ed instead of including it in
   the Makefile.
   
   Note that this patch requires a recent Linus' tree with the select CRC32
   patch included.
   
   diffstat output:
   
    drivers/net/Kconfig          |   11 +++++++++++
    drivers/net/Makefile         |   28 +++++++++++-----------------
    drivers/net/pcmcia/Kconfig   |    1 +
    drivers/net/tulip/Kconfig    |    1 +
    drivers/usb/net/Kconfig      |    2 ++
    drivers/usb/net/Makefile.mii |    6 ------
    6 files changed, 26 insertions(+), 23 deletions(-)
   
   
   Tangential to the patch I observed a small problem (not fixed in the patch):
   MII depends on NET_ETHERNET, but USB_PEGASUS and USB_USBNET depend
   only on NET.
   
   cu
   Adrian

<shemminger@osdl.org> (03/09/27 1.1370)
   [PATCH] wan/z8530 deadlocks
   
   Existing code for drivers/net/wan/z8530 is riddled with self-deadlocks
   and irq flag confusion.  For example:
   	z8530_init -> do_z8530_init -> write_zsreg
   self deadlocks on the channel lock.
   
   Several places acquire both the channel and dma lock and then
   reuse the same irq flags variable - ouch.
   
   This code at least, correctly probes (for no device case) on SMP.
   Other paths verified by inspection.

<shemminger@osdl.org> (03/09/27 1.1369)
   [PATCH] sealevel -- syncppp startup fix
   
   The sealevel driver called sppp_attach before checking that board existed
   and never called detach in the error path.
   
   My change is to call sppp_attach from the netdev->init hook which happens
   later in the process, and call detach from the uninit hook.
   
   Also, changed the structure element 'netdev' to 'pppdev' to avoid confusion.
   
   Here is the fix against 2.6.0-test5 latest

<komujun@nifty.com> (03/09/27 1.1368)
   [netdrvr smc91c92_cs] select proper bank for MII registers

<komujun@nifty.com> (03/09/27 1.1367)
   [netdrvr] build fixes
   
   For e1000 and baycom_epp.
   
   Contributed by Jeff Garzik.

<rddunlap@osdl.org> (03/09/27 1.1366)
   [PATCH] janitor: e100: cleanup #includes
   
   Hi,
   Please apply to 2.6.0-test5-current.
   
   Thanks,
   --
   ~Randy
   
   
   From: Randy Hron <rwhron@earthlink.net>
   
   
   Remove unneeded include of version.h.
   Test compiled against 2.6.0-test5-bk9.
   
   
    linux-260-t5bk12-kj-rddunlap/drivers/net/e100/e100.h |    1 -
    1 files changed, 1 deletion(-)

<rddunlap@osdl.org> (03/09/27 1.1365)
   [PATCH] janitor: hermes: delete verify_area call
   
   Hi,
   Please apply to 2.6.0-test5-current.
   
   Thanks,
   --
   ~Randy
   
   
   From: Domen Puncer <domen@coderock.org>
   
   IMO, that verify_area wasn't needed.
   
   
   
    linux-260-t5bk12-kj-rddunlap/drivers/net/wireless/orinoco.c |    4 ----
    1 files changed, 4 deletions(-)

<scott.feldman@intel.com> (03/09/27 1.1364)
   [e100] trying to pci_alloc before pci_enable
   
   * Some archs don't like calling pci_alloc_consistent before calling
   pci_enable_device.  (Imagine that).  This corrects that.

<scott.feldman@intel.com> (03/09/27 1.1363)
   [e100] h/w can't do IPv6 checksum offloading
   
   * Driver was advertising HW_CSUM, but hardware is only capable of IP_CSUM.

<scott.feldman@intel.com> (03/09/27 1.1362)
   [e100] PRO/10+ not configured properly
   
   * PRO/10+ (10 Mbps-only card) was not configured properly so it didn't
   pass traffic.

<scott.feldman@intel.com> (03/09/27 1.1361)
   [e1000] misc
   
   * removed unused var, ASSERT macro
   * missed a free_netdev() in probe cleanup undo.

<scott.feldman@intel.com> (03/09/27 1.1360)
   [e1000] better propagation of error codes
   
   * Better propagation of error codes during probe/open paths.
     {Janice Girouard (janiceg@us.ibm.com)]

<scott.feldman@intel.com> (03/09/27 1.1359)
   [e1000] force 1000/full on SERDES connected to back-plane
   
   * Bug fix: SERDES devices might be connected to back-plan switch that
     doesn't support auto-neg, so add the capability to force 1000/full.

<scott.feldman@intel.com> (03/09/27 1.1358)
   [e1000] flow control updates
   
   * handle ethtool force flow control
   * correctly set flow control hi/low watermarks based on size of Rx FIFO
     area.  The size can change if doing Jumbo Frames or, in the case of
     82547, is smaller to start with.
   * was not properly forcing flow control settings to fc_none if using
     strict IEEE flow control override.

<shemminger@osdl.org> (03/09/27 1.1357)
   [netdrvr sk98lin] use seq_file for /proc
   
   Replace proc_read with seq_file interface which is much cleaner.
   
   Also, instead of searching the list of devices looking for the
   name which is slow and would break if interface name changes;
   store a pointer to device in the proc entry, and retrieve
   it from the information saved by single_open.
   
   Formatting and other behaviours are retained.

<shemminger@osdl.org> (03/09/27 1.1356)
   [netdrvr skge] handle proc_fs errors.
   
   Existing code does not
   	- check if proc_fs functions return error.
   	- use proc_mkdir to make the directory.
   
   Note pSkRootDir defined twice.

<shemminger@osdl.org> (03/09/27 1.1355)
   [netdrvr sk98lin] build on smp fix
   
   There is no exported variable called smp_num_cpus! so this driver
   won't build on SMP.  Since the local variable is never used anyway
   just get rid of it.
   
   This applies against 2.6.0-test5-bk13 which has the last vendor
   driver update.

