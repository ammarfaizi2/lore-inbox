Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVA2Oqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVA2Oqe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 09:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVA2Oqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 09:46:33 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:5838 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262796AbVA2Oq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 09:46:28 -0500
Subject: Re: Ooops unmounting a defect DVD
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 08:46:16 -0600
Message-Id: <1107009976.4535.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wouldn't have noticed this at all since you didn't send it to the scsi
list, but fortunately, Al Viro drew it politely to my attention as
another example of SCSI refcounting problems.

The issue seems to be that we have a spurious scsi_cd_put() on the error
path of sr_open().  The sr_block_..() functions are the "real" block
opens and should be refcounted, the sr_...() are the pseudo cdrom opens
and should not be refcounted.

Could you try this and see if it fixes the problem?

James

===== drivers/scsi/sr.c 1.124 vs edited =====
--- 1.124/drivers/scsi/sr.c	2005-01-29 08:30:34 -06:00
+++ edited/drivers/scsi/sr.c	2005-01-29 08:39:09 -06:00
@@ -544,7 +544,6 @@
 	return 0;
 
 error_out:
-	scsi_cd_put(cd);
 	return retval;	
 }
 


