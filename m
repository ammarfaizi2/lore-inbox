Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTLSUXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 15:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbTLSUXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 15:23:53 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:5795 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263607AbTLSUXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 15:23:50 -0500
Subject: Re: [RFC] 2.6.0 EDD enhancements
From: James Bottomley <James.Bottomley@steeleye.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20031219130129.B6530@lists.us.dell.com>
References: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com> 
	<20031219130129.B6530@lists.us.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Dec 2003 15:23:21 -0500
Message-Id: <1071865401.1943.31.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-12-19 at 14:01, Matt Domsch wrote:
> @@ -639,11 +629,11 @@
>  	pci_dev = edd_get_pci_dev(edev);
>  	if (pci_dev) {
>  		struct scsi_device * sdev = edd_find_matching_scsi_device(edev);
> -		if (sdev && get_device(&sdev->sdev_driverfs_dev)) {
> +		if (sdev && get_device(&sdev->sdev_gendev)) {
>  			rc = sysfs_create_link(&edev->kobj,
> -					       &sdev->sdev_driverfs_dev.kobj,
> +					       &sdev->sdev_gendev.kobj,
>  					       "disc");
> -			put_device(&sdev->sdev_driverfs_dev);
> +			put_device(&sdev->sdev_gendev);

This is a bit nasty...you're assuming a lot of hidden knowledge about
the layout of sysfs objects in scsi_device in this code.

The current(*) way you should be doing this is to use scsi_device_get()
in your edd_match_scsi_dev() and do a scsi_device_put() after creating
the link...that should be hotplug robust.

(*) since SCSI hotplug is a work in progress, this may change...

James


