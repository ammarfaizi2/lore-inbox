Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265229AbUFWHjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUFWHjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 03:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265230AbUFWHjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 03:39:11 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:640 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S265229AbUFWHiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 03:38:52 -0400
Date: Wed, 23 Jun 2004 09:39:30 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] PS/2 mouse resync for KVM users
Message-ID: <20040623073930.GB1101@ucw.cz>
References: <200406230140.45383.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406230140.45383.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I really like this approach, and it's something I wanted to implement,
but never found the time to do it.

Another heuristic I planned to implement would be interbyte timing - not
just timeouts, but qualify the validity of a packet both on how close
its bytes arrived together and whether it's separated from other
packets by some time. We could even keep an estimate on both the
interbyte and interpacket timing and classify each byte as based on the
probability of a packet boundary. It might be a little overkill, though. 




> +	if (psmouse->pktcnt == 1) {
> +/*
> + * If go by the letter of PS/2 protcol 4th bit in 1st byte should always be set.
> + */
> +		if (psmouse_strict && !(packet[0] & 0x08))
> +			return PSMOUSE_BAD_DATA;

This bit actually says 'internal/external', and can be used to
differentiate between data from an internal trackpoint and an external
mouse on older notebooks.

All newer devices have it at '1'.

> +/*
> + * Overflows should happen rarely.
> + */
> +		if (packet[0] & 0xc0)
> +			return PSMOUSE_SUSPECT_DATA;

Very rarely indeed. It should be next to impossible to generate an
overflow at a reasonable report rate (> 80 reports/sec). For higher
resolutions (> 400 dpi) it might be reasonable to up the report rate
accordingly.

> +/*
> + * Having left or right button together with middle is somewhat unusual.
> + */
> +		if ((packet[0] & 0x07) > 4)
> +			return PSMOUSE_SUSPECT_DATA;
> +	}
> +
>  	if (psmouse->pktcnt < 3 + (psmouse->type >= PSMOUSE_GENPS))
>  		return PSMOUSE_GOOD_DATA;

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
