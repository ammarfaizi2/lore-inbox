Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbWGIPAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWGIPAH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 11:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWGIPAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 11:00:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:38188 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030372AbWGIPAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 11:00:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JkBtydjVSPtCBFFAZXakl89AaIP1cwTxdTYLHtQfqhV6GeduH06OdKCe1DHTYuJge0z1sK3hiwl8Mw7owNLViD+VTZZ8Q+KC14mDPuFono7Z+C7BuF2kcUEaXMDKWttAT8N/r58ekPUkq6yUNQMsZuceCTf58vDcknMzOqnFHPw=
Message-ID: <9e4733910607090800o1be89b37i68183c9869cddea8@mail.gmail.com>
Date: Sun, 9 Jul 2006 11:00:03 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Michael Buesch" <mb@bu3sch.de>
Subject: Re: [RFC][PATCH 1/2] firmware version management: add firmware_version()
Cc: "Martin Langer" <martin-langer@gmx.de>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Marcel Holtmann" <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de
In-Reply-To: <200607091644.53285.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060708130904.GA3819@tuba> <1152366597.29506.13.camel@localhost>
	 <20060709122118.GA3678@tuba> <200607091644.53285.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Michael Buesch <mb@bu3sch.de> wrote:
> On Sunday 09 July 2006 14:21, you wrote:
> > On Sat, Jul 08, 2006 at 03:49:57PM +0200, Marcel Holtmann wrote:
> > > Hi Arjan,
> > >
> > > > > It would be good if a driver knows which firmware version will be
> > > > > written to the hardware. I'm talking about external firmware files
> > > > > claimed by request_firmware().
> > > > >
> > > > > We know so many different firmware files for bcm43xx and it becomes
> > > > > more and more complicated without some firmware version management.
> > > > >
> > > > > This patch can create the md5sum of a firmware file. Then it looks into
> > > > > a table to figure out which version number is assigned to the hashcode.
> > > > > That table is placed in the driver code and an example for bcm43xx comes
> > > > > in my next mail. Any comments?
> > > >
> > > > why does this have to happen on the kernel side? Isn't it a lot easier
> > > > and better to let the userspace side of things do this work, and even
> > > > have a userspace file with the md5->version mapping? Or are there some
> > > > practical considerations that make that hard to impossible?
> > >
> > > I fully agree that we shouldn't put firmware versioning into the kernel
> > > drivers. The pattern you give to request_firmware() can be mapped to any
> > > file on the file system. And you also have the link to the device object
> > > and I prefer you export a sysfs file for the version so that the helper
> > > application loading the firmware can pick the right file.
> >
> > Bcm43xx has no helper application to upload the firmware. This is done
> > in the driver. It's RAM based hardware without a Flash-ROM. The driver
> > has to upload the firmware in the init phase after each reset.
> >
> > The driver gets a firmware file from /lib/firmware/ without knowing
> > which version this is. It's not possible to say enable this in the
> > driver if you find a firmware x and disable that if it's only version
> > y. That was my motivation to start thinking about firmware versioning.
> >
> > But in the meantime I think it's a security issue, too. A driver
> > should only accept firmware files with certified checksums. I guess it
> > would be really difficult to enter a machine by firmware hijacking. So,
> > I'm still in hope that this is only a paranoia on my side. But it's
> > worth to think about it.
>
> I really think drivers should only allow firmware files that are known
> to work. This should be verified by a hardcoded checksum in the driver.
> I support Martin's patch.
> The problem is (for bcm43xx):
> If we load wrong firmware, the device sometimes does not work
> correctly (as the firmware was never tested by any developer).
> If we load wrong firmware, we can completely crash the machine.
> And no, we can't avoid this by some sanity checks. We have sanity
> checks there that catch the most obvious garbage, but it can never
> catch everything. So it is possible to MachineCheck the kernel from
> userspace, by providing wrong firmware. Only root can do that,
> but it is hard to diagnose that it's caused by faulty firmware.
> It is also possible to trigger some NULL pointer dereferences,
> because with a too-new firmware, the device will return different
> TX status reports to the driver. Yeah, we could add a if(foo!=NULL)
> there, but that would _still_ not be safe, because we still get garbage
> back. In a driver we simply _depend_ on the hardware to work correctly.
> As the hardware is equal to the firmware (from the driver pov),
> we depend on correct firmware for correct operation.
> So what we want to do is: Dongle several known good firmwares
> (through the checksum) to a driver version.

You can do this in the other direction from user space. Have the
driver add a sysfs attribute containing a list of allowed MD5s for
firmware images. Now modify /bin/firmware_helper to check the file
against the valid list and abort if there is not a match.

Doing this in user space will make it easier for the user to debug
what is happening when things fail.

>
> --
> Greetings Michael.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Jon Smirl
jonsmirl@gmail.com
