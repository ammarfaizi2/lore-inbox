Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131194AbRCRLbd>; Sun, 18 Mar 2001 06:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbRCRLbY>; Sun, 18 Mar 2001 06:31:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:6029 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S131194AbRCRLbT>;
	Sun, 18 Mar 2001 06:31:19 -0500
Message-ID: <3AB49C2E.4792071B@mandrakesoft.com>
Date: Sun, 18 Mar 2001 06:29:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
        Andrew Morton <andrewm@uow.edu.au>, netdev@oss.sgi.com
Subject: Re: [CHECKER] 120 potential dereference to invalid pointers errors 
 forlinux 2.4.1
In-Reply-To: <Pine.GSO.4.31.0103170126540.14147-100000@elaine24.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang wrote:
> [BUG] dev_alloc_skb can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/3c505.c:619:receive_packet: ERROR:NULL:598:619: Using NULL ptr "skb" illegally! set by 'dev_alloc_skb':598

Fixed.


> [BUG] init_etherdev could return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/3c515.c:604:corkscrew_found_device: ERROR:NULL:603:604: Using unknown ptr "dev" illegally! set by 'init_etherdev':603
> 
> Start --->
>         dev = init_etherdev(dev, sizeof(struct corkscrew_private));
> Error --->
>         dev->base_addr = ioaddr;
>         dev->irq = irq;

init_etherdev is a special case -- It can conditionally take NULL as its
first argument.  If that is the case, when an allocation is performed,
and the return val needed to be checked for NULL.  If init_etherdev's
first arg is guaranteed to be non-NULL, you do not need to check its
return value.  3c515 is one such case.

> [BUG] init_etherdev can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/aironet4500_card.c:537:awc4500_isa_probe: ERROR:NULL:535:537: Using unknown ptr "dev" illegally! set by 'init_etherdev':535

Fixed.


> [BUG]
> /u2/acc/oses/linux/2.4.1/drivers/net/aironet4500_card.c:375:awc4500_pnp_probe: ERROR:NULL:373:375: Using unknown ptr "dev" illegally! set by 'init_etherdev':373

Fixed.


> [BUG] dev_alloc_skb can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/defxx.c:2719:dfx_rcv_init: ERROR:NULL:2712:2719: Using unknown ptr "newskb" illegally! set by 'dev_alloc_skb':2712

Seems to be fixed already in my 2.4.3-pre4-based tree.


> [BUG] kmalloc can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/dgrs.c:1258:dgrs_found_device: ERROR:NULL:1256:1258: Using unknown ptr "dev" illegally! set by 'kmalloc':1256

Seems to be fixed already in my 2.4.3-pre4-based tree.


> [BUG] kmalloc can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/dgrs.c:1297:dgrs_found_device: ERROR:NULL:1294:1297: Using unknown ptr "devN" illegally! set by 'kmalloc':1294

Seems to be fixed already in my 2.4.3-pre4-based tree.


> [BUG] kmalloc can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/aironet4500_cs.c:181:awc_attach: ERROR:NULL:179:181: Using unknown ptr "link" illegally! set by 'kmalloc':179
> 
> Start --->
>         link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
>         memset(link, 0, sizeof(struct dev_link_t));
> Error --->
>         link->dev = kmalloc(sizeof(struct dev_node_t), GFP_KERNEL);
>         memset(link->dev, 0, sizeof(struct dev_node_t));

Fixed.  Your checker missed two other problems of the same sort in the
same function... one of the two missed is the link->dev kmalloc you show
in your example here.


> [BUG] kmalloc can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/wavelan_cs.c:4463:wavelan_attach: ERROR:NULL:4458:4463: Using unknown ptr "dev" illegally! set by 'kmalloc':4458

Seems to be fixed already in my 2.4.3-pre4-based tree.

> [BUG] kmalloc can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/wavelan_cs.c:4430:wavelan_attach: ERROR:NULL:4426:4430: Using unknown ptr "link" illegally! set by 'kmalloc':4426

Seems to be fixed already in my 2.4.3-pre4-based tree.


> [BUG] dev could be NULL, then init_etherdev -> init_netdev will alloc a new device -- it could fail.
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/xircom_tulip_cb.c:559:tulip_probe1: ERROR:NULL:522:559: Using unknown ptr "dev" illegally! set by 'init_etherdev':522

Fixed, although this driver is going away when Arjan's Xircom driver
matures.


> [BUG] init_etherdev
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/xircom_tulip_cb.c:577:tulip_probe1: ERROR:NULL:522:577: Using unknown ptr "dev" illegally! set by 'init_etherdev':522
> [BUG] init_etherdev
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/xircom_tulip_cb.c:607:tulip_probe1: ERROR:NULL:522:607: Using unknown ptr "dev" illegally! set by 'init_etherdev':522
> [BUG] init_etherdev
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/xircom_tulip_cb.c:636:tulip_probe1: ERROR:NULL:522:636: Using unknown ptr "dev" illegally! set by 'init_etherdev':522
> [BUG] init_etherdev
> /u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/xircom_tulip_cb.c:642:tulip_probe1: ERROR:NULL:522:642: Using unknown ptr "dev" illegally! set by 'init_etherdev':522

Fixed by the above fix.

Is this a checker bug... or does the checker spit out each incorrect
de-ref?


> [BUG] function doesn't exit if skb == NULL. just printk
> /u2/acc/oses/linux/2.4.1/drivers/net/smc9194.c:1356:smc_rcv: ERROR:NULL:1341:1356: Using NULL ptr "skb" illegally! set by 'dev_alloc_skb':1341

Seems to be fixed already in my 2.4.3-pre4-based tree.


> [BUG] init_etherdev can return NULL if dev is NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/sunhme.c:2838:happy_meal_pci_init: ERROR:NULL:2806:2838: Using unknown ptr "dev" illegally! set by 'init_etherdev':2806

Fixed.


> [BUG] dev could be NULL, then init_trdev will call init_netdev to allocate a new device.
> /u2/acc/oses/linux/2.4.1/drivers/net/tokenring/ibmtr.c:405:ibmtr_probe1: ERROR:NULL:304:405: Using unknown ptr "dev" illegally! set by 'init_trdev':304
> 
> Start --->
>         dev = init_trdev(dev,0);

As with 3c515, this is a false positive.  'dev' is never NULL when
passed to init_trdev, so the call always succeeds.

> [BUG] dev_alloc_skb can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/tokenring/lanstreamer.c:1429:streamer_arb_cmd: ERROR:NULL:1386:1429: Using unknown ptr "mac_frame" illegally! set by 'dev_alloc_skb':1386

Seems to be fixed already in my 2.4.3-pre4 tree.


> [BUG] dev_alloc_skb can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/tokenring/olympic.c:1276:olympic_arb_cmd: ERROR:NULL:1258:1276: Using unknown ptr "mac_frame" illegally! set by 'dev_alloc_skb':1258

Fixed.


> [BUG] init_trdev can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/tokenring/olympic.c:219:olympic_scan: ERROR:NULL:217:219: Using unknown ptr "dev" illegally! set by 'init_trdev':217

Fixed.

> [BUG] kmalloc can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/tokenring/olympic.c:226:olympic_scan: ERROR:NULL:212:226: Using unknown ptr "olympic_priv" illegally! set by 'kmalloc':212

Seems to be fixed already in my 2.4.3-pre4 tree.


> [BUG] dev_alloc_skb can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/tokenring/smctr.c:3956:smctr_process_rx_packet: ERROR:NULL:3955:3956: Using unknown ptr "skb" illegally! set by 'dev_alloc_skb':3955

Seems to be fixed already in my 2.4.3-pre4 tree.


> [BUG] dev_alloc_skb can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/tokenring/smctr.c:4633:smctr_rx_frame: ERROR:NULL:4630:4633: Using unknown ptr "skb" illegally! set by 'dev_alloc_skb':4630

Fixed.


> [BUG] dev_alloc_skb can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/tokenring/tms380tr.c:2167:tms380tr_rcv_status_irq: ERROR:NULL:2149:2167: Using NULL ptr "skb" illegally! set by 'dev_alloc_skb':2149

Seems to be fixed already in my 2.4.3-pre4 tree.


> [BUG] dev_alloc_skb can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/net/tokenring/tms380tr.c:2172:tms380tr_rcv_status_irq: ERROR:NULL:2149:2172: Using NULL ptr "skb" illegally! set by 'dev_alloc_skb':2149

Fixed.


> [BUG] kmalloc can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/pci/setup-res.c:166:pdev_sort_resources: ERROR:NULL:165:166: Using unknown ptr "tmp" illegally! set by 'kmalloc':165
> 
> Start --->
>                                 tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
> Error --->
>                                 tmp->next = ln;
>                                 tmp->res = r;
> ---------------------------------------------------------
> [BUG] kmalloc can return NULL
> /u2/acc/oses/linux/2.4.1/drivers/pcmcia/bulkmem.c:231:setup_erase_request: ERROR:NULL:230:231: Using unknown ptr "busy" illegally! set by 'kmalloc':230
> 
> Start --->
>             busy = kmalloc(sizeof(erase_busy_t), GFP_KERNEL);
> Error --->

This sizeof() construct may be a special case for your checker, but it's
a common one for the kernel...  It definitely doesn't de-reference a
pointer.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
