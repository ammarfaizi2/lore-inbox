Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWIKS1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWIKS1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWIKS1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:27:38 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:46984 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S932294AbWIKS1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:27:37 -0400
Date: Mon, 11 Sep 2006 14:27:33 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC] OLPC tablet input driver, take two.
Message-ID: <20060911182733.GR4181@aehallh.com>
Mail-Followup-To: Dmitry Torokhov <dtor@insightbb.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>
References: <20060829073339.GA4181@aehallh.com> <20060910201036.GD4187@aehallh.com> <200609101819.32176.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VnOTrGv5LmZxna7m"
Content-Disposition: inline
In-Reply-To: <200609101819.32176.dtor@insightbb.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VnOTrGv5LmZxna7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 10, 2006 at 06:19:31PM -0400, Dmitry Torokhov wrote:
> On Sunday 10 September 2006 16:10, Zephaniah E. Hull wrote:
> > Take two, with most of the items people commented about addressed.
> > 
> 
> Hi Zephaniah,
> 
> I have couple more comments/requests:
> 
> > 
> > +
> > +	if (gs_down) {
> > +		input_report_abs(dev2, ABS_X, gx);
> > +		input_report_abs(dev2, ABS_Y, gy);
> > +	}
> > +	input_report_abs(dev2, ABS_PRESSURE, gz);
> > +
> > +	if (pt_down) {
> > +		input_report_abs(dev, ABS_X, px);
> > +		input_report_abs(dev, ABS_Y, py);
> > +	}
> > +
> > +	input_sync(dev);
> 
> Please add input_sync(dev2);

Whoops, bizarrely it still worked, but fixed.
> 
> > +}
> > +
> > +static psmouse_ret_t olpc_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
> > +{
> > +	struct olpc_data *priv = psmouse->private;
> > +	psmouse_ret_t ret = PSMOUSE_BAD_DATA;
> > +
> > +	if ((psmouse->packet[0] & priv->i->mask0) != priv->i->byte0) {
> > +		ret = PSMOUSE_BAD_DATA;
> 
> It looks like you can kill "ret = PSMOUSE_BAD_DATA" assignments since you
> initialize ret with it.

Done.
> 
> > +		goto out;
> > +	}
> > +
> > +	/* Bytes 2 - 9 should have 0 in the highest bit */
> > +	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 9 &&
> > +		(psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
> > +	    ret = PSMOUSE_BAD_DATA;
> > +	    goto out;
> > +	}
> 
> I'd like to have standard identation throughout the driver (and input
> sybsystem in general).

Whoops, fixed.
>  
> > +
> > +#ifndef _OLPC_H
> > +#define _OLPC_H
> > +
> > +int olpc_detect(struct psmouse *psmouse, int set_properties);
> > +int olpc_init(struct psmouse *psmouse);
> > +
> > +struct olpc_model_info {
> > +        unsigned char signature[3];
> > +        unsigned char byte0, mask0;
> > +        unsigned char flags;
> > +};
> 
> Hard TABs for identation please.

Done.
> 
> > +
> > +struct olpc_data {
> > +	struct input_dev *dev2;		/* Relative device */
> > +	char name[32];			/* Name */
> > +	char phys[32];			/* Phys */
> > +	const struct olpc_model_info *i;/* Info */
> > +};
> > +
> > +
> > +#endif
> > diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> > index 8bc9f51..20060b0 100644
> > --- a/drivers/input/mouse/psmouse-base.c
> > +++ b/drivers/input/mouse/psmouse-base.c
> > @@ -26,6 +26,7 @@
> >  #include "synaptics.h"
> >  #include "logips2pp.h"
> >  #include "alps.h"
> > +#include "olpc.h"
> >  #include "lifebook.h"
> >  #include "trackpoint.h"
> >  
> > @@ -616,6 +617,15 @@ static int psmouse_extensions(struct psm
> >   */
> >  			max_proto = PSMOUSE_IMEX;
> >  		}
> > +		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
> 
> Do we have to do 2nd reset here? Plus logic seems a bit fuzzy here -
> if ALPS is detected but initizliztion fails it will start OLPC detection
> which is probably not what you wanted...

Reset is _probably_ not necessary, I'll verify.

However the logic is the same as for all the others, if init succeeds,
it returns PSMOUSE_ALPS, if it doesn't then it continues on to the next,
which happens to be olpc, admittedly it would be more obvious that it's
doing the same thing if it was in its own if, but.
>  
> > +		if (olpc_detect(psmouse, set_properties) == 0) {
> > +			if (!set_properties || olpc_init(psmouse) == 0)
> > +				return PSMOUSE_OLPC;
> > +/*
> > + * Init failed, try basic relative protocols
> > + */
> > +			max_proto = PSMOUSE_IMEX;
> > +		}
> >  	}
> >  
> >  	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
> > @@ -726,6 +736,13 @@ static struct psmouse_protocol psmouse_p
> >  		.detect		= trackpoint_detect,
> >  	},
> >  	{
> > +		.type		= PSMOUSE_OLPC,
> > +		.name		= "OLPC",
> > +		.alias		= "olpc",
> > +		.maxproto	= 1,
> 
> Do not set maxproto on speciality protocols. It is meant to limit highest
> version of standard protocols to be probed/used by a device.

Fixed.


Thanks a ton, I have some extra testing to do and then I'll send out a
fixed copy.

Zephaniah E. Hull.
> 
> -- 
> Dmitry
> 

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"I am ecstatic that some moron re-invented a 1995 windows fuckup."
        -- Alan Cox

--VnOTrGv5LmZxna7m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFBaqVRFMAi+ZaeAERAnQkAJ9Kjvq5BvE1IwT9RTY0WhnfjDxGegCgw6P/
G3OJUIBJzVZKi6jK4iImlps=
=US9r
-----END PGP SIGNATURE-----

--VnOTrGv5LmZxna7m--
