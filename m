Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261223AbTC3UkH>; Sun, 30 Mar 2003 15:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbTC3UkG>; Sun, 30 Mar 2003 15:40:06 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:48310 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261223AbTC3UkD>; Sun, 30 Mar 2003 15:40:03 -0500
Date: Sun, 30 Mar 2003 22:48:04 +0200
From: Dominik Brodowski <linux@brodo.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCHES 2.5] PCMCIA hotplugging, in-kernel-matching and depmod support
Message-ID: <20030330204804.GA32737@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... and the deprecation of "cardmgr"


Dear kernel developers and testers,

Sixteen pcmcia-related patches are available at 
http://www.brodo.de/pcmcia/

These patches update the PCMCIA subsystem (16-bit) to use the driver
model matching and hotplug utilities. The "cardmgr" will not be 
needed any longer.

They are based on 2.5.66-bk-current + the current patch from Russell's
PCMCIA BK tree, available at
http://patches.arm.linux.org.uk/pcmcia/20030330.diff

However, only one driver is ported so far -- the "pcnet_cs"
driver. Other drivers will continue to work as before, but require
"cardmgr".

Many thanks to David Hinds for the great PCMCIA package to build this
work onto, to David Woodhouse for parts of the code and many ideas,
to Russell King, Greg Kroah-Hartman for their insight, and to Patrick
Mochel for the great linux driver model which made implementing this
so much easier.

"cardctl", by the way, may become deprecated much easier - some patches
which still need cleaning up will be submitted in a few days.

Diffstat for linux-kernel changes:
 drivers/net/pcmcia/pcnet_cs.c   |  212 ++++++++--
 drivers/pcmcia/cistpl.c         |    3
 drivers/pcmcia/cs.c             |    7
 drivers/pcmcia/ds.c             |  818 ++++++++++++++++++++++++++++++++++++++--
 drivers/pcmcia/rsrc_mgr.c       |    3
 include/linux/mod_devicetable.h |   36 +
 include/pcmcia/device_id.h      |   73 +++
 include/pcmcia/ds.h             |   31 +
 scripts/file2alias.c            |   31 +
 9 files changed, 1142 insertions(+), 72 deletions(-)

Diffstat for module-init-tools changes:
 depmod.c         |    9 ++++++++-
 depmod.h         |    2 ++
 moduleops_core.c |    4 ++++
 tables.c         |   31 +++++++++++++++++++++++++++++++
 tables.h         |   24 ++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 1 deletion(-)

Diffstat for linux-hotplug changes:
 pcmcia.agent              |  172 ++++++++++++++++++++++++++++++++++++++++++++++
 pcmcia.rc                 |   32 ++++++++
 pcmcia/allied_telesis     |   24 ++++++
 pcmcia/cisreplace.usermap |    5 +
 pcmcia/kti_pe520          |   25 ++++++
 pcmcia/ndc_instant        |   25 ++++++
 6 files changed, 283 insertions(+)



Here are the descriptions of each patch, each with a direct link:


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-license

The new in-kernel pcmcia matching & hotplug code is distributed only 
under GPL v2.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-device

This patch adds a struct pcmcia_device, and fills it with content for
every function of every pcmcia card inserted into the socket.

Unfortunately, information about the card can only be detected when
"cardmgr"[*] has told the pcmcia rsrc_mgr on what IO-ports and what
IO-mem is available for usage by the pcmcia core or drivers. So the
cards need to be re-scanned on completion of the pcmcia
initialization.

Re-starting cardmgr will not re-enable the resources.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-sysfs_resource

This adds a different, sysfs-based interface to add or remove
resources from rsrc_mgr.c. Remember, without such resources there's no
chance to do anything useful with pcmcia (16-bit) cards - at least on
most sockets.

A sample /etc/rc.d/pcmcia script can also be found there.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-sysfs_output

This patch adds three files (manf_id, card_id, func_id) to any pcmcia
device registered with the sysfs core.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-matching_1

Add a probe and remove callback function.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-matching_2

Add the struct pcmcia_device_id which is used by the drivers to tell
what devices they support.

The matching algorithm  was written by David Woodhouse.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-matching_3

The actual matching of pcmcia drivers and pcmcia devices. The original
version of this was written by David Woodhouse.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-matching_4

Mark the socket setup as done so that we don't end up with both
cardmgr and internal kernel matching wanting to bind a driver.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-matching_5

Add some helpful #defines for easier generation of pcmcia device id
tables.

Originally by David Woodhouse.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-matching_6

Add a hotplug function for pcmcia. 


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-matching_7

Parse MODULE_DEVICE_TABLE(pcmcia,) entries for MODULE_ALIAS generation
which is then used by depmod.


http://www.brodo.de/pcmcia/module-init-tools-0.9.11-pcmcia_matching-8

Let depmod create a modules.pcmciamap.


http://www.brodo.de/pcmcia/hotplug-2002_08_26-pcmcia-matching_9

The userspace matching code needed by hotplug to modprobe the correct
modules.

Also, sample override scripts (experimental/dangerous stuff commented
out) for CIS replacement are included.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-matching_10

A sample conversion of a PCMCIA device driver. I've parsed the
/etc/pcmcia/config from pcmcia-cs-3.2.3 to get the hashes for all
version strings, so if you intend to port drivers to this new
infrastrucutre, I'll gladly send you the correct
PCMCIA_{MFC_}DEVICE_... lines for your driver.

Two other notes:
MOD_INC_USE_COUNT / MOD_DEC_USE_COUNT can safely be removed as the new
core uses try_module_get upon matching and only releases this
reference in pcmcia_device_remove.

flush_stale_links and the really late call to unregister_netdev meant
that the device was still open to userspace until the next insertion
of a card. cardmgr issued a "./network stop $INTERFACE" after device
removal; hotplug is called by the kernel now; but only on
unregister_netdev calls. So move that up.

Oh, and pcnet_cs.c has by far the largest MODULE_DEVICE_TABLE -- 3 
times larger than serial_cs (runner-up) and 6 times larger than #3,
smc91c92_cs.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-forcematch

Sometimes it becomes necessary to override the automatic matching in
the kernel -- for example when the Card Information Structure is
broken or doesn't even exist.


http://www.brodo.de/pcmcia/pcmcia-2.5.66-6-overridecis

Some cards have a broken Card Information Structure (CIS) which should
be replaced. (cardmgr does this, too...) This adds a sysfs file which
allows root to do this.

