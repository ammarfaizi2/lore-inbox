Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVE3SUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVE3SUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVE3SUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:20:47 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:36061 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261670AbVE3SRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:17:37 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: =?ISO-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050530160147.GD14351@gmail.com>
References: <20050521232220.GD28654@gmail.com>
	 <1116770040.5002.13.camel@mulgrave> <20050524153930.GA10911@gmail.com>
	 <1117113563.4967.17.camel@mulgrave> <20050526143516.GA9593@gmail.com>
	 <1117118766.4967.22.camel@mulgrave> <20050526173518.GA9132@gmail.com>
	 <1117463938.4913.3.camel@mulgrave> <20050530150950.GA14351@gmail.com>
	 <1117467248.4913.9.camel@mulgrave>  <20050530160147.GD14351@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 30 May 2005 13:17:20 -0500
Message-Id: <1117477040.4913.12.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 18:01 +0200, Grégoire Favre wrote:
>  target1:0:1: Beginning Domain Validation
>  target1:0:1: Domain Validation skipping write tests
> (scsi1:A:1): 10.000MB/s transfers (10.000MHz, offset 15)
>  target1:0:1: Ending Domain Validation

Well that's good ... it proves the theory that if the DV were correctly
limited initially, everything would work.

However ... lets see if we can get it to work properly even with the
initial mismatch.  Reverse the previous patch, apply this one and try
rebooting ...

Thanks,

James

--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1230,6 +1230,9 @@ static void scsi_eh_offline_sdevs(struct
 				scmd->device->channel,
 				scmd->device->id,
 				scmd->device->lun);
+		/* try to reset the bus and the card to a sane state */
+		scsi_try_bus_reset(scmd);
+		scsi_try_host_reset(scmd);
 		scsi_device_set_state(scmd->device, SDEV_OFFLINE);
 		if (scsi_eh_eflags_chk(scmd, SCSI_EH_CANCEL_CMD)) {
 			/*


