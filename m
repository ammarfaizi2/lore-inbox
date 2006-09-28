Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161174AbWI1UPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbWI1UPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbWI1UPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:15:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36581 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161142AbWI1UPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:15:11 -0400
Message-ID: <451C2D49.7040403@torque.net>
Date: Thu, 28 Sep 2006 16:15:05 -0400
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] async scsi scanning, version 12
References: <20060928182438.GC5017@parisc-linux.org>
In-Reply-To: <20060928182438.GC5017@parisc-linux.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> Hopefully the final version ... I've addressed all the comments
> I received on version 11.  Please review the implementation of
> shost_for_each_device_safe.
> 
> Add ability to scan scsi busses asynchronously
> 
> Since it often takes around 20-30 seconds to scan a scsi bus, it's
> highly advantageous to do this in parallel with other things.  The bulk
> of this patch is ensuring that devices don't change numbering, and that
> all devices are discovered prior to trying to start init.  For those
> who build SCSI as modules, there's a new scsi_wait_scan module that will
> ensure all bus scans are finished.
> 
> This patch only handles drivers which call scsi_scan_host.  Fibre Channel,
> SAS, SATA, USB and Firewire all need additional work.
> 
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 5498324..4b687ef 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1426,6 +1426,11 @@ running once the system is up.
>  
>  	scsi_logging=	[SCSI]
>  
> +	scsi_mod.scan=	[SCSI] sync (default) scans SCSI busses as they are
> +			discovered.  async scans them in kernel threads,
> +			allowing boot to proceed.  none ignores them, expecting
> +			user space to do the scan.

Matthew,
I like the "none" which is no doubt a place holder at
the moment.

For the user space to do discovery, it either needs an out
of band mechanism (e.g. IP) or the ability to talk to a
host in the absence of any "devices" (targets or logical units).
That requires a device node (e.g. /dev/mptctl) or something
equivalent in sysfs (yuk).

Your "none" explanation could be slightly extended to say
that the LLD (and/or its firmware) might do the discovery. As an
example the SAS-2 draft now has self-configuring expanders
(the terms "edge" and "fanout" have been dropped) which
effectively discover the topology and track changes, configuring
themselves and dumber expanders as required. Then host discovery
becomes importing the topology from an external device. However
not all devices may be visible to self-configuring expanders
(e.g. a SATA disk could be directly attached to a SAS HBA). So
some extra work may be required.

So at one extreme the discovery process may be distributed
and at the other extreme there is no discovery at all.
With modern transports (e.g. FC, SAS, iSCSI?) having world
wide unique names who needs discovery?

Doug Gilbert
