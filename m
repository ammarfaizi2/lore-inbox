Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270650AbTHAT3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270651AbTHAT3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:29:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:28094 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270650AbTHAT3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:29:25 -0400
Date: Fri, 1 Aug 2003 12:29:24 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.0-test2
Message-ID: <20030801192924.GA31210@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I turns out the we can not mark pci_device_id variables as __initdata or
__devinitdata due to the way the pci probe functions work (the .id
pointer can be looked at after init runs if a pci module is loaded by
the user.)  We had the same issue come up with USB device ids a while
ago and we had to make this same fix.  I think 2.4 might also have this
problem, but haven't had the time to look into it yet or not.

So these patches fix up all the pci_device_id references that I could
find in the kernel tree that are wrong.  I might have missed a few due
to the different merges happening, so there might be more patches coming
later to catch the stragglers.

Thanks to Andrew Morton and Jeff Garzik for talking it over about this
problem and notifying me of it.

The pnp_id variables also have the same problem, and Adam is fixing them
all up right now.  Any other subsystem that uses the driver core for
probing needs to be checked to make sure this problem isn't there too.

I've also added a documentation and pci_ids.h patch to this tree, as
they had been floating around for a while.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 Documentation/DMA-mapping.txt           |    2 
 arch/mips/vr41xx/common/vrc4173.c       |    2 
 drivers/atm/eni.c                       |    2 
 drivers/atm/firestream.c                |    5 
 drivers/atm/he.c                        |    2 
 drivers/atm/idt77252.c                  |    2 
 drivers/atm/iphase.c                    |    2 
 drivers/block/umem.c                    |    2 
 drivers/char/agp/ali-agp.c              |    2 
 drivers/char/agp/amd-k7-agp.c           |    2 
 drivers/char/agp/amd-k8-agp.c           |    2 
 drivers/char/agp/i460-agp.c             |    2 
 drivers/char/agp/intel-agp.c            |    2 
 drivers/char/agp/nvidia-agp.c           |    2 
 drivers/char/agp/sworks-agp.c           |    2 
 drivers/char/epca.c                     |    2 
 drivers/char/synclink.c                 |    4 
 drivers/char/synclinkmp.c               |    4 
 drivers/char/watchdog/wdt_pci.c         |   10 
 drivers/i2c/busses/i2c-ali1535.c        |    2 
 drivers/i2c/busses/i2c-ali15x3.c        |    2 
 drivers/i2c/busses/i2c-amd756.c         |    2 
 drivers/i2c/busses/i2c-amd8111.c        |    2 
 drivers/i2c/busses/i2c-i801.c           |    2 
 drivers/i2c/busses/i2c-piix4.c          |    2 
 drivers/i2c/busses/i2c-sis96x.c         |    2 
 drivers/i2c/busses/i2c-viapro.c         |    2 
 drivers/i2c/chips/via686a.c             |    2 
 drivers/i2c/i2c-prosavage.c             |    2 
 drivers/ide/pci/aec62xx.c               |    2 
 drivers/ide/pci/alim15x3.c              |    2 
 drivers/ide/pci/amd74xx.c               |    2 
 drivers/ide/pci/cmd64x.c                |    2 
 drivers/ide/pci/cs5520.c                |    2 
 drivers/ide/pci/cs5530.c                |    2 
 drivers/ide/pci/cy82c693.c              |    2 
 drivers/ide/pci/generic.c               |    2 
 drivers/ide/pci/hpt34x.c                |    2 
 drivers/ide/pci/hpt366.c                |    2 
 drivers/ide/pci/it8172.c                |    2 
 drivers/ide/pci/ns87415.c               |    2 
 drivers/ide/pci/opti621.c               |    2 
 drivers/ide/pci/pdc202xx_new.c          |    2 
 drivers/ide/pci/pdc202xx_old.c          |    2 
 drivers/ide/pci/pdcadma.c               |    2 
 drivers/ide/pci/piix.c                  |    2 
 drivers/ide/pci/rz1000.c                |    2 
 drivers/ide/pci/sc1200.c                |    2 
 drivers/ide/pci/serverworks.c           |    2 
 drivers/ide/pci/siimage.c               |    2 
 drivers/ide/pci/sis5513.c               |    2 
 drivers/ide/pci/sl82c105.c              |    2 
 drivers/ide/pci/slc90e66.c              |    2 
 drivers/ide/pci/triflex.h               |    2 
 drivers/ide/pci/trm290.c                |    2 
 drivers/ide/pci/via82cxxx.c             |    2 
 drivers/ieee1394/ohci1394.c             |    2 
 drivers/ieee1394/pcilynx.c              |    2 
 drivers/input/gameport/cs461x.c         |    2 
 drivers/input/gameport/emu10k1-gp.c     |    2 
 drivers/input/gameport/fm801-gp.c       |    2 
 drivers/input/gameport/vortex.c         |    2 
 drivers/isdn/hardware/avm/b1pci.c       |    2 
 drivers/isdn/hardware/avm/c4.c          |    2 
 drivers/isdn/hardware/avm/t1pci.c       |    2 
 drivers/isdn/hardware/eicon/divasmain.c |    2 
 drivers/isdn/hisax/hisax_fcpcipnp.c     |    2 
 drivers/isdn/hisax/hisax_hfcpci.c       |    2 
 drivers/isdn/tpam/tpam_main.c           |    2 
 drivers/media/radio/radio-maxiradio.c   |    2 
 drivers/media/video/bttv-driver.c       |    2 
 drivers/media/video/meye.c              |    2 
 drivers/mtd/maps/amd76xrom.c            |    2 
 drivers/mtd/maps/ich2rom.c              |    2 
 drivers/mtd/maps/pci.c                  |    2 
 drivers/mtd/maps/scb2_flash.c           |    4 
 drivers/net/3c59x.c                     |    4 
 drivers/net/8139cp.c                    |    2 
 drivers/net/8139too.c                   |    2 
 drivers/net/acenic.c                    |    2 
 drivers/net/amd8111e.c                  |    2 
 drivers/net/arcnet/com20020-pci.c       |    2 
 drivers/net/b44.c                       |    2 
 drivers/net/defxx.c                     |    2 
 drivers/net/dl2k.h                      |    2 
 drivers/net/e100/e100_main.c            |    2 
 drivers/net/e1000/e1000_main.c          |    2 
 drivers/net/eepro100.c                  |    2 
 drivers/net/epic100.c                   |    2 
 drivers/net/fealnx.c                    |    2 
 drivers/net/hamachi.c                   |    2 
 drivers/net/ioc3-eth.c                  |    2 
 drivers/net/irda/donauboe.c             |    2 
 drivers/net/irda/toshoboe.c             |    2 
 drivers/net/irda/vlsi_ir.c              |    2 
 drivers/net/ixgb/ixgb_main.c            |    2 
 drivers/net/natsemi.c                   |    2 
 drivers/net/ne2k-pci.c                  |    2 
 drivers/net/ns83820.c                   |    2 
 drivers/net/pci-skeleton.c              |    2 
 drivers/net/pcnet32.c                   |    2 
 drivers/net/r8169.c                     |    2 
 drivers/net/rcpci45.c                   |    2 
 drivers/net/rrunner.c                   |    2 
 drivers/net/sis900.c                    |    2 
 drivers/net/sk98lin/skge.c              |    2 
 drivers/net/starfire.c                  |    2 
 drivers/net/sundance.c                  |    2 
 drivers/net/sungem.c                    |    2 
 drivers/net/sunhme.c                    |    2 
 drivers/net/tc35815.c                   |    2 
 drivers/net/tg3.c                       |    3 
 drivers/net/tlan.c                      |    2 
 drivers/net/tokenring/3c359.c           |    4 
 drivers/net/tokenring/abyss.c           |    2 
 drivers/net/tokenring/lanstreamer.c     |    2 
 drivers/net/tokenring/olympic.c         |    2 
 drivers/net/tokenring/tmspci.c          |    2 
 drivers/net/tulip/de2104x.c             |    2 
 drivers/net/tulip/dmfe.c                |    2 
 drivers/net/tulip/tulip_core.c          |    2 
 drivers/net/tulip/winbond-840.c         |    2 
 drivers/net/tulip/xircom_cb.c           |    2 
 drivers/net/tulip/xircom_tulip_cb.c     |    2 
 drivers/net/typhoon.c                   |    2 
 drivers/net/via-rhine.c                 |    2 
 drivers/net/wan/dscc4.c                 |    4 
 drivers/net/wan/farsync.c               |    2 
 drivers/net/wan/lmc/lmc_main.c          |    2 
 drivers/net/wan/pc300_drv.c             |    4 
 drivers/net/wireless/airo.c             |    2 
 drivers/net/wireless/orinoco_pci.c      |    2 
 drivers/net/wireless/orinoco_plx.c      |    2 
 drivers/net/wireless/orinoco_tmd.c      |    2 
 drivers/net/yellowfin.c                 |    2 
 drivers/parisc/eisa.c                   |    2 
 drivers/parisc/superio.c                |    2 
 drivers/parport/parport_pc.c            |    2 
 drivers/parport/parport_serial.c        |    2 
 drivers/pci/hotplug/cpcihp_zt5550.c     |    5 
 drivers/pci/hotplug/cpqphp_core.c       |    2 
 drivers/pci/hotplug/ibmphp_ebda.c       |    2 
 drivers/pcmcia/yenta_socket.c           |    2 
 drivers/scsi/dc395x.c                   |    4 
 drivers/scsi/gdth.c                     |    4 
 drivers/scsi/ips.c                      |    2 
 drivers/scsi/nsp32.c                    |    2 
 drivers/scsi/tmscsim.c                  |    4 
 drivers/serial/8250_pci.c               |    2 
 drivers/video/aty/aty128fb.c            |    2 
 drivers/video/chipsfb.c                 |    2 
 drivers/video/console/sticore.c         |    2 
 drivers/video/cyber2000fb.c             |    2 
 drivers/video/i810/i810_main.h          |   34 +-
 drivers/video/imsttfb.c                 |    2 
 drivers/video/matrox/matroxfb_base.c    |    2 
 drivers/video/neofb.c                   |    2 
 drivers/video/radeonfb.c                |    2 
 drivers/video/riva/fbdev.c              |    2 
 drivers/video/sstfb.c                   |    2 
 drivers/video/tdfxfb.c                  |    4 
 drivers/video/tridentfb.c               |    2 
 include/linux/pci_ids.h                 |    2 
 sound/oss/ad1889.c                      |    2 
 sound/oss/ali5455.c                     |    2 
 sound/oss/btaudio.c                     |    2 
 sound/oss/cs4281/cs4281m.c              |    2 
 sound/oss/cs46xx.c                      |    2 
 sound/oss/es1370.c                      |    2 
 sound/oss/es1371.c                      |    2 
 sound/oss/esssolo1.c                    |    2 
 sound/oss/forte.c                       |    2 
 sound/oss/i810_audio.c                  |    2 
 sound/oss/ite8172.c                     |    2 
 sound/oss/kahlua.c                      |    2 
 sound/oss/maestro.c                     |    4 
 sound/oss/maestro3.c                    |    2 
 sound/oss/nec_vrc5477.c                 |    2 
 sound/oss/nm256_audio.c                 |    2 
 sound/oss/rme96xx.c                     |    2 
 sound/oss/sonicvibes.c                  |    4 
 sound/oss/trident.c                     |    2 
 sound/oss/via82cxxx_audio.c             |    2 
 sound/oss/ymfpci.c                      |    2 
 sound/pci/ali5451/ali5451.c             |   54 +---
 sound/pci/als4000.c                     |    2 
 sound/pci/azt3328.c                     |    2 
 sound/pci/cmipci.c                      |    6 
 sound/pci/cs4281.c                      |   76 ++---
 sound/pci/cs46xx/cs46xx.c               |   15 -
 sound/pci/emu10k1/emu10k1.c             |   12 
 sound/pci/ens1370.c                     |   12 
 sound/pci/es1938.c                      |    8 
 sound/pci/es1968.c                      |   50 +--
 sound/pci/fm801.c                       |    2 
 sound/pci/ice1712/ice1712.c             |    2 
 sound/pci/ice1712/ice1724.c             |    6 
 sound/pci/intel8x0.c                    |  360 ++++++++++++++++-----------
 sound/pci/korg1212/korg1212.c           |    2 
 sound/pci/maestro3.c                    |  102 ++++---
 sound/pci/nm256/nm256.c                 |   15 -
 sound/pci/rme32.c                       |    2 
 sound/pci/rme96.c                       |   20 -
 sound/pci/rme9652/hdsp.c                |  419 +++++++++++++++++++-------------
 sound/pci/rme9652/rme9652.c             |   80 +++---
 sound/pci/sonicvibes.c                  |    8 
 sound/pci/trident/trident.c             |   17 -
 sound/pci/via82xx.c                     |    8 
 sound/pci/vx222/vx222.c                 |    2 
 sound/pci/ymfpci/ymfpci.c               |   17 -
 210 files changed, 913 insertions(+), 827 deletions(-)
-----

Greg Kroah-Hartman:
  o PCI: merge fixups
  o PCI: pci_device_id can not be marked __devinitdata
  o PCI: pci_device_id can not be marked __devinitdata
  o PCI: pci_device_id can not be marked __devinitdata
  o PCI: pci_device_id can not be marked __devinitdata
  o PCI: pci_device_id can not be marked __devinitdata
  o PCI: pci_device_id can not be marked __devinitdata.  Fixes up sound/*

Mitchell Blank Jr.:
  o PCI: add 2 entries to pci_ids.h
  o PCI: Trivial DMA-mapping.txt fix

