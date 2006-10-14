Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422781AbWJNSdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422781AbWJNSdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422780AbWJNSdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:33:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55300 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422781AbWJNSdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:33:24 -0400
Date: Sat, 14 Oct 2006 20:33:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH 08/18] V4L/DVB (4734): Tda826x: fix frontend selection for dvb_attach
Message-ID: <20061014183322.GS30596@stusta.de>
References: <20061014115356.PS36551000000@infradead.org> <20061014120050.PS78628900008@infradead.org> <20061014121608.GN30596@stusta.de> <45312819.4080909@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45312819.4080909@linuxtv.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2006 at 02:10:33PM -0400, Michael Krufky wrote:
> Adrian Bunk wrote:
> > On Sat, Oct 14, 2006 at 09:00:50AM -0300, mchehab@infradead.org wrote:
> >> From: Michael Krufky <mkrufky@linuxtv.org>
> >>
> >> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
> >> ---
> >>
> >>  drivers/media/dvb/frontends/tda826x.h |   19 ++++++++++++++++---
> >>  1 files changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/media/dvb/frontends/tda826x.h b/drivers/media/dvb/frontends/tda826x.h
> >> index 3307607..83998c0 100644
> >> --- a/drivers/media/dvb/frontends/tda826x.h
> >> +++ b/drivers/media/dvb/frontends/tda826x.h
> >> @@ -35,6 +35,19 @@ #include "dvb_frontend.h"
> >>   * @param has_loopthrough Set to 1 if the card has a loopthrough RF connector.
> >>   * @return FE pointer on success, NULL on failure.
> >>   */
> >> -extern struct dvb_frontend *tda826x_attach(struct dvb_frontend *fe, int addr, struct i2c_adapter *i2c, int has_loopthrough);
> >> -
> >> -#endif
> >> +#if defined(CONFIG_DVB_TDA826X) || defined(CONFIG_DVB_TDA826X_MODULE)
> >> +extern struct dvb_frontend* tda826x_attach(struct dvb_frontend *fe, int addr,
> >> +					   struct i2c_adapter *i2c,
> >> +					   int has_loopthrough);
> >> +#else
> >> +static inline struct dvb_frontend* tda826x_attach(struct dvb_frontend *fe,
> >> +						  int addr,
> >> +						  struct i2c_adapter *i2c,
> >> +						  int has_loopthrough)
> >> +{
> >> +	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __FUNCTION__);
> >> +	return NULL;
> >> +}
> >> +#endif // CONFIG_DVB_TDA826X
> >> +
> >> +#endif // __DVB_TDA826X_H__
> > 
> > This breaks with CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m.
> 
> Regardless, the patch must be applied.  The above should only break with DVB_FE_CUSTOMIZE=Y ...
> 
> Turn off DVB_FE_CUSTOMIZE, and you will find that the above does NOT break.  You can probably reproduce this 'broken' situation by setting any card driver = y, with the frontend = m ...
> 
> As stated in the prior thread, "CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m" is not the problem -- rather, "CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m, DVB_FE_CUSTOMIZE=Y" causes the breakage.

This patch fixes only a part of the problem.

If this is the way how you want to handle CONFIG_DVB_FE_CUSTOMIZE=y, 
I don't understand why you don't use
  #if defined(CONFIG_DVB_TDA826X) || (defined(CONFIG_DVB_TDA826X_MODULE) && defined(MODULE))
which is what I stated in exactly the thread you quote.

> -Mike Krufky

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

