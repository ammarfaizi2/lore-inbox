Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWJBJbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWJBJbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWJBJbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:31:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:37840 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751064AbWJBJbO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:31:14 -0400
Date: Mon, 2 Oct 2006 11:31:11 +0200
From: Karsten Keil <kkeil@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, kai.germaschewski@gmx.de,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ISDN: mark as 32-bit only
Message-ID: <20061002093111.GB10395@pingi.kke.suse.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Jeff Garzik <jeff@garzik.org>, kai.germaschewski@gmx.de,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20061001152116.GA4684@havoc.gtf.org> <1159746470.13029.194.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159746470.13029.194.camel@localhost.localdomain>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.23-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

On Mon, Oct 02, 2006 at 12:47:50AM +0100, Alan Cox wrote:
> Some suggestions on doing it better
> 
> - Clean up warnings in drivers/isdn by using long not int for the values
> where we pass void * and cast to integer types. The code is ok (ok
> passing the stuff this way isn't pretty but the code is valid). In all
> the cases I checked out the right thing happens anyway but this removes
> all the warnings.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Acked-by: kkeil@suse.de

> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/config.c linux-2.6.18-mm2/drivers/isdn/hisax/config.c
> --- linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/config.c	2006-09-20 04:42:06.000000000 +0100
> +++ linux-2.6.18-mm2/drivers/isdn/hisax/config.c	2006-09-25 12:20:16.000000000 +0100
> @@ -1721,11 +1721,11 @@
>  		hisax_b_sched_event(bcs, B_RCVBUFREADY);
>  		break;
>  	case PH_DATA | CONFIRM:
> -		bcs->tx_cnt -= (int) arg;
> +		bcs->tx_cnt -= (long)arg;
>  		if (test_bit(FLG_LLI_L1WAKEUP,&bcs->st->lli.flag)) {
>  			u_long	flags;
>  			spin_lock_irqsave(&bcs->aclock, flags);
> -			bcs->ackcnt += (int) arg;
> +			bcs->ackcnt += (long)arg;
>  			spin_unlock_irqrestore(&bcs->aclock, flags);
>  			schedule_event(bcs, B_ACKPENDING);
>  		}
> @@ -1789,7 +1789,7 @@
>  
>  	switch (pr) {
>  	case PH_ACTIVATE | REQUEST:
> -		B_L2L1(b_if, pr, (void *) st->l1.mode);
> +		B_L2L1(b_if, pr, (void *)(unsigned long)st->l1.mode);
>  		break;
>  	case PH_DATA | REQUEST:
>  	case PH_PULL | INDICATION:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/hfc4s8s_l1.c linux-2.6.18-mm2/drivers/isdn/hisax/hfc4s8s_l1.c
> --- linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/hfc4s8s_l1.c	2006-09-20 04:42:06.000000000 +0100
> +++ linux-2.6.18-mm2/drivers/isdn/hisax/hfc4s8s_l1.c	2006-09-25 12:20:25.000000000 +0100
> @@ -424,7 +424,7 @@
>  	struct hfc4s8s_btype *bch = ifc->priv;
>  	struct hfc4s8s_l1 *l1 = bch->l1p;
>  	struct sk_buff *skb = (struct sk_buff *) arg;
> -	int mode = (int) arg;
> +	long mode = (long) arg;
>  	u_long flags;
>  
>  	switch (pr) {
> @@ -914,7 +914,7 @@
>  	struct sk_buff *skb;
>  	u_char f1, f2;
>  	u_char *cp;
> -	int cnt;
> +	long cnt;
>  
>  	if (l1p->l1_state != 7)
>  		return;
> @@ -980,7 +980,8 @@
>  	struct sk_buff *skb;
>  	struct hfc4s8s_l1 *l1 = bch->l1p;
>  	u_char *cp;
> -	int cnt, max, hdlc_num, ack_len = 0;
> +	int cnt, max, hdlc_num;
> +	long ack_len = 0;
>  
>  	if (!l1->enabled || (bch->mode == L1_MODE_NULL))
>  		return;
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/hfc_sx.c linux-2.6.18-mm2/drivers/isdn/hisax/hfc_sx.c
> --- linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/hfc_sx.c	2006-09-20 04:42:06.000000000 +0100
> +++ linux-2.6.18-mm2/drivers/isdn/hisax/hfc_sx.c	2006-09-25 12:20:25.000000000 +0100
> @@ -970,7 +970,7 @@
>  			break;
>  		case (HW_TESTLOOP | REQUEST):
>  			spin_lock_irqsave(&cs->lock, flags);
> -			switch ((int) arg) {
> +			switch ((long) arg) {
>  				case (1):
>  					Write_hfc(cs, HFCSX_B1_SSL, 0x80);	/* tx slot */
>  					Write_hfc(cs, HFCSX_B1_RSL, 0x80);	/* rx slot */
> @@ -986,7 +986,7 @@
>  				default:
>  					spin_unlock_irqrestore(&cs->lock, flags);
>  					if (cs->debug & L1_DEB_WARN)
> -						debugl1(cs, "hfcsx_l1hw loop invalid %4x", (int) arg);
> +						debugl1(cs, "hfcsx_l1hw loop invalid %4lx", arg);
>  					return;
>  			}
>  			cs->hw.hfcsx.trm |= 0x80;	/* enable IOM-loop */
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/hfc_usb.c linux-2.6.18-mm2/drivers/isdn/hisax/hfc_usb.c
> --- linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/hfc_usb.c	2006-09-20 04:42:06.000000000 +0100
> +++ linux-2.6.18-mm2/drivers/isdn/hisax/hfc_usb.c	2006-09-25 12:20:25.000000000 +0100
> @@ -696,7 +696,7 @@
>  				fifo->delete_flg = TRUE;
>  				fifo->hif->l1l2(fifo->hif,
>  						PH_DATA | CONFIRM,
> -						(void *) fifo->skbuff->
> +						(void *) (unsigned long) fifo->skbuff->
>  						truesize);
>  				if (fifo->skbuff && fifo->delete_flg) {
>  					dev_kfree_skb_any(fifo->skbuff);
> @@ -1144,7 +1144,7 @@
>  				set_hfcmode(hfc,
>  					    (fifo->fifonum ==
>  					     HFCUSB_B1_TX) ? 0 : 1,
> -					    (int) arg);
> +					    (long) arg);
>  				fifo->hif->l1l2(fifo->hif,
>  						PH_ACTIVATE | INDICATION,
>  						NULL);
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/hisax_fcpcipnp.c linux-2.6.18-mm2/drivers/isdn/hisax/hisax_fcpcipnp.c
> --- linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/hisax_fcpcipnp.c	2006-09-20 04:42:06.000000000 +0100
> +++ linux-2.6.18-mm2/drivers/isdn/hisax/hisax_fcpcipnp.c	2006-09-25 12:20:25.000000000 +0100
> @@ -546,7 +546,7 @@
>  	}
>  	bcs->tx_cnt = 0;
>  	bcs->tx_skb = NULL;
> -	B_L1L2(bcs, PH_DATA | CONFIRM, (void *) skb->truesize);
> +	B_L1L2(bcs, PH_DATA | CONFIRM, (void *)(unsigned long)skb->truesize);
>  	dev_kfree_skb_irq(skb);
>  }
>  
> @@ -635,7 +635,7 @@
>  		hdlc_fill_fifo(bcs);
>  		break;
>  	case PH_ACTIVATE | REQUEST:
> -		mode = (int) arg;
> +		mode = (long) arg;
>  		DBG(4,"B%d,PH_ACTIVATE_REQUEST %d", bcs->channel + 1, mode);
>  		modehdlc(bcs, mode);
>  		B_L1L2(bcs, PH_ACTIVATE | INDICATION, NULL);
> @@ -998,18 +998,15 @@
>  
>  	retval = pci_register_driver(&fcpci_driver);
>  	if (retval)
> -		goto out;
> +		return retval;
>  #ifdef __ISAPNP__
>  	retval = pnp_register_driver(&fcpnp_driver);
> -	if (retval < 0)
> -		goto out_unregister_pci;
> +	if (retval < 0) {
> +		pci_unregister_driver(&fcpci_driver);
> +		return retval;
> +	}
>  #endif
>  	return 0;
> -
> - out_unregister_pci:
> -	pci_unregister_driver(&fcpci_driver);
> - out:
> -	return retval;
>  }
>  
>  static void __exit hisax_fcpcipnp_exit(void)
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/st5481_b.c linux-2.6.18-mm2/drivers/isdn/hisax/st5481_b.c
> --- linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/st5481_b.c	2006-09-20 04:42:06.000000000 +0100
> +++ linux-2.6.18-mm2/drivers/isdn/hisax/st5481_b.c	2006-09-25 12:20:39.000000000 +0100
> @@ -86,7 +86,7 @@
>  			if (!skb->len) {
>  				// Frame sent
>  				b_out->tx_skb = NULL;
> -				B_L1L2(bcs, PH_DATA | CONFIRM, (void *) skb->truesize);
> +				B_L1L2(bcs, PH_DATA | CONFIRM, (void *)(unsigned long) skb->truesize);
>  				dev_kfree_skb_any(skb);
>  
>  /* 				if (!(bcs->tx_skb = skb_dequeue(&bcs->sq))) { */
> @@ -350,7 +350,7 @@
>  {
>  	struct st5481_bcs *bcs = ifc->priv;
>  	struct sk_buff *skb = arg;
> -	int mode;
> +	long mode;
>  
>  	DBG(4, "");
>  
> @@ -360,8 +360,8 @@
>  		bcs->b_out.tx_skb = skb;
>  		break;
>  	case PH_ACTIVATE | REQUEST:
> -		mode = (int) arg;
> -		DBG(4,"B%d,PH_ACTIVATE_REQUEST %d", bcs->channel + 1, mode);
> +		mode = (long) arg;
> +		DBG(4,"B%d,PH_ACTIVATE_REQUEST %ld", bcs->channel + 1, mode);
>  		st5481B_mode(bcs, mode);
>  		B_L1L2(bcs, PH_ACTIVATE | INDICATION, NULL);
>  		break;
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/st5481_d.c linux-2.6.18-mm2/drivers/isdn/hisax/st5481_d.c
> --- linux.vanilla-2.6.18-mm2/drivers/isdn/hisax/st5481_d.c	2006-09-20 04:42:06.000000000 +0100
> +++ linux-2.6.18-mm2/drivers/isdn/hisax/st5481_d.c	2006-09-25 12:20:39.000000000 +0100
> @@ -374,7 +374,7 @@
>  {
>  	struct st5481_adapter *adapter = urb->context;
>  	struct st5481_d_out *d_out = &adapter->d_out;
> -	int buf_nr;
> +	long buf_nr;
>  	
>  	DBG(2, "");
>  
> @@ -546,7 +546,7 @@
>  static void dout_complete(struct FsmInst *fsm, int event, void *arg)
>  {
>  	struct st5481_adapter *adapter = fsm->userdata;
> -	int buf_nr = (int) arg;
> +	long buf_nr = (long) arg;
>  
>  	usb_d_out(adapter, buf_nr);
>  }

-- 
Karsten Keil
SuSE Labs
ISDN development
