Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbTCNAuv>; Thu, 13 Mar 2003 19:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263162AbTCNAuv>; Thu, 13 Mar 2003 19:50:51 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48395 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263118AbTCNAut>;
	Thu, 13 Mar 2003 19:50:49 -0500
Date: Thu, 13 Mar 2003 16:50:27 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: [BK PATCH] i2c driver changes for 2.5.64
Message-ID: <20030314005027.GA1923@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a set of i2c driver changes that start the conversion of the i2c
core and drivers over to the kernel driver model.  Eventually this will
allow all of the sysctl and proc mess to be removed for this subsystem.

These patches add i2c driver bus and i2c adapter driver support to the
driver core.  They also export a needed symbol from the driver core
(which Pat Mochel agreed with doing.) The patches also add three i2c
controllers that have been in the i2c cvs tree for a long time, and are
on a lot of people's machines.

The i2c core needs Christoph's previous patches to work properly, and
with that patch, and these patches, it all works properly on my machines
(tested on 4 different types of i2c controllers.)

Oh, and the i2c development team has given the ok for me to send these
patches to you, and for me to do this work.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5


Things left to do after this:
	- clean up #ifdef mess in i2c controllers
	- fix the printk() calls to use proper levels
	- add i2c controller driver core support (present in the patch I
	  previously sent to lkml).
	- add i2c device core support.

thanks,

greg k-h

 arch/i386/kernel/dmi_scan.c      |    3 
 drivers/base/platform.c          |    3 
 drivers/i2c/busses/Kconfig       |   62 +++
 drivers/i2c/busses/Makefile      |    3 
 drivers/i2c/busses/i2c-ali15x3.c |  625 +++++++++++++++++++++++++++++-
 drivers/i2c/busses/i2c-amd756.c  |    3 
 drivers/i2c/busses/i2c-amd8111.c |    5 
 drivers/i2c/busses/i2c-i801.c    |  789 +++++++++++++++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-piix4.c   |  651 ++++++++++++++++++++++++++++----
 drivers/i2c/i2c-core.c           |   46 ++
 include/linux/device.h           |    1 
 include/linux/i2c.h              |    5 
 12 files changed, 2063 insertions(+), 133 deletions(-)
-----

ChangeSet@1.1114, 2003-03-13 16:39:40-08:00, greg@kroah.com
  i2c: add driver model support to i2c adapter drivers

 drivers/i2c/busses/i2c-ali15x3.c |    6 ++++--
 drivers/i2c/busses/i2c-amd756.c  |    3 +++
 drivers/i2c/busses/i2c-amd8111.c |    5 ++++-
 drivers/i2c/busses/i2c-i801.c    |    5 ++++-
 drivers/i2c/busses/i2c-piix4.c   |    3 +++
 drivers/i2c/i2c-core.c           |   13 +++++++++++++
 include/linux/i2c.h              |    2 ++
 7 files changed, 33 insertions(+), 4 deletions(-)
------

ChangeSet@1.1113, 2003-03-13 16:37:27-08:00, greg@kroah.com
  driver core: Export the legacy_bus structure for drivers to use.

 drivers/base/platform.c |    3 ++-
 include/linux/device.h  |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)
------

ChangeSet@1.1112, 2003-03-13 12:26:39-08:00, greg@kroah.com
  i2c: add i2c sysfs bus support.

 drivers/i2c/i2c-core.c |   33 ++++++++++++++++++++++++++++++---
 include/linux/i2c.h    |    3 +++
 2 files changed, 33 insertions(+), 3 deletions(-)
------

ChangeSet@1.1111, 2003-03-13 12:16:52-08:00, greg@kroah.com
  i2c: i2c-piix4.c: Clean up the ibm dma scan logic
  
  Also export the is_unsafe_smbus variable, which is needed.

 arch/i386/kernel/dmi_scan.c    |    3 +++
 drivers/i2c/busses/i2c-piix4.c |   20 ++------------------
 2 files changed, 5 insertions(+), 18 deletions(-)
------

ChangeSet@1.1110, 2003-03-13 11:59:13-08:00, greg@kroah.com
  i2c: get i2c-piix4 driver to actually bind to a PCI device.

 drivers/i2c/busses/i2c-piix4.c |   99 +++++++++++++++++++++--------------------
 1 files changed, 52 insertions(+), 47 deletions(-)
------

ChangeSet@1.1109, 2003-03-13 11:52:26-08:00, greg@kroah.com
  i2c: add bus driver for Intel PIIX4 devices
  
  This is from the i2c CVS tree.

 drivers/i2c/busses/Kconfig     |   25 +
 drivers/i2c/busses/Makefile    |    1 
 drivers/i2c/busses/i2c-piix4.c |  529 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 554 insertions(+), 1 deletion(-)
------

ChangeSet@1.1108, 2003-03-13 11:38:03-08:00, greg@kroah.com
  i2c: get i2c-i801 driver to actually bind to a PCI device.

 drivers/i2c/busses/i2c-i801.c |   74 +++++++++++++++++++++---------------------
 1 files changed, 38 insertions(+), 36 deletions(-)
------

ChangeSet@1.1107, 2003-03-13 11:15:15-08:00, greg@kroah.com
  i2c: add bus driver for Intel 801 devices
  
  This is from the i2c CVS tree.

 drivers/i2c/busses/Kconfig    |   23 +
 drivers/i2c/busses/Makefile   |    1 
 drivers/i2c/busses/i2c-i801.c |  710 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 734 insertions(+)
------

ChangeSet@1.1106, 2003-03-13 10:50:41-08:00, greg@kroah.com
  i2c: get i2c-ali15x3 driver to actually bind to a PCI device.

 drivers/i2c/busses/i2c-ali15x3.c |   32 +++++++++-----------------------
 1 files changed, 9 insertions(+), 23 deletions(-)
------

ChangeSet@1.1105, 2003-03-13 10:31:07-08:00, greg@kroah.com
  i2c: add bus driver for ALI15x3 devices
  
  This is from the i2c CVS tree.

 drivers/i2c/busses/Kconfig       |   14 
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-ali15x3.c |  587 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 602 insertions(+)
------

