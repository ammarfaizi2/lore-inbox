Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWGUGs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWGUGs7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 02:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWGUGs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 02:48:59 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:28128 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030436AbWGUGs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 02:48:58 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Panagiotis Issaris <takis@lumumba.uhasselt.be>
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to k(z|c)alloc.
Date: Fri, 21 Jul 2006 08:50:17 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, chas@cmf.nrl.navy.mil,
       miquel@df.uba.ar, kkeil@suse.de, benh@kernel.crashing.org,
       video4linux-list@redhat.com, rmk+mmc@arm.linux.org.uk,
       Neela.Kolli@engenio.com, jgarzik@pobox.com, vandrove@vc.cvut.cz,
       adaplas@pol.net, thomas@winischhofer.net, weissg@vienna.at,
       philb@gnu.org, linux-pcmcia@lists.infradead.org, jkmaline@cc.hut.fi,
       paulus@samba.org
References: <20060720190529.GC7643@lumumba.uhasselt.be>
In-Reply-To: <20060720190529.GC7643@lumumba.uhasselt.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607210850.17878.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 20. Juli 2006 21:05 schrieb Panagiotis Issaris:
> From: Panagiotis Issaris <takis@issaris.org>
>
> drivers: Conversions from kmalloc+memset to k(z|c)alloc.
> --- a/drivers/atm/zatm.c
> +++ b/drivers/atm/zatm.c
> @@ -603,9 +603,8 @@ static int start_rx(struct atm_dev *dev)
>  DPRINTK("start_rx\n");
>  	zatm_dev = ZATM_DEV(dev);
>  	size = sizeof(struct atm_vcc *)*zatm_dev->chans;
> -	zatm_dev->rx_map = (struct atm_vcc **) kmalloc(size,GFP_KERNEL);
> +	zatm_dev->rx_map = kzalloc(size,GFP_KERNEL);

Space after comma.

> @@ -951,9 +950,8 @@ static int open_tx_first(struct atm_vcc
>  	skb_queue_head_init(&zatm_vcc->tx_queue);
>  	init_waitqueue_head(&zatm_vcc->tx_wait);
>  	/* initialize ring */
> -	zatm_vcc->ring = kmalloc(RING_SIZE,GFP_KERNEL);
> +	zatm_vcc->ring = kzalloc(RING_SIZE,GFP_KERNEL);

Same here

> @@ -443,12 +442,11 @@ int con_clear_unimap(struct vc_data *vc,
>  	p = (struct uni_pagedir *)*vc->vc_uni_pagedir_loc;
>  	if (p && p->readonly) return -EIO;
>  	if (!p || --p->refcount) {
> -		q = (struct uni_pagedir *)kmalloc(sizeof(*p), GFP_KERNEL);
> +		q = kzalloc(sizeof(*p), GFP_KERNEL);
>  		if (!q) {
>  			if (p) p->refcount++;
>  			return -ENOMEM;
>  		}
> -		memset(q, 0, sizeof(*q));
>  		q->refcount=1;
>  		*vc->vc_uni_pagedir_loc = (unsigned long)q;
>  	} else {

This one still changes the way the code works. Before your patch *p will be 
always zeroed out. Now if p is there before it will keep it's contents.

> diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
> index 056ebe8..c39d9bc 100644
> --- a/drivers/char/keyboard.c
> +++ b/drivers/char/keyboard.c
> @@ -1298,9 +1298,9 @@ static struct input_handle *kbd_connect(
>  	if (i == BTN_MISC && !test_bit(EV_SND, dev->evbit))
>  		return NULL;
>
> -	if (!(handle = kmalloc(sizeof(struct input_handle), GFP_KERNEL)))
> +	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
> +	if (!handle)
>  		return NULL;

sizeof(*handle)?

> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 4c3a5ca..0b520f6 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -911,9 +911,8 @@ void rand_initialize_irq(int irq)
>  	 * If kmalloc returns null, we just won't use that entropy
>  	 * source.
>  	 */
> -	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
> +	state = kzalloc(sizeof(struct timer_rand_state), GFP_KERNEL);

sizeof(*state)?

> @@ -926,9 +925,8 @@ void rand_initialize_disk(struct gendisk
>  	 * If kmalloc returns null, we just won't use that entropy
>  	 * source.
>  	 */
> -	state = kmalloc(sizeof(struct timer_rand_state), GFP_KERNEL);
> +	state = kzalloc(sizeof(struct timer_rand_state), GFP_KERNEL);

Also here.

> diff --git a/drivers/char/sx.c b/drivers/char/sx.c
> index e1cd2bc..22b240c 100644
> --- a/drivers/char/sx.c
> +++ b/drivers/char/sx.c
> @@ -2278,18 +2278,6 @@ static int sx_init_drivers(void)
>  	return 0;
>  }
>
> -
> -static void * ckmalloc (int size)
> -{
> -	void *p;
> -
> -	p = kmalloc(size, GFP_KERNEL);
> -	if (p)
> -		memset(p, 0, size);
> -	return p;
> -}
> -
> -
>  static int sx_init_portstructs (int nboards, int nports)
>  {
>  	struct sx_board *board;
> @@ -2302,7 +2290,7 @@ static int sx_init_portstructs (int nboa
>
>  	/* Many drivers statically allocate the maximum number of ports
>  	   There is no reason not to allocate them dynamically. Is there? -- REW
> */ -	sx_ports          = ckmalloc(nports * sizeof (struct sx_port));
> +	sx_ports          = kcalloc(nports, sizeof (struct sx_port), GFP_KERNEL);

No space before opening brace.

> @@ -1477,7 +1466,7 @@ static int init_dev(struct tty_driver *d
>  	tp = o_tp = NULL;
>  	ltp = o_ltp = NULL;
>
> -	tty = alloc_tty_struct();
> +	tty = kzalloc(sizeof(struct tty_struct), GFP_KERNEL);

sizeof(*tty)?

> @@ -1502,15 +1491,13 @@ static int init_dev(struct tty_driver *d
>  	}
>
>  	if (!*ltp_loc) {
> -		ltp = (struct termios *) kmalloc(sizeof(struct termios),
> -						 GFP_KERNEL);
> +		ltp = kzalloc(sizeof(struct termios), GFP_KERNEL);

sizeof(*ltp)?

[more of this snipped]

> diff --git a/drivers/isdn/hisax/hfc_usb.c b/drivers/isdn/hisax/hfc_usb.c
> index b5e571a..8373ce4 100644
> --- a/drivers/isdn/hisax/hfc_usb.c
> +++ b/drivers/isdn/hisax/hfc_usb.c
> @@ -1479,11 +1479,9 @@ #endif
>  		/* found a valid USB Ta Endpint config */
>  		if (small_match != 0xffff) {
>  			iface = iface_used;
> -			if (!
> -			    (context =
> -			     kmalloc(sizeof(hfcusb_data), GFP_KERNEL)))
> +			context = kzalloc(sizeof(hfcusb_data), GFP_KERNEL);
> +			if (!context)
>  				return (-ENOMEM);	/* got no mem */

while you're at it. can you please change it to "return -ENOMEM;"? The comment 
does not help anyone and we return without braces.

> diff --git a/drivers/media/video/planb.c b/drivers/media/video/planb.c
> index 3484e36..25f8485 100644
> --- a/drivers/media/video/planb.c
> +++ b/drivers/media/video/planb.c
> @@ -353,9 +353,9 @@ static int planb_prepare_open(struct pla
>  		* PLANB_DUMMY)*sizeof(struct dbdma_cmd)
>  		+(PLANB_MAXLINES*((PLANB_MAXPIXELS+7)& ~7))/8
>  		+MAX_GBUFFERS*sizeof(unsigned int);
> -	if ((pb->priv_space = kmalloc (size, GFP_KERNEL)) == 0)
> +	pb->priv_space = kzalloc (size, GFP_KERNEL);

space

[...]

Eike
