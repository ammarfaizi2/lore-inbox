Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWIOMnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWIOMnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 08:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWIOMnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 08:43:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:3342 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751347AbWIOMnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 08:43:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VCKZnDQausNVdLbGd94Puu8UdzyvxU0YLSg5IFH/Z1zdjFZ2Tuq5zi0rZVCuFUaLF7maQM2iPwAEezxYPYuJBGEYsq/+PUAnMD64wSmHZm6m2UccVd/BsnGMh65I6REyDQgOUzFWKatPUl8SEkk1/BGPY3wy2d/Pkk2s8L6GR2U=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SCSI: Make megaraid_ioctl() check copy_to_user() return value
Date: Fri, 15 Sep 2006 14:43:11 +0200
User-Agent: KMail/1.9.4
Cc: Seokmann Ju <Seokmann.Ju@lsil.com>,
       Neela Syam Kolli <Neela.Kolli@engenio.com>, linux-scsi@vger.kernel.org,
       akpm@osdl.org, James.Bottomley@steeleye.com, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609151443.12941.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Check copy_to_user() return value in drivers/scsi/megaraid.c::megadev_ioctl()
This gets rid of this little warning:
  drivers/scsi/megaraid.c:3661: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/scsi/megaraid.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc7-git1-orig/drivers/scsi/megaraid.c	2006-09-15 13:51:15.121774000 +0200
+++ linux-2.6.18-rc7-git1/drivers/scsi/megaraid.c	2006-09-15 14:27:32.377407763 +0200
@@ -3658,8 +3658,9 @@ megadev_ioctl(struct inode *inode, struc
 			 * Send the request sense data also, irrespective of
 			 * whether the user has asked for it or not.
 			 */
-			copy_to_user(upthru->reqsensearea,
-					pthru->reqsensearea, 14);
+			if (copy_to_user(upthru->reqsensearea,
+					pthru->reqsensearea, 14))
+				rval = -EFAULT;
 
 freemem_and_return:
 			if( pthru->dataxferlen ) {



