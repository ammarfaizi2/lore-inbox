Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVFFSyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVFFSyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVFFSyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:54:52 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:13382 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261577AbVFFSyr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:54:47 -0400
X-IronPort-AV: i="3.93,174,1115010000"; 
   d="scan'208"; a="251176167:sNHT24183572"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Date: Mon, 6 Jun 2005 13:54:56 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED3AC@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Thread-Index: AcVqw+aNEnKjVMtwRIiSEqrp5WWv7AAAzOQw
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <marcel@holtmann.org>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 06 Jun 2005 18:54:57.0273 (UTC) FILETIME=[3BB6BE90:01C56AC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jun 06, 2005 at 11:27:53AM -0500, Abhay_Salunke@Dell.com
wrote:
> > > The firmware class creates a sysfs file.  That is what I am
referring
> > to
> > > here.
> > >
> > By doing a copy of the image to the sysfs file are we trying to do
the
> > automatic actions done by the hotplug scripts manually?
> 
> Ok, it seems everyone is way confused here.  This is what I was
thinking
> of when I suggested using the firmware code:
> 	- module loads and registers with firmware core doing the
> 	  "request_firmware_nowait" call.
> 	- a hotplug event gets generated that everyone just ignores
> 	  (because it isn't really a big deal.)

At this instance the function returns and no entry is seen in
/sys/class/firmware/

> 	- At some point, the user copies the firmware to the sysfs file
> 	  because they want to update their bios.
> 	- the module is then told that firmware is present and it does
> 	  something with it.
> 
> Note, that between step 2 and 3, it could be _days_ or _months_.  No
> need to touch any hotplug scripts at all.
> 
> Does this make more sense now?  It seems pretty simple to me...

But the code still fails; here's the code snippet tired...

struct device *new_device;
void callbackfn(const struct firmware *fw, void *context)
{
        printk("callbackfn: entry\n");

        if (!fw)
                printk("Got invalid fw entry \n");

        printk("callbackfn: exit\n");
}

static int __init dcdrbu_init(void)
{
        int rc = 0;
        
        init_packet_head();

        new_device = kmalloc(sizeof (struct device), GFP_KERNEL);

        if (!new_device) {
                printk("dcdrbu_init: kmalloc failed \n");
                return -ENOMEM;
        }

        device_initialize(new_device);
        strcpy(new_device->bus_id, "dell_rbu");
      
	  rc = request_firmware_nowait (THIS_MODULE,
                "install.log", new_device,
                NULL,
                callbackfn);
        if(rc) {
                printk(KERN_ERR
                        "dcdrbu_init:"
                        " request_firmware_nowait failed %d\n", error);
        }

     return rc;
}

In this case the fw pointer returned in the callback is NULL, it also
happens without any delay and I also see a message as below in
/var/log/messages.
hald[2888]: Timed out waiting for hotplug event 305. Rebasing to 306.

Thanks
Abhay
