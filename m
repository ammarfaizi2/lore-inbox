Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbTJEOuP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 10:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTJEOuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 10:50:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:33158 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263126AbTJEOuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 10:50:07 -0400
Date: Sun, 5 Oct 2003 07:49:02 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: oops when removing sbp2 module
Message-ID: <20031005074902.A26284@beaverton.ibm.com>
References: <16256.6322.388402.857084@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16256.6322.388402.857084@cargo.ozlabs.ibm.com>; from paulus@samba.org on Sun, Oct 05, 2003 at 11:12:18PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 05, 2003 at 11:12:18PM +1000, Paul Mackerras wrote:

> In fact what is happening is that class_device_unregister gets called
> twice for the same classdev.  This is because scsi_remove_device gets
> called twice for the same device.  The first time, the call chain
> looks like this:
>
> scsi_remove_device
> sbp2_remove_device
> sbp2_remove
> device_release_driver
> driver_detach
> bus_remove_driver
> driver_unregister
> hpsb_unregister_protocol
> sbp2_module_exit
> 
> and the second time it looks like this:
> 
> scsi_remove_device
> scsi_forget_host
> scsi_remove_host
> sbp2_remove_host
> hpsb_unregister_highlevel
> sbp2_module_exit
> 
> So, is this a reference counting problem on the classdev, a problem
> where the scsi layer doesn't remove the scsi device from its internal
> lists properly in scsi_remove_device, or a problem in the sbp2 code?
> Anyone got a fix?
> 
> Thanks,
> Paul.

Paul -

There is a typo on a change to the access_count check. 

Try this patch:

--- bleed-2.5/drivers/scsi/scsi_sysfs.c-orig	Mon Sep 29 12:21:09 2003
+++ bleed-2.5/drivers/scsi/scsi_sysfs.c	Mon Sep 29 16:19:22 2003
@@ -412,7 +412,7 @@
 		set_bit(SDEV_DEL, &sdev->sdev_state);
 		if (sdev->host->hostt->slave_destroy)
 			sdev->host->hostt->slave_destroy(sdev);
-		if (atomic_read(&sdev->access_count))
+		if (!atomic_read(&sdev->access_count))
 			device_del(&sdev->sdev_gendev);
 		up_write(&class->subsys.rwsem);
 	}

-- Patrick Mansfield
