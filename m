Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSJDUsu>; Fri, 4 Oct 2002 16:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbSJDUsu>; Fri, 4 Oct 2002 16:48:50 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:41743 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261836AbSJDUsr>;
	Fri, 4 Oct 2002 16:48:47 -0400
Date: Fri, 4 Oct 2002 13:51:21 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021004205121.GA8346@kroah.com>
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com> <20021004165955.GC6978@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004165955.GC6978@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, looks like Alan owes me a yummy pizza now...

It wasn't that hard to fix up the remaining drivers that used these
functions, here's some changesets that fix up all of the drivers except
two of them.

Please pull from:  http://linuxusb.bkbits.net/pci-2.5

Here's a summary of the status of these pcibios functions after applying
these changesets:

pcibios_present()
 - shows up in a grep in the following files:
   	drivers/char/ip2main.c
	drivers/net/wan/lmc/lmc_ver.h
	drivers/net/wan/sdladrv.c
	drivers/scsi/gdth.c
	drivers/scsi/megaraid.c
	drivers/scsi/qla1280.c
	drivers/scsi/sym53c8xx.c
	drivers/scsi/sym53c8xx_comm.h
	drivers/scsi/tmscsim.c
	include/linux/compatmac.h
   Every one of these instances are for backwards compatibility with
   older kernel versions and will not be used when building for 2.5

pcibios_find_class()
  - completely gone from the 2.5 tree.

pcibios_find_device()
  - the following drivers use it for when they are compiled for older
    kernels:
	drivers/scsi/sym53c8xx.c
	drivers/scsi/sym53c8xx_comm.h
	drivers/char/ip2main.c
	drivers/char/rio/rio_linux.c
	drivers/char/sx.c
	drivers/net/wan/sdladrv.c
	drivers/scsi/gdth.c
	drivers/scsi/megaraid.c
	drivers/scsi/tmscsim.c
   So these instances are safe.

I did not fix up the following two drivers:
 	drivers/char/rocket.c
		This driver does not build at all right now for 2.5 due
		to cli() and other assorted api changes over time in
		2.5.  Also, the PCI probe logic seems very fragile, and
		I do not want to disturb the current sequence without
		fully knowing what the correct board type and number
		sequence should be.
	drivers/isdn/eicon/lincfg.c
		Again the probe sequence seems touchy, and Kai (the ISDN
		maintainer) said he would fix it up properly once these
		patches were accepted.


So the only thing that is broken after these changesets is one isdn
driver (which will be soon fixed by the maintainer), and the rocket.c
driver, which was broken before these changesets :)

Please apply.

Sorry about the one misleading changeset comment, I couldn't figure out
how to go back and change it, and if you really object to it, I'll
rebuild the tree from scratch with it corrected.

thanks,

greg k-h

p.s. I'll send the changesets that I've added since the last set as patches in
response to this email to lkml for those who want to see them.

 drivers/char/rocket.c          |    2 -
 drivers/net/aironet4500_card.c |   43 +++++++++++------------------------------
 drivers/net/hp100.c            |    4 +--
 drivers/net/tulip/de4x5.c      |    4 +--
 drivers/net/wan/lmc/lmc_main.c |   18 +----------------
 drivers/pci/compat.c           |   42 ----------------------------------------
 drivers/pci/syscall.c          |    2 -
 drivers/sbus/sbus.c            |    2 -
 drivers/scsi/53c7,8xx.c        |   13 ++++--------
 drivers/scsi/inia100.c         |    2 -
 include/linux/pci.h            |   27 +++++++++----------------
 11 files changed, 37 insertions(+), 122 deletions(-)
-----

ChangeSet@1.674.3.6, 2002-10-04 12:49:31-07:00, greg@kroah.com
  PCI: remove pcibios_find_device() from the 53c7,8xx.c SCSI driver

 drivers/scsi/53c7,8xx.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)
------

ChangeSet@1.674.3.5, 2002-10-04 11:41:16-07:00, greg@kroah.com
  PCI: remove usages of pcibios_find_class()

 drivers/net/aironet4500_card.c |   43 +++++++++++------------------------------
 drivers/net/wan/lmc/lmc_main.c |   18 +----------------
 2 files changed, 14 insertions(+), 47 deletions(-)
------

ChangeSet@1.674.3.4, 2002-10-04 10:28:07-07:00, greg@kroah.com
  PCI: fixed remaining usages of pcibios_present() that I missed previously.

 drivers/char/rocket.c  |    2 +-
 drivers/sbus/sbus.c    |    2 +-
 drivers/scsi/inia100.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.674.3.3, 2002-10-03 14:06:24-07:00, greg@kroah.com
  PCI: removed pcibios_present()

 drivers/net/hp100.c       |    4 ++--
 drivers/net/tulip/de4x5.c |    4 ++--
 drivers/pci/compat.c      |    8 --------
 drivers/pci/syscall.c     |    2 +-
 include/linux/pci.h       |   21 ++++++++++-----------
 5 files changed, 15 insertions(+), 24 deletions(-)
------

ChangeSet@1.674.3.2, 2002-10-03 13:45:53-07:00, greg@kroah.com
  PCI: remove pci_find_device()

 drivers/pci/compat.c |   17 -----------------
 include/linux/pci.h  |    3 ---
 2 files changed, 20 deletions(-)
------

ChangeSet@1.674.3.1, 2002-10-03 13:36:51-07:00, greg@kroah.com
  PCI: remove pcibios_find_class()

 drivers/pci/compat.c |   17 -----------------
 include/linux/pci.h  |    3 ---
 2 files changed, 20 deletions(-)
------

