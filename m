Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbVJ1G35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbVJ1G35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVJ1G35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:29:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:54249 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965097AbVJ1G34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:29:56 -0400
Date: Thu, 27 Oct 2005 23:29:21 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver Core patches for 2.6.14
Message-ID: <20051028062921.GA6397@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a lot of driver core patches for 2.6.14.  They have all been in
the past few -mm releases with no problems.  They contain the following
things:
	- 2 small aoe driver updates
	- create hotplug events directly from the sysfs tree so that
	  "coldplug" work at boot time is much simpler.
	- add the ability to nest class devices in the driver model
	- move the input drivers to have dynamic structures
	- move the input subsystem to use the nested class devices
	- remove the input core from calling /sbin/hotplug on its own.
	- some driver core pm changes
	- stop the i2o abuse of the driver model
	- some other small things (documentation, bugfixes, etc.)

These patches are needed so that the different distros don't keep trying
to keep their own set of "fix up the input subsystem to play nice with
/sbin/hotplug" patches that they have been, in order to rely only on
udev to handle their hotplug needs.  With these changes, they no longer
need to do that.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

The full patch set will be sent to the linux-kernel mailing lists, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/Changes                          |    2 
 Documentation/DocBook/writing_usb_driver.tmpl  |    3 
 Documentation/driver-model/driver.txt          |   60 --
 Documentation/driver-model/porting.txt         |    2 
 arch/arm/common/locomo.c                       |   10 
 arch/arm/common/sa1111.c                       |   11 
 arch/arm/common/scoop.c                        |   24 -
 arch/arm/mach-pxa/corgi_ssp.c                  |   24 -
 arch/arm/mach-sa1100/neponset.c                |   28 -
 arch/i386/kernel/cpuid.c                       |    2 
 arch/i386/kernel/msr.c                         |    2 
 drivers/base/attribute_container.c             |    2 
 drivers/base/base.h                            |   12 
 drivers/base/class.c                           |  152 ++++--
 drivers/base/core.c                            |   21 
 drivers/base/cpu.c                             |    1 
 drivers/base/driver.c                          |    3 
 drivers/base/firmware.c                        |    3 
 drivers/base/init.c                            |   10 
 drivers/base/platform.c                        |   22 
 drivers/base/power/sysfs.c                     |   73 +++
 drivers/block/aoe/aoe.h                        |    2 
 drivers/block/aoe/aoechr.c                     |    2 
 drivers/block/aoe/aoecmd.c                     |   15 
 drivers/block/genhd.c                          |   25 +
 drivers/block/paride/pg.c                      |    2 
 drivers/block/paride/pt.c                      |    4 
 drivers/char/dsp56k.c                          |    2 
 drivers/char/ftape/zftape/zftape-init.c        |   12 
 drivers/char/ip2main.c                         |   10 
 drivers/char/ipmi/ipmi_devintf.c               |    2 
 drivers/char/istallion.c                       |    3 
 drivers/char/lp.c                              |    2 
 drivers/char/mem.c                             |    3 
 drivers/char/misc.c                            |    2 
 drivers/char/ppdev.c                           |    2 
 drivers/char/raw.c                             |    4 
 drivers/char/s3c2410-rtc.c                     |   20 
 drivers/char/snsc.c                            |    2 
 drivers/char/sonypi.c                          |  106 ++--
 drivers/char/stallion.c                        |    4 
 drivers/char/tipar.c                           |    2 
 drivers/char/tty_io.c                          |   10 
 drivers/char/vc_screen.c                       |   10 
 drivers/char/viotape.c                         |    4 
 drivers/char/watchdog/s3c2410_wdt.c            |   34 -
 drivers/hwmon/hdaps.c                          |    6 
 drivers/hwmon/hwmon.c                          |    2 
 drivers/i2c/busses/i2c-s3c2410.c               |    8 
 drivers/i2c/i2c-core.c                         |    4 
 drivers/ide/ide-tape.c                         |   42 +
 drivers/ieee1394/dv1394.c                      |    2 
 drivers/ieee1394/nodemgr.c                     |    4 
 drivers/ieee1394/raw1394.c                     |    2 
 drivers/ieee1394/video1394.c                   |    2 
 drivers/infiniband/core/ucm.c                  |    2 
 drivers/input/evdev.c                          |   26 -
 drivers/input/input.c                          |  555 +++++++++++++++----------
 drivers/input/joydev.c                         |   26 -
 drivers/input/joystick/adi.c                   |   93 ++--
 drivers/input/joystick/amijoy.c                |   87 ++-
 drivers/input/joystick/analog.c                |  100 ++--
 drivers/input/joystick/cobra.c                 |   70 +--
 drivers/input/joystick/db9.c                   |  292 +++++++------
 drivers/input/joystick/gamecon.c               |  396 +++++++++--------
 drivers/input/joystick/gf2k.c                  |   71 +--
 drivers/input/joystick/grip.c                  |   85 ++-
 drivers/input/joystick/grip_mp.c               |  149 +++---
 drivers/input/joystick/guillemot.c             |   53 +-
 drivers/input/joystick/iforce/iforce-main.c    |  106 ++--
 drivers/input/joystick/iforce/iforce-packets.c |    5 
 drivers/input/joystick/iforce/iforce-serio.c   |   10 
 drivers/input/joystick/iforce/iforce-usb.c     |   22 
 drivers/input/joystick/iforce/iforce.h         |    2 
 drivers/input/joystick/interact.c              |   55 +-
 drivers/input/joystick/magellan.c              |   71 +--
 drivers/input/joystick/sidewinder.c            |   72 +--
 drivers/input/joystick/spaceball.c             |   82 +--
 drivers/input/joystick/spaceorb.c              |   78 +--
 drivers/input/joystick/stinger.c               |   75 +--
 drivers/input/joystick/tmdc.c                  |  324 ++++++++------
 drivers/input/joystick/turbografx.c            |  223 ++++++----
 drivers/input/joystick/twidjoy.c               |  118 ++---
 drivers/input/joystick/warrior.c               |   83 +--
 drivers/input/keyboard/amikbd.c                |   59 +-
 drivers/input/keyboard/atkbd.c                 |  188 ++++----
 drivers/input/keyboard/corgikbd.c              |   96 ++--
 drivers/input/keyboard/lkkbd.c                 |  126 ++---
 drivers/input/keyboard/maple_keyb.c            |   76 +--
 drivers/input/keyboard/newtonkbd.c             |   83 +--
 drivers/input/keyboard/spitzkbd.c              |  121 ++---
 drivers/input/keyboard/sunkbd.c                |  117 ++---
 drivers/input/keyboard/xtkbd.c                 |   82 +--
 drivers/input/misc/m68kspkr.c                  |   40 -
 drivers/input/misc/pcspkr.c                    |   34 -
 drivers/input/misc/sparcspkr.c                 |   45 --
 drivers/input/mouse/alps.c                     |   67 +--
 drivers/input/mouse/alps.h                     |    2 
 drivers/input/mouse/amimouse.c                 |   51 +-
 drivers/input/mouse/inport.c                   |   96 ++--
 drivers/input/mouse/lifebook.c                 |   16 
 drivers/input/mouse/logibm.c                   |   88 ++-
 drivers/input/mouse/logips2pp.c                |   20 
 drivers/input/mouse/maplemouse.c               |   10 
 drivers/input/mouse/pc110pad.c                 |   70 +--
 drivers/input/mouse/psmouse-base.c             |   99 ++--
 drivers/input/mouse/psmouse.h                  |    2 
 drivers/input/mouse/rpcmouse.c                 |   43 -
 drivers/input/mouse/sermouse.c                 |   84 +--
 drivers/input/mouse/synaptics.c                |    6 
 drivers/input/mouse/vsxxxaa.c                  |   84 +--
 drivers/input/mousedev.c                       |   41 -
 drivers/input/serio/i8042.c                    |   13 
 drivers/input/touchscreen/corgi_ts.c           |  131 ++---
 drivers/input/touchscreen/elo.c                |   89 +---
 drivers/input/touchscreen/gunze.c              |   66 +-
 drivers/input/touchscreen/h3600_ts_input.c     |  149 ++----
 drivers/input/touchscreen/hp680_ts_input.c     |   58 +-
 drivers/input/touchscreen/mk712.c              |   80 +--
 drivers/input/touchscreen/mtouch.c             |   64 +-
 drivers/input/tsdev.c                          |   29 -
 drivers/isdn/capi/capi.c                       |    2 
 drivers/macintosh/adb.c                        |    2 
 drivers/macintosh/adbhid.c                     |  220 +++++----
 drivers/macintosh/mac_hid.c                    |   44 +
 drivers/media/common/ir-common.c               |    1 
 drivers/media/dvb/cinergyT2/cinergyT2.c        |  108 +++-
 drivers/media/dvb/dvb-core/dvbdev.c            |    2 
 drivers/media/dvb/dvb-usb/dvb-usb-remote.c     |   50 +-
 drivers/media/dvb/dvb-usb/dvb-usb.h            |    3 
 drivers/media/dvb/ttpci/av7110_ir.c            |   37 -
 drivers/media/dvb/ttpci/budget-ci.c            |   24 -
 drivers/media/dvb/ttusb-dec/ttusb_dec.c        |   51 +-
 drivers/media/video/bttvp.h                    |    2 
 drivers/media/video/cx88/cx88-input.c          |   58 +-
 drivers/media/video/ir-kbd-gpio.c              |   52 +-
 drivers/media/video/ir-kbd-i2c.c               |   33 -
 drivers/media/video/msp3400.c                  |    8 
 drivers/media/video/saa7134/saa7134-input.c    |   39 -
 drivers/media/video/saa7134/saa7134.h          |    2 
 drivers/media/video/tda9887.c                  |    4 
 drivers/media/video/tuner-core.c               |    4 
 drivers/message/i2o/core.h                     |    3 
 drivers/message/i2o/device.c                   |  326 ++++++--------
 drivers/message/i2o/driver.c                   |    3 
 drivers/message/i2o/iop.c                      |   34 -
 drivers/mfd/mcp-sa11x0.c                       |   20 
 drivers/mfd/ucb1x00-ts.c                       |   45 +-
 drivers/mmc/pxamci.c                           |    8 
 drivers/mmc/wbsd.c                             |    4 
 drivers/mtd/maps/sa1100-flash.c                |    8 
 drivers/mtd/mtdchar.c                          |    4 
 drivers/net/dm9000.c                           |    8 
 drivers/net/irda/sa1100_ir.c                   |    8 
 drivers/net/irda/smsc-ircc2.c                  |   12 
 drivers/net/phy/mdio_bus.c                     |   20 
 drivers/net/ppp_generic.c                      |    2 
 drivers/net/smc91x.c                           |    8 
 drivers/net/wan/cosa.c                         |    2 
 drivers/pci/pci.c                              |    4 
 drivers/pci/pcie/portdrv_core.c                |    4 
 drivers/pci/probe.c                            |   16 
 drivers/pcmcia/au1000_generic.c                |   21 
 drivers/pcmcia/ds.c                            |    6 
 drivers/pcmcia/hd64465_ss.c                    |   20 
 drivers/pcmcia/i82365.c                        |   20 
 drivers/pcmcia/m32r_cfc.c                      |   21 
 drivers/pcmcia/m32r_pcc.c                      |   21 
 drivers/pcmcia/omap_cf.c                       |   18 
 drivers/pcmcia/pxa2xx_base.c                   |   26 -
 drivers/pcmcia/rsrc_nonstatic.c                |    6 
 drivers/pcmcia/sa1100_generic.c                |   20 
 drivers/pcmcia/socket_sysfs.c                  |    6 
 drivers/pcmcia/tcic.c                          |   20 
 drivers/pcmcia/vrc4171_card.c                  |   24 -
 drivers/s390/char/tape_class.c                 |    1 
 drivers/s390/char/vmlogrdr.c                   |    1 
 drivers/scsi/ch.c                              |    2 
 drivers/scsi/osst.c                            |    2 
 drivers/scsi/sg.c                              |   10 
 drivers/scsi/st.c                              |    2 
 drivers/serial/8250.c                          |   10 
 drivers/serial/imx.c                           |    8 
 drivers/serial/mpc52xx_uart.c                  |    8 
 drivers/serial/pxa.c                           |    8 
 drivers/serial/s3c2410.c                       |    9 
 drivers/serial/sa1100.c                        |    8 
 drivers/serial/vr41xx_siu.c                    |   10 
 drivers/usb/core/devio.c                       |    2 
 drivers/usb/core/file.c                        |    4 
 drivers/usb/core/hcd.c                         |    3 
 drivers/usb/core/hub.c                         |   16 
 drivers/usb/gadget/dummy_hcd.c                 |   22 
 drivers/usb/gadget/omap_udc.c                  |    9 
 drivers/usb/gadget/pxa2xx_udc.c                |   17 
 drivers/usb/host/isp116x-hcd.c                 |   14 
 drivers/usb/host/ohci-omap.c                   |   10 
 drivers/usb/host/ohci-pxa27x.c                 |    4 
 drivers/usb/host/sl811-hcd.c                   |   10 
 drivers/usb/input/acecad.c                     |   78 +--
 drivers/usb/input/aiptek.c                     |  209 ++++-----
 drivers/usb/input/appletouch.c                 |  130 +++--
 drivers/usb/input/ati_remote.c                 |  173 ++++---
 drivers/usb/input/hid-core.c                   |   51 +-
 drivers/usb/input/hid-input.c                  |   58 +-
 drivers/usb/input/hid-lgff.c                   |   17 
 drivers/usb/input/hid-tmff.c                   |   11 
 drivers/usb/input/hid.h                        |    2 
 drivers/usb/input/itmtouch.c                   |   72 +--
 drivers/usb/input/kbtab.c                      |   86 +--
 drivers/usb/input/keyspan_remote.c             |  214 ++++-----
 drivers/usb/input/mtouchusb.c                  |  111 ++---
 drivers/usb/input/pid.c                        |   12 
 drivers/usb/input/powermate.c                  |  136 +++---
 drivers/usb/input/touchkitusb.c                |  116 ++---
 drivers/usb/input/usbkbd.c                     |  105 ++--
 drivers/usb/input/usbmouse.c                   |   97 ++--
 drivers/usb/input/wacom.c                      |  142 ++----
 drivers/usb/input/xpad.c                       |   97 +---
 drivers/usb/input/yealink.c                    |   66 +-
 drivers/usb/media/konicawc.c                   |   89 ++--
 drivers/usb/storage/onetouch.c                 |  105 ++--
 drivers/video/backlight/corgi_bl.c             |   10 
 drivers/video/fbmem.c                          |    2 
 drivers/video/imxfb.c                          |   10 
 drivers/video/pxafb.c                          |   10 
 drivers/video/s1d13xxxfb.c                     |    7 
 drivers/video/s3c2410fb.c                      |   29 -
 drivers/video/sa1100fb.c                       |   10 
 drivers/video/w100fb.c                         |   48 +-
 fs/coda/psdev.c                                |    4 
 fs/partitions/check.c                          |   27 +
 include/linux/device.h                         |  115 ++---
 include/linux/genhd.h                          |    1 
 include/linux/i2o.h                            |    4 
 include/linux/input.h                          |   28 +
 include/linux/kobject.h                        |    2 
 include/linux/pm.h                             |   26 +
 lib/kobject.c                                  |    2 
 lib/kobject_uevent.c                           |    8 
 net/bluetooth/hidp/core.c                      |   13 
 sound/arm/pxa2xx-ac97.c                        |    8 
 sound/core/init.c                              |   14 
 sound/core/sound.c                             |    2 
 sound/oss/soundcard.c                          |    4 
 sound/pci/ac97/ac97_bus.c                      |    6 
 sound/ppc/beep.c                               |   68 +--
 sound/sound_core.c                             |    2 
 248 files changed, 5702 insertions(+), 5318 deletions(-)


Ben Dooks:
      drivers/base - fix sparse warnings

David Brownell:
      pci device wakeup flags
      driver model wakeup flags
      usb device wakeup flags

Dmitry Torokhov:
      Driver core: pass interface to class interface methods
      Driver core: send hotplug event before adding class interfaces
      I2O: remove i2o_device_class
      I2O: remove class interface
      Input: prepare to sysfs integration
      drivers/input/mouse: convert to dynamic input_dev allocation
      Input: kill devfs references
      Input: convert sonypi to dynamic input_dev allocation
      Input: convert ucb1x00-ts to dynamic input_dev allocation
      drivers/input/keyboard: convert to dynamic input_dev allocation
      Input: convert onetouch to dynamic input_dev allocation
      drivers/input/touchscreen: convert to dynamic input_dev allocation
      drivers/usb/input: convert to dynamic input_dev allocation
      Input: convert driver/input/misc to dynamic input_dev allocation
      Input: convert net/bluetooth to dynamic input_dev allocation
      Input: convert konicawc to dynamic input_dev allocation
      drivers/input/joystick: convert to dynamic input_dev allocation
      Input: convert drivers/macintosh to dynamic input_dev allocation
      Input: convert sound/ppc/beep to dynamic input_dev allocation
      drivers/media: convert to dynamic input_dev allocation
      Input: show sysfs path in /proc/bus/input/devices
      Input: export input_dev data via sysfs attributes
      input core: remove custom-made hotplug handler

Ed L Cashin:
      aoe: update to version 14
      aoe: use get_unaligned for accesses in ATA id buffer

Erik Hovland:
      kobject_uevent.c has a typo in a comment
      changes device to driver in porting.txt

Greg Kroah-Hartman:
      I2O: Clean up some pretty bad driver model abuses in the i2o code
      Driver Core: add the ability for class_device structures to be nested
      Driver Core: fix up all callers of class_device_create()
      Driver Core: document struct class_device properly
      INPUT: remove the input_class structure, as it is unused.
      INPUT: export input_dev_class so that input drivers can use it.
      INPUT: Fix oops when accessing sysfs files of nested input devices
      INPUT: register the input class device sooner
      INPUT: move the input class devices under their new input_dev devices
      INPUT: rename input_dev_class to input_class to be correct.
      update required version of udev
      INPUT: Create symlinks for backwards compatibility

Jesper Juhl:
      Driver Core: Big kfree NULL check cleanup - Documentation

Kay Sievers:
      add sysfs attr to re-emit device hotplug event

Randy Dunlap:
      kobject: fix gfp flags type
      kernel-doc: drivers/base fixes

Russell King:
      DRIVER MODEL: Get rid of the obsolete tri-level suspend/resume callbacks

Will Dyson:
      add sysfs support for ide tape

