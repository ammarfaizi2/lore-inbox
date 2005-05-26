Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVEZQiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVEZQiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 12:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVEZQiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 12:38:11 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:38815 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261604AbVEZQhy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 12:37:54 -0400
X-IronPort-AV: i="3.93,140,1115010000"; 
   d="scan'208"; a="247679751:sNHT23415810"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Date: Thu, 26 May 2005 11:37:44 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED399@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Thread-Index: AcVfri1aFpNaZsXsRFK548jZrcsNkACYfA7Q
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <ranty@debian.org>
X-OriginalArrivalTime: 26 May 2005 16:37:45.0010 (UTC) FILETIME=[3E5BD920:01C56211]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, May 23, 2005 10:48 AM
> To: Salunke, Abhay
> Cc: linux-kernel@vger.kernel.org; akpm@osdl.org; Domsch, Matt
> Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new
Dell
> BIOS update driver
> 
> On Mon, May 23, 2005 at 09:52:05AM -0500, Abhay_Salunke@Dell.com
wrote:
> > Greg,
> > >
> > > Also, what's wrong with using the existing firmware interface in
the
> > > kernel?
> > request_firmware requires the $FIRMWARE env to be populated with the
> > firmware image name or the firmware image name needs to be hardcoded
> > within  the call to request_firmware. Since the user is free to
change
> > the BIOS update image at will, it may not be possible if we use
> > $FIRMWARE also I am not sure if this env variable might be
conflicting
> > to some other driver.
> 
> As others have already stated, this doesn't really matter.  Make it
> "dell_bios_update", if any device names their firmware that, well,
> that's their problem...

OK, I have been trying to use request_firmware but it always fails with
return code -2. This is the code snippet below, any thoughts?

static struct device rbu_device_type;

static struct device rbu_device;

static int __init dcdrbu_init(void)
{
        int rc = 0;
        const struct firmware *fw;

        device_initialize(&rbu_device_type);
        device_initialize(&rbu_device);

        strncpy(rbu_device.bus_id,"dell_rbu.bin", BUS_ID_SIZE);
        strncpy(rbu_device_type.bus_id,"dell_rbu1.bin", BUS_ID_SIZE);

        rc = request_firmware(&fw, "dell_rbu_type", &rbu_device_type);

        if (rc) {
                printk(KERN_ERR "dcdrbu_init: Firmware 1 missing "
                        "%d\n", rc);
                return -EIO;
        }

        release_firmware(fw);

        rc = request_firmware(&fw, "dell_rbu_data", &rbu_device);
        if (rc) {
                printk(KERN_ERR "dcdrbu_init: Firmware 2 missing "
                        "%d\n", rc);
                return -EIO;
        }

        release_firmware(fw);

        return rc;
}

static __exit void dcdrbu_exit( void)
{
}

module_exit(dcdrbu_exit);
module_init(dcdrbu_init);
