Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262905AbTCSCSr>; Tue, 18 Mar 2003 21:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbTCSCSr>; Tue, 18 Mar 2003 21:18:47 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:52098 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262905AbTCSCSo>;
	Tue, 18 Mar 2003 21:18:44 -0500
Date: Tue, 18 Mar 2003 21:33:07 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "Ruslan U. Zakirov" <cubic@wildrose.miee.ru>
Cc: Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
       Alexander Hoogerhuis <alexh@ihatent.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.65-mm1
Message-ID: <20030318213307.GA13998@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Ruslan U. Zakirov" <cubic@wildrose.miee.ru>,
	Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
	Alexander Hoogerhuis <alexh@ihatent.com>,
	linux-kernel@vger.kernel.org
References: <20030318031104.13fb34cc.akpm@digeo.com> <87adfs4sqk.fsf@lapper.ihatent.com> <87bs08vfkg.fsf@lapper.ihatent.com> <1731494377120.20030318224925@wr.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1731494377120.20030318224925@wr.miee.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 10:49:25PM +0300, Ruslan U. Zakirov wrote:
> AH> Alexander Hoogerhuis <alexh@ihatent.com> writes:
> >> Andrew Morton <akpm@digeo.com> writes:
> >> >
> >> > [SNIP]
> >> >
> >> 
> >> [SNIP MYSELF]
> >>
> AH> And this one when probing for my PCIC:
> 
> AH> Intel PCIC probe: PNP <6>pnp: res: The PnP device '00:0f' is already
> AH> active.
> Hello, Alexandre and other.
>        This error is not mm specific.
> This was brought with latest PnP changes.
> As I've understood that latest PnP Layer activates all devices during layer
> initialisation, but I don't know how it could be if we don't register

PnP code currently assigns resources at init and then activates during driver
matching.

> pnp_driver. With first look I didn't find this runpaths. I'll try to
> review all changes.
> Adam know absolutly right solution in this case, I think :)
>                        Best regards, Ruslan.
>
>                          mailto:cubic@wr.miee.ru

Hi Ruslan and others,

Yes, this is actually a glitch in the driver.  The bios has activated this
device at boot time and the driver tries to activate it again without
checking if it was active in the first place.

I'm going to do the following to correct this:
1.) Update this driver to use the new pnp code, the new code automatically
manages this.
2.) Change pnp_activate_dev so that it doesn't return an error if the device
is already active, instead have it silently stop.  This is a more logical
behavior because the device will function properly even if it was already
active.  I should probably do the same with pnp_disable_dev.

Regards,
Adam
