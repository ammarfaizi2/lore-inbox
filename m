Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbTJNThO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 15:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbTJNTgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 15:36:13 -0400
Received: from havoc.gtf.org ([63.247.75.124]:57313 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262583AbTJNTcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 15:32:51 -0400
Date: Tue, 14 Oct 2003 15:32:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [BK PATCHES] 2.6.x experimental net driver updates
Message-ID: <20031014193250.GA23250@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BK users:

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.5-exp

GNU diff:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test7-bk6-netdrvr-exp1.patch.bz2

This will update the following files:

 drivers/net/3c515.c            |   23 +-
 drivers/net/3c527.c            |  371 +++++++++++++++----------------------
 drivers/net/8139too.c          |   51 +++--
 drivers/net/defxx.c            |    2 
 drivers/net/dummy.c            |    2 
 drivers/net/eql.c              |    2 
 drivers/net/natsemi.c          |   39 ++-
 drivers/net/ns83820.c          |    2 
 drivers/net/plip.c             |   14 +
 drivers/net/shaper.c           |   11 -
 drivers/net/skfp/skfddi.c      |   12 -
 drivers/net/tokenring/smctr.c  |    8 
 drivers/net/tulip/Kconfig      |   20 ++
 drivers/net/tulip/interrupt.c  |  410 ++++++++++++++++++++++++++++++-----------
 drivers/net/tulip/tulip.h      |   18 +
 drivers/net/tulip/tulip_core.c |   55 ++---
 drivers/net/tun.c              |   18 -
 drivers/net/wan/lmc/lmc_main.c |  375 ++++++++++++-------------------------
 drivers/net/wan/lmc/lmc_var.h  |   15 -
 net/wanrouter/wanmain.c        |    2 
 20 files changed, 740 insertions(+), 710 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/10/14 1.1364)
   [netdrvr tulip] support NAPI
   
   Contributed by Robert Ollsson.

<shemminger@osdl.org> (03/10/14 1.1363)
   [PATCH] smctr - get rid of MOD_INC/DEC
   
   Get rid of warning now that module refcounting now done by network code not drivers.
   
   Not tested on real hardware.

<rddunlap@osdl.org> (03/10/14 1.1362)
   [PATCH] janitor: insert missing iounmap(), add error handling
   
   Hi,
   Please apply to 2.6.0-test6-current.
   
   Thanks,
   --
   ~Randy
   
   
   
   From: Leann Ogasawara <ogasawara@osdl.org>
   Subject: Re: [Kernel-janitors] [PATCH] insert missing iounmap()
   
   > > Patch inserts a missing iounmap().  Implements a cleanup path
   > > for error handling as well.  Feedback is much appreciated.  Thanks :)
   
   
   
   ===== drivers/net/natsemi.c 1.55 vs edited =====
   
   
    linux-260-test6-kj1-rddunlap/drivers/net/natsemi.c |   39 ++++++++++-----------
    1 files changed, 20 insertions(+), 19 deletions(-)

<felipewd@terra.com.br> (03/10/14 1.1361)
   [PATCH] release region in skfddi driver
   
   This is a multi-part message in MIME format.

<felipewd@terra.com.br> (03/10/14 1.1360)
   [netdrvr 3c527] remove cli/sti
   
   
       Richard Procter and I worked to remove cli/sti to add proper SMP support (I did the original stuff and Richard did the actual current code :)).
   
       Besides that, Richard did a great jog improving the perfomance of the driver quite a bit:
   
       - Improve mc32_command by 770% (438% non-inlined) over the semaphore version (at a cost of 1 sem + 2 completions per driver).
   
       - Removed mutex covering mc32_send_packet (hard_start_xmit). This lets the interrupt handler operate concurrently and removes unnecessary locking. It makes the code only slightly more brittle
   
       Original post:
   
   http://marc.theaimsgroup.com/?l=linux-netdev&m=106438449315202&w=2
   
       Since it didn't apply cleanly against 2.6.0-test6, I forward ported it. Patch attached.
   
       Jeff, please consider applying,
   
       Thanks.

<shemminger@osdl.org> (03/10/14 1.1359)
   [PATCH] remove dev_get from wanrouter
   
   The call to dev_get() in wanrouter_device_new_if is racy and redundant and should
   be removed.  The later 'register_netdev()' does the same test internally and will
   return the appropriate error if the name already exists.
   
   This patch is against 2.6.0-test6.
   Resend of earlier patch because it was ignored, or missed.

<romieu@fr.zoreil.com> (03/10/14 1.1358)
   [PATCH] 2.6.0-test6 - more free_netdev() conversion
   
   Compiles ok (with true .o generated, yeah). Please review.
   
   free_netdev() of devices allocated through use of alloc_netdev().
   Though baroque, drivers/net/3c515.c now uses alloc_etherdev().
   
   
    drivers/net/3c515.c   |   23 ++++++++++++-----------
    drivers/net/defxx.c   |    2 +-
    drivers/net/dummy.c   |    2 +-
    drivers/net/eql.c     |    2 +-
    drivers/net/ns83820.c |    2 +-
    drivers/net/plip.c    |   14 ++++++++++----
    drivers/net/shaper.c  |   11 ++++++++---
    drivers/net/tun.c     |   18 +++++++++---------
    9 files changed, 43 insertions(+), 31 deletions(-)

<shemminger@osdl.org> (03/10/14 1.1357)
   [PATCH] wan/lmc -- convert to new network device model
   
   Resend of LMC driver patch for 2.6.0-test6
     * do proper probing
     * allocate network device with alloc_netdev
     * use standard pci_id's instead of local defines
     * use standard PCI device interface to find and remove devices.

<krishnakumar@naturesoft.net> (03/10/14 1.1356)
   [netdrvr 8139too] support netif_msg_* interface

