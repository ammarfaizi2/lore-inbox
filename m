Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVADRWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVADRWc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVADRWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:22:31 -0500
Received: from penta.pentaserver.com ([216.74.97.66]:37028 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261818AbVADRUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:20:43 -0500
From: Manu Abraham <manu@kromtek.com>
Reply-To: manu@kromtek.com
Organization: Kromtek Systems
To: Arne Ahrend <aahrend@web.de>
Subject: Re: PATCH: DVB bt8xx in 2.6.10
Date: Tue, 4 Jan 2005 21:20:31 +0400
User-Agent: KMail/1.6.2
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
References: <20050104175043.6a8fd195.aahrend@web.de>
In-Reply-To: <20050104175043.6a8fd195.aahrend@web.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501042120.31987.manu@kromtek.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue January 4 2005 8:50 pm, Arne Ahrend wrote:
> This patch allows the user to select only actually desired frontend
> driver(s) for bt8xx based DVB cards by removing calls to frontend-specific
> XXX_attach() functions and returning NULL instead for unconfigured
> frontends.
>
> To keep this patch small, no attempt is made to #ifdef away other static
> functions or data for unselected frontends. This leads to compiler warnings
> about defined, but unused code, unless all four frontends relevant to bt8xx
> based cards are selected.
>
> I have tested this on the Avermedia 771 (the only DVB card I have access
> to).
>
>
> Signed-off-by: Arne Ahrend <aahrend@web.de>
>
>
> diff -uprN -X dontdiff linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/Kconfig
> linux-2.6.10/drivers/media/dvb/bt8xx/Kconfig ---
> linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/Kconfig	2005-01-04
> 15:36:33.000000000 +0100 +++
> linux-2.6.10/drivers/media/dvb/bt8xx/Kconfig	2005-01-04 15:17:16.000000000
> +0100 @@ -1,8 +1,6 @@
>  config DVB_BT8XX
> -	tristate "Nebula/Pinnacle PCTV/Twinhan PCI cards"
> +	tristate "Avermedia/Nebula/Pinnacle PCTV/Twinhan PCI cards"
>  	depends on DVB_CORE && PCI && VIDEO_BT848
> -	select DVB_MT352
> -	select DVB_SP887X
>  	help
>  	  Support for PCI cards based on the Bt8xx PCI bridge. Examples are
>  	  the Nebula cards, the Pinnacle PCTV cards and Twinhan DST cards.
> @@ -11,8 +9,24 @@ config DVB_BT8XX
>  	  only compressed MPEG data over the PCI bus, so you need
>  	  an external software decoder to watch TV on your computer.
>
> +	  It is safe to select more than one of the frontends.
> +
> +	  If you have an Avermedia (761) DVB-T card, select
> +	  "Spase sp887x based" frontend.
> +
> +	  If you have an Avermedia 771 DVB-T card, select
> +	  "Zarlink MT352 based" frontend.
> +
> +	  For Nebula or Pinnacle cards "NxtWave Communications NXT6000"
> +	  frontend might suit you.
> +
>  	  If you have a Twinhan card, don't forget to select
>  	  "Twinhan DST based DVB-S/-T frontend".
>
>  	  Say Y if you own such a device and want to use it.
>
> +config DVB_TWINHAN_DST
> +	tristate "Twinhan DST based DVB-S/-T frontend"
> +	depends on DVB_CORE && PCI && VIDEO_BT848
> +	help
> +	  The Twinham DST frontend for DVB.
> diff -uprN -X dontdiff
> linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/Makefile
> linux-2.6.10/drivers/media/dvb/bt8xx/Makefile ---
> linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/Makefile	2005-01-04
> 15:36:33.000000000 +0100 +++
> linux-2.6.10/drivers/media/dvb/bt8xx/Makefile	2005-01-03 22:49:06.000000000
> +0100 @@ -1,5 +1,6 @@
>
> -obj-$(CONFIG_DVB_BT8XX) += bt878.o dvb-bt8xx.o dst.o
> +obj-$(CONFIG_DVB_BT8XX) += bt878.o dvb-bt8xx.o
> +obj-$(CONFIG_DVB_TWINHAN_DST) += dst.o
>
>  EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/video
> -Idrivers/media/dvb/frontends
>
> diff -uprN -X dontdiff
> linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/dvb-bt8xx.c
> linux-2.6.10/drivers/media/dvb/bt8xx/dvb-bt8xx.c ---
> linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-01-04
> 15:36:33.000000000 +0100 +++
> linux-2.6.10/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-01-04
> 17:01:59.000000000 +0100 @@ -220,7 +220,7 @@ static int
> microtune_mt7202dtf_request_f
>  	return request_firmware(fw, name, &bt->bt->dev->dev);
>  }
>
> -struct sp887x_config microtune_mt7202dtf_config = {
> +static struct sp887x_config microtune_mt7202dtf_config = {
>
>  	.demod_address = 0x70,
>  	.pll_set = microtune_mt7202dtf_pll_set,
> @@ -340,12 +340,108 @@ static struct nxt6000_config vp3021_alps
>  };
>
>
> +
> +#if(defined(CONFIG_DVB_MT352) || defined(CONFIG_DVB_MT352_MODULE))
> +static inline struct dvb_frontend*
> +thomson_dtt7579_frontend(struct i2c_adapter* i2c)
> +{
> +  return mt352_attach(&thomson_dtt7579_config, i2c);
> +}
> +
> +#else
> +
> +static inline struct dvb_frontend*
> +thomson_dtt7579_frontend(struct i2c_adapter* i2c)
> +{
> +  return NULL;
> +}
> +#endif /* CONFIG_DVB_MT352 || CONFIG_DVB_MT352_MODULE */
> +
> +
> +
> +
> +#if(defined(CONFIG_DVB_SP887X) || defined(CONFIG_DVB_SP887X_MODULE))
> +static inline struct dvb_frontend*
> +microtune_mt7202dtf_frontend(struct i2c_adapter* i2c)
> +{
> +  return sp887x_attach(&microtune_mt7202dtf_config, i2c);
> +}
> +
> +#else
> +
> +static inline struct dvb_frontend*
> +microtune_mt7202dtf_frontend(struct i2c_adapter* i2c)
> +{
> +  return NULL;
> +}
> +#endif /* CONFIG_DVB_SP887X || CONFIG_DVB_SP887X_MODULE */
> +
> +
> +
> +
> +#if(defined(CONFIG_DVB_MT352) || defined(CONFIG_DVB_MT352_MODULE))
> +static inline struct dvb_frontend*
> +advbt771_samsung_tdtc9251dh0_frontend(struct i2c_adapter* i2c)
> +{
> +  return mt352_attach(&advbt771_samsung_tdtc9251dh0_config, i2c);
> +}
> +
> +#else
> +
> +static inline struct dvb_frontend*
> +advbt771_samsung_tdtc9251dh0_frontend(struct i2c_adapter* i2c)
> +{
> +  return NULL;
> +}
> +#endif /* CONFIG_DVB_MT352 || CONFIG_DVB_MT352_MODULE */
> +
> +
> +
> +
> +#if(defined(CONFIG_DVB_TWINHAN_DST) ||
> defined(CONFIG_DVB_TWINHAN_DST_MODULE)) +static inline struct dvb_frontend*
> +dst_frontend(struct i2c_adapter* i2c, struct bt878* bt)
> +{
> +  return dst_attach(&dst_config, i2c, bt);
> +}
> +
> +#else
> +
> +static inline struct dvb_frontend*
> +dst_frontend(struct i2c_adapter* i2c, struct bt878* bt)
> +{
> +  return NULL;
> +}
> +#endif /* CONFIG_DVB_TWINHAN_DST || CONFIG_DVB_TWINHAN_DST_MODULE */
> +
> +
> +
> +
> +#if(defined(CONFIG_DVB_NXT6000) || defined(CONFIG_DVB_NXT6000_MODULE))
> +static inline struct dvb_frontend*
> +vp3021_alps_tded4_frontend(struct i2c_adapter* i2c)
> +{
> +  return nxt6000_attach(&vp3021_alps_tded4_config, i2c);
> +}
> +
> +#else
> +
> +static inline struct dvb_frontend*
> +vp3021_alps_tded4_frontend(struct i2c_adapter* i2c)
> +{
> +  return NULL;
> +}
> +#endif /* CONFIG_DVB_NXT6000 || CONFIG_DVB_NXT6000_MODULE */
> +
> +
> +
> +
>  static void frontend_init(struct dvb_bt8xx_card *card, u32 type)
>  {
>  	switch(type) {
>  #ifdef BTTV_DVICO_DVBT_LITE
>  	case BTTV_DVICO_DVBT_LITE:
> -		card->fe = mt352_attach(&thomson_dtt7579_config, card->i2c_adapter);
> +		card->fe = thomson_dtt7579_frontend(card->i2c_adapter);
>  		if (card->fe != NULL) {
>  			card->fe->ops->info.frequency_min = 174000000;
>  			card->fe->ops->info.frequency_max = 862000000;
> @@ -359,21 +455,21 @@ static void frontend_init(struct dvb_bt8
>  #else
>  	case BTTV_NEBULA_DIGITV:
>  #endif
> -		card->fe = nxt6000_attach(&vp3021_alps_tded4_config, card->i2c_adapter);
> +		card->fe = vp3021_alps_tded4_frontend(card->i2c_adapter);
>  		if (card->fe != NULL) {
>  			break;
>  		}
>  		break;
>
>  	case BTTV_AVDVBT_761:
> -		card->fe = sp887x_attach(&microtune_mt7202dtf_config,
> card->i2c_adapter); +		card->fe =
> microtune_mt7202dtf_frontend(card->i2c_adapter);
>  		if (card->fe != NULL) {
>  			break;
>  		}
>  		break;
>
>  	case BTTV_AVDVBT_771:
> -		card->fe = mt352_attach(&advbt771_samsung_tdtc9251dh0_config,
> card->i2c_adapter); +		card->fe =
> advbt771_samsung_tdtc9251dh0_frontend(card->i2c_adapter); if (card->fe !=
> NULL) {
>  			card->fe->ops->info.frequency_min = 174000000;
>  			card->fe->ops->info.frequency_max = 862000000;
> @@ -382,7 +478,7 @@ static void frontend_init(struct dvb_bt8
>  		break;
>
>  	case BTTV_TWINHAN_DST:
> -		card->fe = dst_attach(&dst_config, card->i2c_adapter, card->bt);

Here dst is not a frontend, but a generic card driver. If you remove it the 
other devices of the DST hardware, which is under development also would fail 
to function, like the CA and the NET modules...


> +		card->fe = dst_frontend(card->i2c_adapter, card->bt);
This is wrong since dst is not a frontend driver, but a card driver, has to be 
used in this manner due to the architecture of the card... Considering it 
like this would be as good as throwing away all the work that has undergone 
into the CA and the DVBNET modules..

The reason is that the architecture of the card is totally different to that 
of any DVB card S/C/T.


Manu 

>  		if (card->fe != NULL) {
>  			break;
>  		}
> diff -uprN -X dontdiff
> linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/dvb-bt8xx.h
> linux-2.6.10/drivers/media/dvb/bt8xx/dvb-bt8xx.h ---
> linux-2.6.10-vanilla/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-01-04
> 15:36:33.000000000 +0100 +++
> linux-2.6.10/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-01-04
> 17:01:36.000000000 +0100 @@ -22,6 +22,10 @@
>   *
>   */
>
> +#ifndef DVB_BT8XX_H
> +#define DVB_BT8XX_H
> +
> +
>  #include <linux/i2c.h>
>  #include "dvbdev.h"
>  #include "dvb_net.h"
> @@ -50,3 +54,6 @@ struct dvb_bt8xx_card {
>
>  	struct dvb_frontend* fe;
>  };
> +
> +
> +#endif /* DVB_BT8XX_H */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
