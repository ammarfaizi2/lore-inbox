Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWBEG7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWBEG7g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 01:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964919AbWBEG7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 01:59:36 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:12197 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964906AbWBEG7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 01:59:36 -0500
Message-ID: <43E5A23D.8080107@linuxtv.org>
Date: Sun, 05 Feb 2006 01:59:09 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andreas Oberritter <obi@linuxtv.org>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch]	drivers/media/dvb/frontends/mt312.c:
 possible cleanups
References: <20060204233751.GH4528@stusta.de>
In-Reply-To: <20060204233751.GH4528@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - update the Kconfig help to mention the VP310
> - merge vp310_attach and mt312_attach into a new vp310_mt312_attach
>   to remove some code duplication
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 28 Jan 2006
> 
>  drivers/media/dvb/b2c2/flexcop-fe-tuner.c |    2 
>  drivers/media/dvb/frontends/Kconfig       |    2 
>  drivers/media/dvb/frontends/mt312.c       |  111 +++++++---------------
>  drivers/media/dvb/frontends/mt312.h       |    6 -
>  4 files changed, 43 insertions(+), 78 deletions(-)
> 
> --- linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/Kconfig.old	2006-01-28 17:12:59.000000000 +0100
> +++ linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/Kconfig	2006-01-28 17:13:26.000000000 +0100
> @@ -29,7 +29,7 @@
>  	  A DVB-S tuner module. Say Y when you want to support this frontend.
>  
>  config DVB_MT312
> -	tristate "Zarlink MT312 based"
> +	tristate "Zarlink VP310/MT312 based"
>  	depends on DVB_CORE
>  	help
>  	  A DVB-S tuner module. Say Y when you want to support this frontend.
> --- linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/mt312.h.old	2006-01-28 17:23:16.000000000 +0100
> +++ linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/mt312.h	2006-01-28 17:23:45.000000000 +0100
> @@ -38,10 +38,8 @@
>  	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
>  };
>  
> -extern struct dvb_frontend* mt312_attach(const struct mt312_config* config,
> -					 struct i2c_adapter* i2c);
> +struct dvb_frontend* vp310_mt312_attach(const struct mt312_config* config,
> +					struct i2c_adapter* i2c);
>  
> -extern struct dvb_frontend* vp310_attach(const struct mt312_config* config,
> -					 struct i2c_adapter* i2c);
>  
>  #endif // MT312_H
> --- linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/mt312.c.old	2006-01-28 17:13:36.000000000 +0100
> +++ linux-2.6.16-rc1-mm3-full/drivers/media/dvb/frontends/mt312.c	2006-01-28 17:20:15.000000000 +0100
> @@ -612,76 +612,6 @@
>  	kfree(state);
>  }
>  
[snip]
>  static struct dvb_frontend_ops vp310_mt312_ops = {
>  
>  	.info = {
> @@ -720,6 +650,44 @@
>  	.set_voltage = mt312_set_voltage,
>  };
>  
> +struct dvb_frontend* vp310_mt312_attach(const struct mt312_config* config,
> +					struct i2c_adapter* i2c)
> +{
> +	struct mt312_state* state = NULL;
> +
> +	/* allocate memory for the internal state */
> +	state = kmalloc(sizeof(struct mt312_state), GFP_KERNEL);
> +	if (state == NULL)
> +		goto error;
> +
> +	/* setup the state */
> +	state->config = config;
> +	state->i2c = i2c;
> +	memcpy(&state->ops, &vp310_mt312_ops, sizeof(struct dvb_frontend_ops));
> +
> +	/* check if the demod is there */
> +	if (mt312_readreg(state, ID, &state->id) < 0)
> +		goto error;
> +
> +	if (state->id == ID_VP310){
> +		strcpy(state->ops.info.name, "Zarlink VP310 DVB-S");
> +		state->frequency = 90;
> +	} else if (state->id == ID_MT312) {
> +		strcpy(state->ops.info.name, "Zarlink MT312 DVB-S");
> +		state->frequency = 60;
> +	} else
> +		goto error;

^^^ I would prefer to see this as a switch..case block, in the spirit of 
nxt200x and lgdt330x.

> +
> +	/* create dvb_frontend */
> +	state->frontend.ops = &state->ops;
> +	state->frontend.demodulator_priv = state;
> +	return &state->frontend;
> +
> +error:
> +	kfree(state);
> +	return NULL;
> +}
> +
>  module_param(debug, int, 0644);
>  MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
>  
> @@ -727,5 +695,4 @@
>  MODULE_AUTHOR("Andreas Oberritter <obi@linuxtv.org>");
>  MODULE_LICENSE("GPL");
>  
> -EXPORT_SYMBOL(mt312_attach);
> -EXPORT_SYMBOL(vp310_attach);
> +EXPORT_SYMBOL(vp310_mt312_attach);

^^^ I think vp310_mt312_attach is starting to get long, maybe even ugly. 
  Isn't mt312_attach enough, considering that it is the name of the 
module?  I think just mt312_attach would be nicer, unless someone thinks 
otherwise?

> --- linux-2.6.16-rc1-mm3-full/drivers/media/dvb/b2c2/flexcop-fe-tuner.c.old	2006-01-28 17:17:41.000000000 +0100
> +++ linux-2.6.16-rc1-mm3-full/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2006-01-28 17:29:53.000000000 +0100
> @@ -526,7 +526,7 @@
>  		info("found the stv0297 at i2c address: 0x%02x",alps_tdee4_stv0297_config.demod_address);
>  	} else
>  	/* try the sky v2.3 (vp310/Samsung tbdu18132(tsa5059)) */
> -	if ((fc->fe = vp310_attach(&skystar23_samsung_tbdu18132_config, &fc->i2c_adap)) != NULL) {
> +	if ((fc->fe = vp310_mt312_attach(&skystar23_samsung_tbdu18132_config, &fc->i2c_adap)) != NULL) {
>  		ops = fc->fe->ops;
>  
>  		ops->diseqc_send_master_cmd = flexcop_diseqc_send_master_cmd;

Besides my comments above, the patch looks okay to me, by eye, although 
I lack the hardware to test...

-Michael Krufky
