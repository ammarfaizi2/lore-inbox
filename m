Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135212AbRDRQA6>; Wed, 18 Apr 2001 12:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135213AbRDRQAs>; Wed, 18 Apr 2001 12:00:48 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7590 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S135212AbRDRQAn>;
	Wed, 18 Apr 2001 12:00:43 -0400
Message-ID: <3ADDBA29.C3ADDD60@mandrakesoft.com>
Date: Wed, 18 Apr 2001 12:00:41 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Phillips <mikep@linuxtr.net>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        torvalds@transmeta.com
Subject: Re: [PATCH] Updated Olympic Driver
In-Reply-To: <Pine.LNX.4.10.10104181102180.5458-100000@www.linuxtr.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Phillips wrote:

hey Mike :)
> diff -urN --exclude-from=dontdiff linux-2.4.3.clean/drivers/net/Space.c linux-2.4.3.olympic/drivers/net/Space.c
> --- linux-2.4.3.clean/drivers/net/Space.c       Tue Feb 13 16:15:05 2001
> +++ linux-2.4.3.olympic/drivers/net/Space.c     Sun Apr  1 19:22:08 2001
> @@ -544,7 +544,6 @@
>  #ifdef CONFIG_TR
>  /* Token-ring device probe */
>  extern int ibmtr_probe(struct net_device *);
> -extern int olympic_probe(struct net_device *);
>  extern int smctr_probe(struct net_device *);

*cheer*


>  static char *version =
> -"Olympic.c v0.5.C 12/23/00 - Peter De Schrijver & Mike Phillips" ;
> -
> -static struct pci_device_id olympic_pci_tbl[] __initdata = {
> -       { PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_TR_WAKE, PCI_ANY_ID, PCI_ANY_ID, },
> -       { }                     /* Terminating entry */
> -};
> -MODULE_DEVICE_TABLE(pci, olympic_pci_tbl);
> -
> +"Olympic.c v0.9.C 4/18/01 - Peter De Schrijver & Mike Phillips" ;

Define your strings like "version[]" because they take up a bit less
space in the output.  Also, you can most likely mark your string
__devinitdata -- typically for network drivers, you want to always print
out your version on module load; and when built into the kernel, print
out the version once at least one device has been found.
>  MODULE_PARM(ringspeed, "1-" __MODULE_STRING(OLYMPIC_MAX_ADAPTERS) "i");
>  MODULE_PARM(pkt_buf_sz, "1-" __MODULE_STRING(OLYMPIC_MAX_ADAPTERS) "i") ;
>  MODULE_PARM(message_level, "1-" __MODULE_STRING(OLYMPIC_MAX_ADAPTERS) "i") ;

MODULE_PARM_DESC here too might be nice

> +static struct pci_device_id olympic_pci_tbl[] __devinitdata = {
> +       {PCI_VENDOR_ID_IBM,PCI_DEVICE_ID_IBM_TR_WAKE,PCI_ANY_ID,PCI_ANY_ID,},
> +       { }     /* Terminating Entry */
> +};
> +MODULE_DEVICE_TABLE(pci,olympic_pci_tbl) ;
> +
> +static int __init olympic_probe(struct pci_dev *pdev, const struct pci_device_id *ent);

1) prototypes don't need __init
2) this is a cardbus (hotplug) capable driver, to olympic_probe should
be __devinit not __init

> -int __init olympic_probe(struct net_device *dev)
> +static int __init olympic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)

ditto


> +       olympic_priv->olympic_mmio = ioremap(pci_resource_start(pdev,1),256);
> +       olympic_priv->olympic_lap = ioremap(pci_resource_start(pdev,2),2048);

check both of these for NULL return value.  since you have a lot of
error cases, as is typical in a probe function, you might consider the
goto-exit style used by many drivers in drivers/net/*.c.  Just grep for
goto ;-)  Using gotos for error exit handling greatly increases the
readability of the code and greatly reduces the likelihood of bugs due
to cut-n-paste (or forgetting to cut-n-paste).


> +       dev->open=&olympic_open;
> +       dev->hard_start_xmit=&olympic_xmit;
> +       dev->change_mtu=&olympic_change_mtu;
> +       dev->stop=&olympic_close;
> +       dev->do_ioctl=NULL;
> +       dev->set_multicast_list=&olympic_set_rx_mode;
> +       dev->get_stats=&olympic_get_stats ;
> +       dev->set_mac_address=&olympic_set_mac_address ;

I think you're missing SET_MODULE_OWNER(dev)..  use that here, and
remove all calls to MOD_{INC,DEC}_USE_COUNT...

> +       register_netdev(dev) ;

check return code

> +       if (olympic_priv->olympic_network_monitor) {
> +               __u8 *oat ;
> +               __u8 *opt ;
> +               oat = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_addr_table_addr) ;
> +               opt = (__u8 *)(olympic_priv->olympic_lap + olympic_priv->olympic_parms_addr) ;

prefer kernel standard "u8" type

> +       /*
> +        *  Read sisr but don't reset it yet.
> +        *  The indication bit may have been set but the interrupt latch
> +        *  bit may not be set, so we'd lose the interrupt later.
> +        */
> +       sisr=readl(olympic_mmio+SISR) ;
>         if (!(sisr & SISR_MI)) /* Interrupt isn't for us */
>                 return ;
> +       sisr=readl(olympic_mmio+SISR_RR) ;  /* Read & Reset sisr */

you should also check for 0xFFFFFFFF, which will happen if the hardware
disappears...

> +static void __devexit olympic_remove_one(struct pci_dev *pdev)
> +       if (olympic_priv->olympic_network_monitor) {
> +               char proc_name[20] ;
> +               strcpy(proc_name,"net/olympic_") ;
> +               strcat(proc_name,dev->name) ;
> +               remove_proc_entry(proc_name,NULL);
>         }
> +       unregister_trdev(dev) ;
> +       iounmap(olympic_priv->olympic_mmio) ;
> +       iounmap(olympic_priv->olympic_lap) ;
> +       pci_release_regions(pdev) ;
> +       kfree(dev) ;
> +}

call pci_set_drvdata(pdev,NULL) to clear your tracks

> diff -urN --exclude-from=dontdiff linux-2.4.3.clean/drivers/net/tokenring/olympic.h linux-2.4.3.olympic/drivers/net/tokenring/olympic.h
> --- linux-2.4.3.clean/drivers/net/tokenring/olympic.h   Tue Mar  6 22:28:35 2001
> +++ linux-2.4.3.olympic/drivers/net/tokenring/olympic.h Wed Apr 18 08:38:07 2001
> @@ -263,10 +264,12 @@
>         volatile int trb_queued;   /* True if a TRB is posted */
>         wait_queue_head_t trb_wait ;
> 
> +       /* These must be on a 4 byte boundary. */
>         struct olympic_rx_desc olympic_rx_ring[OLYMPIC_RX_RING_SIZE];
>         struct olympic_tx_desc olympic_tx_ring[OLYMPIC_TX_RING_SIZE];
>         struct olympic_rx_status olympic_rx_status_ring[OLYMPIC_RX_RING_SIZE];
>         struct olympic_tx_status olympic_tx_status_ring[OLYMPIC_TX_RING_SIZE];

With PCI DMA you (theoretically) never pass any members of your private
struct directly to the chip.  thus, either your comment or code is
wrong...

> @@ -274,9 +277,13 @@
>         __u16 olympic_lan_status ;
>         __u8 olympic_ring_speed ;
>         __u16 pkt_buf_sz ;
> -       __u8 olympic_receive_options, olympic_copy_all_options, olympic_message_level;
> +       __u8 olympic_receive_options, olympic_copy_all_options,olympic_message_level, olympic_network_monitor;
>         __u16 olympic_addr_table_addr, olympic_parms_addr ;
>         __u8 olympic_laa[6] ;
> +       __u32 rx_ring_dma_addr;
> +       __u32 rx_status_ring_dma_addr;
> +       __u32 tx_ring_dma_addr;
> +       __u32 tx_status_ring_dma_addr;

ditto comments about using standard kernel types


-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
