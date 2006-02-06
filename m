Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWBFSXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWBFSXs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWBFSXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:23:48 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:43142 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932277AbWBFSXr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:23:47 -0500
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] s390: dasd extended error reporting module.
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFF4667F11.171F84D7-ONC125710D.00645C4D-C125710D.00650CEA@de.ibm.com>
From: Stefan Weinhuber <WEIN@de.ibm.com>
Date: Mon, 6 Feb 2006 19:23:44 +0100
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 06/02/2006 19:23:45,
	Serialize complete at 06/02/2006 19:23:45
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote on 04.02.2006 14:14:19:
>
> NACK again.  (although andrew unfortunately pushed this to Linus
> already, it would be good if this went out again before 2.6.16).
>
> If you really want this functionality in a separate module you need
> to call try_module_get on the module structure of the eer module
> everytime before calling into it.  You need to register a structure
> ala
>
> struct dasd_eer_ops {
>    struct module *owner;
>    void (*disable_on_device)(struct dasd_device *);
>    void (*write_trigger)(struct dasd_eer_trigger *);
> };
>
> and then have wrappers in the core dasd code ala
>
> eer_disable_on_device(struct dasd_device *dev)
> {
>    if (try_module_get(eer_ops->owner)) {
>       eer_ops->write_trigger(dev);
>       module_put(eer_ops->owner);
>    }
> }
>
> the module_get/put on THIS_MODULE in the patch are completely broken.

For the dynamically registered ioctls there is exactly such a
concept in place. So a try_module_get is done _before_ the
dasd_ioctl_set_eer function is called. That function again calls
dasd_eer_enable_on_device which does the try_module_get you complain
about. So, for each device on which the error reporing is enabled, a
try_module_get is done, and it should be safe for those devices to
call the respective notifier functions later on.

>
> the ioctl registration is also totally not acceptable.  firtly this
> interface is absolutely suitable for sysfs, although that might only 
work
> if it's in the main module.  But even if you go for ioctls it should be
> on your separate char device and not use the broken dynamic ioctl
> registration which _must_ not be used in any new code.

I know that you don't like that dynamic ioctl interface, but I would
like to leave that discussion to Horst.
But besides that, the ioctl in question is needed on the DASD device,
since we want to enable or disable error reporting per DASD device.

Best Regards /  Mit freundlichen Grüßen

Stefan Weinhuber

-------------------------------------------------------------------
IBM Deutschland Entwicklung GmbH
Linux for zSeries Development & Services

