Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbTLET2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTLET2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:28:43 -0500
Received: from havoc.gtf.org ([63.247.75.124]:34271 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264320AbTLET23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:28:29 -0500
Date: Fri, 5 Dec 2003 14:28:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: netdev@oss.sgi.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.6.x experimental net driver queue
Message-ID: <20031205192828.GA15907@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the latest installment of "stuff I think should go into 2.6.1" ;-)
or IOW, my patch queue.

The changelog was getting quite long, so I'm now omitting all but the
new changes.  The full changelog is in BK, and also will be posted on
kernel.org in the same directory as its respective patch.

The new and interesting thing in today's patch is the e100 rewrite.

A bit of history.  I have been really impressed with what Intel has done
with the e100 driver.  If anyone saw it in the days when e100 only
reared its head in vendor kernels, it was pretty grotty, and had license
problems to boot.  The current guys working on e100 listened to feedback
from the community, and over time improved e100's code and license to
the point where it was acceptable for merging into the mainline kernel.

Well, even after all that work, it was a pretty darn big driver.  It
supported all the whiz bang hw-offload features.  But as hardware does,
you find out about various limits and errata that have crept into the
field over time.  Particularly, some of the hwaccel features don't work
on some chips.

So we come full circle, with e100 version 3.  I've received a lot of
"this works where e100 and eepro100 don't" reports, so I'm anxious to
see how it does in wide testing.  To quote from the driver,

 *      VLAN offload support of tagging, stripping and filtering is not
 *      supported, but driver will accommodate the extra 4-byte VLAN tag
 *      for processing by upper layers.  Tx/Rx Checksum offloading is not
 *      supported.  Tx Scatter/Gather is not supported.  Jumbo Frames is
 *      not supported.
 *
 *      NAPI support is enabled with CONFIG_E100_NAPI.
 *
 *      MagicPacket(tm) WoL support is enabled/disabled via ethtool.

In other words, the scales tip back in the direction of letting the net
stack do a bit more of the work.  And guess what?  The newer, more
simple driver not only seems a bit more stable, but sometimes faster,
because it now scales upward with the performance of your system CPU.

If I may risk a tangent, this is another reason why I feel interest in
TOE may be more trouble than it's worth.  Forget security issues.
Forget userland interface issues.  The plain and simple fact is that
CPUs keep getting faster, while that TOE card you bought last month does
not.

Getting back on topic, I like the new e100.  Yes, it's a rewrite from
scratch.  But darn, it's clean, and early reports seem to indicate it's
more stable and faster, too.  So why not?

	Jeff




BK users:

	bk pull bk://gkernel.bkbits.net/net-drivers-2.5-exp

Patch:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test11-netdrvr-exp2.patch.bz2

This will update the following files:

 Documentation/networking/8139too.txt    |  438 ---
 drivers/net/68360enet.c                 |  951 ------
 drivers/net/e100/LICENSE                |  339 --
 drivers/net/e100/Makefile               |    8 
 drivers/net/e100/e100.h                 |  999 -------
 drivers/net/e100/e100_config.c          |  639 ----
 drivers/net/e100/e100_config.h          |  168 -
 drivers/net/e100/e100_eeprom.c          |  565 ----
 drivers/net/e100/e100_main.c            | 4358 --------------------------------
 drivers/net/e100/e100_phy.c             | 1163 --------
 drivers/net/e100/e100_phy.h             |  158 -
 drivers/net/e100/e100_test.c            |  500 ---
 drivers/net/e100/e100_ucode.h           |  365 --
 Documentation/SubmittingPatches         |    4 
 Documentation/networking/netconsole.txt |   57 
 drivers/char/synclink.c                 |   43 
 drivers/net/3c501.c                     |  116 
 drivers/net/3c501.h                     |    1 
 drivers/net/3c503.c                     |  117 
 drivers/net/3c505.c                     |  128 
 drivers/net/3c507.c                     |  120 
 drivers/net/3c515.c                     |  328 +-
 drivers/net/3c523.c                     |  108 
 drivers/net/3c527.c                     |  682 ++---
 drivers/net/3c527.h                     |    6 
 drivers/net/3c59x.c                     |   17 
 drivers/net/8139too.c                   |  405 +-
 drivers/net/82596.c                     |   83 
 drivers/net/Kconfig                     |   34 
 drivers/net/Makefile                    |    4 
 drivers/net/Space.c                     |  587 ++--
 drivers/net/a2065.c                     |   21 
 drivers/net/ac3200.c                    |   91 
 drivers/net/amd8111e.c                  |   14 
 drivers/net/apne.c                      |   81 
 drivers/net/appletalk/ipddp.c           |   62 
 drivers/net/appletalk/ltpc.c            |    2 
 drivers/net/arcnet/arc-rimi.c           |  131 
 drivers/net/arcnet/arcnet.c             |    6 
 drivers/net/arcnet/com20020-isa.c       |   84 
 drivers/net/arcnet/com20020-pci.c       |   54 
 drivers/net/arcnet/com20020.c           |   16 
 drivers/net/arcnet/com90io.c            |  126 
 drivers/net/arcnet/com90xx.c            |  238 -
 drivers/net/ariadne.c                   |   10 
 drivers/net/arm/am79c961a.c             |    2 
 drivers/net/arm/ether00.c               |    4 
 drivers/net/arm/ether1.c                |    2 
 drivers/net/arm/ether3.c                |    2 
 drivers/net/arm/etherh.c                |    2 
 drivers/net/at1700.c                    |  166 -
 drivers/net/atari_bionet.c              |   62 
 drivers/net/atari_pamsnet.c             |   67 
 drivers/net/atarilance.c                |   58 
 drivers/net/atp.c                       |   40 
 drivers/net/au1000_eth.c                |   61 
 drivers/net/bagetlance.c                |   77 
 drivers/net/cs89x0.c                    |  132 
 drivers/net/de600.c                     |   59 
 drivers/net/de600.h                     |    1 
 drivers/net/de620.c                     |   63 
 drivers/net/declance.c                  |   17 
 drivers/net/defxx.c                     |    2 
 drivers/net/depca.c                     |   20 
 drivers/net/dummy.c                     |    2 
 drivers/net/e100.c                      | 2299 ++++++++++++++++
 drivers/net/e100/e100_config.c          |    8 
 drivers/net/e100/e100_main.c            |   41 
 drivers/net/e100/e100_phy.c             |   14 
 drivers/net/e1000/e1000.h               |   10 
 drivers/net/e1000/e1000_ethtool.c       |   94 
 drivers/net/e1000/e1000_hw.c            |   65 
 drivers/net/e1000/e1000_hw.h            |    9 
 drivers/net/e1000/e1000_main.c          |  143 -
 drivers/net/e1000/e1000_param.c         |   45 
 drivers/net/e2100.c                     |   88 
 drivers/net/eepro.c                     |  256 -
 drivers/net/eepro100.c                  |   21 
 drivers/net/eexpress.c                  |   91 
 drivers/net/eql.c                       |    2 
 drivers/net/es3210.c                    |   87 
 drivers/net/eth16i.c                    |  119 
 drivers/net/ethertap.c                  |    3 
 drivers/net/ewrk3.c                     |  684 ++---
 drivers/net/fc/iph5526.c                |    3 
 drivers/net/fc/iph5526_scsi.h           |    2 
 drivers/net/fmv18x.c                    |  111 
 drivers/net/gt96100eth.c                |   49 
 drivers/net/hamradio/baycom_epp.c       |    2 
 drivers/net/hamradio/bpqether.c         |    2 
 drivers/net/hamradio/hdlcdrv.c          |    2 
 drivers/net/hamradio/yam.c              |    2 
 drivers/net/hp-plus.c                   |   84 
 drivers/net/hp.c                        |   84 
 drivers/net/hp100.c                     |  743 ++---
 drivers/net/hplance.c                   |   85 
 drivers/net/hydra.c                     |   19 
 drivers/net/jazzsonic.c                 |   88 
 drivers/net/lance.c                     |  129 
 drivers/net/lasi_82596.c                |   17 
 drivers/net/lne390.c                    |   88 
 drivers/net/mac8390.c                   |  103 
 drivers/net/mac89x0.c                   |   77 
 drivers/net/mace.c                      |   50 
 drivers/net/macmace.c                   |   30 
 drivers/net/macsonic.c                  |  103 
 drivers/net/meth.c                      |   83 
 drivers/net/mvme147.c                   |   64 
 drivers/net/natsemi.c                   |   39 
 drivers/net/ne.c                        |   83 
 drivers/net/ne2.c                       |   82 
 drivers/net/ne2k-pci.c                  |    3 
 drivers/net/ne2k_cbus.c                 |  107 
 drivers/net/ne2k_cbus.h                 |    2 
 drivers/net/ne3210.c                    |   18 
 drivers/net/netconsole.c                |  120 
 drivers/net/ni5010.c                    |  184 -
 drivers/net/ni52.c                      |  118 
 drivers/net/ni65.c                      |  101 
 drivers/net/ns83820.c                   |    2 
 drivers/net/oaknet.c                    |   61 
 drivers/net/pci-skeleton.c              |    2 
 drivers/net/pcmcia/3c574_cs.c           |   25 
 drivers/net/pcmcia/3c589_cs.c           |   24 
 drivers/net/pcmcia/axnet_cs.c           |   17 
 drivers/net/pcmcia/com20020_cs.c        |   47 
 drivers/net/pcmcia/fmvj18x_cs.c         |   28 
 drivers/net/pcmcia/ibmtr_cs.c           |   15 
 drivers/net/pcmcia/nmclan_cs.c          |   24 
 drivers/net/pcmcia/pcnet_cs.c           |   17 
 drivers/net/pcmcia/smc91c92_cs.c        |   24 
 drivers/net/pcmcia/xirc2ps_cs.c         |    7 
 drivers/net/pcnet32.c                   |   11 
 drivers/net/plip.c                      |   18 
 drivers/net/ppp_generic.c               |   67 
 drivers/net/r8169.c                     |  448 ++-
 drivers/net/saa9730.c                   |   63 
 drivers/net/sb1250-mac.c                |   49 
 drivers/net/seeq8005.c                  |   97 
 drivers/net/sgiseeq.c                   |   29 
 drivers/net/shaper.c                    |   11 
 drivers/net/sk_g16.c                    |  182 -
 drivers/net/sk_mca.c                    |  119 
 drivers/net/sk_mca.h                    |    3 
 drivers/net/skfp/skfddi.c               |   32 
 drivers/net/smc-ultra.c                 |  107 
 drivers/net/smc-ultra32.c               |   85 
 drivers/net/smc9194.c                   |  110 
 drivers/net/stnic.c                     |   42 
 drivers/net/sun3_82586.c                |   81 
 drivers/net/sun3lance.c                 |   85 
 drivers/net/tc35815.c                   |  194 -
 drivers/net/tg3.c                       |   16 
 drivers/net/tlan.c                      |   11 
 drivers/net/tokenring/3c359.c           |    4 
 drivers/net/tokenring/abyss.c           |    2 
 drivers/net/tokenring/madgemc.c         |    6 
 drivers/net/tokenring/proteon.c         |  184 -
 drivers/net/tokenring/skisa.c           |  182 -
 drivers/net/tokenring/smctr.c           |  194 -
 drivers/net/tokenring/tmspci.c          |    2 
 drivers/net/tulip/Kconfig               |   20 
 drivers/net/tulip/de2104x.c             |    2 
 drivers/net/tulip/dmfe.c                |    2 
 drivers/net/tulip/interrupt.c           |  417 ++-
 drivers/net/tulip/tulip.h               |   18 
 drivers/net/tulip/tulip_core.c          |   78 
 drivers/net/tulip/winbond-840.c         |    2 
 drivers/net/tulip/xircom_tulip_cb.c     |    3 
 drivers/net/tun.c                       |   18 
 drivers/net/wan/cosa.c                  |   37 
 drivers/net/wan/lmc/lmc_main.c          |  375 --
 drivers/net/wan/lmc/lmc_var.h           |   15 
 drivers/net/wan/x25_asy.c               |    2 
 drivers/net/wd.c                        |   89 
 drivers/net/wireless/arlan-main.c       |  283 --
 drivers/net/wireless/arlan.h            |    6 
 drivers/net/wireless/atmel.c            |    2 
 drivers/net/wireless/ray_cs.c           |   17 
 drivers/net/wireless/strip.c            |    2 
 drivers/net/wireless/wavelan.c          |  251 -
 drivers/net/wireless/wavelan.p.h        |   58 
 drivers/net/wireless/wavelan_cs.c       |  113 
 drivers/net/wireless/wavelan_cs.p.h     |   49 
 drivers/net/znet.c                      |   36 
 drivers/net/zorro8390.c                 |   19 
 drivers/s390/net/qeth.c                 |   18 
 drivers/usb/gadget/ether.c              |    2 
 include/linux/arcdevice.h               |    1 
 include/linux/com20020.h                |    1 
 include/linux/netdevice.h               |   18 
 include/linux/netpoll.h                 |   38 
 include/linux/pci_ids.h                 |    2 
 net/Kconfig                             |   20 
 net/core/Makefile                       |    1 
 net/core/dev.c                          |   39 
 net/core/netpoll.c                      |  646 ++++
 net/wanrouter/wanmain.c                 |    2 
 198 files changed, 10465 insertions(+), 17186 deletions(-)

through these ChangeSets:

<prasanna@in.ibm.com> (03/12/05 1.1505)
   [netdrvr tlan] netpoll support
   
   Hi Jeff,
   
   Below is the pollcontroller patch for tlan network device driver.
   This patch can be applied over 2.6.0-test9-bk25-netdrvr-exp1.patch

<prasanna@in.ibm.com> (03/12/05 1.1504)
   [netdrvr smc-ultra] netpoll support
   
   Hi Jeff,
   
   Below is the pollcontroller patch for smc ultra net driver.
   This patch can be applied over 2.6.0-test9-bk25-netdrvr-exp1.patch

<jgarzik@redhat.com> (03/12/05 1.1503)
   [netdrvr e100] complete rewrite of e100 driver

[... snip changes from previous net-drivers-2.5-exp patchkits ...]


