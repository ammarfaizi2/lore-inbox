Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbTCMSjd>; Thu, 13 Mar 2003 13:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbTCMSjd>; Thu, 13 Mar 2003 13:39:33 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:32676 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262490AbTCMSjc>;
	Thu, 13 Mar 2003 13:39:32 -0500
Date: Thu, 13 Mar 2003 21:49:27 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.4] Memleak in drivers/scsi/cpqfcTSinit.c::cpqfcTS_ioctl()
Message-ID: <20030313184927.GA2423@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is a trivial memleak in drivers/scsi/cpqfcTSinit.c::cpqfcTS_ioctl()
   on error exit paths if copy_to/from_user fails, see the patch below.
   Found with help of smatch + enhanced unfree script.

Bye,
    Oleg

===== drivers/scsi/cpqfcTSinit.c 1.14 vs edited =====
--- 1.14/drivers/scsi/cpqfcTSinit.c	Tue Dec 17 16:18:20 2002
+++ edited/drivers/scsi/cpqfcTSinit.c	Thu Mar 13 21:45:20 2003
@@ -467,8 +467,10 @@
 				// Need data from user?
 				// make sure caller's buffer is in kernel space.
 				if ((vendor_cmd->rw_flag == VENDOR_WRITE_OPCODE) && vendor_cmd->len)
-					if (copy_from_user(buf, vendor_cmd->bufp, vendor_cmd->len))
+					if (copy_from_user(buf, vendor_cmd->bufp, vendor_cmd->len)) {
+						kfree(buf);
 						return (-EFAULT);
+					}
 
 				// copy the CDB (if/when MAX_COMMAND_SIZE is 16, remove copy below)
 				memcpy(&ScsiPassThruCmnd->cmnd[0], &vendor_cmd->cdb[0], MAX_COMMAND_SIZE);
@@ -533,7 +535,7 @@
 				// need to pass data back to user (space)?
 				if ((vendor_cmd->rw_flag == VENDOR_READ_OPCODE) && vendor_cmd->len)
 					if (copy_to_user(vendor_cmd->bufp, buf, vendor_cmd->len))
-						return (-EFAULT);
+						result = -EFAULT;
 
 				if (buf)
 					kfree(buf);
