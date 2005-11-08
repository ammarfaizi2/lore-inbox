Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965239AbVKHSFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965239AbVKHSFP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbVKHSFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:05:14 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:63599 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S965239AbVKHSFN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:05:13 -0500
Message-ID: <C2EEB4E538D3DC48BF57F391F422779321ADBE@srmanning.eng.emc.com>
From: "goggin, edward" <egoggin@emc.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "goggin, edward" <egoggin@emc.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, Masanari Iida <standby24x7@gmail.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org
Subject: RE: oops with USB Storage on 2.6.14
Date: Tue, 8 Nov 2005 13:02:45 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.11.8.18
X-PerlMx-Spam: Gauge=, SPAM=1%, Reasons='EMC_FROM_00+ -3, __CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __IMS_MSGID 0, __IMS_MUA 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good point.

I tested your suggested patch fix and it works well in my test use case.

BTW, I've got test code in my just tested version of your patch to read the
kref of the sdev_gendev between the calls to scsi_run_queue and
put_device to increase the likelihood that the use case has actually
been tested.

> -----Original Message-----
> From: James Bottomley [mailto:James.Bottomley@SteelEye.com] 
> Sent: Tuesday, November 08, 2005 12:02 PM
> To: goggin, edward
> Cc: 'Andrew Morton'; Masanari Iida; 
> linux-kernel@vger.kernel.org; 
> linux-usb-devel@lists.sourceforge.net; linux-scsi@vger.kernel.org
> Subject: RE: oops with USB Storage on 2.6.14
> 
> On Tue, 2005-11-08 at 11:24 -0500, goggin, edward wrote:
> > ! 	struct scsi_device *sdev = cmd->device;
> > ! 	struct request_queue *q = sdev->request_queue;
> > ! 
> > ! 	// need to hold a reference on the device before we let 
> go of the
> > cmd
> > ! 	if (scsi_device_get(sdev)) {
> > ! 		scsi_put_command(cmd);
> > ! 		return;		// maybe sdev_state == 
> SDEV_CANCEL, SDEV_DEL
> > ! 	}
> >   
> >   	scsi_put_command(cmd);
> >   	scsi_run_queue(q);
> > + 
> > + 	// ok to remove device now
> > + 	scsi_device_put(sdev);
> 
> This is the right idea, I think, but not necessarily the right fix.
> scsi_device_get() will fail if the device is going offline, 
> but we would
> still need to run the queues.
> 
> try this sequence instead:
> 
> get_device(&sdev->sdev_gendev);
> scsi_put_command(cmd);
> scsi_run_queue(q);
> put_device(&sdev->sdev_gendev);
> 
> James
> 
> 
