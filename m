Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbSJNV0P>; Mon, 14 Oct 2002 17:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262195AbSJNV0O>; Mon, 14 Oct 2002 17:26:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28056 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262194AbSJNVZw>;
	Mon, 14 Oct 2002 17:25:52 -0400
Subject: Re: [PATCH 2.5.42] aacraid code changes
From: Mark Haverkamp <markh@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1034619906.5419.34.camel@markh1.pdx.osdl.net>
References: <1034619906.5419.34.camel@markh1.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Oct 2002 14:32:46 -0700
Message-Id: <1034631166.23163.5.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found a source for the rq_dev element elsewhere in the Scsi_Cmnd
structure.  This patch contains a replacement for the one I sent
earlier.

Mark.

diff -Nru  base_linux-2.5/drivers/scsi/aacraid/aachba.c linux-2.5/drivers/scsi/aacraid/aachba.c
--- base_linux-2.5/drivers/scsi/aacraid/aachba.c	Mon Oct  7 13:03:15 2002
+++ linux-2.5/drivers/scsi/aacraid/aachba.c	Mon Oct 14 14:24:16 2002
@@ -1060,7 +1060,8 @@
 			 */
 			 
 			spin_unlock_irq(scsicmd->host->host_lock);
-			fsa_dev_ptr->devno[cid] = DEVICE_NR(scsicmd->sc_request->sr_request->rq_dev);
+			fsa_dev_ptr->devno[cid] = 
+					DEVICE_NR(scsicmd->request->rq_dev);
 			ret = aac_read(scsicmd, cid);
 			spin_lock_irq(scsicmd->host->host_lock);
 			return ret;
diff -Nru base_linux-2.5/drivers/scsi/aacraid/commctrl.c linux-2.5/drivers/scsi/aacraid/commctrl.c
--- base_linux-2.5/drivers/scsi/aacraid/commctrl.c	Mon Oct  7 13:03:15 2002
+++ linux-2.5/drivers/scsi/aacraid/commctrl.c	Mon Oct 14 10:35:04 2002
@@ -424,7 +424,12 @@
 		status = aac_get_pci_info(dev,arg);
 		break;
 	default:
-		status = -ENOTTY;
+		/*
+		 * Return EINVAL instead of ENOTTY because blkdev_ioctl 
+		 * understands the EINVAL return code to mean that the
+		 * ioctl wasn't handled and blk_ioctl should be called.
+		 */
+		status = -EINVAL;
 	  	break;	
 	}
 	return status;


