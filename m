Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932791AbVHTBfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbVHTBfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 21:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbVHTBfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 21:35:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932791AbVHTBfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 21:35:46 -0400
Date: Fri, 19 Aug 2005 18:34:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
Message-Id: <20050819183421.3c2849f3.akpm@osdl.org>
In-Reply-To: <430686EA.3000901@reub.net>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	<4305DCC6.70906@reub.net>
	<20050819103435.2c88a9f2.akpm@osdl.org>
	<430686EA.3000901@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> >> Aug 20 12:26:10 tornado kernel: Device  not ready.
> >>
> >> 2.  That message on the third line of the trace above: "kernel: Device  not 
> >> ready." is being logged every few mins or so, I believe it is my SCSI CDROM 
> >> that is causing it.  It also logs something similar after the SCSI driver has 
> >> probed the device on boot:
> >>
> >> Aug 20 12:24:36 tornado kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA 
> >> DRIVER, Rev 7.0
> >> Aug 20 12:24:36 tornado kernel:         <Adaptec 2940 Ultra SCSI adapter>
> >> Aug 20 12:24:36 tornado kernel:         aic7880: Ultra Wide Channel A, SCSI 
> >> Id=7, 16/253 SCBs
> >> Aug 20 12:24:36 tornado kernel:
> >> Aug 20 12:24:36 tornado kernel:   Vendor: SONY      Model: CD-RW  CRX145S 
> >> Rev: 1.0b
> >> Aug 20 12:24:36 tornado kernel:   Type:   CD-ROM 
> >> ANSI SCSI revision: 04
> >> Aug 20 12:24:36 tornado kernel:  target0:0:6: Beginning Domain Validation
> >> Aug 20 12:24:36 tornado kernel:  target0:0:6: Domain Validation skipping write 
> >> tests
> >> Aug 20 12:24:36 tornado kernel:  target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 
> >> ns, offset 15)
> >> Aug 20 12:24:36 tornado kernel:  target0:0:6: Ending Domain Validation
> >> Aug 20 12:24:36 tornado kernel: Device  not ready.
> >>
> >> This has been a problem for quite a few weeks now, albeit I believe, only a 
> >> cosmetic one.
> > 
> > Is some application trying to poll the device?
> 
> I wonder if hald knows something about this and is polling.. however that 
> message above about "Device  not ready" occurs when the kernel is booting, 
> before any userspace stuff has started up.  Maybe hald is just being a bit 
> aggressive in re-probing the drive after userspace launches.  B all accounts 
> after a week of uptime the drive certainly ought to be ready, it seems to work 
> ok ;-)
> 
> Note the extra space after 'Device' and 'not' which implies possibly some text 
> is missing (which would have made it more clear which device is not exactly 
> ready).  The case sensitive strings "Device" and "not ready" appears together 
> in scsi_lib.c and very few other places.

OK, it'll be this:

		case NOT_READY:
			/*
			 * If the device is in the process of becoming ready,
			 * retry.
			 */
			if (sshdr.asc == 0x04 && sshdr.ascq == 0x01) {
				scsi_requeue_command(q, cmd);
				return;
			}
			printk(KERN_INFO "Device %s not ready.\n",
			       req->rq_disk ? req->rq_disk->disk_name : "");

Where the disk name is evaluating to an empty string.

Maybe you could stick a dump_stack() in there, get some additional info.

Anyway, over to you, James ;)

> > Is the device actually "not ready", or is it in reality ready and working? 
> > ie: what happens if you stick a CD in it?
> 
> The CD can be read, and the error messages go away.  They stay away even after 
> the CD has been ejected.

