Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264713AbSJUDYJ>; Sun, 20 Oct 2002 23:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbSJUDYJ>; Sun, 20 Oct 2002 23:24:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:60891 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264713AbSJUDYG>; Sun, 20 Oct 2002 23:24:06 -0400
Date: Sun, 20 Oct 2002 20:30:11 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>, Jurriaan <thunder7@xs4all.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: problemn when shutting down, drivers/base/power.c and the global_device_list
Message-ID: <20021021033011.GA1534@beaverton.ibm.com>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
References: <20021019153417.GA567@middle.of.nowhere> <Pine.LNX.4.44.0210201117080.963-100000@cherise.pdx.osdl.net> <20021020145947.A11444@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020145947.A11444@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for debugging this.

I meant to keep the one in scsi_register_host and delete the one in
scsi_set_pci_device. I was having an issue with non-pci hosts when I
registered only through scsi_set_pci_device though the problem could
have been not ensuring parent was set to null so that if it was not set
prior to device_register we would not oops.

Either Patrick M's patch or this one should work until we straighten out
our device model support.

--- 1.19/drivers/scsi/hosts.h	Wed Oct 16 17:53:47 2002
+++ edited/drivers/scsi/hosts.h	Sun Oct 20 19:45:35 2002
@@ -551,9 +551,6 @@
 {
 	shost->pci_dev = pdev;
 	shost->host_driverfs_dev.parent=&pdev->dev;
-
-	/* register parent with driverfs */
-	device_register(&shost->host_driverfs_dev);
 }
 
 



Patrick Mansfield [patmans@us.ibm.com] wrote:
> On Sun, Oct 20, 2002 at 01:21:29PM -0700, Patrick Mochel wrote:
> > 
> > On Sat, 19 Oct 2002, Jurriaan wrote:
> > 
> > > DEV: registering device: ID = 'scsi0', name = sym53c8xx
> 
> Above is from scsi_set_pci_device() call.
> 
> > > scsi0 : sym53c8xx-1.7.3c-20010512
> > > DEV: registering device: ID = 'scsi0', name = sym53c8xx
> 
> Above are from scsi_register_host().
> 
> > > sym53c860-0-<1,*>: FAST-20 SCSI 20.0 MB/s (50.0 ns, offset 8)
> > >   Vendor: TOSHIBA   Model: DVD-ROM SD-M1401  Rev: 1007
> > >   Type:   CD-ROM                             ANSI SCSI revision: 02
> 
> > 
> > It appears the same device is being added twice. After doing some digging
> > in the sym53c8xx and the scsi host code, that suspicion grows, though I'm 
> > not positively sure how the host is being added twice. 
> > 
> 
> Looks like we have two device_register(&shost->host_driverfs_dev) calls,
> one in scsi_set_pci_device, and one in scsi_register_host(). I think 
> Mike meant to delete the one in scsi_register_host, but I can't tell
> for certain which one should go away.
> 
> And this must might be why I can't shutdown (i.e. no auto reboot).
> 
> So in 2.5.44 have:
> 
> 	scsi_register_host() calls
> 		attach [ncr_attach] calls
> 			scsi_register
> 			scsi_set_pci_device calls
> 				device_register(&shost->host_driverfs_dev)
> 		call to device_register() again in scsi_register_host
> 
> This removes the scsi_register_host() one, I can shutdown/reboot
> with this patch, I didn't dump anything else or try rmmod's:
> 
> --- bleed-2.5/drivers/scsi/hosts.c	Sat Oct 19 10:30:01 2002
> +++ bleed-2.5/drivers/scsi/hosts.c-mine	Sun Oct 20 14:46:13 2002
> @@ -543,7 +543,6 @@
>  				       shost->host_no, dm_name);
>  
>  				/* first register parent with driverfs */
> -				device_register(&shost->host_driverfs_dev);
>  				scan_scsis(shost, 0, 0, 0, 0);
>  			}
>  		}
> 
> > scsi_register_host() then loops through the hosts, and registers all the 
> > ones that this driver added. (Q: why is that function constantly looping 
> > through all the scsi hosts just to operate on the one passed in?).
> 
> A Scsi_Host_Template is passed in, it loops over Scsi_Hosts to find
> everyone that is using the Scsi_Host_Template, the names are confusing
> as well as the code.
> 
> > The SCSI code is confusing and likely the culprit. 
> 
> Yes and yes ...
> 
> -- Patrick Mansfield
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-andmike
--
Michael Anderson
andmike@us.ibm.com

