Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbRAHUff>; Mon, 8 Jan 2001 15:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131098AbRAHUf2>; Mon, 8 Jan 2001 15:35:28 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:64232 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129735AbRAHUfS>; Mon, 8 Jan 2001 15:35:18 -0500
Date: Mon, 8 Jan 2001 21:35:15 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0: defxx oopses upon insmod if short on memory
In-Reply-To: <E14Fii1-0005FV-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1010108211657.23234d-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Alan Cox wrote:

> > @@ -2709,7 +2709,10 @@ static void dfx_rcv_init(DFX_board_t *bp
> >  			struct sk_buff *newskb;
> >  			bp->descr_block_virt->rcv_data[i+j].long_0 = (u32) (PI_RCV_DESCR_M_SOP |
> >  				((PI_RCV_DATA_K_SIZE_MAX / PI_ALIGN_K_RCV_DATA_BUFF) << PI_RCV_DESCR_V_SEG_LEN));
> > -			newskb = dev_alloc_skb(NEW_SKB_SIZE);
> > +			while (!(newskb = dev_alloc_skb(NEW_SKB_SIZE))) {
> > +				printk(KERN_WARNING "%s: Could not allocate receive buffer.\n", bp->dev->name);
> > +				schedule();
> > +			}
> 
> Wouldn't it be cleaner to malloc the new buffer and if that fails drop the
> just received frame and reuse that skbuff?

 It would, but this would require quite a serious driver rewrite --
buffers would only be allocated when a frame arrives and not when the
board is initialized (no idea why it is handled differently now, maybe an
OSF/1 legacy...).  I might see if I can do it but not at the moment -- I
have definitely too many other tasks pending. 

 An alternate short-term solution could be just to return -ENOMEM and let
the caller of init_module() handle it.  But this way there may never be
much enough real memory available.

> schedule definitely isnt going to help

 It does help.  Note the code is allocating ~1.2MB in one run and there is
plenty of virtual memory available (but not real one). 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
