Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWGIOv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWGIOv3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWGIOv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:51:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:54818 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932478AbWGIOv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:51:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f0dJSh8gGjtgepMFHbjeLVlqvaey0QmgtEhfvToDS3NRHGakH4GfTEOpzh0PjlWfgq+43pEUjSC7u98xFEgq+Cy5IEhGnLIbeprQWxVNSvzxJSVDZwC6MQGxtFgBx7iGudt6FODXo2pTdKH51KOdM/A4M9AlP1H+jJr9XkZdA58=
Message-ID: <9e4733910607090751t29882cb6n961495dad426bdd8@mail.gmail.com>
Date: Sun, 9 Jul 2006 10:51:26 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Martin Langer" <martin-langer@gmx.de>
Subject: Re: [RFC][PATCH 1/2] firmware version management: add firmware_version()
Cc: "Marcel Holtmann" <marcel@holtmann.org>,
       "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de
In-Reply-To: <20060709122118.GA3678@tuba>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060708130904.GA3819@tuba>
	 <1152365514.3120.46.camel@laptopd505.fenrus.org>
	 <1152366597.29506.13.camel@localhost> <20060709122118.GA3678@tuba>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Martin Langer <martin-langer@gmx.de> wrote:
> On Sat, Jul 08, 2006 at 03:49:57PM +0200, Marcel Holtmann wrote:
> > Hi Arjan,
> >
> > > > It would be good if a driver knows which firmware version will be
> > > > written to the hardware. I'm talking about external firmware files
> > > > claimed by request_firmware().
> > > >
> > > > We know so many different firmware files for bcm43xx and it becomes
> > > > more and more complicated without some firmware version management.
> > > >
> > > > This patch can create the md5sum of a firmware file. Then it looks into
> > > > a table to figure out which version number is assigned to the hashcode.
> > > > That table is placed in the driver code and an example for bcm43xx comes
> > > > in my next mail. Any comments?
> > >
> > > why does this have to happen on the kernel side? Isn't it a lot easier
> > > and better to let the userspace side of things do this work, and even
> > > have a userspace file with the md5->version mapping? Or are there some
> > > practical considerations that make that hard to impossible?
> >
> > I fully agree that we shouldn't put firmware versioning into the kernel
> > drivers. The pattern you give to request_firmware() can be mapped to any
> > file on the file system. And you also have the link to the device object
> > and I prefer you export a sysfs file for the version so that the helper
> > application loading the firmware can pick the right file.
>
> Bcm43xx has no helper application to upload the firmware. This is done
> in the driver. It's RAM based hardware without a Flash-ROM. The driver
> has to upload the firmware in the init phase after each reset.

When your driver does request_firmware() I believe udev is triggering
the /sbin/firmware_helper app.

rules.d/05-udev-early.rules:ACTION=="add", SUBSYSTEM=="firmware",
ENV{FIRMWARE}=="*", RUN="/sbin/firmware_helper", OPTIONS="last_rule"

This app could be made smarter and set a version/checksum into two
more sysfs attributes.

I also though that the firmware loader was going to be modified to
load the firmware via a firmware attribute located in the device node
instead of a global firmware attribute. But it doesn't look like that
change has been made. If the loading were done inside the device node
adding the version/checksum attributes would be more obvious.
/sbin/firmware_helper could set these attributes while loading the
file.

> The driver gets a firmware file from /lib/firmware/ without knowing
> which version this is. It's not possible to say enable this in the
> driver if you find a firmware x and disable that if it's only version
> y. That was my motivation to start thinking about firmware versioning.
>
> But in the meantime I think it's a security issue, too. A driver
> should only accept firmware files with certified checksums. I guess it
> would be really difficult to enter a machine by firmware hijacking. So,
> I'm still in hope that this is only a paranoia on my side. But it's
> worth to think about it.
>
>
> Martin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Jon Smirl
jonsmirl@gmail.com
