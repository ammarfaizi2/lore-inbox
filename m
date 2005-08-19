Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbVHSRgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbVHSRgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 13:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbVHSRgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 13:36:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932684AbVHSRgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 13:36:08 -0400
Date: Fri, 19 Aug 2005 10:34:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
Message-Id: <20050819103435.2c88a9f2.akpm@osdl.org>
In-Reply-To: <4305DCC6.70906@reub.net>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	<4305DCC6.70906@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> Hi,
> 
> On 19/08/2005 11:33 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/
> > 
> > - Lots of fixes, updates and cleanups all over the place.
> > 
> > - If you have the right debugging options set, this kernel will generate
> >   a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
> >   It is being worked on.
> 
> A few new problems cropped up with this kernel..
> 
> 1. NFS seems to be unstable, oopsing when shutting down:

--- devel/fs/nfsd/nfssvc.c~ingo-nfs-stuff-fix	2005-08-19 10:29:15.000000000 -0700
+++ devel-akpm/fs/nfsd/nfssvc.c	2005-08-19 10:30:03.000000000 -0700
@@ -286,7 +286,6 @@ out:
 	/* Release the thread */
 	svc_exit_thread(rqstp);
 
-	unlock_kernel();
 	/* Release module */
 	unlock_kernel();
 	module_put_and_exit(0);
_

> ...
> Aug 20 12:26:10 tornado kernel: Device  not ready.
> 
> 2.  That message on the third line of the trace above: "kernel: Device  not 
> ready." is being logged every few mins or so, I believe it is my SCSI CDROM 
> that is causing it.  It also logs something similar after the SCSI driver has 
> probed the device on boot:
> 
> Aug 20 12:24:36 tornado kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA 
> DRIVER, Rev 7.0
> Aug 20 12:24:36 tornado kernel:         <Adaptec 2940 Ultra SCSI adapter>
> Aug 20 12:24:36 tornado kernel:         aic7880: Ultra Wide Channel A, SCSI 
> Id=7, 16/253 SCBs
> Aug 20 12:24:36 tornado kernel:
> Aug 20 12:24:36 tornado kernel:   Vendor: SONY      Model: CD-RW  CRX145S 
> Rev: 1.0b
> Aug 20 12:24:36 tornado kernel:   Type:   CD-ROM 
> ANSI SCSI revision: 04
> Aug 20 12:24:36 tornado kernel:  target0:0:6: Beginning Domain Validation
> Aug 20 12:24:36 tornado kernel:  target0:0:6: Domain Validation skipping write 
> tests
> Aug 20 12:24:36 tornado kernel:  target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 
> ns, offset 15)
> Aug 20 12:24:36 tornado kernel:  target0:0:6: Ending Domain Validation
> Aug 20 12:24:36 tornado kernel: Device  not ready.
> 
> This has been a problem for quite a few weeks now, albeit I believe, only a 
> cosmetic one.

Is some application trying to poll the device?

Is the device actually "not ready", or is it in reality ready and working? 
ie: what happens if you stick a CD in it?

> 3. As I have a Marvell Yukon 2 chipset, I was _delighted_ to see a new driver 
> from Stephen Hemmingway appear in the netdev tree for it.  However it seems to 
> be a bit broken, I get link up and a bit of traffic before it just stops 
> passing traffic of any sort and requires an rmmod/modprobe to get going again. 
>   I've emailed him directly about this.

OK.

> 4. PAM is complaining about "PAM audit_open() failed: Protocol not suppor
> ted" and I can't log in as any user including root.  I would have picked this 
> was a userspace problem, but it doesn't break with -rc5-mm1, yet reproduceably 
> breaks with -rc6-mm1.  Weird.

hm.  How come you're able to use the machine then?

Is it possible to get an strace of this failure somehow?

