Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751587AbWIFHOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbWIFHOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWIFHOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:14:30 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:16005 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751585AbWIFHO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:14:28 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44FE751E.4030505@s5r6.in-berlin.de>
Date: Wed, 06 Sep 2006 09:13:34 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
       linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Ben Collins <bcollins@ubuntu.com>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive	locking
 detected
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com> <20060905111306.80398394.akpm@osdl.org> <44FDCEAD.5070905@s5r6.in-berlin.de>
In-Reply-To: <44FDCEAD.5070905@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> Andrew Morton wrote:
>> On Tue, 5 Sep 2006 10:37:51 -0700
>> "Miles Lane" <miles.lane@gmail.com> wrote:
>>
>>> ieee1394: Node changed: 0-01:1023 -> 0-00:1023
>>> ieee1394: Node changed: 0-02:1023 -> 0-01:1023
>>> ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0080880002103eae]
>>>
>>> =============================================
>>> [ INFO: possible recursive locking detected ]
>>> 2.6.18-rc5-mm1 #2
>>> ---------------------------------------------
>>> knodemgrd_0/2321 is trying to acquire lock:
>>>  (&s->rwsem){----}, at: [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
>>>
>>> but task is already holding lock:
>>>  (&s->rwsem){----}, at: [<f8959078>] nodemgr_host_thread+0x717/0x883 [ieee1394]
> [...]
> 
> This information confuses me. These places are not supposed to be the
> ones where the locks were actually acquired, are they?
> 
>> That's a 1394 glitch, possibly introduced by git-ieee1394.patch.
> 
> Or maybe it's older. Nodemgr takes class->subsys.rwsem and
> device.bus->subsys.rwsem. It always did. Could there be a change in
> driver core which makes this recursive? Or has it always been recursive?
> For example,
> 
> static void nodemgr_update_pdrv(struct node_entry *ne)
> {
> 	struct unit_directory *ud;
> 	struct hpsb_protocol_driver *pdrv;
> 	struct class *class = &nodemgr_ud_class;
> 	struct class_device *cdev;
> 
> 	down_read(&class->subsys.rwsem);
> 	list_for_each_entry(cdev, &class->children, node) {
> 		ud = container_of(cdev, struct unit_directory, class_dev);
> 		if (ud->ne != ne || !ud->device.driver)
> 			continue;
> 
> 		pdrv = container_of(ud->device.driver, struct hpsb_protocol_driver, driver);
> 
> 		if (pdrv->update && pdrv->update(ud)) {
> 			down_write(&ud->device.bus->subsys.rwsem);
> 			device_release_driver(&ud->device);
> 			up_write(&ud->device.bus->subsys.rwsem);
> 		}
> 	}
> 	up_read(&class->subsys.rwsem);
> }

Hi Greg,

perhaps you could advise on this. It appears from grepping through the
sources that drivers/ieee1394/nodemgr.c is the only one with mixed
access to device.bus->subsys.rwsem and class->subsys.rwsem.

Other usages of subsys.rwsem that I found are:
1a.) dev->bus->subsys.rwsem
driver/ide/ide-proc.c and drivers/net/phy/phy_device.c take
dev->bus->subsys.rwsem. drivers/pnp/card.c takes dev.bus->subsys.rwsem.

1b.) driver.bus->subsys.rwsem
drivers/s390/net/qeth_proc.c takes driver.bus->subsys.rwsem.

2.) class->subsys.rwsem
drivers/scsi/hosts.c takes class->subsys.rwsem.

3.) bustype.subsys.rwsem
drivers/input/serio/serio.c takes serio_bus.subsys.rwsem.
drivers/input/gameport/gameport.c takes gameport_bus.subsys.rwsem.
drivers/base/power/shutdown.c takes devices_subsys.rwsem.
drivers/usb/core/devices.c and devio.c take usb_bus_type.subsys.rwsem.

Do class->subsys.rwsem, bus->subsys.rwsem, and bus_type.subsys.rwsem
point to identical or different lock instances?

Either way, could it hurt to convert nodemgr to uniformly use
ieee1394_bus_type.subsys.rwsem all over the place?

Thanks,
-- 
Stefan Richter
-=====-=-==- =--= --==-
http://arcgraph.de/sr/
