Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422742AbWJNSKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422742AbWJNSKu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 14:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbWJNSKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 14:10:50 -0400
Received: from thing.hostingexpert.com ([67.15.235.34]:42144 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1422742AbWJNSKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 14:10:49 -0400
Message-ID: <45312819.4080909@linuxtv.org>
Date: Sat, 14 Oct 2006 14:10:33 -0400
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org,
       Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH 08/18] V4L/DVB (4734): Tda826x: fix frontend selection
 for dvb_attach
References: <20061014115356.PS36551000000@infradead.org> <20061014120050.PS78628900008@infradead.org> <20061014121608.GN30596@stusta.de>
In-Reply-To: <20061014121608.GN30596@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
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
> On Sat, Oct 14, 2006 at 09:00:50AM -0300, mchehab@infradead.org wrote:
>> From: Michael Krufky <mkrufky@linuxtv.org>
>>
>> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
>> ---
>>
>>  drivers/media/dvb/frontends/tda826x.h |   19 ++++++++++++++++---
>>  1 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/dvb/frontends/tda826x.h b/drivers/media/dvb/frontends/tda826x.h
>> index 3307607..83998c0 100644
>> --- a/drivers/media/dvb/frontends/tda826x.h
>> +++ b/drivers/media/dvb/frontends/tda826x.h
>> @@ -35,6 +35,19 @@ #include "dvb_frontend.h"
>>   * @param has_loopthrough Set to 1 if the card has a loopthrough RF connector.
>>   * @return FE pointer on success, NULL on failure.
>>   */
>> -extern struct dvb_frontend *tda826x_attach(struct dvb_frontend *fe, int addr, struct i2c_adapter *i2c, int has_loopthrough);
>> -
>> -#endif
>> +#if defined(CONFIG_DVB_TDA826X) || defined(CONFIG_DVB_TDA826X_MODULE)
>> +extern struct dvb_frontend* tda826x_attach(struct dvb_frontend *fe, int addr,
>> +					   struct i2c_adapter *i2c,
>> +					   int has_loopthrough);
>> +#else
>> +static inline struct dvb_frontend* tda826x_attach(struct dvb_frontend *fe,
>> +						  int addr,
>> +						  struct i2c_adapter *i2c,
>> +						  int has_loopthrough)
>> +{
>> +	printk(KERN_WARNING "%s: driver disabled by Kconfig\n", __FUNCTION__);
>> +	return NULL;
>> +}
>> +#endif // CONFIG_DVB_TDA826X
>> +
>> +#endif // __DVB_TDA826X_H__
> 
> This breaks with CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m.

Regardless, the patch must be applied.  The above should only break with DVB_FE_CUSTOMIZE=Y ...

Turn off DVB_FE_CUSTOMIZE, and you will find that the above does NOT break.  You can probably reproduce this 'broken' situation by setting any card driver = y, with the frontend = m ...

As stated in the prior thread, "CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m" is not the problem -- rather, "CONFIG_VIDEO_SAA7134_DVB=y, CONFIG_DVB_TDA826X=m, DVB_FE_CUSTOMIZE=Y" causes the breakage.

-Mike Krufky
