Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTE0FTP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 01:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTE0FTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 01:19:15 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:48579
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S263493AbTE0FTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 01:19:05 -0400
Date: Tue, 27 May 2003 01:32:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [PATCH] 2.4.x net driver pending stuff
Message-ID: <20030527053218.GA24582@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here are the pending bits for Marcelo, once 2.4.21 is released.


BK users may pull from

	bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.4

Others may obtain the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.21-rc2-netdrvr1.patch.bz2

This will update the following files:

 drivers/net/bonding.c                | 3434 -------------------------
 Documentation/Configure.help         |    9 
 Documentation/networking/bonding.txt |  148 -
 Documentation/networking/ifenslave.c |  334 +-
 drivers/net/8139cp.c                 |    7 
 drivers/net/Config.in                |    3 
 drivers/net/Makefile                 |    6 
 drivers/net/arcnet/arcnet.c          |    2 
 drivers/net/arcnet/rfc1201.c         |    6 
 drivers/net/bonding.c                |  266 +
 drivers/net/bonding/Makefile         |   18 
 drivers/net/bonding/bond_3ad.c       | 2667 +++++++++++++++++++
 drivers/net/bonding/bond_3ad.h       |  342 ++
 drivers/net/bonding/bond_alb.c       | 1585 +++++++++++
 drivers/net/bonding/bond_alb.h       |  129 
 drivers/net/bonding/bond_main.c      | 4737 ++++++++++++++++++++++++++++++++---
 drivers/net/bonding/bonding.h        |  209 +
 drivers/net/e1000/e1000.h            |    3 
 drivers/net/e1000/e1000_main.c       |  167 +
 drivers/net/eepro.c                  |    2 
 drivers/net/r8169.c                  |    2 
 drivers/net/sundance.c               |  144 -
 drivers/net/tulip/tulip_core.c       |    7 
 drivers/net/typhoon.c                |    4 
 drivers/net/via-rhine.c              |    2 
 drivers/net/wireless/airo.c          |    2 
 include/linux/if_arcnet.h            |    4 
 include/linux/if_bonding.h           |  101 
 include/linux/if_vlan.h              |    1 
 include/linux/skbuff.h               |    4 
 include/net/if_inet6.h               |    5 
 include/net/irda/irlan_common.h      |    2 
 net/core/dev.c                       |    4 
 net/core/skbuff.c                    |    3 
 net/ipv6/addrconf.c                  |   13 
 net/ipv6/ndisc.c                     |    3 
 net/irda/irlan/irlan_eth.c           |    6 
 37 files changed, 10114 insertions(+), 4267 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/05/27 1.1229)
   [netdrvr eepro] update MODULE_AUTHOR per old-author request

<edward_peng@dlink.com.tw> (03/05/27 1.1228)
   [netdrvr sundance] fix another flow control bug

<edward_peng@dlink.com.tw> (03/05/27 1.1227)
   [netdrvr sundance] fix flow control bug

<shmulik.hen@intel.com> (03/05/27 1.1226)
   [netdrvr bonding] fix ABI version control problem
   
   This fix makes bonding not commit to a specific ABI version if the ioctl
   command is not supported by bonding.
   
   (It also removes the '\n' in the continuous printk reporting the link down
   event in bond_mii_monitor - it got in there by mistake in our previous
   patch set and caused log messages to appear funny in some situations).

<shmulik.hen@intel.com> (03/05/27 1.1225)
   [netdrvr bonding] fix long failover in 802.3ad mode
   
   This patch fixes the bug reported by Jay on April 3rd regarding long
   failover time when releasing the last slave in the active aggregator. The
   fix, as suggested by Jay, is to follow the spec recommendation and send a
   LACPDU to the partner saying this port is no longer aggregatable and
   therefore trigger an immediate re-selection of a new aggregator instead of
   waiting the entire expiration timeout.

<yoshfuji@linux-ipv6.org> (03/05/25 1.1224)
   IPv6 over ARCnet (RFC2497) support, IPv6 part.

<yoshfuji@linux-ipv6.org> (03/05/25 1.1223)
   IPv6 over ARCnet (RFC2497) support, driver part

<rusty@rustcorp.com.au> (03/05/25 1.1222)
   [irda] module refcounts for irlan

<fubar@us.ibm.com> (03/05/23 1.1215.1.7)
   [bonding] small cleanups

<shmulik.hen@intel.com> (03/05/23 1.1215.1.6)
   [bonding] add rcv load balancing mode
   
   This patch adds a new mode that enables receive load balancing for IPv4
   traffic on top of the transmit load balancing mode. This capability is
   achieved by intercepting and manipulating the ARP negotiation to teach
   clients several MAC addresses for the bond and thus distribute incoming
   traffic among all slaves with the highest link speed.
   
   In order to function properly, slaves are required to be able to have
   their MAC address set even while the interface is up since once the
   primary slave looses its link, the new primary slave (and only it) must be
   able to take over and receive the incoming traffic instead. If a
   non-primary slave looses its link, ARP packets will be sent to all clients
   communicating through it in order to teach them a replacement MAC address,
   and the primary slave will be put in promiscuous mode for 10 seconds for
   fault tolerance reasons.
   
   This patch is against bonding-20030415, but must come only after the
   locking scheme changing patch since it uses dev_set_promiscuity() that
   would otherwise cause a system hang.

<shmulik.hen@intel.com> (03/05/23 1.1215.1.5)
   [bonding] support xmit load balancing mode

<shmulik.hen@intel.com> (03/05/23 1.1215.1.4)
   [bonding] much improved locking
   
   This patch replaces the use of lock_irqsave/unlock_irqrestore in bonding
   with lock/unlock or lock_bh/unlock_bh as appropriate according to context.
   This change is based on a previous discussion regarding the fact that
   holding a lock_irqsave doesn't prevent softirqs from running which can
   cause deadlocks in certain situations. This new locking scheme has already
   undergone massive testing cycle by our QA group and we feel it is ready
   for release (some new modes and enhancements will not work properly
   without it).

<shmulik.hen@intel.com> (03/05/23 1.1215.1.3)
   [bonding] better 802.3ad mode control, some cleanup
   
   This patch adds the lacp_rate module param to enable better control over
   the IEEE 802.3ad mode. This param controls the rate at which the partner
   system is asked to send LACPDUs to bonding.
   Two options exist:
   - slow (or 0) - LACPDUs are 30 seconds apart
   - fast (or 1) - LACPDUs are 1 second apart
   The default is slow (like most switches around).
   
   There are also some code beautifications (mainly converting comments to C
   style in code segments we added in the past).
   

<shmulik.hen@intel.com> (03/05/23 1.1215.1.2)
   [bonding] ABI versioning
   
   This patch adds user-land to kernel ABI version control in bonding to
   restore backward compatibility between different versions of ifenslave and
   the bonding module. It uses ethtool's GDRVINFO ioctl to pass the ABI
   version number between ifenslave and the bonding module in both directions
   so both the driver and the application can tell which partner they're
   working against and take the appropriate measures when enslaving/releasing
   an interface. The bonding module remembers the ABI version received from
   the application, and from that moment on will deny enslave and release
   commands from an application using a different ABI version, which means
   that if you want to switch to an ifenslave with a different ABI version
   (or with non at all), you'll first have to re-load the bonding module.
   
   This patch also changes the driver/application versioning scheme to
   contain 3 fields X.Y.Z with the follows meaning:
   X - Major version - big behavior changes
   Y - Minor version - addition of features
   Z - Extra version - minor changes and bug fixes
   
   There are also three minor bug fixes:
   1. Prevent enslaving an interface that is already a slave.
   2. Prevent enslaving if the bond is down.
   3. In bond_release_all, save old value of current_slave before assigning
      NULL to it to enable using it's original value later on.
   
   This patch is against bonding-20030415.
   

<scott.feldman@intel.com> (03/04/27 1.1137.1.6)
   [netdrvr e1000] add TSO support -- disabled
   
   * Copy TSO support for 2.5 e1000.  Wrapped with NETIF_F_TSO, so
     not currently enabled in 2.4.  Done to keep 2.4 and 2.5 drivers
     in-sync as much as possible.
   

<scott.feldman@intel.com> (03/04/27 1.1137.1.5)
   [netdrvr e1000] add support for NAPI
   
   * Copy NAPI support from 2.5 e1000 driver
   * Add CONFIG_E1000_NAPI option
   

<dean@arctic.org> (03/04/27 1.1137.1.4)
   [netdrvr tulip] support DM910x chip from ALi

<jgarzik@redhat.com> (03/04/27 1.1137.1.3)
   Remove duplicate CONFIG_TULIP_MWI entry in Configure.help
   
   Noticed by Geert Uytterhoeven

<anton@samba.org> (03/04/27 1.1137.1.2)
   [netdrvr 8139cp] enable MWI via pci_set_mwi, rather than manually

<Valdis.Kletnieks@vt.edu> (03/04/26 1.1131.2.6)
   [netdrvr typhoon] s/#if/#ifdef/ for a CONFIG_ var

<jgarzik@redhat.com> (03/04/25 1.1131.2.5)
   [netdrvr sundance] small cleanups from 2.5
   
   - s/long flag/unsigned long flag/
   - C99 initializers

<edward_peng@dlink.com.tw> (03/04/25 1.1131.2.4)
   [netdrvr sundance] bug fixes, VLAN support
   
       - Fix tx bugs in big-endian machines
       - Remove unused max_interrupt_work module parameter, the new 
         NAPI-like rx scheme doesn't need it.
       - Remove redundancy get_stats() in intr_handler(), those 
         I/O access could affect performance in ARM-based system
       - Add Linux software VLAN support
       - Fix bug of custom mac address 
       (StationAddr register only accept word write) 

<edward_peng@dlink.com.tw> (03/04/25 1.1131.2.3)
   [netdrvr via-rhine] fix promisc mode
   
   I found a via-rhine bug, it can't receive BPDU (mac: 0180c2000000)
   in promiscuous mode. 
   Fill all "1" in hash table to fix this problem in promiscuous mode.
   (RCR remain 0x1c, write it as 0x1f don't work)

<riel@redhat.com> (03/04/25 1.1131.2.2)
   [wireless airo] fix end-of-array test
   
   FYI statsLabels[] is an array of char*, so the fix below
   is pretty obvious.

<bunk@fs.tum.de> (03/04/25 1.1131.2.1)
   [PATCH] fix .text.exit error in drivers/net/r8169.c
   
   In drivers/net/r8169.c the function rtl8169_remove_one is __devexit but
   the pointer to it didn't use __devexit_p resulting in a.text.exit
   compile error when !CONFIG_HOTPLUG.
   
   The fix is simple:

<jgarzik@redhat.com> (03/04/17 1.1101.8.7)
   [bonding] add support for IEEE 802.3ad Dynamic link aggregation
   
   Contributed by Shmulik Hen @ Intel, merge by Jay Vosburgh @ IBM

<jgarzik@redhat.com> (03/04/17 1.1101.8.6)
   [bonding] move private decls into new drv/net/bonding/bonding.h file

<jgarzik@redhat.com> (03/04/17 1.1101.8.5)
   [bonding] move driver into new drivers/net/bonding directory

<jgarzik@redhat.com> (03/04/17 1.1101.8.4)
   [bonding] Moved setting slave mac addr, and open, from app to the driver
   
   This patch enables support of modes that need to use the unique mac 
   address of each slave. It moves setting the slave's mac address and 
   opening it from the application to the driver.
   This breaks backward compatibility between the new driver and older 
   applications !
   It also blocks possibility of enslaving before the master is up (to 
   prevent putting the system in an unstable state), and removes the code 
   that unconditionally restores all base driver's flags (flags are 
   automatically restored once all undo stages are done in proper order).
   
   Contributed by Shmulik Hen @ Intel

<jgarzik@redhat.com> (03/04/17 1.1101.8.3)
   [bonding] add support for getting slave's speed and duplex via ethtool
   
   Contributed by Shmulik Hen @ Intel

<jgarzik@redhat.com> (03/04/17 1.1101.8.2)
   [bonding] fix comment to prevent future merge difficulties
   
   Contributed by Jay Vosburgh @ IBM

<jgarzik@redhat.com> (03/04/17 1.1101.8.1)
   [net] store physical device a packet arrives in on
   
   (Needed for bonding)
   
   Contributed by Jay Vosburgh @ IBM, Shmulik Hen @ Intel, and others.

