Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131877AbRBKDzI>; Sat, 10 Feb 2001 22:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131910AbRBKDyt>; Sat, 10 Feb 2001 22:54:49 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52235 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131877AbRBKDyh>;
	Sat, 10 Feb 2001 22:54:37 -0500
Message-ID: <3A860CF4.81622FC0@mandrakesoft.com>
Date: Sat, 10 Feb 2001 22:54:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: Alan Cox <alan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More network pci_enable cleanups.
In-Reply-To: <Pine.LNX.4.31.0102110253410.4383-100000@athlon.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:
> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/defxx.c linux-dj/drivers/net/defxx.c
> --- linux/drivers/net/defxx.c   Sat Feb 10 02:49:43 2001
> +++ linux-dj/drivers/net/defxx.c        Sat Feb 10 03:05:03 2001
> @@ -414,6 +415,7 @@
>         struct net_device *dev;
>         DFX_board_t       *bp;                  /* board pointer */
>         static int version_disp;
> +       int err;
> 
>         if (!version_disp)                                      /* display version info if adapter is found */
>         {
> @@ -429,8 +431,8 @@
> 
>         /* Enable PCI device. */
>         if (pdev != NULL) {
> -               if (pci_enable_device (pdev))
> -                       goto err_out;
> +               err = pci_enable_device (pdev);
> +               if (err) return err;
>                 ioaddr = pci_resource_start (pdev, 1);
>         }

1) Bug: Introduced memory leak by replacing "goto err_out" with "return
err"

2) Sole usage of 'err' -- it should be scoped inside the pdev!=NULL
check.


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/dgrs.c linux-dj/drivers/net/dgrs.c
> --- linux/drivers/net/dgrs.c    Sat Feb 10 02:49:43 2001
> +++ linux-dj/drivers/net/dgrs.c Sat Feb 10 03:05:09 2001
> @@ -1352,7 +1355,7 @@
> 
>  static int __init  dgrs_scan(void)
>  {
> -       int     cards_found = 0;
> +       int     cards_found;
>         uint    io;
>         uint    mem;
>         uint    irq;

Rejected.  Introduces bug.  That zero is required!


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/eepro.c linux-dj/drivers/net/eepro.c
> --- linux/drivers/net/eepro.c   Sat Feb 10 02:49:43 2001
> +++ linux-dj/drivers/net/eepro.c        Sat Feb 10 03:05:05 2001
> @@ -1098,7 +1098,7 @@
>         printk (KERN_ERR "%s: transmit timed out, %s?\n", dev->name,
>                 "network cable problem");
>         /* This is not a duplicate. One message for the console,
> -          one for the the log file  */
> +          one for the log file  */
>         printk (KERN_DEBUG "%s: transmit timed out, %s?\n", dev->name,
>                 "network cable problem");
>         eepro_complete_selreset(ioaddr);

rejected -- already in AC patches (and merged into my tree as well)

> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/eepro100.c linux-dj/drivers/net/eepro100.c
> --- linux/drivers/net/eepro100.c        Sat Feb 10 02:49:43 2001
> +++ linux-dj/drivers/net/eepro100.c     Sat Feb 10 03:05:06 2001
> @@ -550,10 +552,10 @@
>  {
>         unsigned long ioaddr;
>         int irq, i;
> -       int acpi_idle_state = 0, pm;
> -       static int cards_found /* = 0 */;
> +       int acpi_idle_state, pm;
> +       static int cards_found;
> +       static int did_version;         /* Already printed version info. */
> 
> -       static int did_version /* = 0 */;               /* Already printed version info. */
>         if (speedo_debug > 0  &&  did_version++ == 0)
>                 printk(version);
> 

Rejected.  The maintainer clearly wanted the "/* = 0 */" present, yet
you remove them.  I'm suspicious of the acpi_idle_state initialization
removal as well, but can't check it quickly at present (acpi_idle_state
is gone in my tree)

> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/ncr885e.c linux-dj/drivers/net/ncr885e.c
> --- linux/drivers/net/ncr885e.c Sat Feb 10 02:49:44 2001
> +++ linux-dj/drivers/net/ncr885e.c      Sat Feb 10 03:05:05 2001
> @@ -1163,7 +1163,7 @@
>  }
> 
>  /*  Since the NCR 53C885 is a multi-function chip, I'm not worrying about
> - *  trying to get the the device(s) in slot order.  For our (Synergy's)
> + *  trying to get the device(s) in slot order.  For our (Synergy's)
>   *  purpose, there's just a single 53C885 on the board and we don't
>   *  worry about the rest.
>   */

rejected -- already in AC and my own patches

All the rest were applied.

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
