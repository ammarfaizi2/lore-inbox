Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263960AbTJFDJC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 23:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbTJFDJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 23:09:02 -0400
Received: from ozlabs.org ([203.10.76.45]:44486 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263960AbTJFDI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 23:08:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16256.56491.671416.205944@cargo.ozlabs.ibm.com>
Date: Mon, 6 Oct 2003 13:08:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: oops when removing sbp2 module
In-Reply-To: <20031005074902.A26284@beaverton.ibm.com>
References: <16256.6322.388402.857084@cargo.ozlabs.ibm.com>
	<20031005074902.A26284@beaverton.ibm.com>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield writes:

> There is a typo on a change to the access_count check. 
> 
> Try this patch:
> 
> --- bleed-2.5/drivers/scsi/scsi_sysfs.c-orig	Mon Sep 29 12:21:09 2003
> +++ bleed-2.5/drivers/scsi/scsi_sysfs.c	Mon Sep 29 16:19:22 2003
> @@ -412,7 +412,7 @@
>  		set_bit(SDEV_DEL, &sdev->sdev_state);
>  		if (sdev->host->hostt->slave_destroy)
>  			sdev->host->hostt->slave_destroy(sdev);
> -		if (atomic_read(&sdev->access_count))
> +		if (!atomic_read(&sdev->access_count))
>  			device_del(&sdev->sdev_gendev);
>  		up_write(&class->subsys.rwsem);
>  	}

That fixes it, it no longer oopses on removing sbp2.  As before I get
a message saying "Device 'fw-host0' does not have a release()
function, it is broken and must be fixed."  I assume that is a problem
with the sbp2 module.

The code in the patch looks a little worrying to me, though.  Is there
some lock we have taken to ensure that no other process could be
modifying sdev->access_count at the same time?  Also, what is to stop
some other process from noticing that sdev->access_count is 0 and
calling device_del(&sdev->sdev_gendev) ?

Regards,
Paul.
