Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbVLOVzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbVLOVzM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbVLOVzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:55:12 -0500
Received: from amdext4.amd.com ([163.181.251.6]:28327 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751136AbVLOVzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:55:10 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Thu, 15 Dec 2005 14:56:55 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Andrew Morton" <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       info-linux@ldcmail.amd.com
Subject: Re: APM Screen Blanking fix
Message-ID: <20051215215655.GC14013@cosmic.amd.com>
References: <20051215211248.GE11054@cosmic.amd.com>
 <20051215211423.GF11054@cosmic.amd.com>
 <20051215211601.GG11054@cosmic.amd.com>
 <LYRIS-4270-4193-2005.12.15-14.45.16--jordan.crouse#amd.com@whitestar.amd.com>
MIME-Version: 1.0
In-Reply-To: <LYRIS-4270-4193-2005.12.15-14.45.16--jordan.crouse#amd.com@whitestar.amd.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FBF39A30C011924-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	state = blank ? APM_STATE_STANDBY : APM_STATE_READY;
> > -	/* Blank the first display device */
> > -	error = set_power_state(0x100, state);
> > -	if ((error != APM_SUCCESS) && (error != APM_NO_ERROR)) {
> > -		/* try to blank them all instead */
> > -		error = set_power_state(0x1ff, state);
> > -		if ((error != APM_SUCCESS) && (error != APM_NO_ERROR))
> > -			/* try to blank device one instead */
> > -			error = set_power_state(0x101, state);
> > +
> > +	for (i = 0; i < 3; i++) {
> > +		error = set_power_state(dev[i], state);
> > +
> > +		if ((error == APM_SUCCESS) || (error == APM_NO_ERROR))
> > +			return 1;
> > +
> > +		if (error == APM_NOT_ENGAGED)
> > +			break;
> >  	}
> > -	if ((error == APM_SUCCESS) || (error == APM_NO_ERROR))
> > -		return 1;
> 
> All the above doesn't actually have any functional changes does it?

No, thats actually the fix - Note that the original code only tried to
set the state on device 0x100, and then 0x1FF, and I added 0x101 to the
mix too. I just figured that while I was in there, I would re-do the
code to avoid a tiny if-then-else mess.

> > -	if (error == APM_NOT_ENGAGED) {
> > +	if (error == APM_NOT_ENGAGED && state != APM_STATE_READY) {
> 
> And this is the actual fix/workaround?

Thats just prevents the error message from printing out twice.
I can't remember if it really fixed a problem with our BIOS returning
APM_NOT_ENGAGED when the READY state was set, but it still seems like
a good idea.

Jordan

