Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130884AbQL0PFZ>; Wed, 27 Dec 2000 10:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130897AbQL0PFP>; Wed, 27 Dec 2000 10:05:15 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:50309 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130884AbQL0PFJ>; Wed, 27 Dec 2000 10:05:09 -0500
Message-ID: <3A49FF32.5F53DB26@uow.edu.au>
Date: Thu, 28 Dec 2000 01:39:46 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: [patch] remove usage of init_etherdev
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I have just sent you the prepare/withdraw/publish_etherdev patch for the ethernet
devices.  There's a copy (80kbytes) at

	http://www.uow.edu.au/~andrewm/linux/init_etherdev.patch

It was fairly clean and I don't expect much breakage at all from this. 
I could only test the module and non-module error paths, but surely
this patch represents an aggregate bug reduction :)

eepro100.c and acenic.c should still be 2.2-compatible.

The patch includes some other xmas goodies, including:

- An update to 3c59x which allows it to support 3com's
  recently-released 3c905CX.  This is a bit ugly, but it gets people up
  and running until I can get my hands on one of these things.  

- Fixed locking and write barriers in natsemi.c, as discussed with Manfred.

- Fixed a fair number of unchecked kmallocs and error-path resource leaks.

- comx.c needs proc_get_inode(), so that has been exported.

- dmfe.c was allowing itself to be unloaded whilst remaining
  registered on the PCI device list.  crash, crash.

- Several drivers were not declaring their module parms and were not
  loadable with recent modutils.

- Several drivers had incorrect module parm declarations are were not
  loadable with recent modutils.

- All affected drivers now use SET_MODULE_OWNER instead of MOD_INC/DEC.

- drivers/net/depca.c oopses on boot because egcs-1.1.2 is
  miscompiling strstr().  It's failing to honour the clobber on edi.  I
  put a workaround in depca.c.

  A workaround in strstr is to force `ct' to be a memory operand, not
  a general operand.  Shouldn't we do this? Or, even better, kill the
  asm strstr and use the one in lib/string.c?


I think aironet4500_card.c is missing some module refcount handling,
but I didn't address this.

I'll send you the rrunner.c patch (maybe Jes has already done so?). 
Then if/when this stuff comes back to me I can do a final patch to
remove the now-unused init_etherdev, init_fcdev, init_hip_dev,
init_fddidev and init_trdev functions.  Then we're done.

The CardServices drivers use a bare register_netdev() and I think they
have the same race.  But that's orthogonal to the current work.

Thanks.


Affected files:


arch/ppc/8xx_io/enet.c
arch/ppc/8xx_io/fec.c
arch/ppc/8260_io/enet.c
arch/ppc/8260_io/fcc_enet.c
drivers/net/3c509.c
drivers/net/lance.c
drivers/net/atp.c
drivers/net/tlan.c
drivers/net/sunbmac.c
drivers/net/sk_g16.c
drivers/net/3c59x.c
drivers/net/acenic.c
drivers/net/sunlance.c
drivers/net/sunhme.c
drivers/net/a2065.c
drivers/net/hydra.c
drivers/net/ariadne.c
drivers/net/myri_sbus.c
drivers/net/sunqe.c
drivers/net/atari_bionet.c
drivers/net/atari_pamsnet.c
drivers/net/eepro100.c
drivers/net/ncr885e.c
drivers/net/starfire.c
drivers/net/pcnet32.c
drivers/net/via-rhine.c
drivers/net/yellowfin.c
drivers/net/oaknet.c
drivers/net/sis900.c
drivers/net/arlan.c
drivers/net/mace.c
drivers/net/am79c961a.c
drivers/net/epic100.c
drivers/net/ne2k-pci.c
drivers/net/hplance.c
drivers/net/bmac.c
drivers/net/sb1000.c
drivers/net/dmfe.c
drivers/net/gmac.c
drivers/net/daynaport.c
drivers/net/8139too.c
drivers/net/3c515.c
drivers/net/sk98lin/skge.c
drivers/net/tulip/tulip_core.c
drivers/net/bagetlance.c
drivers/net/declance.c
drivers/net/stnic.c
drivers/net/ioc3-eth.c
drivers/net/macsonic.c
drivers/net/sun3lance.c
drivers/net/pcmcia/aironet4500_cs.c
drivers/net/pcmcia/xircom_tulip_cb.c
drivers/net/aironet4500_card.c
drivers/net/aironet4500_core.c
drivers/net/macmace.c
drivers/net/rtl8129.c
drivers/net/natsemi.c
drivers/net/hamachi.c
drivers/net/sundance.c
drivers/net/winbond-840.c
drivers/net/depca.c
drivers/acorn/net/ether1.c
drivers/acorn/net/ether3.c
drivers/acorn/net/etherh.c
drivers/usb/pegasus.c

fs/proc/procfs_syms.c

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
