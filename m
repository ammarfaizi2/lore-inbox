Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265401AbSJRXxM>; Fri, 18 Oct 2002 19:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSJRXxM>; Fri, 18 Oct 2002 19:53:12 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5650 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265401AbSJRXxI>;
	Fri, 18 Oct 2002 19:53:08 -0400
Date: Fri, 18 Oct 2002 16:58:38 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: [BK PATCH] PNP driver changes for 2.5.43
Message-ID: <20021018235838.GA11924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a changeset from Adam Belay that reworks the PNP driver layer.
I've tested this out on my machines and seems to work well.  It also
nicely integrates the pnp devices into driverfs.

I took his patch and put it into a bk repository, handling the file
renames that his original patch did.

Please pull from:  bk://linuxusb.bkbits.net/pnp-2.5

thanks,

greg k-h


 drivers/pnp/isapnp.c         | 2514 -------------------------------------------
 drivers/pnp/isapnp_proc.c    | 1134 -------------------
 drivers/pnp/pnpbios_core.c   | 1350 -----------------------
 drivers/pnp/pnpbios_proc.c   |  279 ----
 CREDITS                      |    5 
 Documentation/pnp.txt        |  250 ++++
 MAINTAINERS                  |    7 
 drivers/parport/parport_pc.c |   29 
 drivers/pnp/Config.help      |   29 
 drivers/pnp/Config.in        |   11 
 drivers/pnp/Makefile         |   14 
 drivers/pnp/base.h           |   11 
 drivers/pnp/compat.c         |   94 +
 drivers/pnp/core.c           |  176 +++
 drivers/pnp/driver.c         |  202 +++
 drivers/pnp/idlist.h         |  321 +++++
 drivers/pnp/interface.c      |  342 +++++
 drivers/pnp/isapnp/Makefile  |   11 
 drivers/pnp/isapnp/core.c    | 1193 ++++++++++++++++++++
 drivers/pnp/isapnp/proc.c    |  171 ++
 drivers/pnp/names.c          |   51 
 drivers/pnp/pnpbios/Makefile |   11 
 drivers/pnp/pnpbios/core.c   | 1572 ++++++++++++++++++++++++++
 drivers/pnp/pnpbios/proc.c   |  279 ++++
 drivers/pnp/quirks.c         |  140 +-
 drivers/pnp/resource.c       |  880 +++++++++++++++
 drivers/pnp/system.c         |  123 ++
 drivers/serial/8250_pnp.c    |  202 ---
 drivers/serial/Makefile      |    2 
 include/linux/isapnp.h       |   49 
 include/linux/pnp.h          |  285 ++++
 include/linux/pnpbios.h      |   75 -
 sound/oss/ad1848.c           |   52 
 sound/oss/opl3sa2.c          |  168 +-
 34 files changed, 6268 insertions(+), 5764 deletions(-)
-----

ChangeSet@1.803, 2002-10-18 16:51:11-07:00, ambx1@neo.rr.com
  [PATCH] PnP Rewrite V0.9 - 2.5.43
  
  The included patch is essentially a Linux Plug and Play Support rewrite.  It
  contains many significant improvements, including the following:
  
  
  1.)  A Global Plug and Play Layer
      - Now drivers do not have to worry about which plug and play
        protocol they are using.  Calls are made directly to the Linux
        Plug and Play Layer and then forwarded to the appropriate
        protocol.
      - This will make it very easy to integrate ACPI PnP support when
        it's ready
  
  
  2.)  A complete Plug and Play BIOS driver
      - The Plug and Play BIOS now supports reading and writing of
        resource configurations.
      - It is now possible to enable disabled PNPBIOS devices.  Therefore
        the user can safely enable PnP OS support in their BIOS.
  
  
  3.)  Driver Model Integration
      - The entire plug and play layer is integrated into the driver model
      - The user interface is housed here
      - PnP protocols are listed under the bus "pnp"
  
  
  4.)  A powerful global resource configuration interface
      - The user can use this to activate PnP devices for legacy and
        user-level drivers
      - See the documentation for how to configure devices.
  
  5.)  Automatic resource allocation for needed devices
  
  
  6.)  A PnP device name database
  
  And many more improvements.
  
  This patch also adds me to the maintainers list, considering the current
  PnP maintainer has been inactive for over 2 years now.

 drivers/pnp/isapnp.c         | 2514 -------------------------------------------
 drivers/pnp/isapnp_proc.c    | 1134 -------------------
 drivers/pnp/pnpbios_core.c   | 1350 -----------------------
 drivers/pnp/pnpbios_proc.c   |  279 ----
 CREDITS                      |    5 
 Documentation/pnp.txt        |  250 ++++
 MAINTAINERS                  |    7 
 drivers/parport/parport_pc.c |   29 
 drivers/pnp/Config.help      |   29 
 drivers/pnp/Config.in        |   11 
 drivers/pnp/Makefile         |   14 
 drivers/pnp/base.h           |   11 
 drivers/pnp/compat.c         |   94 +
 drivers/pnp/core.c           |  176 +++
 drivers/pnp/driver.c         |  202 +++
 drivers/pnp/idlist.h         |  321 +++++
 drivers/pnp/interface.c      |  342 +++++
 drivers/pnp/isapnp/Makefile  |   11 
 drivers/pnp/isapnp/core.c    | 1193 ++++++++++++++++++++
 drivers/pnp/isapnp/proc.c    |  171 ++
 drivers/pnp/names.c          |   51 
 drivers/pnp/pnpbios/Makefile |   11 
 drivers/pnp/pnpbios/core.c   | 1572 ++++++++++++++++++++++++++
 drivers/pnp/pnpbios/proc.c   |  279 ++++
 drivers/pnp/quirks.c         |  140 +-
 drivers/pnp/resource.c       |  880 +++++++++++++++
 drivers/pnp/system.c         |  123 ++
 drivers/serial/8250_pnp.c    |  202 ---
 drivers/serial/Makefile      |    2 
 include/linux/isapnp.h       |   49 
 include/linux/pnp.h          |  285 ++++
 include/linux/pnpbios.h      |   75 -
 sound/oss/ad1848.c           |   52 
 sound/oss/opl3sa2.c          |  168 +-
 34 files changed, 6268 insertions(+), 5764 deletions(-)
------

