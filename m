Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbSJ2SgY>; Tue, 29 Oct 2002 13:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262152AbSJ2SgY>; Tue, 29 Oct 2002 13:36:24 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:33549 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262148AbSJ2SgV>;
	Tue, 29 Oct 2002 13:36:21 -0500
Date: Tue, 29 Oct 2002 10:40:10 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: [BK PATCH] PNP driver changes for 2.5.44
Message-ID: <20021029184010.GA27082@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a set of updated PNP driver patches from Adam Belay.

Please pull from:  bk://linuxusb.bkbits.net/pnp-2.5

thanks,

greg k-h


 drivers/pnp/compat.c        |   94 ----------------------------------------
 drivers/pnp/Config.in       |   16 +++---
 drivers/pnp/Makefile        |    4 -
 drivers/pnp/base.h          |    3 -
 drivers/pnp/core.c          |    5 --
 drivers/pnp/driver.c        |   19 ++++++--
 drivers/pnp/isapnp/Makefile |    4 -
 drivers/pnp/isapnp/compat.c |   94 ++++++++++++++++++++++++++++++++++++++++
 drivers/pnp/names.c         |    1 
 drivers/pnp/pnpbios/core.c  |  101 ++++++++++++++++++++++++++++++--------------
 drivers/pnp/quirks.c        |    1 
 drivers/pnp/resource.c      |   72 +++++++++++++++++++++++--------
 include/linux/pnp.h         |   62 ++++++++++++++++-----------
 sound/oss/ad1848.c          |    5 --
 sound/oss/cs4232.c          |   88 ++++++++++++++------------------------
 15 files changed, 317 insertions(+), 252 deletions(-)
-----

ChangeSet@1.808.31.1, 2002-10-28 21:30:10-08:00, greg@kroah.com
  merge

 include/linux/pnp.h |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)
------

ChangeSet@1.808.4.5, 2002-10-24 00:27:01-07:00, ambx1@neo.rr.com
  [PATCH] update PnP layer to driver model changes - 2.5.44 (4/4)
  
  Updates to the driver model changes.  This should fix a potential panic.

 drivers/pnp/driver.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.808.4.4, 2002-10-24 00:26:22-07:00, ambx1@neo.rr.com
  [PATCH] Convert CS4236B driver - 2.5.44 (3/4)
  
  This patch converts the CS4236B sound card driver to the new PnP APIs.  Also it
  makes pnp_driver_register return the number of matches during the driver add.
  This should serve as a sample driver, along with the serial and parport_pc.

 drivers/pnp/driver.c |   12 ++++++
 include/linux/pnp.h  |    1 
 sound/oss/ad1848.c   |    5 --
 sound/oss/cs4232.c   |   88 +++++++++++++++++++--------------------------------
 4 files changed, 45 insertions(+), 61 deletions(-)
------

ChangeSet@1.808.4.3, 2002-10-24 00:25:49-07:00, ambx1@neo.rr.com
  [PATCH] PnPBIOS changes - 2.5.44 (2/4)
  
  This patch adds compatible PnP ID support to the PnPBIOS protocol.  None of my
  test systems take advantage of this feature but it is included in the
  specifications so it makes sense to support it.  If anyone does get a compatible
  ID listed for the PnPBIOS I'd be interested to hear about it (if more than 1 id
  is listed when viewing the driverfs file 'id' within the PnPBIOS protocol).  Also
  it fixes the dma and mem resource problem.

 drivers/pnp/pnpbios/core.c |  101 +++++++++++++++++++++++++++++++--------------
 1 files changed, 70 insertions(+), 31 deletions(-)
------

ChangeSet@1.808.4.2, 2002-10-24 00:25:27-07:00, ambx1@neo.rr.com
  [PATCH] PnP cleanups and resource changes - 2.5.44 (1/4)
  
  This patch fixes a number of things pointed out by Arne Thomassen.  Also it
  makes a few changes to the resource checking functions in that they now check to
  make sure that resources do not conflict within the same device instead of only
  other devices.  Although it is rare for this to be a factor it's nice to be able
  to deal with such situations properly.

 drivers/pnp/core.c          |    5 ---
 drivers/pnp/driver.c        |    3 -
 drivers/pnp/isapnp/compat.c |    1 
 drivers/pnp/names.c         |    1 
 drivers/pnp/quirks.c        |    1 
 drivers/pnp/resource.c      |   72 +++++++++++++++++++++++++++++++++-----------
 6 files changed, 57 insertions(+), 26 deletions(-)
------

ChangeSet@1.808.4.1, 2002-10-21 11:39:24-07:00, ambx1@neo.rr.com
  [PATCH] PnP Rewrite Fixes - 2.5.44
  
  This patch addresses a few minor issues for the Linux Plug and Play Rewrite.  It
  is against 2.5.44.
  
  They are as follows.
  
  1.) fix Config.in file - from Adrian Bunk and Roman Zippel
  2.) if unable to activate a device the match should fail.  This can be done now
  that the driver model matching bug has been corrected.
  3.) move compat.c to isapnp directory and fix everything accordingly - suggested
  by Stelian Pop.  This fixes a compile error if ISAPNP is disabled.
  4.) fix a typo in pnp.h - patch from Skip Ford
  
  Please Apply,
  Adam

 drivers/pnp/compat.c        |   94 --------------------------------------------
 drivers/pnp/Config.in       |   16 ++++---
 drivers/pnp/Makefile        |    4 -
 drivers/pnp/base.h          |    3 -
 drivers/pnp/driver.c        |    2 
 drivers/pnp/isapnp/Makefile |    4 -
 drivers/pnp/isapnp/compat.c |   93 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pnp.h         |   31 ++++++++------
 8 files changed, 126 insertions(+), 121 deletions(-)
------

