Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbVKHRD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVKHRD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVKHRD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:03:26 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:29613 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030258AbVKHRDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:03:25 -0500
Subject: RE: oops with USB Storage on 2.6.14
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "goggin, edward" <egoggin@emc.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, Masanari Iida <standby24x7@gmail.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org
In-Reply-To: <C2EEB4E538D3DC48BF57F391F422779321ADBA@srmanning.eng.emc.com>
References: <C2EEB4E538D3DC48BF57F391F422779321ADBA@srmanning.eng.emc.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 12:01:45 -0500
Message-Id: <1131469305.3270.21.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 11:24 -0500, goggin, edward wrote:
> ! 	struct scsi_device *sdev = cmd->device;
> ! 	struct request_queue *q = sdev->request_queue;
> ! 
> ! 	// need to hold a reference on the device before we let go of the
> cmd
> ! 	if (scsi_device_get(sdev)) {
> ! 		scsi_put_command(cmd);
> ! 		return;		// maybe sdev_state == SDEV_CANCEL, SDEV_DEL
> ! 	}
>   
>   	scsi_put_command(cmd);
>   	scsi_run_queue(q);
> + 
> + 	// ok to remove device now
> + 	scsi_device_put(sdev);

This is the right idea, I think, but not necessarily the right fix.
scsi_device_get() will fail if the device is going offline, but we would
still need to run the queues.

try this sequence instead:

get_device(&sdev->sdev_gendev);
scsi_put_command(cmd);
scsi_run_queue(q);
put_device(&sdev->sdev_gendev);

James


