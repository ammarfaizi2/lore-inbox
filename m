Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUI2HOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUI2HOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 03:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268251AbUI2HOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 03:14:37 -0400
Received: from styx.suse.cz ([82.119.242.94]:43137 "EHLO shadow.suse.cz")
	by vger.kernel.org with ESMTP id S268249AbUI2HOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 03:14:34 -0400
Date: Wed, 29 Sep 2004 09:15:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] Psmouse - add packet size
Message-ID: <20040929071504.GB2648@ucw.cz>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290145.39919.dtor_core@ameritech.net> <200409290146.38929.dtor_core@ameritech.net> <200409290147.35864.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409290147.35864.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 01:47:34AM -0500, Dmitry Torokhov wrote:

> -int alps_detect(struct psmouse *psmouse)
> +int alps_detect(struct psmouse *psmouse, int set_properties)
>  {
> -	return alps_get_model(psmouse) < 0 ? 0 : 1;
> +	if (alps_get_model(psmouse) < 0)
> +		return 0;
> +
> +	if (set_properties) {
> +		psmouse->vendor = "ALPS";
> +		psmouse->name = "TouchPad";
> +	}
> +	return 1;
>  }

I think we should return -1 (or -errno) on failure and 0 on success,
like everybody else does.

> -	return param[0] == 3;
> +	if (param[0] == 3) {
> +		if (set_properties) {
> +			set_bit(REL_WHEEL, psmouse->dev.relbit);
> +
> +			if (!psmouse->vendor) psmouse->vendor = "Generic";
> +			if (!psmouse->name) psmouse->name = "Wheel Mouse";
> +			psmouse->pktsize = 4;
> +		}
> +		return 1;
> +	}
> +	return 0;
>  }

This should be:

	if (param[0] != 3) 
		return -1;
	if (set_properties) {
		set_bit(REL_WHEEL, psmouse->dev.relbit);
		if (!psmouse->vendor) psmouse->vendor = "Generic";
		if (!psmouse->name) psmouse->name = "Wheel Mouse";
		psmouse->pktsize = 4;
	}
	return 0;

... and similarly elsewhere. You save one level of nesting and it makes
more sense.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
