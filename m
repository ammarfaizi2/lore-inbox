Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129358AbRBHDsq>; Wed, 7 Feb 2001 22:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129694AbRBHDsh>; Wed, 7 Feb 2001 22:48:37 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:22543 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129358AbRBHDs3>;
	Wed, 7 Feb 2001 22:48:29 -0500
Message-ID: <3A821701.C7ED5ED2@mandrakesoft.com>
Date: Wed, 07 Feb 2001 22:48:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Remaining net/ pci_enable_device cleanups.
In-Reply-To: <Pine.LNX.4.31.0102072310240.29253-100000@athlon.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:
> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/defxx.c linux-dj/drivers/net/defxx.c
> --- linux/drivers/net/defxx.c   Wed Feb  7 21:55:56 2001
> +++ linux-dj/drivers/net/defxx.c        Wed Feb  7 22:34:27 2001

applied


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/dgrs.c linux-dj/drivers/net/dgrs.c
> --- linux/drivers/net/dgrs.c    Wed Feb  7 21:55:56 2001
> +++ linux-dj/drivers/net/dgrs.c Wed Feb  7 22:17:37 2001

applied


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/dmfe.c linux-dj/drivers/net/dmfe.c
> --- linux/drivers/net/dmfe.c    Wed Feb  7 21:55:56 2001
> +++ linux-dj/drivers/net/dmfe.c Wed Feb  7 22:18:18 2001
> @@ -356,6 +356,11 @@
> 
>         DMFE_DBUG(0, "dmfe_probe()", 0);
> 
> +       /* Enable Master/IO access, Disable memory access */
> +       if (pci_enable_device(pdev))
> +               goto err_out;
> +       pci_set_master(pdev);

not applied -- used this code instead:

        /* Enable Master/IO access, Disable memory access */
        i = pci_enable_device(pdev);
        if (i) return i;

        pci_set_master(pdev);
        pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
        pci_comand &= ~PCI_COMMAND_MEM;
        pci_write_config_word(pdev, PCI_COMMAND, pci_command);


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/eepro100.c linux-dj/drivers/net/eepro100.c
> --- linux/drivers/net/eepro100.c        Wed Feb  7 21:55:56 2001
> +++ linux-dj/drivers/net/eepro100.c     Wed Feb  7 22:00:35 2001
> @@ -557,6 +557,17 @@
>         if (speedo_debug > 0  &&  did_version++ == 0)
>                 printk(version);
> 
> +       /* save power state b4 pci_enable_device overwrites it */
> +       pm = pci_find_capability(pdev, PCI_CAP_ID_PM);
> +       if (pm) {
> +               u16 pwr_command;
> +               pci_read_config_word(pdev, pm + PCI_PM_CTRL, &pwr_command);
> +               acpi_idle_state = pwr_command & PCI_PM_CTRL_STATE_MASK;
> +       }
> +
> +       if (pci_enable_device(pdev))
> +               goto err_out_none;

applied then modified:  -ENODEV is rarely a descriptive return code on
pci_enable_device failure

> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/epic100.c linux-dj/drivers/net/epic100.c
> --- linux/drivers/net/epic100.c Wed Feb  7 21:55:56 2001
> +++ linux-dj/drivers/net/epic100.c      Wed Feb  7 22:15:22 2001

applied


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/natsemi.c linux-dj/drivers/net/natsemi.c
> --- linux/drivers/net/natsemi.c Wed Feb  7 21:55:56 2001
> +++ linux-dj/drivers/net/natsemi.c      Wed Feb  7 22:03:05 2001

already applied/fixed


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/pcnet32.c linux-dj/drivers/net/pcnet32.c
> --- linux/drivers/net/pcnet32.c Wed Feb  7 21:55:57 2001
> +++ linux-dj/drivers/net/pcnet32.c      Wed Feb  7 22:00:35 2001
> @@ -482,7 +482,12 @@
> 
>      printk(KERN_INFO "pcnet32_probe_pci: found device %#08x.%#08x\n", ent->vendor, ent->device);
> 
> -    ioaddr = pci_resource_start (pdev, 0);
> +       if ((err = pci_enable_device(pdev)) < 0) {
> +       printk(KERN_ERR "pcnet32.c: failed to enable device -- err=%d\n", err);
> +       return err;
> +       }
> +
> +       ioaddr = pci_resource_start (pdev, 0);

applied, then fixed up the fubar'd indentation..


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/rcpci45.c linux-dj/drivers/net/rcpci45.c
> --- linux/drivers/net/rcpci45.c Wed Feb  7 21:55:57 2001
> +++ linux-dj/drivers/net/rcpci45.c      Wed Feb  7 22:13:56 2001

applied


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/rtl8129.c linux-dj/drivers/net/rtl8129.c
> --- linux/drivers/net/rtl8129.c Wed Feb  7 21:55:57 2001
> +++ linux-dj/drivers/net/rtl8129.c      Wed Feb  7 22:08:47 2001

not applied -- already met its demise in my tree :)


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/sis900.c linux-dj/drivers/net/sis900.c
> --- linux/drivers/net/sis900.c  Wed Feb  7 21:55:57 2001
> +++ linux-dj/drivers/net/sis900.c       Wed Feb  7 22:08:04 2001

applied


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/sundance.c linux-dj/drivers/net/sundance.c
> --- linux/drivers/net/sundance.c        Mon Dec 11 21:38:29 2000
> +++ linux-dj/drivers/net/sundance.c     Wed Feb  7 22:03:56 2001

applied


> diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/winbond-840.c linux-dj/drivers/net/winbond-840.c
> --- linux/drivers/net/winbond-840.c     Wed Feb  7 21:56:00 2001
> +++ linux-dj/drivers/net/winbond-840.c  Wed Feb  7 22:05:21 2001

applied

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
