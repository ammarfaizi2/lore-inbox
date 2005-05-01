Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVEAI3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVEAI3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 04:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVEAI3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 04:29:24 -0400
Received: from mx2.mail.ru ([194.67.23.122]:54598 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261553AbVEAI3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 04:29:18 -0400
Date: Sun, 1 May 2005 12:32:42 +0000
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: "David S. Miller" <davem@davemloft.net>,
       Jouni Malinen <jkmaline@cc.hut.fi>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] resource release cleanup in net/
Message-ID: <20050501123242.GA8407@mipter.zuzino.mipt.ru>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	"David S. Miller" <davem@davemloft.net>,
	Jouni Malinen <jkmaline@cc.hut.fi>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0504302219520.2094@dragon.hyggekrogen.localhost> <20050501025349.GA9243@mipter.zuzino.mipt.ru> <Pine.LNX.4.62.0505010101580.2094@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505010101580.2094@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2005 at 01:13:28AM +0200, Jesper Juhl wrote:
> On Sun, 1 May 2005, Alexey Dobriyan wrote:
> 
> > On Sat, Apr 30, 2005 at 10:36:00PM +0200, Jesper Juhl wrote:
> > > Since Andrew merged the patch that makes calling crypto_free_tfm() with a 
> > > NULL pointer safe into 2.6.12-rc3-mm1, I made a patch to remove checks for 
> > > NULL before calling that function
> > >  drivers/net/wireless/hostap/hostap_crypt_ccmp.c |    5 -
> > >  drivers/net/wireless/hostap/hostap_crypt_tkip.c |   10 +-
> > >  drivers/net/wireless/hostap/hostap_crypt_wep.c  |    5 -
> > >  net/ieee80211/ieee80211_crypt_ccmp.c            |    5 -
> > >  net/ieee80211/ieee80211_crypt_tkip.c            |   10 +-
> > >  net/ieee80211/ieee80211_crypt_wep.c             |    5 -
> > I think I have a better one for these.
> > 
> > --- linux-2.6.12-rc3-mm1/drivers/net/wireless/hostap/hostap_crypt_ccmp.c	2005-05-01 01:53:50.000000000 +0000
> > +++ linux-2.6.12-rc3-mm1-hostap/drivers/net/wireless/hostap/hostap_crypt_ccmp.c	2005-05-01 02:21:10.000000000 +0000

> > @@ -121,8 +118,7 @@ fail:
> >  static void hostap_ccmp_deinit(void *priv)
> >  {
> >  	struct hostap_ccmp_data *_priv = priv;
> > -	if (_priv && _priv->tfm)
> > -		crypto_free_tfm(_priv->tfm);
> > +	crypto_free_tfm(_priv->tfm);
> >  	kfree(priv);
> >  	module_put(THIS_MODULE);
> >  }
> 
> This will Oops if _priv is NULL. That's why my patch did 
> 
> if (_priv)
> 	crypto_free_tfm(_priv->tfm);

After hostap_ccmp_init() returns successfully:
1. priv is valid pointer	line 95
2. priv->tfm is valid pointer	line 102

