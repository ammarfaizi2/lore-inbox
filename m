Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbTH0W2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 18:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbTH0W2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 18:28:17 -0400
Received: from havoc.gtf.org ([63.247.75.124]:47079 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262466AbTH0W2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 18:28:01 -0400
Date: Wed, 27 Aug 2003 18:27:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [bk patches] 2.6.x net driver queue
Message-ID: <20030827222755.GA10445@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the pile waiting for Linus, so far.

BK users:

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.6
		or
	bk pull http://gkernel.bkbits.net/net-drivers-2.6

Patch users:

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test4-bk2-netdrvr2.patch.bz2

This will update the following files:

 drivers/net/3c501.c             |   91 ----
 drivers/net/3c501.h             |    2 
 drivers/net/3c503.c             |   71 ---
 drivers/net/3c505.c             |   96 +---
 drivers/net/3c507.c             |   97 +----
 drivers/net/3c515.c             |   94 ----
 drivers/net/3c523.c             |   73 ---
 drivers/net/3c527.c             |   94 ----
 drivers/net/3c59x.c             |   47 --
 drivers/net/8139cp.c            |  444 +++++++++--------------
 drivers/net/8139too.c           |  391 +++++++-------------
 drivers/net/Kconfig             |    4 
 drivers/net/pcmcia/3c574_cs.c   |   28 -
 drivers/net/pcmcia/3c589_cs.c   |   81 +---
 drivers/net/pcmcia/axnet_cs.c   |   28 -
 drivers/net/pcmcia/fmvj18x_cs.c |   75 +--
 drivers/net/pcmcia/ibmtr_cs.c   |   35 -
 drivers/net/pcmcia/nmclan_cs.c  |   77 +--
 drivers/net/pcmcia/pcnet_cs.c   |   41 --
 drivers/net/pcmcia/xirc2ps_cs.c |   28 -
 drivers/net/sis190.c            |  221 ++++++-----
 drivers/net/sis900.c            |   62 +--
 drivers/net/tulip/dmfe.c        |   62 ---
 drivers/net/tulip/xircom_cb.c   |   38 -
 drivers/net/wireless/airo.c     |  772 +++++++++++++++++++++++++++++++++-------
 drivers/net/wireless/ray_cs.c   |   32 -
 net/core/ethtool.c              |   12 
 27 files changed, 1398 insertions(+), 1698 deletions(-)

through these ChangeSets:

<romieu@fr.zoreil.com> (03/08/27 1.1316)
   [netdrvr sis190] use PCI DMA API for RX buffers
   
   Missing pieces for DMA-API on the Rx side:
   - SiS190_init_ring: the global area for the received data is mapped.
     This area is persistent during the whole driver's life.
     It only needs to be unmapped in SiS190_close() as no other exit/error
     path exists.
   - SiS190_rx_interrupt: no map/unmap for received data buffer. A single
     sync operation is done. Btw, there is no need to store the same value
     in RxDescArray[cur_rx].buf_addr over and over again.
   - Remove driver dependancy on CONFIG_BROKEN.

<willy@debian.org> (03/08/27 1.1315)
   [netdrvr 8139too] ethtool_ops support

<willy@debian.org> (03/08/27 1.1314)
   [ethtool] fix ethtool_get_strings counting bug

<jgarzik@redhat.com> (03/08/26 1.1313)
   [netdrvr sis190] small bug fixes
   
   * call pci_set_dma_mask
   * remove erroneous call to unregister_netdev in _init_board()

<javier@tudela.mad.ttd.net> (03/08/26 1.1312)
   [wireless airo] add support for MIC and latest firmwares

<greg@kroah.com> (03/08/26 1.1311)
   [netdrvr sis900] don't call pci_find_device from irq context
   
   I realized that I've had this patch in my tree for a while, and forgot
   to send it to you and lkml.  The patch below fixes bug number 923:
   	http://bugme.osdl.org/show_bug.cgi?id=923
   (basically keeps us from calling pci_find_device from interrupt
   context.)
   
   It's been tested by a few people with this device, and they say it works
   just fine for them.  Please forward it on up the food chain.

<hirofumi@mail.parknet.co.jp> (03/08/26 1.1310)
   [netdrvr 8139too] add more h/w revision ids

<hirofumi@mail.parknet.co.jp> (03/08/26 1.1309)
   [netdrvr 8139too] remove unused RxConfigMask

<hirofumi@mail.parknet.co.jp> (03/08/26 1.1308)
   [netdrvr 8139too] lwake unlock fix

<srompf@isg.de> (03/08/26 1.1307)
   [netdrvr 8139too] use mii_check_media lib function,
   instead of homebrew MII bitbanging.

<romieu@fr.zoreil.com> (03/08/26 1.1306)
   [netdrvr sis190] remove unneeded alignment code, other small fixes
   
   Driver does not need to enforce 256 byte alignment for data returned
   from pci_alloc_consistent().
   - {rx/tx}_dma_aligned and {rx/td}_dma_raw are both replaced by {rx/tx}_dma;
   - {rx/tx}_desc_raw is replaced by direct use of {Rx/Tx}DescArray;
   - SiS190_open()
     + fixup for a lack of kmalloc() failure handling;
     + (return status) there is no need for both retval/rc: merge them;
     + anonymous printk() fixup: the name of the guilty device is printed;
   - define {RX/TX}_DESC_TOTAL_SIZE because I am too lazy to read twice the
     same lengthy arithmetic expression.
   
   

<jgarzik@redhat.com> (03/08/26 1.1305)
   [wireless ray_cs] ethtool_ops support

<jgarzik@redhat.com> (03/08/26 1.1304)
   [netdrvr xircom_cb] ethtool_ops support
   
   Also, export PCI bus id via ETHTOOL_GDRVINFO.

<jgarzik@redhat.com> (03/08/26 1.1303)
   [netdrvr pcmcia] convert several drivers to ethtool_ops
   
   Drivers updated: fmvj18x_cs, ibmtr_cs, nmclan_cs, pcnet_cs,
   xirc2ps_cs.

<jgarzik@redhat.com> (03/08/26 1.1302)
   [netdrvr pcmcia] ethtool_ops for 3c574, 3c589, axnet

<jgarzik@redhat.com> (03/08/26 1.1301)
   [netdrvr] ethtool_ops support for 3c515, 3c523, 3c527, and dmfe

<jgarzik@redhat.com> (03/08/26 1.1300)
   [netdrvr] ethtool_ops support in 3c503, 3c505, 3c507

<jgarzik@redhat.com> (03/08/26 1.1299)
   [netdrvr 3c501] ethtool_ops support

<jgarzik@redhat.com> (03/08/26 1.1298)
   [netdrvr sis190] make driver depend on CONFIG_BROKEN
   
   Until RX path is cleaned up to use PCI DMA API and
   not virt_to_bus.

<jgarzik@redhat.com> (03/08/26 1.1297)
   [netdrvr sis190] convert TX path to use PCI DMA API
   
   Also, minor changes:
   * mark ->hard_start_xmit ETH_ZLEN test as unlikely()
   * use cpu_to_le32() and le32_to_cpu() in TX path
   * fix two leak in error path, in ->hard_start_xmit
   * don't test netif_queue_stopped() in TX completion path,
     netif_wake_queue() already does that.

<jgarzik@redhat.com> (03/08/26 1.1296)
   [netdrvr 8139cp] ethtool_ops support

<jgarzik@redhat.com> (03/08/26 1.1295)
   [netdrvr sis900] ethtool_ops support

<willy@debian.org> (03/08/26 1.1294)
   [netdrvr 3c59x] ethtool_ops support

<romieu@fr.zoreil.com> (03/08/26 1.1293)
   [netdrvr sis190] pass irq argument to synchronize_irq()
   
   Looks like this driver wasn't tested on SMP :)

<bunk@fs.tum.de> (03/08/26 1.1292)
   [netdrvr sis190] fix build with older gcc
   
   older gcc's do not support C99/C++ style of variable declarations.

