Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVBBKRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVBBKRG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 05:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVBBKRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 05:17:06 -0500
Received: from styx.suse.cz ([82.119.242.94]:8082 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262203AbVBBKQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 05:16:31 -0500
Date: Wed, 2 Feb 2005 11:20:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050202102033.GA2420@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com> <20050201234148.4d5eac55@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201234148.4d5eac55@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 11:41:48PM -0800, Pete Zaitcev wrote:
> On 30 Jan 2005 12:10:34 +0100, Peter Osterlund <petero2@telia.com> wrote:
> 
> > > - Slow motion of finger produces no motion, then a jump. So, it's very hard to
> > >   target smaller UI elements and some web links.
> > 
> > I see this too when I don't use the X touchpad driver. With the X
> > driver there is no problem. I think the problem is that mousedev.c in
> > the kernel has to use integer arithmetic, so probably small movements
> > are rounded off to 0. I'll try to come up with a fix for this.
> 
> Thanks for the hint. I tried various schemes and mathematical transformations
> and found one which gives unquestionably the best result, with smoothest, most
> precise and comfortable pointer movement:

Well, you removed the scaling to the touchpad resolution, which will
cause ALPS touchpad to be significantly slower than Synaptics touchpads.
Similarly, the screen size used to be taken into account, but probably
that was a mistake, since the value is usually left at default and
doesn't correspond to the real screen size.

> --- linux-2.6.11-rc2/drivers/input/mousedev.c	2005-01-22 14:54:14.000000000 -0800
> +++ linux-2.6.11-rc2-lem/drivers/input/mousedev.c	2005-02-01 23:20:19.000000000 -0800
> @@ -122,19 +122,19 @@ static void mousedev_touchpad_event(stru
>  	if (mousedev->touch) {
>  		switch (code) {
>  			case ABS_X:
> -				size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
> -				if (size == 0) size = xres;
>  				fx(0) = value;
>  				if (mousedev->pkt_count >= 2)
> -					mousedev->packet.dx = ((fx(0) - fx(1)) / 2 + (fx(1) - fx(2)) / 2) * xres / (size * 2);
> +					mousedev->packet.dx = (value - fx(2)) / 2;
> +				else if (mousedev->pkt_count == 1)
> +					mousedev->packet.dx = value - fx(1);
>  				break;
>  
>  			case ABS_Y:
> -				size = dev->absmax[ABS_Y] - dev->absmin[ABS_Y];
> -				if (size == 0) size = yres;
>  				fy(0) = value;
>  				if (mousedev->pkt_count >= 2)
> -					mousedev->packet.dy = -((fy(0) - fy(1)) / 2 + (fy(1) - fy(2)) / 2) * yres / (size * 2);
> +					mousedev->packet.dy = (fy(2) - value) / 2;
> +				else if (mousedev->pkt_count == 1)
> +					mousedev->packet.dy = fy(1) - value;
>  				break;
>  		}
>  	}
> 
> I'm not kidding. Someone obviously outsmarted himself when programming this.
 
-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
