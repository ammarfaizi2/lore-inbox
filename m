Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbVHIQzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVHIQzs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbVHIQzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:55:47 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:41864 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S964879AbVHIQzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:55:46 -0400
Subject: Re: [Bugme-new] [Bug 5003] New: Problem with symbios
	driver	on	recent	-mm trees
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       bugme-daemon@kernel-bugs.osdl.org
In-Reply-To: <531000000.1123599581@[10.10.2.4]>
References: <135040000.1123216397@[10.10.2.4]>
	 <20050804233927.2d3abb16.akpm@osdl.org> <1123251892.5003.6.camel@mulgrave>
	 <179280000.1123252564@[10.10.2.4]> <1123254086.5003.10.camel@mulgrave>
	 <453380000.1123562466@[10.10.2.4]> <1123597604.5170.10.camel@mulgrave>
	 <531000000.1123599581@[10.10.2.4]>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 11:55:36 -0500
Message-Id: <1123606536.5170.27.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 07:59 -0700, Martin J. Bligh wrote:
> Dear novice test examiner,
> 
> It's in http://test.kernel.org with everything else ;-)
> 2.6.13-rc4-mm1+jejb_fix ... drills down to:
> 
> http://test.kernel.org/10080/debug/console.log

Well, OK, apparently some novice coder made an error converting from a
stack allocated buffer to a kmalloc'd one in the sense handling
routines.

I think this patch should fix it (or at least restore it to the level of
bugginess it had before).

James

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -342,12 +342,12 @@ int scsi_execute_req(struct scsi_device 
 		sense = kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
 		if (!sense)
 			return DRIVER_ERROR << 24;
-		memset(sense, 0, sizeof(*sense));
+		memset(sense, 0, SCSI_SENSE_BUFFERSIZE);
 	}
 	result = scsi_execute(sdev, cmd, data_direction, buffer, bufflen,
 				  sense, timeout, retries, 0);
 	if (sshdr)
-		scsi_normalize_sense(sense, sizeof(*sense), sshdr);
+		scsi_normalize_sense(sense, SCSI_SENSE_BUFFERSIZE, sshdr);
 
 	kfree(sense);
 	return result;


