Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278296AbRJSEFZ>; Fri, 19 Oct 2001 00:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278297AbRJSEFR>; Fri, 19 Oct 2001 00:05:17 -0400
Received: from toad.com ([140.174.2.1]:47621 "EHLO toad.com")
	by vger.kernel.org with ESMTP id <S278296AbRJSEFG>;
	Fri, 19 Oct 2001 00:05:06 -0400
Message-ID: <3BCFA6AB.4EAD4161@mandrakesoft.com>
Date: Fri, 19 Oct 2001 00:06:03 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@sun.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        manfred@colorfullife.com, alan@redhat.com
Subject: Re: Another Natsemi patch
In-Reply-To: <3BCF7A4D.B6060973@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> 
> Hey guys,
> 
> Ttime for my monthly natsemi patch :)  I have a couple issues still pending
> with NSC, but I wanted to get this patch out ASAP.
> 
> * increase RX ring

You just doubled the Rx memory usage... why?

> * DP83816 strings

I prefer "DP83815/16" not the longer version

> * try to wait for AnegDone bit
> * Magic registers have constant values

cool.  can I request further cleanup?  there are still many "magic
numbers" that should be defined as constants.  Mask values like "foo &
0x3ff", or chip revision ids, or media selection, etc.  Make sure there
is usage of linux/mii.h constants where possible.

> * Catch nasty PHY resets that happen periodically
> * some formatting
> * SOPASS only on revD and higher
> 
> Pretty heavily tested.  Issues still pending:
> 
> * Some report of "Something Wicked" happening to the point of no network
> traffic at all - investigating
> * A report of "Something Wicked" under heavy load - can't repro here, but
> can on reporting machine - may need to grow RX ring by a lot.
> * Report of slowdown since EEPROM reload added - can't repro.
> * Perhaps teh WoL config register should be saved/restored across calls to
> natsemi_reset?  Comments?
> 
> Please apply for next 2.4.x.
> 
> Tim
> --
> Tim Hockin
> Systems Software Engineer
> Sun Microsystems, Cobalt Server Appliances
> thockin@sun.com
> 
>   ------------------------------------------------------------------------
> diff -ruN dist-2.4.12+patches/drivers/net/natsemi.c cvs-2.4.12+patches/drivers/net/natsemi.c
> --- dist-2.4.12+patches/drivers/net/natsemi.c   Mon Oct 15 10:22:07 2001
> +++ cvs-2.4.12+patches/drivers/net/natsemi.c    Mon Oct 15 10:22:08 2001
> @@ -85,6 +85,10 @@
>                 * use long for ee_addr (various)
>                 * print pointers properly (DaveM)
>                 * include asm/irq.h (?)
> +
> +       version 1.0.11:
> +               * check and reset if PHY errors appear (Adrian Sun)
> +               * WoL cleanup (Tim Hockin)
> 
>         TODO:
>         * big endian support with CFG:BEM instead of cpu_to_le32
> @@ -96,7 +100,6 @@
>  #define DRV_VERSION    "1.07+LK1.0.10"
>  #define DRV_RELDATE    "Oct 09, 2001"

whoops :)  s/10/11/

> -c-help: including the 83815 chip.
> +c-help: including the 83815/83816 chips.

shorten (as noted above) as it's always possible to have yet another
chip version


> +#ifndef PCI_DEVICE_ID_NS_83815
> +#define PCI_DEVICE_ID_NS_83815 0x0020
> +#endif

if your patch to pci_ids.h goes in (it will), then don't add this at all


> @@ -516,9 +536,9 @@
>          * to be brought to D0 in this manner.
>          */
>         pci_read_config_dword(pdev, PCIPM, &tmp);
> -       if (tmp & (0x03|0x100)) {
> +       if (tmp & 0x03) {
>                 /* D0 state, disable PME assertion */
> -               u32 newtmp = tmp & ~(0x03|0x100);
> +               u32 newtmp = tmp & ~0x03;

magic numbers

> @@ -790,7 +810,7 @@
>         init_timer(&np->timer);
>         np->timer.expires = jiffies + 3*HZ;
>         np->timer.data = (unsigned long)dev;
> -       np->timer.function = &netdev_timer;                             /* timer handler */
> +       np->timer.function = &netdev_timer; /* timer handler */

make 3*HZ a constant

> @@ -907,23 +944,36 @@
>          * nothing will be written to memory. */
>         np->SavedClkRun = readl(ioaddr + ClkRun);
>         writel(np->SavedClkRun & ~0x100, ioaddr + ClkRun);
> +       if (np->SavedClkRun & 0x8000) {
> +               printk(KERN_NOTICE "%s: Wake-up event %8.8x\n",
> +                       dev->name, readl(ioaddr + WOLCmd));
> +       }

magic num

>         writel(RxOn | TxOn, ioaddr + ChipCmd);
>         writel(4, ioaddr + StatsCtrl); /* Clear Stats */

magic num

> +       /* check for a nasty random phy-reset - use dspcfg as a flag */
> +       writew(1, ioaddr+PGSEL);
> +       dspcfg = readw(ioaddr+DSPCFG);
> +       writew(0, ioaddr+PGSEL);

I wonder if you want a readw(ioaddr+PGSEL) after the first writew, to
flush it to hardware?

> @@ -1219,7 +1291,7 @@
>                 }
>         } while (1);
> 
> -       if (debug > 3)
> +       if (debug > 4)
>                 printk(KERN_DEBUG "%s: exiting interrupt.\n",
>                            dev->name);
>  }

Check out the netif_msg_xxx stuff in include/linux/netdevice.h in
2.4.13-preXX...


> @@ -1553,24 +1625,33 @@
>         u32 data = readl(dev->base_addr + WOLCmd) & ~WakeOptsSummary;
> 
>         /* translate to bitmasks this chip understands */
> -       if (newval & WAKE_PHY)
> +       if (newval & WAKE_PHY) {
>                 data |= WakePhy;
> -       if (newval & WAKE_UCAST)
> +       }
> +       if (newval & WAKE_UCAST) {
>                 data |= WakeUnicast;
> -       if (newval & WAKE_MCAST)
> +       }
> +       if (newval & WAKE_MCAST) {
>                 data |= WakeMulticast;
> -       if (newval & WAKE_BCAST)
> +       }
> +       if (newval & WAKE_BCAST) {
>                 data |= WakeBroadcast;
> -       if (newval & WAKE_ARP)
> +       }
> +       if (newval & WAKE_ARP) {
>                 data |= WakeArp;
> -       if (newval & WAKE_MAGIC)
> +       }
> +       if (newval & WAKE_MAGIC) {
>                 data |= WakeMagic;
> -       if (newval & WAKE_MAGICSECURE)
> -               data |= WakeMagicSecure;
> +       }

why are you adding all these braces?  ug.

> -       /* should we burn these into the EEPROM? */
> +       /* FIXME: should we burn these into the EEPROM? */

If you want to update the EEPROM, do it from userspace...

>         /* translate from chip bitmasks */
> -       if (regval & 0x1)
> +       if (regval & WakePhy) {
>                 *cur |= WAKE_PHY;
> -       if (regval & 0x2)
> +       }
> +       if (regval & WakeUnicast) {
>                 *cur |= WAKE_UCAST;
> -       if (regval & 0x4)
> +       }
> +       if (regval & WakeMulticast) {
>                 *cur |= WAKE_MCAST;
> -       if (regval & 0x8)
> +       }
> +       if (regval & WakeBroadcast) {
>                 *cur |= WAKE_BCAST;
> -       if (regval & 0x10)
> +       }
> +       if (regval & WakeArp) {
>                 *cur |= WAKE_ARP;
> -       if (regval & 0x200)
> +       }
> +       if (regval & WakeMagic) {
>                 *cur |= WAKE_MAGIC;
> -       if (regval & 0x400)
> +       }
> +       if (regval & WakeMagicSecure) {
> +               /* this can be on in revC, but it's broken */
>                 *cur |= WAKE_MAGICSECURE;
> +       }

less magic numbers <cheer> but more extra braces.  The extra braces here
just serve to spread out the code and make it less readable (eyes travel
more, for same [small] amount of information).


>         /* enable writing to these registers by disabling the RX filter */
> +       addr = readl(dev->base_addr + RxFilterAddr) & ~0x3ff;
>         addr &= ~0x80000000;
>         writel(addr, dev->base_addr + RxFilterAddr);

yay, magic numbers :)

> @@ -1631,9 +1731,16 @@
>  static int netdev_get_sopass(struct net_device *dev, u8 *data)
>  {
>         u16 *sval = (u16 *)data;
> -       u32 addr = readl(dev->base_addr + RxFilterAddr) & ~0x3ff;
> +       u32 addr;
> +
> +       if (readl(dev->base_addr + SiliconRev) < 0x403) {
> +               sval[0] = sval[1] = sval[2] = 0;
> +               return 0;
> +       }

you add --how-- many of these SiliconRev checks?  dude, read it once and
set a flag


> +       /* PME on, clear status */
> +       writel(np->SavedClkRun | 0x8100, ioaddr + ClkRun);

magic


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
