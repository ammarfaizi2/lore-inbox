Return-Path: <linux-kernel-owner+w=401wt.eu-S1751109AbXAFCni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbXAFCni (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbXAFC23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:28:29 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47953 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbXAFC14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:27:56 -0500
Message-Id: <20070106023159.171784000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:09 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, jens.axboe@oracle.com,
       dougg@torque.net, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Tejun Heo <htejun@gmail.com>
Subject: [patch 16/50] SCSI: add missing cdb clearing in scsi_execute()
Content-Disposition: inline; filename=scsi-add-missing-cdb-clearing-in-scsi_execute.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Tejun Heo <htejun@gmail.com>

Clear-garbage-after-CDB patch missed scsi_execute() and it causes some
ODDs (HL-DT-ST DVD-RAM GSA-H30N) choke during SCSI scan.  Note that
this patch is only for -stable.  There is another more reliable fix
for this problem proposed for devel tree.

http://thread.gmane.org/gmane.linux.ide/14605/focus=14605

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jens Axboe <jens.axboe@oracle.com>
Cc: Douglas Gilbert <dougg@torque.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/scsi/scsi_lib.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.19.1.orig/drivers/scsi/scsi_lib.c
+++ linux-2.6.19.1/drivers/scsi/scsi_lib.c
@@ -191,6 +191,7 @@ int scsi_execute(struct scsi_device *sde
 		goto out;
 
 	req->cmd_len = COMMAND_SIZE(cmd[0]);
+	memset(req->cmd, 0, BLK_MAX_CDB); /* ATAPI hates garbage after CDB */
 	memcpy(req->cmd, cmd, req->cmd_len);
 	req->sense = sense;
 	req->sense_len = 0;

--
