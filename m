Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274973AbTHPWQG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 18:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274975AbTHPWQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 18:16:06 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:30654 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S274973AbTHPWQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 18:16:00 -0400
Message-ID: <3F3EAD2E.4020702@myrealbox.com>
Date: Sat, 16 Aug 2003 15:16:14 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 current - firewire compile error
References: <3F3E288B.3010105@cornell.edu> <3F3DD93E.7090706@myrealbox.com> <20030816163643.GB9735@kroah.com> <20030816172234.GB9552@neo.rr.com>
In-Reply-To: <20030816172234.GB9552@neo.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:

>>On Sat, Aug 16, 2003 at 12:11:58AM -0700, walt wrote:

>>>drivers/pnp/core.c: In function `pnp_register_protocol':
>>>drivers/pnp/core.c:72: structure has no member named `name'

> I apoligize for forgetting to correct this.  Here is a fix.

> diff -urN a/drivers/pnp/core.c b/drivers/pnp/core.c
> --- a/drivers/pnp/core.c	2003-08-09 04:33:18.000000000 +0000
> +++ b/drivers/pnp/core.c	2003-08-16 16:26:59.000000000 +0000
> @@ -69,7 +69,6 @@
>  
>  	protocol->number = nodenum;
>  	sprintf(protocol->dev.bus_id, "pnp%d", nodenum);
> -	strlcpy(protocol->dev.name,protocol->name,DEVICE_NAME_SIZE);
>  	return device_register(&protocol->dev);
>  }
>  
> diff -urN a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
> --- a/drivers/pnp/isapnp/core.c	2003-08-09 04:37:19.000000000 +0000
> +++ b/drivers/pnp/isapnp/core.c	2003-08-16 16:45:16.000000000 +0000
> @@ -743,7 +743,7 @@
>  			size = 0;
>  			break;
>  		case _LTAG_ANSISTR:
> -			isapnp_parse_name(dev->dev.name, sizeof(dev->dev.name), &size);
> +			isapnp_parse_name(dev->name, sizeof(dev->name), &size);
>  			break;
>  		case _LTAG_UNICODESTR:
>  			/* silently ignore */
> @@ -808,7 +808,7 @@
>  		case _STAG_VENDOR:
>  			break;
>  		case _LTAG_ANSISTR:
> -			isapnp_parse_name(card->dev.name, sizeof(card->dev.name), &size);
> +			isapnp_parse_name(card->name, sizeof(card->name), &size);
>  			break;
>  		case _LTAG_UNICODESTR:
>  			/* silently ignore */
> @@ -1144,11 +1144,11 @@
>  	protocol_for_each_card(&isapnp_protocol,card) {
>  		cards++;
>  		if (isapnp_verbose) {
> -			printk(KERN_INFO "isapnp: Card '%s'\n", card->dev.name[0]?card->dev.name:"Unknown");
> +			printk(KERN_INFO "isapnp: Card '%s'\n", card->name[0]?card->name:"Unknown");
>  			if (isapnp_verbose < 2)
>  				continue;
>  			card_for_each_dev(card,dev) {
> -				printk(KERN_INFO "isapnp:   Device '%s'\n", dev->dev.name[0]?dev->dev.name:"Unknown");
> +				printk(KERN_INFO "isapnp:   Device '%s'\n", dev->name[0]?dev->name:"Unknown");
>  			}
>  		}
>  	}
> --- a/drivers/serial/8250_pnp.c	2003-08-09 04:31:45.000000000 +0000
> +++ b/drivers/serial/8250_pnp.c	2003-08-16 16:47:21.000000000 +0000
> @@ -369,7 +369,7 @@
>   */
>  static int __devinit serial_pnp_guess_board(struct pnp_dev *dev, int *flags)
>  {
> -	if (!(check_name(dev->dev.name) || (dev->card && check_name(dev->card->dev.name))))
> +	if (!(check_name(pnp_dev_name(dev)) || (dev->card && check_name(dev->card->name))))
>  		return -ENODEV;
>  
>  	if (check_resources(dev->independent))
> --- a/include/linux/pnp.h	2003-08-09 04:42:16.000000000 +0000
> +++ b/include/linux/pnp.h	2003-08-16 16:43:32.000000000 +0000
> @@ -19,6 +19,7 @@
>  #define PNP_MAX_DMA		2
>  #define PNP_MAX_DEVICES		8
>  #define PNP_ID_LEN		8
> +#define PNP_NAME_LEN		50
>  
>  struct pnp_protocol;
>  struct pnp_dev;
> @@ -133,6 +134,7 @@
>  	struct pnp_protocol * protocol;
>  	struct pnp_id * id;		/* contains supported EISA IDs*/
>  
> +	char name[PNP_NAME_LEN];	/* contains a human-readable name */
>  	unsigned char	pnpver;		/* Plug & Play version */
>  	unsigned char	productver;	/* product version */
>  	unsigned int	serial;		/* serial number */
> @@ -187,6 +189,7 @@
>  	struct pnp_option * dependent;
>  	struct pnp_resource_table res;
>  
> +	char name[PNP_NAME_LEN];	/* contains a human-readable name */
>  	unsigned short	regs;		/* ISAPnP: supported registers */
>  	int 		flags;		/* used by protocols */
>  	struct proc_dir_entry *procent;	/* device entry in /proc/bus/isapnp */
> @@ -204,7 +207,7 @@
>  	for((dev) = card_to_pnp_dev((card)->devices.next); \
>  	(dev) != card_to_pnp_dev(&(card)->devices); \
>  	(dev) = card_to_pnp_dev((dev)->card_list.next))
> -#define pnp_dev_name(dev) (dev)->dev.name
> +#define pnp_dev_name(dev) (dev)->name
>  
>  static inline void *pnp_get_drvdata (struct pnp_dev *pdev)
>  {

Your patch works for me, thanks!

