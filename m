Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262135AbSJNSSO>; Mon, 14 Oct 2002 14:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262136AbSJNSSN>; Mon, 14 Oct 2002 14:18:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:10940 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262135AbSJNSSM>;
	Mon, 14 Oct 2002 14:18:12 -0400
Subject: [PATCH 2.5.42] aacraid code changes
From: Mark Haverkamp <markh@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Oct 2002 11:25:06 -0700
Message-Id: <1034619906.5419.34.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a couple changes to the aacraid code that I made to get the
module to load and run.   The change in aachba.c is a work around so I
could get the module to load.  The sc_request element is always NULL as
far as I can tell. I haven't yet found an alternate place to get the
rq_dev information.  With this change and the one to commctrl.c, I have
been able to get access to the drives and use them.

Mark.



diff -Nru base_linux-2.5/drivers/scsi/aacraid/aachba.c linux-2.5/drivers/scsi/aacraid/aachba.c
--- base_linux-2.5/drivers/scsi/aacraid/aachba.c	Mon Oct  7 13:03:15 2002
+++ linux-2.5/drivers/scsi/aacraid/aachba.c	Mon Oct 14 11:14:05 2002
@@ -1060,7 +1060,11 @@
 			 */
 			 
 			spin_unlock_irq(scsicmd->host->host_lock);
-			fsa_dev_ptr->devno[cid] = DEVICE_NR(scsicmd->sc_request->sr_request->rq_dev);
+		
+			if (scsicmd->sc_request != NULL) {
+				fsa_dev_ptr->devno[cid] = 
+					DEVICE_NR(scsicmd->sc_request->sr_request->rq_dev);
+			} 
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

