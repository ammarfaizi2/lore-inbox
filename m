Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWJEOiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWJEOiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWJEOiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:38:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53717 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932083AbWJEOh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:37:58 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061002132116.2663d7a3.akpm@osdl.org> 
References: <20061002132116.2663d7a3.akpm@osdl.org>  <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       Dmitry Torokhov <dtor@mail.ru>, Greg KH <greg@kroah.com>,
       David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 05 Oct 2006 15:22:07 +0100
Message-ID: <18975.1160058127@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> These should just use __get_cpu_var().

Done.

> And could we please remove the irq_regs macro?

Done.

> I think the change is good.  But I don't want to maintain this whopper
> out-of-tree for two months!  If we want to do this, we should just smash it
> in and grit our teeth.  But I am a bit concerned about the non-x86
> architectures.  I assume they'll continue to compile-and-work?

Well, it seems that IA64 and MIPS don't build as of 2.6.19-rc1 without my
having to do anything.  i386, x86_64, powerpc and frv build for at least one
configuration each.  The other archs I haven't touched, so will definitely
break.

Can those arch maintainers give me patches?


Anyway, I've made a GIT tree with just IRQ my patches in.  It can be browsed
at:

	http://git.infradead.org/?p=users/dhowells/irq-2.6.git;a=shortlog

Or pulled from:

	git://git.infradead.org/~dhowells/irq-2.6.git

David

---
The following changes since commit d223a60106891bfe46febfacf46b20cd8509aaad:
  Linus Torvalds:
        Linux 2.6.19-rc1

are found in the git repository at:

  git://git.infradead.org/~dhowells/irq-2.6.git

David Howells:
      IRQ: Typedef the IRQ flow handler function type
      IRQ: Typedef the IRQ handler function type
      IRQ: Maintain regs pointer globally rather than passing to IRQ handlers

 arch/frv/kernel/dma.c                             |    5 -
 arch/frv/kernel/irq-mb93091.c                     |    4 -
 arch/frv/kernel/irq-mb93093.c                     |    4 -
 arch/frv/kernel/irq-mb93493.c                     |    4 -
 arch/frv/kernel/irq.c                             |    2 
 arch/frv/kernel/time.c                            |    8 +
 arch/i386/kernel/apic.c                           |   18 ++-
 arch/i386/kernel/i8259.c                          |    4 -
 arch/i386/kernel/irq.c                            |   12 +-
 arch/i386/kernel/smp.c                            |    6 +
 arch/i386/kernel/time.c                           |    6 -
 arch/i386/kernel/time_hpet.c                      |    4 -
 arch/i386/kernel/vm86.c                           |    2 
 arch/i386/mach-visws/visws_apic.c                 |    4 -
 arch/i386/mach-voyager/voyager_basic.c            |    2 
 arch/i386/mach-voyager/voyager_smp.c              |   28 +++-
 arch/ia64/kernel/irq_ia64.c                       |    4 -
 arch/ia64/kernel/machvec.c                        |    2 
 arch/ia64/kernel/mca.c                            |   32 ++---
 arch/ia64/kernel/time.c                           |    8 +
 arch/ia64/sn/pci/tioca_provider.c                 |    3 
 arch/ia64/sn/pci/tioce_provider.c                 |    3 
 arch/mips/kernel/irq.c                            |    4 -
 arch/mips/kernel/time.c                           |   24 ++--
 arch/mips/sgi-ip22/ip22-reset.c                   |    2 
 arch/mips/sgi-ip22/ip22-time.c                    |    4 -
 arch/powerpc/kernel/irq.c                         |    6 +
 arch/powerpc/kernel/misc_64.S                     |    6 -
 arch/powerpc/kernel/smp.c                         |    6 -
 arch/powerpc/kernel/time.c                        |    6 +
 arch/powerpc/platforms/cell/interrupt.c           |    4 -
 arch/powerpc/platforms/cell/spider-pic.c          |    5 -
 arch/powerpc/platforms/powermac/low_i2c.c         |    2 
 arch/powerpc/platforms/powermac/pfunc_base.c      |    2 
 arch/powerpc/platforms/powermac/pic.c             |    7 -
 arch/powerpc/platforms/pseries/ras.c              |   14 +-
 arch/powerpc/platforms/pseries/setup.c            |    7 -
 arch/powerpc/platforms/pseries/xics.c             |   18 +--
 arch/powerpc/platforms/pseries/xics.h             |    3 
 arch/powerpc/sysdev/mpic.c                        |    4 -
 arch/powerpc/xmon/xmon.c                          |    6 -
 arch/x86_64/kernel/apic.c                         |   12 +-
 arch/x86_64/kernel/irq.c                          |    7 +
 arch/x86_64/kernel/time.c                         |   20 ++-
 drivers/acorn/block/mfmhd.c                       |    2 
 drivers/acpi/osl.c                                |    2 
 drivers/ata/ahci.c                                |    4 -
 drivers/ata/libata-core.c                         |    3 
 drivers/ata/pdc_adma.c                            |    5 -
 drivers/ata/sata_mv.c                             |    6 -
 drivers/ata/sata_nv.c                             |   18 +--
 drivers/ata/sata_promise.c                        |    4 -
 drivers/ata/sata_qstor.c                          |    4 -
 drivers/ata/sata_sil.c                            |    6 -
 drivers/ata/sata_sil24.c                          |    4 -
 drivers/ata/sata_sx4.c                            |    4 -
 drivers/ata/sata_vsc.c                            |    3 
 drivers/atm/ambassador.c                          |    4 -
 drivers/atm/eni.c                                 |    2 
 drivers/atm/firestream.c                          |    2 
 drivers/atm/fore200e.c                            |    2 
 drivers/atm/he.c                                  |    4 -
 drivers/atm/horizon.c                             |    4 -
 drivers/atm/idt77252.c                            |    2 
 drivers/atm/iphase.c                              |    2 
 drivers/atm/lanai.c                               |    4 -
 drivers/atm/nicstar.c                             |    4 -
 drivers/atm/zatm.c                                |    2 
 drivers/block/DAC960.c                            |   24 +---
 drivers/block/DAC960.h                            |   14 +-
 drivers/block/acsi.c                              |    4 -
 drivers/block/acsi_slm.c                          |    4 -
 drivers/block/amiflop.c                           |    4 -
 drivers/block/ataflop.c                           |    4 -
 drivers/block/cciss.c                             |    6 -
 drivers/block/cpqarray.c                          |    4 -
 drivers/block/floppy.c                            |    4 -
 drivers/block/ps2esdi.c                           |    6 -
 drivers/block/swim3.c                             |    8 +
 drivers/block/swim_iop.c                          |    4 -
 drivers/block/sx8.c                               |    2 
 drivers/block/ub.c                                |    6 -
 drivers/block/umem.c                              |    2 
 drivers/block/xd.c                                |    3 
 drivers/block/xd.h                                |    3 
 drivers/bluetooth/bcm203x.c                       |    2 
 drivers/bluetooth/bfusb.c                         |    8 +
 drivers/bluetooth/bluecard_cs.c                   |    2 
 drivers/bluetooth/bpa10x.c                        |    2 
 drivers/bluetooth/bt3c_cs.c                       |    2 
 drivers/bluetooth/btuart_cs.c                     |    2 
 drivers/bluetooth/dtl1_cs.c                       |    2 
 drivers/bluetooth/hci_usb.c                       |    8 +
 drivers/cdrom/cdu31a.c                            |    2 
 drivers/cdrom/cm206.c                             |    2 
 drivers/cdrom/mcdx.c                              |    2 
 drivers/cdrom/sonycd535.c                         |    2 
 drivers/char/amiserial.c                          |    6 -
 drivers/char/applicom.c                           |    4 -
 drivers/char/cyclades.c                           |    4 -
 drivers/char/drm/drm_os_linux.h                   |    2 
 drivers/char/ec3104_keyb.c                        |    2 
 drivers/char/esp.c                                |    3 
 drivers/char/ftape/lowlevel/fdc-io.c              |    2 
 drivers/char/hangcheck-timer.c                    |    2 
 drivers/char/hpet.c                               |    2 
 drivers/char/hvc_console.c                        |    4 -
 drivers/char/hvcs.c                               |    6 -
 drivers/char/hvsi.c                               |    6 -
 drivers/char/ip2/ip2main.c                        |    9 +
 drivers/char/ipmi/ipmi_si_intf.c                  |    6 -
 drivers/char/ipmi/ipmi_watchdog.c                 |    2 
 drivers/char/isicom.c                             |    2 
 drivers/char/keyboard.c                           |  135 +++++++++++----------
 drivers/char/mbcs.c                               |    3 
 drivers/char/mmtimer.c                            |    3 
 drivers/char/mwave/tp3780i.c                      |    4 -
 drivers/char/mxser.c                              |    4 -
 drivers/char/nwbutton.c                           |    2 
 drivers/char/nwbutton.h                           |    2 
 drivers/char/pcmcia/synclink_cs.c                 |    5 -
 drivers/char/ppdev.c                              |    2 
 drivers/char/qtronix.c                            |    4 -
 drivers/char/rio/rio_linux.c                      |    4 -
 drivers/char/riscom8.c                            |    2 
 drivers/char/rtc.c                                |    8 +
 drivers/char/ser_a2232.c                          |    4 -
 drivers/char/serial167.c                          |    8 +
 drivers/char/snsc.c                               |    2 
 drivers/char/snsc_event.c                         |    2 
 drivers/char/sonypi.c                             |    2 
 drivers/char/specialix.c                          |    4 -
 drivers/char/stallion.c                           |    5 -
 drivers/char/sx.c                                 |    4 -
 drivers/char/synclink.c                           |    3 
 drivers/char/synclink_gt.c                        |    5 -
 drivers/char/synclinkmp.c                         |    3 
 drivers/char/sysrq.c                              |   62 ++++------
 drivers/char/tlclk.c                              |    4 -
 drivers/char/tpm/tpm_tis.c                        |    4 -
 drivers/char/vme_scc.c                            |   18 +--
 drivers/char/vr41xx_giu.c                         |    2 
 drivers/char/watchdog/eurotechwdt.c               |    2 
 drivers/char/watchdog/mpcore_wdt.c                |    2 
 drivers/char/watchdog/pcwd_usb.c                  |    2 
 drivers/char/watchdog/s3c2410_wdt.c               |    3 
 drivers/char/watchdog/wdt.c                       |    3 
 drivers/char/watchdog/wdt285.c                    |    2 
 drivers/char/watchdog/wdt_pci.c                   |    3 
 drivers/dma/ioatdma.c                             |    2 
 drivers/fc4/soc.c                                 |    2 
 drivers/fc4/socal.c                               |    2 
 drivers/i2c/busses/i2c-elektor.c                  |    2 
 drivers/i2c/busses/i2c-ibm_iic.c                  |    2 
 drivers/i2c/busses/i2c-iop3xx.c                   |    2 
 drivers/i2c/busses/i2c-ite.c                      |    3 
 drivers/i2c/busses/i2c-mpc.c                      |    2 
 drivers/i2c/busses/i2c-mv64xxx.c                  |    2 
 drivers/i2c/busses/i2c-ocores.c                   |    2 
 drivers/i2c/busses/i2c-omap.c                     |    4 -
 drivers/i2c/busses/i2c-pca-isa.c                  |    2 
 drivers/i2c/busses/i2c-pxa.c                      |    2 
 drivers/i2c/busses/i2c-rpx.c                      |    4 -
 drivers/i2c/busses/i2c-s3c2410.c                  |    3 
 drivers/i2c/chips/isp1301_omap.c                  |    4 -
 drivers/i2c/chips/tps65010.c                      |    2 
 drivers/ide/ide-io.c                              |    2 
 drivers/ide/legacy/hd.c                           |    2 
 drivers/ide/legacy/macide.c                       |    2 
 drivers/ieee1394/ohci1394.c                       |    3 
 drivers/ieee1394/pcilynx.c                        |    3 
 drivers/infiniband/hw/amso1100/c2.c               |    4 -
 drivers/infiniband/hw/ehca/ehca_irq.c             |    4 -
 drivers/infiniband/hw/ehca/ehca_irq.h             |    4 -
 drivers/infiniband/hw/ipath/ipath_intr.c          |    2 
 drivers/infiniband/hw/ipath/ipath_kernel.h        |    2 
 drivers/infiniband/hw/mthca/mthca_eq.c            |   10 +-
 drivers/input/joystick/amijoy.c                   |    4 -
 drivers/input/joystick/iforce/iforce-packets.c    |    6 -
 drivers/input/joystick/iforce/iforce-serio.c      |    4 -
 drivers/input/joystick/iforce/iforce-usb.c        |    8 +
 drivers/input/joystick/iforce/iforce.h            |    2 
 drivers/input/joystick/magellan.c                 |    8 -
 drivers/input/joystick/spaceball.c                |    8 -
 drivers/input/joystick/spaceorb.c                 |    8 -
 drivers/input/joystick/stinger.c                  |    8 -
 drivers/input/joystick/twidjoy.c                  |    8 -
 drivers/input/joystick/warrior.c                  |   10 +-
 drivers/input/keyboard/amikbd.c                   |    4 -
 drivers/input/keyboard/atkbd.c                    |    4 -
 drivers/input/keyboard/corgikbd.c                 |    9 -
 drivers/input/keyboard/hil_kbd.c                  |    2 
 drivers/input/keyboard/hilkbd.c                   |    2 
 drivers/input/keyboard/lkkbd.c                    |    5 -
 drivers/input/keyboard/locomokbd.c                |    8 -
 drivers/input/keyboard/newtonkbd.c                |    3 
 drivers/input/keyboard/omap-keypad.c              |    3 
 drivers/input/keyboard/spitzkbd.c                 |   10 +-
 drivers/input/keyboard/stowaway.c                 |    3 
 drivers/input/keyboard/sunkbd.c                   |    3 
 drivers/input/keyboard/xtkbd.c                    |    3 
 drivers/input/misc/ixp4xx-beeper.c                |    2 
 drivers/input/mouse/alps.c                        |   10 +-
 drivers/input/mouse/amimouse.c                    |    4 -
 drivers/input/mouse/hil_ptr.c                     |    2 
 drivers/input/mouse/inport.c                      |    4 -
 drivers/input/mouse/lifebook.c                    |    4 -
 drivers/input/mouse/logibm.c                      |    3 
 drivers/input/mouse/logips2pp.c                   |    4 -
 drivers/input/mouse/pc110pad.c                    |    9 +
 drivers/input/mouse/psmouse-base.c                |   16 +-
 drivers/input/mouse/psmouse.h                     |    2 
 drivers/input/mouse/rpcmouse.c                    |    4 -
 drivers/input/mouse/sermouse.c                    |   14 +-
 drivers/input/mouse/synaptics.c                   |   15 +-
 drivers/input/mouse/vsxxxaa.c                     |   22 +--
 drivers/input/serio/ambakmi.c                     |    4 -
 drivers/input/serio/ct82c710.c                    |    4 -
 drivers/input/serio/gscps2.c                      |    6 -
 drivers/input/serio/hp_sdc.c                      |    4 -
 drivers/input/serio/i8042.c                       |   12 +-
 drivers/input/serio/maceps2.c                     |    5 -
 drivers/input/serio/parkbd.c                      |    4 -
 drivers/input/serio/pcips2.c                      |    4 -
 drivers/input/serio/q40kbd.c                      |    4 -
 drivers/input/serio/rpckbd.c                      |    6 -
 drivers/input/serio/sa1111ps2.c                   |    6 -
 drivers/input/serio/serio.c                       |    4 -
 drivers/input/serio/serio_raw.c                   |    2 
 drivers/input/serio/serport.c                     |    5 -
 drivers/input/touchscreen/ads7846.c               |    2 
 drivers/input/touchscreen/corgi_ts.c              |   13 +-
 drivers/input/touchscreen/elo.c                   |   17 +--
 drivers/input/touchscreen/gunze.c                 |    7 -
 drivers/input/touchscreen/h3600_ts_input.c        |   14 +-
 drivers/input/touchscreen/hp680_ts_input.c        |    2 
 drivers/input/touchscreen/mk712.c                 |    3 
 drivers/input/touchscreen/mtouch.c                |   11 +-
 drivers/input/touchscreen/penmount.c              |    3 
 drivers/input/touchscreen/touchright.c            |    3 
 drivers/input/touchscreen/touchwin.c              |    3 
 drivers/isdn/act2000/act2000_isa.c                |    2 
 drivers/isdn/gigaset/bas-gigaset.c                |   12 +-
 drivers/isdn/gigaset/usb-gigaset.c                |    4 -
 drivers/isdn/hardware/avm/avmcard.h               |    4 -
 drivers/isdn/hardware/avm/b1.c                    |    2 
 drivers/isdn/hardware/avm/b1dma.c                 |    2 
 drivers/isdn/hardware/avm/c4.c                    |    2 
 drivers/isdn/hardware/avm/t1isa.c                 |    2 
 drivers/isdn/hardware/eicon/diva.c                |    4 -
 drivers/isdn/hardware/eicon/divasmain.c           |    3 
 drivers/isdn/hisax/amd7930_fn.c                   |    2 
 drivers/isdn/hisax/asuscom.c                      |    4 -
 drivers/isdn/hisax/avm_a1.c                       |    2 
 drivers/isdn/hisax/avm_a1p.c                      |    2 
 drivers/isdn/hisax/avm_pci.c                      |    2 
 drivers/isdn/hisax/bkm_a4t.c                      |    2 
 drivers/isdn/hisax/bkm_a8.c                       |    2 
 drivers/isdn/hisax/diva.c                         |    8 +
 drivers/isdn/hisax/elsa.c                         |    4 -
 drivers/isdn/hisax/enternow_pci.c                 |    2 
 drivers/isdn/hisax/gazel.c                        |    4 -
 drivers/isdn/hisax/hfc4s8s_l1.c                   |    2 
 drivers/isdn/hisax/hfc_pci.c                      |    2 
 drivers/isdn/hisax/hfc_sx.c                       |    2 
 drivers/isdn/hisax/hfc_usb.c                      |    8 +
 drivers/isdn/hisax/hfcscard.c                     |    2 
 drivers/isdn/hisax/hisax.h                        |    2 
 drivers/isdn/hisax/hisax_fcpcipnp.c               |    4 -
 drivers/isdn/hisax/icc.c                          |    2 
 drivers/isdn/hisax/isac.c                         |    2 
 drivers/isdn/hisax/isurf.c                        |    2 
 drivers/isdn/hisax/ix1_micro.c                    |    2 
 drivers/isdn/hisax/mic.c                          |    2 
 drivers/isdn/hisax/netjet.h                       |    2 
 drivers/isdn/hisax/niccy.c                        |    3 
 drivers/isdn/hisax/nj_s.c                         |    2 
 drivers/isdn/hisax/nj_u.c                         |    2 
 drivers/isdn/hisax/s0box.c                        |    2 
 drivers/isdn/hisax/saphir.c                       |    2 
 drivers/isdn/hisax/sedlbauer.c                    |    6 -
 drivers/isdn/hisax/sportster.c                    |    2 
 drivers/isdn/hisax/st5481_b.c                     |    2 
 drivers/isdn/hisax/st5481_d.c                     |    2 
 drivers/isdn/hisax/st5481_usb.c                   |    6 -
 drivers/isdn/hisax/teleint.c                      |    2 
 drivers/isdn/hisax/teles0.c                       |    2 
 drivers/isdn/hisax/teles3.c                       |    2 
 drivers/isdn/hisax/telespci.c                     |    2 
 drivers/isdn/hisax/w6692.c                        |    4 -
 drivers/isdn/hysdn/boardergo.c                    |    2 
 drivers/isdn/pcbit/layer2.c                       |    2 
 drivers/isdn/pcbit/layer2.h                       |    2 
 drivers/isdn/sc/init.c                            |    2 
 drivers/isdn/sc/interrupt.c                       |    2 
 drivers/macintosh/adb-iop.c                       |    8 +
 drivers/macintosh/adb.c                           |   10 +-
 drivers/macintosh/adbhid.c                        |   20 +--
 drivers/macintosh/macio-adb.c                     |    7 -
 drivers/macintosh/smu.c                           |    6 -
 drivers/macintosh/via-cuda.c                      |   12 +-
 drivers/macintosh/via-macii.c                     |    7 -
 drivers/macintosh/via-maciisi.c                   |   12 +-
 drivers/macintosh/via-pmu.c                       |   32 ++---
 drivers/macintosh/via-pmu68k.c                    |   13 +-
 drivers/media/common/saa7146_core.c               |    2 
 drivers/media/dvb/b2c2/flexcop-pci.c              |    2 
 drivers/media/dvb/b2c2/flexcop-usb.c              |    2 
 drivers/media/dvb/bt8xx/bt878.c                   |    2 
 drivers/media/dvb/cinergyT2/cinergyT2.c           |    4 -
 drivers/media/dvb/dvb-usb/usb-urb.c               |    2 
 drivers/media/dvb/pluto2/pluto2.c                 |    2 
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 
 drivers/media/dvb/ttusb-dec/ttusb_dec.c           |    4 -
 drivers/media/video/arv.c                         |    2 
 drivers/media/video/bt8xx/bttv-driver.c           |    2 
 drivers/media/video/cpia2/cpia2_usb.c             |    4 -
 drivers/media/video/cpia_usb.c                    |    2 
 drivers/media/video/cx88/cx88-alsa.c              |    2 
 drivers/media/video/cx88/cx88-mpeg.c              |    2 
 drivers/media/video/cx88/cx88-video.c             |    2 
 drivers/media/video/dabusb.c                      |    2 
 drivers/media/video/em28xx/em28xx-core.c          |    6 -
 drivers/media/video/et61x251/et61x251_core.c      |    2 
 drivers/media/video/meye.c                        |    2 
 drivers/media/video/ov511.c                       |    2 
 drivers/media/video/planb.c                       |    4 -
 drivers/media/video/pvrusb2/pvrusb2-hdw.c         |    4 -
 drivers/media/video/pvrusb2/pvrusb2-io.c          |    2 
 drivers/media/video/pwc/pwc-if.c                  |    2 
 drivers/media/video/saa7134/saa7134-alsa.c        |    2 
 drivers/media/video/saa7134/saa7134-core.c        |    2 
 drivers/media/video/saa7134/saa7134-oss.c         |    2 
 drivers/media/video/se401.c                       |    4 -
 drivers/media/video/sn9c102/sn9c102_core.c        |    2 
 drivers/media/video/stradis.c                     |    2 
 drivers/media/video/stv680.c                      |    2 
 drivers/media/video/usbvideo/konicawc.c           |    2 
 drivers/media/video/usbvideo/quickcam_messenger.c |    4 -
 drivers/media/video/usbvideo/usbvideo.c           |    2 
 drivers/media/video/vino.c                        |    2 
 drivers/media/video/w9968cf.c                     |    4 -
 drivers/media/video/zc0301/zc0301_core.c          |    2 
 drivers/media/video/zoran_device.c                |    3 
 drivers/media/video/zoran_device.h                |    4 -
 drivers/media/video/zr36120.c                     |    4 -
 drivers/message/fusion/mptbase.c                  |    5 -
 drivers/message/i2o/pci.c                         |    3 
 drivers/mfd/ucb1x00-core.c                        |    2 
 drivers/misc/ibmasm/ibmasm.h                      |    4 -
 drivers/misc/ibmasm/lowlevel.c                    |    4 -
 drivers/misc/ibmasm/remote.c                      |   14 +-
 drivers/misc/lkdtm.c                              |    5 -
 drivers/misc/tifm_7xx1.c                          |    2 
 drivers/mmc/at91_mci.c                            |    4 -
 drivers/mmc/au1xmmc.c                             |    2 
 drivers/mmc/imxmmc.c                              |    4 -
 drivers/mmc/mmci.c                                |    4 -
 drivers/mmc/omap.c                                |    4 -
 drivers/mmc/pxamci.c                              |    6 -
 drivers/mmc/sdhci.c                               |    2 
 drivers/mmc/wbsd.c                                |    2 
 drivers/net/3c501.c                               |    3 
 drivers/net/3c501.h                               |    2 
 drivers/net/3c505.c                               |    2 
 drivers/net/3c507.c                               |    4 -
 drivers/net/3c509.c                               |    6 -
 drivers/net/3c515.c                               |    6 -
 drivers/net/3c523.c                               |    6 -
 drivers/net/3c527.c                               |    4 -
 drivers/net/3c59x.c                               |   14 +-
 drivers/net/7990.c                                |    2 
 drivers/net/8139cp.c                              |    5 -
 drivers/net/8139too.c                             |    8 -
 drivers/net/82596.c                               |    8 +
 drivers/net/8390.c                                |    5 -
 drivers/net/8390.h                                |    2 
 drivers/net/a2065.c                               |    3 
 drivers/net/acenic.c                              |    2 
 drivers/net/acenic.h                              |    2 
 drivers/net/amd8111e.c                            |    4 -
 drivers/net/apne.c                                |    6 -
 drivers/net/appletalk/cops.c                      |    4 -
 drivers/net/appletalk/ltpc.c                      |    2 
 drivers/net/arcnet/arcnet.c                       |    2 
 drivers/net/ariadne.c                             |    4 -
 drivers/net/arm/am79c961a.c                       |    4 -
 drivers/net/arm/at91_ether.c                      |    4 -
 drivers/net/arm/ep93xx_eth.c                      |    2 
 drivers/net/arm/ether1.c                          |    4 -
 drivers/net/arm/ether3.c                          |    4 -
 drivers/net/at1700.c                              |    5 -
 drivers/net/atari_bionet.c                        |    2 
 drivers/net/atari_pamsnet.c                       |    3 
 drivers/net/atarilance.c                          |    4 -
 drivers/net/atp.c                                 |    5 -
 drivers/net/au1000_eth.c                          |    4 -
 drivers/net/b44.c                                 |    4 -
 drivers/net/bmac.c                                |   14 +-
 drivers/net/bnx2.c                                |    6 -
 drivers/net/cassini.c                             |    8 +
 drivers/net/chelsio/cxgb2.c                       |    2 
 drivers/net/chelsio/sge.c                         |    6 -
 drivers/net/chelsio/sge.h                         |    9 -
 drivers/net/cris/eth_v10.c                        |    8 +
 drivers/net/cs89x0.c                              |    6 -
 drivers/net/de600.c                               |    2 
 drivers/net/de600.h                               |    2 
 drivers/net/de620.c                               |    4 -
 drivers/net/declance.c                            |    6 -
 drivers/net/defxx.c                               |    6 -
 drivers/net/depca.c                               |    4 -
 drivers/net/dgrs.c                                |    2 
 drivers/net/dl2k.c                                |    4 -
 drivers/net/dm9000.c                              |    4 -
 drivers/net/e100.c                                |    4 -
 drivers/net/e1000/e1000_ethtool.c                 |    3 
 drivers/net/e1000/e1000_main.c                    |    7 -
 drivers/net/eepro.c                               |    4 -
 drivers/net/eepro100.c                            |    6 -
 drivers/net/eexpress.c                            |    4 -
 drivers/net/ehea/ehea_main.c                      |   12 +-
 drivers/net/epic100.c                             |    4 -
 drivers/net/eth16i.c                              |    4 -
 drivers/net/ewrk3.c                               |    4 -
 drivers/net/fealnx.c                              |    4 -
 drivers/net/fec.c                                 |   10 +-
 drivers/net/fec_8xx/fec_main.c                    |    4 -
 drivers/net/forcedeth.c                           |   20 ++-
 drivers/net/fs_enet/fs_enet-main.c                |    4 -
 drivers/net/gianfar.c                             |   22 ++-
 drivers/net/gianfar.h                             |    2 
 drivers/net/hamachi.c                             |    4 -
 drivers/net/hamradio/baycom_epp.c                 |    2 
 drivers/net/hamradio/baycom_par.c                 |    2 
 drivers/net/hamradio/baycom_ser_fdx.c             |    2 
 drivers/net/hamradio/baycom_ser_hdx.c             |    2 
 drivers/net/hamradio/dmascc.c                     |    4 -
 drivers/net/hamradio/scc.c                        |    4 -
 drivers/net/hamradio/yam.c                        |    2 
 drivers/net/hp100.c                               |    4 -
 drivers/net/ibm_emac/ibm_emac_core.c              |    4 -
 drivers/net/ibm_emac/ibm_emac_debug.c             |    3 
 drivers/net/ibm_emac/ibm_emac_mal.c               |   10 +-
 drivers/net/ibmlana.c                             |    2 
 drivers/net/ibmveth.c                             |    8 +
 drivers/net/ioc3-eth.c                            |    2 
 drivers/net/irda/ali-ircc.c                       |    3 
 drivers/net/irda/au1k_ir.c                        |    4 -
 drivers/net/irda/donauboe.c                       |    4 -
 drivers/net/irda/irda-usb.c                       |   12 +-
 drivers/net/irda/irport.c                         |    8 -
 drivers/net/irda/irport.h                         |    2 
 drivers/net/irda/mcs7780.c                        |    4 -
 drivers/net/irda/mcs7780.h                        |    4 -
 drivers/net/irda/nsc-ircc.c                       |    3 
 drivers/net/irda/pxaficp_ir.c                     |    8 +
 drivers/net/irda/sa1100_ir.c                      |    2 
 drivers/net/irda/smsc-ircc2.c                     |    6 -
 drivers/net/irda/stir4200.c                       |    2 
 drivers/net/irda/via-ircc.c                       |    8 -
 drivers/net/irda/vlsi_ir.c                        |    3 
 drivers/net/irda/w83977af_ir.c                    |    3 
 drivers/net/isa-skeleton.c                        |    4 -
 drivers/net/iseries_veth.c                        |    2 
 drivers/net/ixgb/ixgb_main.c                      |    7 -
 drivers/net/ixp2000/ixpdev.c                      |    2 
 drivers/net/lance.c                               |    5 -
 drivers/net/lasi_82596.c                          |    6 -
 drivers/net/lp486e.c                              |    4 -
 drivers/net/mac89x0.c                             |    4 -
 drivers/net/mace.c                                |   12 +-
 drivers/net/macmace.c                             |    8 +
 drivers/net/meth.c                                |    4 -
 drivers/net/mipsnet.c                             |    3 
 drivers/net/mv643xx_eth.c                         |    3 
 drivers/net/myri10ge/myri10ge.c                   |    2 
 drivers/net/myri_sbus.c                           |    2 
 drivers/net/natsemi.c                             |    6 -
 drivers/net/netx-eth.c                            |    2 
 drivers/net/ni5010.c                              |    4 -
 drivers/net/ni52.c                                |    4 -
 drivers/net/ni65.c                                |    4 -
 drivers/net/ns83820.c                             |    2 
 drivers/net/pci-skeleton.c                        |    6 -
 drivers/net/pcmcia/3c574_cs.c                     |    6 -
 drivers/net/pcmcia/3c589_cs.c                     |    6 -
 drivers/net/pcmcia/axnet_cs.c                     |   12 +-
 drivers/net/pcmcia/fmvj18x_cs.c                   |    4 -
 drivers/net/pcmcia/nmclan_cs.c                    |    4 -
 drivers/net/pcmcia/pcnet_cs.c                     |    8 +
 drivers/net/pcmcia/smc91c92_cs.c                  |    6 -
 drivers/net/pcmcia/xirc2ps_cs.c                   |    4 -
 drivers/net/pcnet32.c                             |    6 -
 drivers/net/phy/phy.c                             |    2 
 drivers/net/plip.c                                |    6 -
 drivers/net/qla3xxx.c                             |    2 
 drivers/net/r8169.c                               |    7 -
 drivers/net/rrunner.c                             |    2 
 drivers/net/rrunner.h                             |    2 
 drivers/net/s2io.c                                |   12 +-
 drivers/net/s2io.h                                |    8 +
 drivers/net/saa9730.c                             |    3 
 drivers/net/sb1000.c                              |    4 -
 drivers/net/sb1250-mac.c                          |    4 -
 drivers/net/seeq8005.c                            |    4 -
 drivers/net/sgiseeq.c                             |    2 
 drivers/net/sis190.c                              |    4 -
 drivers/net/sis900.c                              |    6 -
 drivers/net/sk98lin/skge.c                        |   10 +-
 drivers/net/sk_mca.c                              |    2 
 drivers/net/skfp/skfddi.c                         |    5 -
 drivers/net/skge.c                                |    4 -
 drivers/net/sky2.c                                |    5 -
 drivers/net/smc-ultra.c                           |    2 
 drivers/net/smc911x.c                             |    6 -
 drivers/net/smc9194.c                             |    4 -
 drivers/net/smc91x.c                              |    2 
 drivers/net/smc91x.h                              |    2 
 drivers/net/sonic.c                               |    2 
 drivers/net/sonic.h                               |    2 
 drivers/net/spider_net.c                          |    4 -
 drivers/net/starfire.c                            |    4 -
 drivers/net/sun3_82586.c                          |    4 -
 drivers/net/sun3lance.c                           |    4 -
 drivers/net/sunbmac.c                             |    2 
 drivers/net/sundance.c                            |    4 -
 drivers/net/sungem.c                              |    4 -
 drivers/net/sunhme.c                              |    4 -
 drivers/net/sunlance.c                            |    2 
 drivers/net/sunqe.c                               |    2 
 drivers/net/tc35815.c                             |    4 -
 drivers/net/tg3.c                                 |   15 +-
 drivers/net/tlan.c                                |    7 -
 drivers/net/tokenring/3c359.c                     |    4 -
 drivers/net/tokenring/ibmtr.c                     |    6 -
 drivers/net/tokenring/lanstreamer.c               |    5 -
 drivers/net/tokenring/madgemc.c                   |    6 -
 drivers/net/tokenring/olympic.c                   |    4 -
 drivers/net/tokenring/smctr.c                     |    4 -
 drivers/net/tokenring/tms380tr.c                  |    2 
 drivers/net/tokenring/tms380tr.h                  |    2 
 drivers/net/tulip/de2104x.c                       |    2 
 drivers/net/tulip/de4x5.c                         |    4 -
 drivers/net/tulip/dmfe.c                          |    6 -
 drivers/net/tulip/interrupt.c                     |    2 
 drivers/net/tulip/tulip.h                         |    2 
 drivers/net/tulip/tulip_core.c                    |    2 
 drivers/net/tulip/uli526x.c                       |    4 -
 drivers/net/tulip/winbond-840.c                   |    4 -
 drivers/net/tulip/xircom_cb.c                     |    6 -
 drivers/net/tulip/xircom_tulip_cb.c               |    4 -
 drivers/net/typhoon.c                             |    2 
 drivers/net/ucc_geth.c                            |    5 -
 drivers/net/via-rhine.c                           |    6 -
 drivers/net/via-velocity.c                        |    5 -
 drivers/net/wan/cosa.c                            |    4 -
 drivers/net/wan/cycx_main.c                       |    4 -
 drivers/net/wan/dscc4.c                           |    4 -
 drivers/net/wan/farsync.c                         |    2 
 drivers/net/wan/hd6457x.c                         |    2 
 drivers/net/wan/lmc/lmc_main.c                    |    4 -
 drivers/net/wan/pc300_drv.c                       |    4 -
 drivers/net/wan/sbni.c                            |    4 -
 drivers/net/wan/sdla.c                            |    2 
 drivers/net/wan/wanxl.c                           |    2 
 drivers/net/wan/z85230.c                          |    2 
 drivers/net/wan/z85230.h                          |    2 
 drivers/net/wireless/airo.c                       |    5 -
 drivers/net/wireless/arlan-main.c                 |    4 -
 drivers/net/wireless/atmel.c                      |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c       |    4 -
 drivers/net/wireless/hostap/hostap_hw.c           |    2 
 drivers/net/wireless/ipw2100.c                    |    2 
 drivers/net/wireless/ipw2200.c                    |    2 
 drivers/net/wireless/netwave_cs.c                 |    6 -
 drivers/net/wireless/orinoco.c                    |    2 
 drivers/net/wireless/orinoco.h                    |    2 
 drivers/net/wireless/prism54/islpci_dev.c         |    2 
 drivers/net/wireless/prism54/islpci_dev.h         |    2 
 drivers/net/wireless/ray_cs.c                     |    4 -
 drivers/net/wireless/wavelan.c                    |    2 
 drivers/net/wireless/wavelan.p.h                  |    3 
 drivers/net/wireless/wavelan_cs.c                 |    3 
 drivers/net/wireless/wavelan_cs.p.h               |    3 
 drivers/net/wireless/wl3501_cs.c                  |    3 
 drivers/net/wireless/zd1201.c                     |    6 -
 drivers/net/wireless/zd1211rw/zd_usb.c            |    6 -
 drivers/net/yellowfin.c                           |    4 -
 drivers/net/znet.c                                |    4 -
 drivers/parisc/dino.c                             |    3 
 drivers/parisc/eisa.c                             |    4 -
 drivers/parisc/gsc.c                              |    4 -
 drivers/parisc/gsc.h                              |    2 
 drivers/parisc/power.c                            |    2 
 drivers/parisc/superio.c                          |    4 -
 drivers/parport/daisy.c                           |    2 
 drivers/parport/ieee1284.c                        |    2 
 drivers/parport/parport_amiga.c                   |    4 -
 drivers/parport/parport_atari.c                   |    4 -
 drivers/parport/parport_ax88796.c                 |    4 -
 drivers/parport/parport_gsc.c                     |    4 -
 drivers/parport/parport_ip32.c                    |   11 --
 drivers/parport/parport_mfc3.c                    |    2 
 drivers/parport/parport_pc.c                      |    4 -
 drivers/parport/parport_sunbpp.c                  |    2 
 drivers/parport/share.c                           |    2 
 drivers/pci/hotplug/cpci_hotplug_core.c           |    2 
 drivers/pci/hotplug/cpqphp.h                      |    2 
 drivers/pci/hotplug/cpqphp_ctrl.c                 |    2 
 drivers/pci/hotplug/pciehp_hpc.c                  |    6 -
 drivers/pci/hotplug/shpchp_hpc.c                  |    6 -
 drivers/pci/pcie/aer/aerdrv.c                     |    3 
 drivers/pcmcia/at91_cf.c                          |    2 
 drivers/pcmcia/hd64465_ss.c                       |    2 
 drivers/pcmcia/i82092.c                           |    2 
 drivers/pcmcia/i82092aa.h                         |    2 
 drivers/pcmcia/i82365.c                           |    9 +
 drivers/pcmcia/m32r_cfc.c                         |    7 -
 drivers/pcmcia/m32r_pcc.c                         |    4 -
 drivers/pcmcia/m8xx_pcmcia.c                      |    4 -
 drivers/pcmcia/omap_cf.c                          |    2 
 drivers/pcmcia/pcmcia_resource.c                  |    2 
 drivers/pcmcia/pd6729.c                           |    6 -
 drivers/pcmcia/soc_common.c                       |    2 
 drivers/pcmcia/tcic.c                             |   10 +-
 drivers/pcmcia/vrc4171_card.c                     |    2 
 drivers/pcmcia/vrc4173_cardu.c                    |    2 
 drivers/pcmcia/yenta_socket.c                     |    6 -
 drivers/pnp/resource.c                            |    2 
 drivers/rtc/rtc-at91.c                            |    3 
 drivers/rtc/rtc-ds1553.c                          |    3 
 drivers/rtc/rtc-pl031.c                           |    2 
 drivers/rtc/rtc-s3c.c                             |    4 -
 drivers/rtc/rtc-sa1100.c                          |    6 -
 drivers/rtc/rtc-sh.c                              |    4 -
 drivers/rtc/rtc-vr41xx.c                          |    4 -
 drivers/sbus/char/aurora.c                        |    4 -
 drivers/sbus/char/bbc_i2c.c                       |    2 
 drivers/sbus/char/cpwatchdog.c                    |    4 -
 drivers/sbus/char/uctrl.c                         |    2 
 drivers/scsi/3w-9xxx.c                            |    2 
 drivers/scsi/3w-xxxx.c                            |    3 
 drivers/scsi/53c700.c                             |    2 
 drivers/scsi/53c700.h                             |    2 
 drivers/scsi/53c7xx.c                             |    6 -
 drivers/scsi/BusLogic.c                           |    2 
 drivers/scsi/BusLogic.h                           |    2 
 drivers/scsi/NCR5380.c                            |    6 -
 drivers/scsi/NCR5380.h                            |    2 
 drivers/scsi/NCR53C9x.c                           |    6 -
 drivers/scsi/NCR53C9x.h                           |    2 
 drivers/scsi/NCR53c406a.c                         |   11 +-
 drivers/scsi/NCR_D700.c                           |    4 -
 drivers/scsi/NCR_Q720.c                           |    4 -
 drivers/scsi/a100u2w.c                            |    2 
 drivers/scsi/a2091.c                              |    2 
 drivers/scsi/a3000.c                              |    2 
 drivers/scsi/aacraid/rx.c                         |    4 -
 drivers/scsi/aacraid/sa.c                         |    2 
 drivers/scsi/advansys.c                           |    4 -
 drivers/scsi/aha152x.c                            |    6 -
 drivers/scsi/aha1542.c                            |   12 +-
 drivers/scsi/aha1740.c                            |    3 
 drivers/scsi/aic7xxx/aic79xx_osm.c                |    2 
 drivers/scsi/aic7xxx/aic79xx_osm.h                |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.c                |    2 
 drivers/scsi/aic7xxx/aic7xxx_osm.h                |    2 
 drivers/scsi/aic7xxx_old.c                        |   12 +-
 drivers/scsi/aic94xx/aic94xx_hwi.c                |    3 
 drivers/scsi/aic94xx/aic94xx_hwi.h                |    2 
 drivers/scsi/amiga7xx.h                           |    2 
 drivers/scsi/arcmsr/arcmsr_hba.c                  |    3 
 drivers/scsi/arm/acornscsi.c                      |    5 -
 drivers/scsi/arm/cumana_2.c                       |    3 
 drivers/scsi/arm/eesox.c                          |    3 
 drivers/scsi/arm/powertec.c                       |    4 -
 drivers/scsi/atari_NCR5380.c                      |    2 
 drivers/scsi/atari_dma_emul.c                     |    4 -
 drivers/scsi/atari_scsi.c                         |   10 +-
 drivers/scsi/atp870u.c                            |    2 
 drivers/scsi/bvme6000.h                           |    2 
 drivers/scsi/dc395x.c                             |    3 
 drivers/scsi/dec_esp.c                            |   12 +-
 drivers/scsi/dpt_i2o.c                            |    2 
 drivers/scsi/dpti.h                               |    2 
 drivers/scsi/eata.c                               |    5 -
 drivers/scsi/eata_pio.c                           |    7 -
 drivers/scsi/esp.c                                |    4 -
 drivers/scsi/fd_mcs.c                             |    4 -
 drivers/scsi/fdomain.c                            |    6 -
 drivers/scsi/gdth.c                               |    6 -
 drivers/scsi/gvp11.c                              |    2 
 drivers/scsi/hptiop.c                             |    2 
 drivers/scsi/ibmmca.c                             |    3 
 drivers/scsi/ibmvscsi/rpa_vscsi.c                 |    5 -
 drivers/scsi/in2000.c                             |    2 
 drivers/scsi/initio.c                             |    2 
 drivers/scsi/ipr.c                                |    3 
 drivers/scsi/ips.c                                |    4 -
 drivers/scsi/lpfc/lpfc_crtn.h                     |    2 
 drivers/scsi/lpfc/lpfc_sli.c                      |    2 
 drivers/scsi/mac53c94.c                           |   10 +-
 drivers/scsi/mac_esp.c                            |   14 +-
 drivers/scsi/megaraid.c                           |    6 -
 drivers/scsi/megaraid.h                           |    4 -
 drivers/scsi/megaraid/megaraid_mbox.c             |    4 -
 drivers/scsi/megaraid/megaraid_sas.c              |    2 
 drivers/scsi/mesh.c                               |    8 +
 drivers/scsi/mvme147.c                            |    2 
 drivers/scsi/mvme16x.h                            |    2 
 drivers/scsi/ncr53c8xx.c                          |    2 
 drivers/scsi/ncr53c8xx.h                          |    2 
 drivers/scsi/nsp32.c                              |    4 -
 drivers/scsi/pcmcia/nsp_cs.c                      |    2 
 drivers/scsi/pcmcia/nsp_cs.h                      |    2 
 drivers/scsi/pcmcia/sym53c500_cs.c                |    2 
 drivers/scsi/psi240i.c                            |    7 -
 drivers/scsi/qla1280.c                            |    2 
 drivers/scsi/qla2xxx/qla_def.h                    |    2 
 drivers/scsi/qla2xxx/qla_gbl.h                    |    6 -
 drivers/scsi/qla2xxx/qla_inline.h                 |    2 
 drivers/scsi/qla2xxx/qla_isr.c                    |    9 -
 drivers/scsi/qla4xxx/ql4_glbl.h                   |    2 
 drivers/scsi/qla4xxx/ql4_isr.c                    |    3 
 drivers/scsi/qlogicfas408.c                       |    6 -
 drivers/scsi/qlogicfas408.h                       |    2 
 drivers/scsi/qlogicpti.c                          |    4 -
 drivers/scsi/seagate.c                            |   11 +-
 drivers/scsi/sgiwd93.c                            |    2 
 drivers/scsi/stex.c                               |    2 
 drivers/scsi/sun3_NCR5380.c                       |    2 
 drivers/scsi/sun3_scsi.c                          |    6 -
 drivers/scsi/sun3_scsi_vme.c                      |    6 -
 drivers/scsi/sym53c416.c                          |    3 
 drivers/scsi/sym53c8xx_2/sym_glue.c               |    2 
 drivers/scsi/tmscsim.c                            |    6 -
 drivers/scsi/u14-34f.c                            |    5 -
 drivers/scsi/ultrastor.c                          |   13 +-
 drivers/scsi/wd7000.c                             |    2 
 drivers/serial/21285.c                            |    4 -
 drivers/serial/68328serial.c                      |    9 +
 drivers/serial/68360serial.c                      |    2 
 drivers/serial/8250.c                             |   14 +-
 drivers/serial/amba-pl010.c                       |   15 --
 drivers/serial/amba-pl011.c                       |   15 --
 drivers/serial/atmel_serial.c                     |    8 +
 drivers/serial/clps711x.c                         |    6 -
 drivers/serial/cpm_uart/cpm_uart_core.c           |   16 +-
 drivers/serial/crisv10.c                          |    6 -
 drivers/serial/dz.c                               |    2 
 drivers/serial/icom.c                             |    3 
 drivers/serial/imx.c                              |    8 +
 drivers/serial/ioc3_serial.c                      |   10 +-
 drivers/serial/ioc4_serial.c                      |    3 
 drivers/serial/ip22zilog.c                        |   18 +--
 drivers/serial/jsm/jsm.h                          |    2 
 drivers/serial/jsm/jsm_neo.c                      |    2 
 drivers/serial/m32r_sio.c                         |   14 +-
 drivers/serial/mcfserial.c                        |    2 
 drivers/serial/mpc52xx_uart.c                     |   10 +-
 drivers/serial/mpsc.c                             |    8 +
 drivers/serial/netx-serial.c                      |    8 +
 drivers/serial/pmac_zilog.c                       |   17 +--
 drivers/serial/pxa.c                              |   10 +-
 drivers/serial/s3c2410.c                          |    6 -
 drivers/serial/sa1100.c                           |    8 +
 drivers/serial/serial_lh7a40x.c                   |   16 --
 drivers/serial/serial_txx9.c                      |    8 +
 drivers/serial/sh-sci.c                           |   33 ++---
 drivers/serial/sn_console.c                       |   11 +-
 drivers/serial/sunhv.c                            |   10 +-
 drivers/serial/sunsab.c                           |   13 +-
 drivers/serial/sunsu.c                            |   19 +--
 drivers/serial/sunzilog.c                         |   31 ++---
 drivers/serial/v850e_uart.c                       |    4 -
 drivers/serial/vr41xx_siu.c                       |    9 +
 drivers/sn/ioc3.c                                 |   12 +-
 drivers/spi/pxa2xx_spi.c                          |    4 -
 drivers/spi/spi_mpc83xx.c                         |    3 
 drivers/spi/spi_s3c24xx.c                         |    2 
 drivers/tc/zs.c                                   |    6 -
 drivers/usb/atm/cxacru.c                          |    2 
 drivers/usb/atm/speedtch.c                        |    2 
 drivers/usb/atm/ueagle-atm.c                      |    2 
 drivers/usb/atm/usbatm.c                          |    2 
 drivers/usb/class/cdc-acm.c                       |    6 -
 drivers/usb/class/usblp.c                         |    4 -
 drivers/usb/core/devio.c                          |    2 
 drivers/usb/core/hcd.c                            |   15 +-
 drivers/usb/core/hcd.h                            |    9 -
 drivers/usb/core/hub.c                            |    2 
 drivers/usb/core/message.c                        |    4 -
 drivers/usb/gadget/at91_udc.c                     |    4 -
 drivers/usb/gadget/goku_udc.c                     |    2 
 drivers/usb/gadget/lh7a40x_udc.c                  |    2 
 drivers/usb/gadget/net2280.c                      |    2 
 drivers/usb/gadget/omap_udc.c                     |    9 -
 drivers/usb/gadget/pxa2xx_udc.c                   |   11 +-
 drivers/usb/host/ehci-hcd.c                       |   26 ++--
 drivers/usb/host/ehci-hub.c                       |    4 -
 drivers/usb/host/ehci-pci.c                       |    4 -
 drivers/usb/host/ehci-q.c                         |   21 ++-
 drivers/usb/host/ehci-sched.c                     |   21 +--
 drivers/usb/host/hc_crisv10.c                     |   12 +-
 drivers/usb/host/isp116x-hcd.c                    |   16 +-
 drivers/usb/host/ohci-hcd.c                       |   14 +-
 drivers/usb/host/ohci-hub.c                       |    8 +
 drivers/usb/host/ohci-q.c                         |   16 +-
 drivers/usb/host/sl811-hcd.c                      |   21 ++-
 drivers/usb/host/u132-hcd.c                       |    8 +
 drivers/usb/host/uhci-hcd.c                       |    8 +
 drivers/usb/host/uhci-hub.c                       |    2 
 drivers/usb/host/uhci-q.c                         |   15 +-
 drivers/usb/image/mdc800.c                        |    6 -
 drivers/usb/image/microtek.c                      |   10 +-
 drivers/usb/input/acecad.c                        |    2 
 drivers/usb/input/aiptek.c                        |   13 --
 drivers/usb/input/appletouch.c                    |    2 
 drivers/usb/input/ati_remote.c                    |   17 +--
 drivers/usb/input/ati_remote2.c                   |   14 +-
 drivers/usb/input/hid-core.c                      |   28 ++--
 drivers/usb/input/hid-input.c                     |    4 -
 drivers/usb/input/hid.h                           |    4 -
 drivers/usb/input/hiddev.c                        |    2 
 drivers/usb/input/itmtouch.c                      |    4 -
 drivers/usb/input/kbtab.c                         |    2 
 drivers/usb/input/keyspan_remote.c                |    7 -
 drivers/usb/input/mtouchusb.c                     |    3 
 drivers/usb/input/powermate.c                     |    7 -
 drivers/usb/input/touchkitusb.c                   |   15 +-
 drivers/usb/input/usbkbd.c                        |    6 -
 drivers/usb/input/usbmouse.c                      |    4 -
 drivers/usb/input/usbtouchscreen.c                |   15 +-
 drivers/usb/input/wacom.h                         |    4 -
 drivers/usb/input/wacom_sys.c                     |    9 -
 drivers/usb/input/wacom_wac.c                     |    9 -
 drivers/usb/input/xpad.c                          |    8 -
 drivers/usb/input/yealink.c                       |    9 +
 drivers/usb/misc/adutux.c                         |    4 -
 drivers/usb/misc/appledisplay.c                   |    2 
 drivers/usb/misc/auerswald.c                      |   30 ++---
 drivers/usb/misc/ftdi-elan.c                      |    2 
 drivers/usb/misc/ldusb.c                          |    4 -
 drivers/usb/misc/legousbtower.c                   |    8 +
 drivers/usb/misc/phidgetkit.c                     |    2 
 drivers/usb/misc/phidgetmotorcontrol.c            |    2 
 drivers/usb/misc/sisusbvga/sisusb.c               |    4 -
 drivers/usb/misc/usblcd.c                         |    2 
 drivers/usb/misc/usbtest.c                        |    8 +
 drivers/usb/misc/uss720.c                         |    4 -
 drivers/usb/net/asix.c                            |    2 
 drivers/usb/net/catc.c                            |    8 +
 drivers/usb/net/gl620a.c                          |    2 
 drivers/usb/net/kaweth.c                          |   10 +-
 drivers/usb/net/net1080.c                         |    2 
 drivers/usb/net/pegasus.c                         |   14 +-
 drivers/usb/net/rtl8150.c                         |   12 +-
 drivers/usb/net/usbnet.c                          |   10 +-
 drivers/usb/serial/aircable.c                     |    4 -
 drivers/usb/serial/airprime.c                     |    4 -
 drivers/usb/serial/belkin_sa.c                    |    4 -
 drivers/usb/serial/cyberjack.c                    |   12 +-
 drivers/usb/serial/cypress_m8.c                   |    8 +
 drivers/usb/serial/digi_acceleport.c              |    8 +
 drivers/usb/serial/empeg.c                        |    8 +
 drivers/usb/serial/ftdi_sio.c                     |    8 +
 drivers/usb/serial/garmin_gps.c                   |    6 -
 drivers/usb/serial/generic.c                      |    4 -
 drivers/usb/serial/io_edgeport.c                  |   16 +-
 drivers/usb/serial/io_ti.c                        |    6 -
 drivers/usb/serial/ipaq.c                         |    8 +
 drivers/usb/serial/ipw.c                          |    4 -
 drivers/usb/serial/ir-usb.c                       |    8 +
 drivers/usb/serial/keyspan.c                      |   52 ++++----
 drivers/usb/serial/keyspan_pda.c                  |    4 -
 drivers/usb/serial/kl5kusb105.c                   |    8 +
 drivers/usb/serial/kobil_sct.c                    |    8 +
 drivers/usb/serial/mct_u232.c                     |    4 -
 drivers/usb/serial/mos7840.c                      |    9 +
 drivers/usb/serial/navman.c                       |    2 
 drivers/usb/serial/omninet.c                      |    8 +
 drivers/usb/serial/option.c                       |   10 +-
 drivers/usb/serial/pl2303.c                       |    6 -
 drivers/usb/serial/safe_serial.c                  |    2 
 drivers/usb/serial/ti_usb_3410_5052.c             |   12 +-
 drivers/usb/serial/visor.c                        |   12 +-
 drivers/usb/serial/whiteheat.c                    |   16 +-
 drivers/usb/storage/onetouch.c                    |    3 
 drivers/usb/storage/transport.c                   |    2 
 drivers/usb/usb-skeleton.c                        |    2 
 drivers/video/amifb.c                             |    4 -
 drivers/video/arcfb.c                             |    3 
 drivers/video/atafb.c                             |    2 
 drivers/video/aty/atyfb_base.c                    |    2 
 drivers/video/au1200fb.c                          |    2 
 drivers/video/console/fbcon.c                     |    4 -
 drivers/video/intelfb/intelfbhw.c                 |    2 
 drivers/video/matrox/matroxfb_base.c              |    2 
 drivers/video/pvr2fb.c                            |    4 -
 drivers/video/pxafb.c                             |    2 
 drivers/video/s3c2410fb.c                         |    2 
 drivers/video/sa1100fb.c                          |    2 
 fs/proc/proc_misc.c                               |    2 
 include/asm-frv/dma.h                             |    5 -
 include/asm-frv/irq_regs.h                        |   27 ++++
 include/asm-frv/ptrace.h                          |    1 
 include/asm-generic/irq_regs.h                    |   37 ++++++
 include/asm-i386/apic.h                           |    4 -
 include/asm-i386/arch_hooks.h                     |    2 
 include/asm-i386/floppy.h                         |    6 -
 include/asm-i386/hpet.h                           |    2 
 include/asm-i386/hw_irq.h                         |    2 
 include/asm-i386/irq_regs.h                       |    1 
 include/asm-i386/mach-default/do_timer.h          |    8 +
 include/asm-i386/mach-visws/do_timer.h            |    8 +
 include/asm-i386/mach-voyager/do_timer.h          |    6 -
 include/asm-i386/voyager.h                        |    4 -
 include/asm-ia64/irq_regs.h                       |    1 
 include/asm-ia64/machvec.h                        |    4 -
 include/asm-mips/irq_regs.h                       |    1 
 include/asm-mips/time.h                           |    4 -
 include/asm-powerpc/irq.h                         |    2 
 include/asm-powerpc/irq_regs.h                    |    2 
 include/asm-powerpc/smp.h                         |    3 
 include/asm-x86_64/apic.h                         |    2 
 include/asm-x86_64/floppy.h                       |    6 -
 include/asm-x86_64/irq_regs.h                     |    1 
 include/asm-x86_64/proto.h                        |    4 -
 include/linux/adb.h                               |    4 -
 include/linux/arcdevice.h                         |    2 
 include/linux/hiddev.h                            |    4 -
 include/linux/ide.h                               |    2 
 include/linux/input.h                             |    7 -
 include/linux/interrupt.h                         |    9 +
 include/linux/ioc3.h                              |    2 
 include/linux/irq.h                               |   66 ++++------
 include/linux/libata.h                            |    4 -
 include/linux/parport.h                           |   16 +-
 include/linux/profile.h                           |    2 
 include/linux/rtc.h                               |    2 
 include/linux/serial_core.h                       |    7 -
 include/linux/serio.h                             |    5 -
 include/linux/sysrq.h                             |    6 -
 include/linux/usb.h                               |    3 
 include/linux/usb/serial.h                        |   12 +-
 include/sound/cs4231.h                            |    2 
 include/sound/emu10k1.h                           |    2 
 include/sound/gus.h                               |    2 
 include/sound/initval.h                           |    2 
 include/sound/mpu401.h                            |    6 -
 include/sound/sb.h                                |    6 -
 include/sound/vx_core.h                           |    2 
 kernel/irq/chip.c                                 |   48 +++----
 kernel/irq/handle.c                               |   19 +--
 kernel/irq/manage.c                               |    4 -
 kernel/irq/spurious.c                             |   10 +-
 kernel/power/poweroff.c                           |    3 
 kernel/profile.c                                  |    5 +
 lib/Makefile                                      |    2 
 lib/irq_regs.c                                    |   15 ++
 sound/aoa/core/snd-aoa-gpio-feature.c             |    4 -
 sound/aoa/soundbus/i2sbus/i2sbus-core.c           |    5 -
 sound/aoa/soundbus/i2sbus/i2sbus-pcm.c            |    4 -
 sound/aoa/soundbus/i2sbus/i2sbus.h                |    4 -
 sound/arm/aaci.c                                  |    2 
 sound/arm/pxa2xx-ac97.c                           |    2 
 sound/arm/pxa2xx-pcm.c                            |    2 
 sound/drivers/mpu401/mpu401_uart.c                |    8 -
 sound/drivers/mtpav.c                             |    2 
 sound/drivers/mts64.c                             |    2 
 sound/drivers/serial-u16550.c                     |    2 
 sound/drivers/vx/vx_core.c                        |    2 
 sound/isa/ad1816a/ad1816a_lib.c                   |    2 
 sound/isa/ad1848/ad1848_lib.c                     |    2 
 sound/isa/cs423x/cs4231_lib.c                     |    2 
 sound/isa/es1688/es1688_lib.c                     |    2 
 sound/isa/es18xx.c                                |    4 -
 sound/isa/gus/gus_irq.c                           |    2 
 sound/isa/gus/gusmax.c                            |    6 -
 sound/isa/gus/interwave.c                         |    6 -
 sound/isa/opl3sa2.c                               |    6 -
 sound/isa/opti9xx/opti92x-ad1848.c                |    2 
 sound/isa/sb/es968.c                              |    3 
 sound/isa/sb/sb16_main.c                          |    4 -
 sound/isa/sb/sb8.c                                |    2 
 sound/isa/sb/sb_common.c                          |    2 
 sound/isa/sgalaxy.c                               |    2 
 sound/isa/wavefront/wavefront.c                   |    4 -
 sound/mips/au1x00.c                               |    2 
 sound/oss/ad1816.c                                |    2 
 sound/oss/ad1848.c                                |    4 -
 sound/oss/ad1889.c                                |    2 
 sound/oss/btaudio.c                               |    2 
 sound/oss/cs46xx.c                                |    2 
 sound/oss/dmasound/dmasound_atari.c               |    4 -
 sound/oss/dmasound/dmasound_awacs.c               |   14 +-
 sound/oss/dmasound/dmasound_paula.c               |    4 -
 sound/oss/dmasound/dmasound_q40.c                 |    8 +
 sound/oss/emu10k1/irqmgr.c                        |    2 
 sound/oss/emu10k1/main.c                          |    2 
 sound/oss/es1371.c                                |    2 
 sound/oss/hal2.c                                  |    2 
 sound/oss/i810_audio.c                            |    2 
 sound/oss/mpu401.c                                |    2 
 sound/oss/mpu401.h                                |    3 
 sound/oss/msnd_pinnacle.c                         |    2 
 sound/oss/nec_vrc5477.c                           |    2 
 sound/oss/nm256.h                                 |    2 
 sound/oss/nm256_audio.c                           |    8 +
 sound/oss/pas2_card.c                             |    2 
 sound/oss/sb_common.c                             |    4 -
 sound/oss/sh_dac_audio.c                          |    2 
 sound/oss/swarm_cs4297a.c                         |    2 
 sound/oss/trident.c                               |    2 
 sound/oss/uart401.c                               |    2 
 sound/oss/uart6850.c                              |    2 
 sound/oss/via82cxxx_audio.c                       |    6 -
 sound/oss/vidc.h                                  |    2 
 sound/oss/vwsnd.c                                 |    4 -
 sound/oss/waveartist.c                            |    2 
 sound/parisc/harmony.c                            |    2 
 sound/pci/ad1889.c                                |    4 -
 sound/pci/ali5451/ali5451.c                       |    4 -
 sound/pci/als300.c                                |    6 -
 sound/pci/als4000.c                               |    4 -
 sound/pci/atiixp.c                                |    2 
 sound/pci/atiixp_modem.c                          |    2 
 sound/pci/au88x0/au88x0.h                         |    3 
 sound/pci/au88x0/au88x0_core.c                    |    4 -
 sound/pci/azt3328.c                               |    4 -
 sound/pci/bt87x.c                                 |    2 
 sound/pci/ca0106/ca0106_main.c                    |    3 
 sound/pci/cmipci.c                                |    4 -
 sound/pci/cs4281.c                                |    4 -
 sound/pci/cs46xx/cs46xx_lib.c                     |    2 
 sound/pci/cs5535audio/cs5535audio.c               |    3 
 sound/pci/echoaudio/echoaudio.c                   |    3 
 sound/pci/emu10k1/emu10k1x.c                      |    3 
 sound/pci/emu10k1/irq.c                           |    2 
 sound/pci/ens1370.c                               |    4 -
 sound/pci/es1938.c                                |    6 -
 sound/pci/es1968.c                                |    6 -
 sound/pci/fm801.c                                 |    4 -
 sound/pci/hda/hda_intel.c                         |    2 
 sound/pci/ice1712/ice1712.c                       |    6 -
 sound/pci/ice1712/ice1724.c                       |    4 -
 sound/pci/intel8x0.c                              |    2 
 sound/pci/intel8x0m.c                             |    2 
 sound/pci/korg1212/korg1212.c                     |    2 
 sound/pci/maestro3.c                              |    3 
 sound/pci/mixart/mixart_core.c                    |    2 
 sound/pci/mixart/mixart_core.h                    |    2 
 sound/pci/nm256/nm256.c                           |    6 -
 sound/pci/pcxhr/pcxhr_core.c                      |    2 
 sound/pci/pcxhr/pcxhr_core.h                      |    2 
 sound/pci/riptide/riptide.c                       |    5 -
 sound/pci/rme32.c                                 |    3 
 sound/pci/rme96.c                                 |    3 
 sound/pci/rme9652/hdsp.c                          |    2 
 sound/pci/rme9652/hdspm.c                         |    3 
 sound/pci/rme9652/rme9652.c                       |    2 
 sound/pci/sonicvibes.c                            |    4 -
 sound/pci/trident/trident_main.c                  |    7 -
 sound/pci/via82xx.c                               |    6 -
 sound/pci/via82xx_modem.c                         |    2 
 sound/pci/ymfpci/ymfpci_main.c                    |    4 -
 sound/pcmcia/pdaudiocf/pdaudiocf.h                |    2 
 sound/pcmcia/pdaudiocf/pdaudiocf_irq.c            |    4 -
 sound/ppc/pmac.c                                  |    6 -
 sound/ppc/tumbler.c                               |    2 
 sound/sparc/amd7930.c                             |    2 
 sound/sparc/cs4231.c                              |    2 
 sound/sparc/dbri.c                                |    3 
 sound/usb/usbaudio.c                              |    4 -
 sound/usb/usbmidi.c                               |    4 -
 sound/usb/usbmixer.c                              |    5 -
 sound/usb/usx2y/usbusx2y.c                        |    4 -
 sound/usb/usx2y/usbusx2yaudio.c                   |   10 +-
 sound/usb/usx2y/usx2yhwdeppcm.c                   |    6 -
 1080 files changed, 2638 insertions(+), 3006 deletions(-)
 create mode 100644 include/asm-frv/irq_regs.h
 create mode 100644 include/asm-generic/irq_regs.h
 create mode 100644 include/asm-i386/irq_regs.h
 create mode 100644 include/asm-ia64/irq_regs.h
 create mode 100644 include/asm-mips/irq_regs.h
 create mode 100644 include/asm-powerpc/irq_regs.h
 create mode 100644 include/asm-x86_64/irq_regs.h
 create mode 100644 lib/irq_regs.c
