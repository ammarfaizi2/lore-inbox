Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261683AbTCVAxF>; Fri, 21 Mar 2003 19:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261684AbTCVAxF>; Fri, 21 Mar 2003 19:53:05 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48648 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261683AbTCVAxB>;
	Fri, 21 Mar 2003 19:53:01 -0500
Date: Fri, 21 Mar 2003 17:04:05 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] More i2c driver changes for 2.5.65
Message-ID: <20030322010405.GA18613@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more i2c driver changes for 2.5.65.  These include changes
that now hook up the i2c devices to the driver core.  This results in a
sysfs tree that looks like the following on one of my boxes:

/sys/bus/i2c/
|-- devices
|   `-- i2c_dev_0 -> ../../../devices/pci0/00:1f.3/i2c-0/i2c_dev_0
`-- drivers
    `-- LM75 sensor
        `-- i2c_dev_0 -> ../../../../devices/pci0/00:1f.3/i2c-0/i2c_dev_0


Now the fun work of starting to rip out the i2c sysctl and proc code can
begin :)

These changesets also include the patch from Petr Vandrovec that fixes
an oops on booting with i2c built into the kernel, and some more minor
cleanups to some of the i2c core code.

I'll try to post a document later this weekend on lkml and
kernel-janitors-discuss that explains how the i2c drivers will need to
be converted, and how people can help out now that the infrastructure is
finished.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/busses/i2c-ali15x3.c |    8 +
 drivers/i2c/busses/i2c-amd756.c  |    6 -
 drivers/i2c/busses/i2c-amd8111.c |    4 
 drivers/i2c/busses/i2c-i801.c    |    8 +
 drivers/i2c/busses/i2c-isa.c     |    4 
 drivers/i2c/busses/i2c-piix4.c   |    8 +
 drivers/i2c/chips/adm1021.c      |   21 ++--
 drivers/i2c/chips/lm75.c         |   14 +--
 drivers/i2c/i2c-algo-bit.c       |   13 +-
 drivers/i2c/i2c-algo-pcf.c       |   19 +---
 drivers/i2c/i2c-core.c           |   99 ++++++++++-----------
 drivers/i2c/i2c-dev.c            |   21 ++--
 drivers/i2c/i2c-elektor.c        |   10 +-
 drivers/i2c/i2c-elv.c            |    6 -
 drivers/i2c/i2c-philips-par.c    |    4 
 drivers/i2c/i2c-proc.c           |  180 ++++++++++-----------------------------
 drivers/i2c/i2c-velleman.c       |    4 
 drivers/i2c/scx200_acb.c         |   32 +++---
 include/linux/i2c.h              |   33 ++++---
 19 files changed, 218 insertions(+), 276 deletions(-)

-----
Short log:
-----

Greg Kroah-Hartman <greg@kroah.com>:
  o i2c: ugh, clean up lindent mess in i2c-proc.c::i2c_detect()
  o i2c: fix up the chip driver names to play nice with sysfs
  o i2c: actually register the i2c client device with the driver core
  o i2c: Removed the name variable from i2c_client as the dev one should be used instead
  o i2c: remove the data field from struct i2c_client
  o i2c: add struct device to i2c_client structure
  o i2c: remove *data from i2c_adapter, as dev->data should be used instead
  o i2c: remove i2c_adapter->name and use dev->name instead

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o Fix kobject_get oopses triggered by i2c in 2.5.65-bk

-----
Long log:
-----

ChangeSet@1.1196, 2003-03-21 16:45:59-08:00, greg@kroah.com
  i2c: ugh, clean up lindent mess in i2c-proc.c::i2c_detect()
  
  Yes, this function now goes beyond 80 columns, but it's almost 
  readable, while the previous version was not.
  
  Also removed some #ifdefs

 drivers/i2c/i2c-proc.c |  180 ++++++++++++-------------------------------------
 1 files changed, 47 insertions(+), 133 deletions(-)
------

ChangeSet@1.1195, 2003-03-21 16:39:04-08:00, greg@kroah.com
  [PATCH] i2c: fix up the chip driver names to play nice with sysfs

 drivers/i2c/chips/adm1021.c |    2 +-
 drivers/i2c/chips/lm75.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.1194, 2003-03-21 16:26:04-08:00, greg@kroah.com
  i2c: actually register the i2c client device with the driver core.
  
  We have to initialize the client structure with 0 to keep the
  driver core from oopsing.
  
  Now everything is hooked up enough to start removing the i2c sysctl
  and proc crud.

 drivers/i2c/chips/adm1021.c |    2 ++
 drivers/i2c/chips/lm75.c    |    2 ++
 drivers/i2c/i2c-core.c      |   10 ++++++++++
 3 files changed, 14 insertions(+)
------

ChangeSet@1.1193, 2003-03-21 16:16:01-08:00, greg@kroah.com
  i2c: Removed the name variable from i2c_client as the dev one should be used instead.

 drivers/i2c/chips/adm1021.c |    2 +-
 drivers/i2c/chips/lm75.c    |    2 +-
 drivers/i2c/i2c-core.c      |   14 +++++++-------
 drivers/i2c/i2c-dev.c       |    4 +++-
 include/linux/i2c.h         |    1 -
 5 files changed, 12 insertions(+), 11 deletions(-)
------

ChangeSet@1.1192, 2003-03-21 16:07:30-08:00, greg@kroah.com
  [PATCH] i2c: remove the data field from struct i2c_client
  
  It's no longer needed, as the struct device should be used instead.
  
  Created i2c_get_clientdata() and i2c_set_clientdata() to access the data.

 drivers/i2c/chips/adm1021.c |   15 +++++++--------
 drivers/i2c/chips/lm75.c    |    8 ++++----
 include/linux/i2c.h         |   11 ++++++++++-
 3 files changed, 21 insertions(+), 13 deletions(-)
------

ChangeSet@1.1191, 2003-03-21 16:00:39-08:00, greg@kroah.com
  i2c: add struct device to i2c_client structure
  
  Not quite ready to hook it up to the driver core yet.

 include/linux/i2c.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.1190, 2003-03-21 14:38:21-08:00, greg@kroah.com
  [PATCH] i2c: remove *data from i2c_adapter, as dev->data should be used instead.

 drivers/i2c/i2c-elv.c    |    2 +-
 drivers/i2c/scx200_acb.c |    4 ++--
 include/linux/i2c.h      |   17 +++++++++++------
 3 files changed, 14 insertions(+), 9 deletions(-)
------

ChangeSet@1.1189, 2003-03-21 12:45:28-08:00, greg@kroah.com
  i2c: remove i2c_adapter->name and use dev->name instead.

 drivers/i2c/busses/i2c-ali15x3.c |    8 ++--
 drivers/i2c/busses/i2c-amd756.c  |    6 ++-
 drivers/i2c/busses/i2c-amd8111.c |    4 +-
 drivers/i2c/busses/i2c-i801.c    |    8 ++--
 drivers/i2c/busses/i2c-isa.c     |    4 +-
 drivers/i2c/busses/i2c-piix4.c   |    8 ++--
 drivers/i2c/i2c-algo-bit.c       |   13 +++---
 drivers/i2c/i2c-algo-pcf.c       |   19 ++++------
 drivers/i2c/i2c-core.c           |   73 ++++++++++++++++-----------------------
 drivers/i2c/i2c-dev.c            |   17 +++------
 drivers/i2c/i2c-elektor.c        |   10 +++--
 drivers/i2c/i2c-elv.c            |    4 +-
 drivers/i2c/i2c-philips-par.c    |    4 +-
 drivers/i2c/i2c-velleman.c       |    4 +-
 drivers/i2c/scx200_acb.c         |   28 ++++++--------
 include/linux/i2c.h              |    1 
 16 files changed, 105 insertions(+), 106 deletions(-)
------

ChangeSet@1.1188, 2003-03-21 12:29:44-08:00, vandrove@vc.cvut.cz
  [PATCH] Fix kobject_get oopses triggered by i2c in 2.5.65-bk
  
  i2c initialization must not use module_init now, when it was converted
  to the kobject interface. There are dozens of users which need it working
  much sooner. i2c is subsystem after all, isn't it?
  
  Fixes kernel oopses in kobject_get during system init which were happening
  to me.

Push file://home/greg/linux/BK/i2c-2.5 -> file://home/greg/linux/BK/bleed-2.5
 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------
