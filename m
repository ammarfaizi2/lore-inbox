Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWDMODw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWDMODw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 10:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWDMODw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 10:03:52 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:21637 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S964941AbWDMODv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 10:03:51 -0400
Message-ID: <443E5AAD.5040800@keyaccess.nl>
Date: Thu, 13 Apr 2006 16:05:33 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       Greg KH <gregkh@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>,
       ALSA devel <alsa-devel@alsa-project.org>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again
 if probe was unsuccessful
References: <443DAD5C.8080007@keyaccess.nl> <200604131126.35841.ioe-lkml@rameria.de>
In-Reply-To: <200604131126.35841.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:

Why did you remove alsa-devel from the CC?

> This is inserting lots of duplicate and control heavy code. It looks 
> like the same pattern and is using just platform_xxx funxtions.
> 
> Any counter-examples with a different pattern, which you converted in
> a different manner?

Not lots really... for all of them it's basically:

if (!platform_get_drvdata(device)) {
	platform_device_unregister(device);
	continue;
}

in the driver's main init loop. In this batch there were three drivers 
that both did not support more than one device and passed the error on 
up meaning it looks a bit a bit more clumsy than that but when moving 
these drivers from the platform_device_register_simple() interface this 
code will be revisited again; making them support more devices can also 
happen longer term.

> Wouldn't it be more useful to do these checks in 
> platform_register_simple() and return the proper error value there?

That interface is going away. I checked where ALSA used them due to that 
in fact (the same patches for sound/isa are already in ALSA and have 
been submitted for -stable as well).

Yes, it would be better if the driver model supplied this functionality 
itself. The problem is that an error return from the platform probe() 
method is not being honoured/passed up by the driver model so that we 
don't get a chance to say "no, the hardware's not here, go away!".

Not honouring/passing up probe() method error returns, not even -ENODEV, 
makes some sense for discoverable busses such as PCI where you at least 
have a driver independent bus_id sitting in /sys/devices/pci* that you 
can later echo into /sys/bus/pci/drivers/*/bind to make the driver bind 
to a device, but not much sense for the platform bus. Platform devices 
only "exist" (in /sys/devices/platform) due to the driver creating them 
itself and keeping them after failing a probe means that directory 
becomes an enumeration of the drivers we loaded, rather than a view of 
what's present in the system.

The driver model crowd did not seem exceedingly interested in the 
problem though:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114417829014332&w=2

It _is_ ofcourse an option to not care about /sys/devices/platform, and 
ALSA could do that as well longer term. This was discussed:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114442720631596&w=2

(marc seems to be not so good at keeping threads intact. reply at: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=114469016131522&w=2)

and for now, we'll keep the old behaviour of not loading on probe 
failure, using drvdata() as a private success flag set from probe(). 
Longer term, we can revisit this.

Most importantly though, you replied to the one submitted for -stable. 
For -stable, this is certainly the way to go. ALSA drivers always failed 
to load on probe() failure before they were even using the platform 
driver interface (which was new to 2.6.16) and things like the alsaconf 
script rely on this. For -stable, it's a simple bugfix therefore.

> Or just create a small helper, if this have to be done seperate.

That would be going way overboard for the three lines as stated in the 
beginning. Certainly when they might/will go again in the future...

Rene.

