Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWIJWTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWIJWTg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 18:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWIJWTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 18:19:36 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:58021 "EHLO
	asav13.insightbb.com") by vger.kernel.org with ESMTP
	id S932186AbWIJWTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 18:19:35 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AT0KAA8rBEWBTol4LA
From: Dmitry Torokhov <dtor@insightbb.com>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Subject: Re: [RFC] OLPC tablet input driver, take two.
Date: Sun, 10 Sep 2006 18:19:31 -0400
User-Agent: KMail/1.9.3
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
References: <20060829073339.GA4181@aehallh.com> <20060910201036.GD4187@aehallh.com>
In-Reply-To: <20060910201036.GD4187@aehallh.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609101819.32176.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 September 2006 16:10, Zephaniah E. Hull wrote:
> Take two, with most of the items people commented about addressed.
> 

Hi Zephaniah,

I have couple more comments/requests:

> 
> +
> +	if (gs_down) {
> +		input_report_abs(dev2, ABS_X, gx);
> +		input_report_abs(dev2, ABS_Y, gy);
> +	}
> +	input_report_abs(dev2, ABS_PRESSURE, gz);
> +
> +	if (pt_down) {
> +		input_report_abs(dev, ABS_X, px);
> +		input_report_abs(dev, ABS_Y, py);
> +	}
> +
> +	input_sync(dev);

Please add input_sync(dev2);

> +}
> +
> +static psmouse_ret_t olpc_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
> +{
> +	struct olpc_data *priv = psmouse->private;
> +	psmouse_ret_t ret = PSMOUSE_BAD_DATA;
> +
> +	if ((psmouse->packet[0] & priv->i->mask0) != priv->i->byte0) {
> +		ret = PSMOUSE_BAD_DATA;

It looks like you can kill "ret = PSMOUSE_BAD_DATA" assignments since you
initialize ret with it.

> +		goto out;
> +	}
> +
> +	/* Bytes 2 - 9 should have 0 in the highest bit */
> +	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 9 &&
> +		(psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
> +	    ret = PSMOUSE_BAD_DATA;
> +	    goto out;
> +	}

I'd like to have standard identation throughout the driver (and input
sybsystem in general).
 
> +
> +#ifndef _OLPC_H
> +#define _OLPC_H
> +
> +int olpc_detect(struct psmouse *psmouse, int set_properties);
> +int olpc_init(struct psmouse *psmouse);
> +
> +struct olpc_model_info {
> +        unsigned char signature[3];
> +        unsigned char byte0, mask0;
> +        unsigned char flags;
> +};

Hard TABs for identation please.

> +
> +struct olpc_data {
> +	struct input_dev *dev2;		/* Relative device */
> +	char name[32];			/* Name */
> +	char phys[32];			/* Phys */
> +	const struct olpc_model_info *i;/* Info */
> +};
> +
> +
> +#endif
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index 8bc9f51..20060b0 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -26,6 +26,7 @@
>  #include "synaptics.h"
>  #include "logips2pp.h"
>  #include "alps.h"
> +#include "olpc.h"
>  #include "lifebook.h"
>  #include "trackpoint.h"
>  
> @@ -616,6 +617,15 @@ static int psmouse_extensions(struct psm
>   */
>  			max_proto = PSMOUSE_IMEX;
>  		}
> +		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);

Do we have to do 2nd reset here? Plus logic seems a bit fuzzy here -
if ALPS is detected but initizliztion fails it will start OLPC detection
which is probably not what you wanted...
 
> +		if (olpc_detect(psmouse, set_properties) == 0) {
> +			if (!set_properties || olpc_init(psmouse) == 0)
> +				return PSMOUSE_OLPC;
> +/*
> + * Init failed, try basic relative protocols
> + */
> +			max_proto = PSMOUSE_IMEX;
> +		}
>  	}
>  
>  	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
> @@ -726,6 +736,13 @@ static struct psmouse_protocol psmouse_p
>  		.detect		= trackpoint_detect,
>  	},
>  	{
> +		.type		= PSMOUSE_OLPC,
> +		.name		= "OLPC",
> +		.alias		= "olpc",
> +		.maxproto	= 1,

Do not set maxproto on speciality protocols. It is meant to limit highest
version of standard protocols to be probed/used by a device.

-- 
Dmitry
