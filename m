Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287948AbSAMCUN>; Sat, 12 Jan 2002 21:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287950AbSAMCUF>; Sat, 12 Jan 2002 21:20:05 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:61706 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287948AbSAMCTt>; Sat, 12 Jan 2002 21:19:49 -0500
Message-ID: <3C40ED74.29F949CB@zip.com.au>
Date: Sat, 12 Jan 2002 18:14:12 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Walter <srwalter@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] unchecked request_region's in drivers/net
In-Reply-To: <20020112183542.A5557@hapablap.dyn.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Walter wrote:
> 
> As suggested, I have submitted each patch to its respective maintainer.
> Those patches below are those who either didn't respond, or okayed the
> patch for inclusion.
> 
> Any objection to this being merged in both 2.4 and 2.5?
> --
> -Steven
> In a time of universal deceit, telling the truth is a revolutionary act.
>                         -- George Orwell
> He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
> Well, who's mad now?
>                         -- Montgomery C. Burns
> 
> diff -Nru clean-2.4.17//drivers/net/irda/ali-ircc.c linux/drivers/net/irda/ali-ircc.c
> --- clean-2.4.17//drivers/net/irda/ali-ircc.c   Mon Nov  5 19:23:13 2001
> +++ linux/drivers/net/irda/ali-ircc.c   Thu Dec 27 14:08:34 2001

OK

> --- clean-2.4.17//drivers/net/hamradio/baycom_ser_fdx.c Thu Aug 16 15:50:30 2001
> +++ linux/drivers/net/hamradio/baycom_ser_fdx.c Thu Dec 27 13:58:40 2001

Need to call release_region() if request_irq() or ser12_check_uart() fail.

> --- clean-2.4.17//drivers/net/hamradio/baycom_ser_hdx.c Thu Aug 16 15:50:30 2001
> +++ linux/drivers/net/hamradio/baycom_ser_hdx.c Thu Dec 27 13:58:08 2001

Ditto.

> --- clean-2.4.17//drivers/net/arcnet/com90xx.c  Mon Nov  5 19:24:25 2001
> +++ linux/drivers/net/arcnet/com90xx.c  Thu Dec 27 13:32:25 2001
> @@ -479,7 +479,9 @@
>         dev->irq = airq;
> 
>         /* reserve the I/O and memory regions - guaranteed to work by check_region */
> -       request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (90xx)");
> +       if (!request_region(ioaddr, ARCNET_TOTAL_SIZE, "arcnet (90xx)"))
> +               goto err_release;
> +
>         request_mem_region(dev->mem_start, dev->mem_end - dev->mem_start + 1, "arcnet (90xx)");
>         dev->base_addr = ioaddr;

request_mem_region() also needs to have its reurn value checked,
and the error handling code needs some work so we only release things
which have been allocated, and so we don't miss things.

> --- clean-2.4.17//drivers/net/wan/comx-hw-comx.c        Mon Nov  5 19:22:12 2001
> +++ linux/drivers/net/wan/comx-hw-comx.c        Thu Dec 27 14:21:17 2001

OK

> --- clean-2.4.17//drivers/net/wan/comx-hw-locomx.c      Mon Nov  5 19:22:12 2001
> +++ linux/drivers/net/wan/comx-hw-locomx.c      Thu Dec 27 14:20:11 2001

OK

> --- clean-2.4.17//drivers/net/wan/cosa.c        Mon Nov  5 19:22:12 2001
> +++ linux/drivers/net/wan/cosa.c        Thu Dec 27 14:16:43 2001
> @@ -547,7 +547,8 @@
>         cosa->usage = 0;
>         cosa->nchannels = 2;    /* FIXME: how to determine this? */
> 
> -       request_region(base, is_8bit(cosa)?2:4, cosa->type);
> +       if (!request_region(base, is_8bit(cosa)?2:4, cosa->type))
> +               goto bad1;

`goto bad1;' here will try to release a region which we don't own.
You need to goto the next statement.

> --- clean-2.4.17//drivers/net/de4x5.c   Mon Nov  5 19:23:11 2001
> +++ linux/drivers/net/de4x5.c   Thu Dec 27 13:34:03 2001
> @@ -1296,9 +1296,10 @@
> 
>         barrier();
> 
> -       request_region(iobase, (lp->bus == PCI ? DE4X5_PCI_TOTAL_SIZE :
> +       if (!request_region(iobase, (lp->bus == PCI ? DE4X5_PCI_TOTAL_SIZE :
>                                 DE4X5_EISA_TOTAL_SIZE),
> -                      lp->adapter_name);
> +                      lp->adapter_name))
> +               return -EBUSY;
> 
>         lp->rxRingSize = NUM_RX_DESC;
>         lp->txRingSize = NUM_TX_DESC;

This will leak lots of stuff, but it's an improvement over what is
there at present.  I think de4x5 is deprecated?  Probably OK, unless
you're feeling ambitious about the resource leaks.

> diff -Nru clean-2.4.17//drivers/net/de600.c linux/drivers/net/de600.c
> --- clean-2.4.17//drivers/net/de600.c   Mon Nov  5 19:23:11 2001
> +++ linux/drivers/net/de600.c   Thu Dec 27 13:34:28 2001
> @@ -689,7 +689,8 @@
>                 return -EBUSY;
>         }
>  #endif
> -       request_region(DE600_IO, 3, "de600");
> +       if (!request_region(DE600_IO, 3, "de600"))
> +               return -EBUSY
> 
>         printk(", Ethernet Address: %02X", dev->dev_addr[0]);
>         for (i = 1; i < ETH_ALEN; i++)

Seems OK.

> diff -Nru clean-2.4.17//drivers/net/ewrk3.c linux/drivers/net/ewrk3.c
> --- clean-2.4.17//drivers/net/ewrk3.c   Mon Nov  5 19:23:12 2001
> +++ linux/drivers/net/ewrk3.c   Thu Dec 27 13:40:31 2001

OK, I think.  (yech)

> --- clean-2.4.17//drivers/net/gt96100eth.c      Mon Nov  5 19:24:01 2001
> +++ linux/drivers/net/gt96100eth.c      Thu Dec 27 13:55:39 2001
> @@ -493,7 +493,8 @@
>                 printk(KERN_INFO "gt96100_probe1: ioaddr 0x%lx, irq %d\n",
>                        ioaddr, irq);
> 
> -       request_region(ioaddr, GT96100_ETH_IO_SIZE, "GT96100ETH");
> +       if (!request_region(ioaddr, GT96100_ETH_IO_SIZE, "GT96100ETH"))
> +               return -EBUSY;
> 
>         cpuConfig = GT96100_READ(GT96100_CPU_INTERF_CONFIG);
>         if (cpuConfig & (1 << 12)) {

OK.  A `goto out;' here would be better - multiple return statements
in functions are a maintainability problem, and it'll match the
current style.

> diff -Nru clean-2.4.17//drivers/net/irda/irport.c linux/drivers/net/irda/irport.c
> --- clean-2.4.17//drivers/net/irda/irport.c     Mon Nov  5 19:23:13 2001
> +++ linux/drivers/net/irda/irport.c     Thu Dec 27 14:06:16 2001
> @@ -169,13 +169,11 @@
>          self->io.fifo_size = 16;
> 
>         /* Lock the port that we need */
> -       ret = check_region(self->io.sir_base, self->io.sir_ext);
> -       if (ret < 0) {
> +       if (!request_region(self->io.sir_base, self->io.sir_ext, driver_name)) {
>                 IRDA_DEBUG(0, __FUNCTION__ "(), can't get iobase of 0x%03x\n",
>                            self->io.sir_base);
>                 return NULL;
>         }
> -       request_region(self->io.sir_base, self->io.sir_ext, driver_name);
> 
>         /* Initialize QoS for this device */
>         irda_init_max_qos_capabilies(&self->qos);

kfree(self) needed.

> diff -Nru clean-2.4.17//drivers/net/isa-skeleton.c linux/drivers/net/isa-skeleton.c
> --- clean-2.4.17//drivers/net/isa-skeleton.c    Mon Nov  5 19:24:01 2001
> +++ linux/drivers/net/isa-skeleton.c    Thu Dec 27 14:09:17 2001
> @@ -281,7 +281,8 @@
>         spin_lock_init(&np->lock);
> 
>         /* Grab the region so that no one else tries to probe our ioports. */
> -       request_region(ioaddr, NETCARD_IO_EXTENT, cardname);
> +       if (!request_region(ioaddr, NETCARD_IO_EXTENT, cardname))
> +               return -EBUSY;
> 
>         dev->open               = net_open;
>         dev->stop               = net_close;

heh.  A bug in the skeleton driver.   We need to release the irq and the dma
which were earlier allocated.

> diff -Nru clean-2.4.17//drivers/net/wan/lmc/lmc_main.c linux/drivers/net/wan/lmc/lmc_main.c
> --- clean-2.4.17//drivers/net/wan/lmc/lmc_main.c        Mon Nov  5 19:22:13 2001
> +++ linux/drivers/net/wan/lmc/lmc_main.c        Thu Dec 27 14:22:37 2001
> @@ -945,7 +945,13 @@
>       * later on, no one else will take our card away from
>       * us.
>       */
> -    request_region (ioaddr, LMC_REG_RANGE, dev->name);
> +    if (!request_region (ioaddr, LMC_REG_RANGE, dev->name)) {
> +           printk(KERN_ERR "%s: request_region failed.\n", dev->name);
> +           lmc_proto_detach(sc);
> +           kfree(dev->priv);
> +           kfree(dev);
> +           return NULL;
> +    }
> 
>      sc->lmc_cardtype = LMC_CARDTYPE_UNKNOWN;
>      sc->lmc_timing = LMC_CTL_CLOCK_SOURCE_EXT;

the request_region() should happen before the register_netdev(), and
can share its cleanup code.

> diff -Nru clean-2.4.17//drivers/net/ni5010.c linux/drivers/net/ni5010.c
> --- clean-2.4.17//drivers/net/ni5010.c  Mon Nov  5 19:23:13 2001
> +++ linux/drivers/net/ni5010.c  Thu Dec 27 14:10:35 2001
> @@ -308,7 +308,8 @@
>         memset(dev->priv, 0, sizeof(struct ni5010_local));
> 
>         /* Grab the region so we can find another board if autoIRQ fails. */
> -       request_region(ioaddr, NI5010_IO_EXTENT, boardname);
> +       if (!request_region(ioaddr, NI5010_IO_EXTENT, boardname))
> +               return -EBUSY;
> 
>         dev->open               = ni5010_open;
>         dev->stop               = ni5010_close;

Lots of resource leaks here.  Suggest you also add a comment 
indicating that this is a "known bug" :)  Depending on how keen
you're feeling.

> diff -Nru clean-2.4.17//drivers/net/ni65.c linux/drivers/net/ni65.c
> --- clean-2.4.17//drivers/net/ni65.c    Mon Nov  5 19:23:13 2001
> +++ linux/drivers/net/ni65.c    Thu Dec 27 14:11:21 2001

Ditto.

> --- clean-2.4.17//drivers/net/irda/nsc-ircc.c   Mon Nov  5 19:23:13 2001
> +++ linux/drivers/net/irda/nsc-ircc.c   Thu Dec 27 14:08:03 2001

Already fixed in 2.4.18-pre3 (!)

> --- clean-2.4.17//drivers/net/hamradio/scc.c    Mon Nov  5 19:24:25 2001
> +++ linux/drivers/net/hamradio/scc.c    Thu Dec 27 14:00:34 2001

OK

> --- clean-2.4.17//drivers/net/irda/w83977af_ir.c        Mon Nov  5 19:23:13 2001
> +++ linux/drivers/net/irda/w83977af_ir.c        Thu Dec 27 14:07:23 2001

Fixed in 2.4.18-pre3

> --- clean-2.4.17//drivers/net/hamradio/yam.c    Mon Nov  5 19:23:12 2001
> +++ linux/drivers/net/hamradio/yam.c    Thu Dec 27 14:02:40 2001

OK

> --- clean-2.4.17//drivers/net/arcnet/com90io.c  Mon Nov  5 19:24:25 2001
> +++ linux/drivers/net/arcnet/com90io.c  Thu Dec 27 13:30:57 2001
> @@ -241,7 +241,8 @@
>                 return -ENODEV;
>         }
>         /* Reserve the I/O region - guaranteed to work by check_region */
> -       request_region(dev->base_addr, ARCNET_TOTAL_SIZE, "arcnet (COM90xx-IO)");
> +       if (!request_region(dev->base_addr, ARCNET_TOTAL_SIZE, "arcnet (COM90xx-IO)"))
> +               return -EBUSY;
> 
>         /* Initialize the rest of the device structure. */
>         dev->priv = kmalloc(sizeof(struct arcnet_local), GFP_KERNEL);

Need a free_irq() here.

> diff -Nru clean-2.4.17//drivers/net/sb1000.c linux/drivers/net/sb1000.c
> --- clean-2.4.17//drivers/net/sb1000.c  Mon Nov  5 19:23:13 2001
> +++ linux/drivers/net/sb1000.c  Thu Dec 27 14:13:18 2001
> @@ -262,8 +262,9 @@
> 
>                 /* Lock resources */
> 
> -               request_region(ioaddr[0], 16, dev->name);
> -               request_region(ioaddr[1], 16, dev->name);
> +               if (!request_region(ioaddr[0], 16, dev->name) ||
> +                   !request_region(ioaddr[1], 16, dev->name))
> +                       return -EBUSY;
> 
>                 return 0;
>         }

Lots of leaks - looks like this can be moved up to "Ok set it up".

> @@ -962,8 +963,9 @@
>         /* rmem_end holds the second I/O address - fv */
>         ioaddr[1] = dev->rmem_end;
>         name = dev->name;
> -       request_region(ioaddr[0], SB1000_IO_EXTENT, "sb1000");
> -       request_region(ioaddr[1], SB1000_IO_EXTENT, "sb1000");
> +       if (!request_region(ioaddr[0], SB1000_IO_EXTENT, "sb1000") ||
> +           !request_region(ioaddr[1], SB1000_IO_EXTENT, "sb1000"))
> +               return -EBUSY;
> 
>         /* initialize sb1000 */
>         if ((status = sb1000_reset(ioaddr, name)))

ug.  This looks like a driver bug.  Those regions were reserved
in the probe function.  We don't request IO resources in the
open() function.  I think just delete those lines.


> diff -Nru clean-2.4.17//drivers/net/wan/sealevel.c linux/drivers/net/wan/sealevel.c
> --- clean-2.4.17//drivers/net/wan/sealevel.c    Mon Nov  5 19:23:14 2001
> +++ linux/drivers/net/wan/sealevel.c    Thu Dec 27 14:18:21 2001

OK.
