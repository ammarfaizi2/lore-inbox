Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSKTQwI>; Wed, 20 Nov 2002 11:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSKTQwI>; Wed, 20 Nov 2002 11:52:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:19350 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261463AbSKTQwB>;
	Wed, 20 Nov 2002 11:52:01 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: Arnd Bergmann <com.ibm@arndb.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] s390 device drivers rewrite
Date: Wed, 20 Nov 2002 19:55:46 +0100
User-Agent: KMail/1.4.3
Organization: IBM Deutschland Entwicklung GmbH
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Cornelia Huck <cohuck@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211201953.20508.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have set up a BK repository with a preview of some s390
specific device drivers on http://linux-390.bkbits.net/main/ .

This finally introduces support for the driver model
in our drivers and gets rid of some really ugly code.
Some parts don't work right now, but the major changes
are included.

Changelog and diffstat output follows below. If you have
comments/flames/requests for one of the changesets,
please cc: all the authors.

	Arnd <><

--------------------------------------------
02/11/20	arnd@b551138y.boeblingen.de.ibm.com	1.907.1.1
rewrite of the s390 channel subsystem driver for the new driver model

The channel subsystem driver a.k.a s390 common I/O layer is the low level
driver for most device drivers on s390 systems. The old code is largely
unchanged from the initial linux-2.2 port and there is a lot of bitrot
on it.

In particular, concepts from the 2.5 driver model are implemented in a 
completely different and more complicated way here.
This rewrite tries to get the driver ready for 2.6. The new interface is 
not compatible to the old one but should be rather stable now unless
someone finds major flaws.

The driver internals are still being worked on and this is not ready for
inclusion but is stable enough to work with.

The 's390dyn' and 'chandev' interfaces have been removed entirely (yippii!)
and are replaced by hotplug and sysfs interfaces. There are three bus
drivers reflecting different layers of abstractions:
The channel subsystem bus contains all subchannels which resemble the host
side of device connections. Most of these subchannels are used by the
i/o subchannel driver and connected to client devices like tapes or
dasd. These are now called 'ccw_device's and belong to the 'ccw_dev_bus'.

The third bus contains 'ccw_group' devices, which needed because of
strange hardware properties: Some device drivers need two or more
ccw_devices to make up a logical device and the user has to configure
which ones belong together. We have not found a way to represent this
correctly using the linux driver model, the current implementation
is about as good as it gets.

Authors: Arnd Bergmann <arndb@de.ibm.com>, 
         Cornelia Huck <cohuck@de.ibm.com>,
         Martin Schwidefsky <schwidefsky@de.ibm.com>
--------------------------------------------
02/11/20	arnd@b551138y.boeblingen.de.ibm.com	1.907.1.2
[s390] convert dasd driver to new channel subsystem driver

This makes the dasd driver work again after the changes to
the channel subsystem driver:
- handle device detection with standard driver model functions
- reduce use of dasd_devmap (devmap will die as soon as 
  dasd configuration is handled from initramfs)
- some cleanups

Authors: Arnd Bergmann <arndb@de.ibm.com>
	 Martin Schwidefsky <schwidefsky@de.ibm.com>
--------------------------------------------
02/11/20	arnd@b551138y.boeblingen.de.ibm.com	1.907.1.3
[s390] convert 3215 console driver to new channel subsystem driver

this adds support for the driver model to the 3215 driver. The console
is one of the biggest problems because the regular device detection
is now done at initcall time although we actually want full
support for channel attached console devices as early as possible.
con3215_init() now uses a special s390_probe_console() function
to do an early initialization of a single device.

The main backdraw for users is that the console can no longer
be autodetected when not running under VM. LPAR or P390 users
with a channel attached console now have to specify
console_device=f00 as a kernel parameter.

Authors:
	Martin Schwidefsky <schwidefsky@de.ibm.com>
	Arnd Bergmann <arndb@de.ibm.com>
--------------------------------------------
02/11/20	arnd@b551138y.boeblingen.de.ibm.com	1.907.1.4
[s390] add driver for multi-subchannel devices (ctc and lcs)

The cu3088 driver is an attempt to make the ctc and lcs
(potentially also claw) drivers work with the new
channel subsystem driver.

The current version is broken in several aspects and part of it
will be replaced by the ccwgroup driver. The driver as it is now
will not be submitted for inclusion but you can use it to experiment
with the ctc and lcs drivers.

Authors:
	Arnd Bergmann <arndb@de.ibm.com>
	Cornelia Huck <cohuck@de.ibm.com>
--------------------------------------------
02/11/20	arnd@b551138y.boeblingen.de.ibm.com	1.907.1.5
[s390] ctc crapectomy

- fix lots of bitrot
- port to cu3088 driver (will be changed to ccwgroup)

Authors:
	Cornelia Huck <cohuck@de.ibm.com>
	Arnd Bergmann <arndb@de.ibm.com>
--------------------------------------------
02/11/20	arnd@b551138y.boeblingen.de.ibm.com	1.907.1.6
[s390] major rewrite of lcs driver

This driver is starting to make sense.
Like the ctc driver, this one currently uses the cu3088 driver,
which is being replaced by ccwgroup, so some parts still
need changes.

Authors:
	Frank Pavlic <pavlic@de.ibm.com>
	Martin Schwidefsky <schwidefsky@de.ibm.com>
--------------------------------------------
02/11/20	arnd@b551138y.boeblingen.de.ibm.com	1.907.1.7
 [s390] rework of tape driver

  Almost complete rewrite of the s390 tape driver code by
  Martin Schwidefsky. Skipping the 2.4 era, this makes the tape
  code ready for the future. Code size is reduced by one third
  and the code becomes readable.

  This driver probably doesn't have to change much before
  2.6.

Author:	Martin Schwidefsky <schwidefsky@de.ibm.com>
	Stefan Bader <shbader@de.ibm.com>
--------------------------------------------
02/11/20	arnd@b551138y.boeblingen.de.ibm.com	1.907.1.8
[s390] update iucv driver for new driver model

iucv device configuration is now done through sysfs instead of /proc

Author: Cornelia Huck <cohuck@de.ibm.com>
--------------------------------------------

combined diffstat output:

 115 files changed, 16300 insertions(+), 24988 deletions(-)

 Documentation/s390/cds.txt          |  689 ----
 Documentation/s390/chandev.8        |  429 --
 Documentation/s390/driver-model.txt |  236 +
 arch/s390/kernel/setup.c            |   11
 arch/s390/kernel/smp.c              |    7
 drivers/s390/Kconfig                |   79
 drivers/s390/Makefile               |    4
 drivers/s390/block/dasd.c           |  947 ++----
 drivers/s390/block/dasd_3370_erp.c  |    7
 drivers/s390/block/dasd_3370_erp.h  |   15
 drivers/s390/block/dasd_3990_erp.c  |   44
 drivers/s390/block/dasd_3990_erp.h  |   26
 drivers/s390/block/dasd_9336_erp.c  |    7
 drivers/s390/block/dasd_9336_erp.h  |   15
 drivers/s390/block/dasd_9343_erp.c  |   10
 drivers/s390/block/dasd_9343_erp.h  |   17
 drivers/s390/block/dasd_devmap.c    |  122
 drivers/s390/block/dasd_diag.c      |   88
 drivers/s390/block/dasd_diag.h      |    7
 drivers/s390/block/dasd_eckd.c      |  295 --
 drivers/s390/block/dasd_eckd.h      |   22
 drivers/s390/block/dasd_erp.c       |   40
 drivers/s390/block/dasd_fba.c       |  147 -
 drivers/s390/block/dasd_fba.h       |   13
 drivers/s390/block/dasd_genhd.c     |   38
 drivers/s390/block/dasd_int.h       |   64
 drivers/s390/block/dasd_ioctl.c     |  182 -
 drivers/s390/block/dasd_proc.c      |  267 -
 drivers/s390/char/con3215.c         |  919 +++---
 drivers/s390/char/tape.h            |  566 +--
 drivers/s390/char/tape3480.c        |   96
 drivers/s390/char/tape3480.h        |   23
 drivers/s390/char/tape3490.c        |   97
 drivers/s390/char/tape3490.h        |   23
 drivers/s390/char/tape34xx.c        | 1254 --------
 drivers/s390/char/tape34xx.h        |  133
 drivers/s390/char/tape_34xx.c       |  978 ++++++
 drivers/s390/char/tape_block.c      |  355 ++
 drivers/s390/char/tape_char.c       |  391 ++
 drivers/s390/char/tape_core.c       |  933 ++++++
 drivers/s390/char/tape_proc.c       |  144
 drivers/s390/char/tape_std.c        |  657 ++++
 drivers/s390/char/tape_std.h        |  144
 drivers/s390/char/tapeblock.c       |  441 ---
 drivers/s390/char/tapeblock.h       |   36
 drivers/s390/char/tapechar.c        |  627 ----
 drivers/s390/char/tapechar.h        |   40
 drivers/s390/char/tapedefs.h        |   77
 drivers/s390/cio/Makefile           |    9
 drivers/s390/cio/airq.c             |   31
 drivers/s390/cio/blacklist.c        |  139
 drivers/s390/cio/blacklist.h        |    2
 drivers/s390/cio/ccwgroup.c         |  318 ++
 drivers/s390/cio/chsc.c             |  873 +++--
 drivers/s390/cio/chsc.h             |   25
 drivers/s390/cio/cio.c              | 2376 ++++++----------
 drivers/s390/cio/cio.h              |  215 +
 drivers/s390/cio/cio_debug.c        |   72
 drivers/s390/cio/cio_debug.h        |   70
 drivers/s390/cio/css.c              |  441 +++
 drivers/s390/cio/css.h              |  101
 drivers/s390/cio/device.c           |  877 ++++++
 drivers/s390/cio/device_fsm.c       | 1169 ++++++++
 drivers/s390/cio/device_fsm.h       |   69
 drivers/s390/cio/ioasm.h            |  305 ++
 drivers/s390/cio/ioinfo.c           |  292 --
 drivers/s390/cio/ioinfo.h           |   10
 drivers/s390/cio/misc.c             |  235 -
 drivers/s390/cio/misc.h             |    4
 drivers/s390/cio/proc.c             |  275 -
 drivers/s390/cio/proc.h             |   19
 drivers/s390/cio/requestirq.c       |  469 ---
 drivers/s390/cio/s390io.c           | 2494 +----------------
 drivers/s390/cio/s390io.h           |   20
 drivers/s390/misc/chandev.c         | 3304 ----------------------
 drivers/s390/net/Makefile           |    6
 drivers/s390/net/ctcmain.c          | 2831 ++++++-------------
 drivers/s390/net/ctctty.c           |   44
 drivers/s390/net/ctctty.h           |   16
 drivers/s390/net/cu3088.c           |  399 ++
 drivers/s390/net/cu3088.h           |   70
 drivers/s390/net/lcs.c              | 5256 ++++++++++--------------------------
 drivers/s390/net/lcs.h              |  287 +
 drivers/s390/net/netiucv.c          |  557 +--
 drivers/s390/qdio.c                 |  352 --
 drivers/s390/s390dyn.c              |  160 -
 drivers/s390/s390mach.c             |  647 ----
 drivers/s390/s390mach.h             |   83
 fs/partitions/ibm.c                 |    5
 include/asm-s390/ccwdev.h           |  195 +
 include/asm-s390/ccwgroup.h         |   41
 include/asm-s390/chandev.h          |  237 -
 include/asm-s390/cio.h              |  362 ++
 include/asm-s390/dasd.h             |    4
 include/asm-s390/idals.h            |  147 -
 include/asm-s390/irq.h              |  907 ------
 include/asm-s390/qdio.h             |   96
 include/asm-s390/s390dyn.h          |   56
 include/asm-s390/s390io.h           |  124
 include/asm-s390/s390mach.h         |  119
 include/asm-s390/setup.h            |    1


