Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbWIGWph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWIGWph (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbWIGWph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:45:37 -0400
Received: from qb-out-0506.google.com ([72.14.204.237]:22394 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751614AbWIGWpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:45:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CEY2uD9H6Sc51EvjrIR4oiFt+PmoZMX5K/E7Rwe7e4YDtina9LC6JXVqPSk9tTTUakElMwtYQwjSWt9RPajngaCsx3lnoD8nqWVDal0ObenvJLFcp86aKTL1rfzd5N1Aj3JY3I/gdl3pIya6wNeNei/zOfSF6hpHHFYxYYifKN0=
Message-ID: <a44ae5cd0609071545p26b42432ife69bf7c63d41dd0@mail.gmail.com>
Date: Thu, 7 Sep 2006 15:45:34 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive locking detected
Cc: "Greg KH" <gregkh@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Ben Collins" <bcollins@ubuntu.com>
In-Reply-To: <44FEFC68.90201@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
	 <20060905111306.80398394.akpm@osdl.org>
	 <44FDCEAD.5070905@s5r6.in-berlin.de>
	 <44FE751E.4030505@s5r6.in-berlin.de>
	 <44FEFC68.90201@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> I wrote:
> > I wrote:
> >> Or maybe it's older. Nodemgr takes class->subsys.rwsem and
> >> device.bus->subsys.rwsem. It always did. Could there be a change in
> >> driver core which makes this recursive? Or has it always been recursive?
> >> For example,
> >>
> >> static void nodemgr_update_pdrv(struct node_entry *ne)
> >> {
> >>      struct unit_directory *ud;
> >>      struct hpsb_protocol_driver *pdrv;
> >>      struct class *class = &nodemgr_ud_class;
> >>      struct class_device *cdev;
> >>
> >>      down_read(&class->subsys.rwsem);
> >>      list_for_each_entry(cdev, &class->children, node) {
>
> This may be wrong anyway. According to include/linux/device.h,
> class->sem should be used to protect access to class->children. There
> are more places in nodemgr of this sort.
>
> >>              ud = container_of(cdev, struct unit_directory, class_dev);
> >>              if (ud->ne != ne || !ud->device.driver)
> >>                      continue;
> >>
> >>              pdrv = container_of(ud->device.driver, struct hpsb_protocol_driver, driver);
> >>
> >>              if (pdrv->update && pdrv->update(ud)) {
> >>                      down_write(&ud->device.bus->subsys.rwsem);
> >>                      device_release_driver(&ud->device);
> >>                      up_write(&ud->device.bus->subsys.rwsem);
> >>              }
> >>      }
> >>      up_read(&class->subsys.rwsem);
> >> }
> >
> > Hi Greg,
> >
> > perhaps you could advise on this. It appears from grepping through the
> > sources that drivers/ieee1394/nodemgr.c is the only one with mixed
> > access to device.bus->subsys.rwsem and class->subsys.rwsem.
> >
> > Other usages of subsys.rwsem that I found are:
> > 1a.) dev->bus->subsys.rwsem
> > driver/ide/ide-proc.c and drivers/net/phy/phy_device.c take
> > dev->bus->subsys.rwsem. drivers/pnp/card.c takes dev.bus->subsys.rwsem.
> >
> > 1b.) driver.bus->subsys.rwsem
> > drivers/s390/net/qeth_proc.c takes driver.bus->subsys.rwsem.
> >
> > 2.) class->subsys.rwsem
> > drivers/scsi/hosts.c takes class->subsys.rwsem.
> >
> > 3.) bustype.subsys.rwsem
> > drivers/input/serio/serio.c takes serio_bus.subsys.rwsem.
> > drivers/input/gameport/gameport.c takes gameport_bus.subsys.rwsem.
> > drivers/base/power/shutdown.c takes devices_subsys.rwsem.
> > drivers/usb/core/devices.c and devio.c take usb_bus_type.subsys.rwsem.
> >
> > Do class->subsys.rwsem, bus->subsys.rwsem, and bus_type.subsys.rwsem
> > point to identical or different lock instances?
> >
> > Either way, could it hurt to convert nodemgr to uniformly use
> > ieee1394_bus_type.subsys.rwsem all over the place?

I don't have time to do the bisection testing.  If there is a patch
you'd like me to test against 2.6.18-rc5-mm1+all hotfixes, please let
me know.  I apologize for not being able to narrow this down further
for you.

        Miles
