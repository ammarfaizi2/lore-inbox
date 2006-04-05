Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWDEO7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWDEO7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 10:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDEO7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 10:59:06 -0400
Received: from wproxy.gmail.com ([64.233.184.226]:29331 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750836AbWDEO7F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 10:59:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LA9uSb7Essu/j1BKwNaUtBAtSuhETcaiajBhxvpF5IX9xuOVI2oUm+WD2lFOohWP+sEFNpenNsj/kfHlHvRaaMTHOC3Evy7loyPv/q6gCW8/ixrofmUbn6Ra6ke+J56ubrtitZzd8CghXdR8W3V87wp5aaqXfgaX1QAMuC4xPAE=
Message-ID: <d120d5000604050759k576133a9t90dd02c35fce91af@mail.gmail.com>
Date: Wed, 5 Apr 2006 10:59:04 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Rene Herman" <rene.herman@keyaccess.nl>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Cc: "Greg KH" <gregkh@suse.de>, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de,
       "Andrew Morton" <akpm@osdl.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <4433CB34.6010707@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44238489.8090402@keyaccess.nl> <20060404210048.GA5694@suse.de>
	 <4432EF58.1060502@keyaccess.nl>
	 <200604042148.57286.dtor_core@ameritech.net>
	 <4433CB34.6010707@keyaccess.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/06, Rene Herman <rene.herman@keyaccess.nl> wrote:
> Dmitry Torokhov wrote:
>
> > On Tuesday 04 April 2006 18:12, Rene Herman wrote:
>
> >> To Dmitry, I see you saying "probe() failing is driver's problem.
> >> The device is still there and should still be presented in sysfs.".
> >> No, at least in the case of these platform drivers (or at least
> >> these old ISA cards using the platform driver interface), a -ENODEV
> >> return from the probe() method would mean the device is _not_
> >> present (or not found at least). NODEV.
> >
> > Or you could separate device probing code from driver->probe(). BTW I
> > think that ->probe() is not the best name for that method.
>
> Right...
>
> > It really is supposed to allocate resources and initialize the device
> > so that it is ready to be used, not to verify that device is present.
> > The code that created device shoudl've done that.
>
> How do you feel about the flag that I've been proposing that a driver
> that needs to probe for its hardware could set and that says "if we
> return an error (or specifically -ENODEV I guess) the hardware's
> reallyreally not present and the device should not register"?
>
> Greg, and how do you feel about such a flag?
>
> As an alternative to the flag, how would either of you feel about either
>
> 1) adding a .discover method to struct device_driver that noone other
> than drivers for this old non generically discoverable hardware would
> set but which would make a registration fail if set and returning < 0?
>
> 2) adding that method only to platform_driver?
>
> 3) ... and after a few months when people aren't paying attention
> anymore rename .probe to .init and .discover back to .probe? ;-)
>

You need to let go of the model that driver that drives hardware also
do the device discovery and it will all fall into place. While it may
be contained in the same source module it is 2 different code chunks
(for the lack of the better word) and we should not mix them together.

> Russel, you wrote:
>
> > Note also that this patch will not do what the ALSA folk want - they
> > want to know if the device was found or whether the probe returned
> > -ENODEV. We knock -ENODEV and -ENXIO to zero in
> > driver_probe_device(), so they won't even see that.
>
> Yes, I know about the -ENODEV / -ENXIO thing. I asked for comment on
> that as well, but haven't gotten any.
>
> Anyways, the additional method would, I feel, be the conceptually
> cleanest approach. Practically speaking though, simply doing a manual
> probe and only calling platform_register() after everything is found to
> be present and accounted for is not much of a problem either.
>

Unfortunately it breaks manual driver binding/unbinding through sysfs
so I don't think it is a good long-term solution.

--
Dmitry
