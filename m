Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVGLLY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVGLLY3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVGLLY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:24:29 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:3895 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261335AbVGLLXv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:23:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cIeShPbf7gHgnmi3KxaNVA2bAkGno6lLRDOdyA2fk9cWjaf/n9M6Vp19SvJJu2cuO7Zcrt4KSkaJHr4uWp+GgSKNtAc1SX8rSSMvWdu7WNu2K38n0nUyyQeIj3H/RBKC8kouSZwW7/KfZNENkG+47GfvELlBqzieE0Is3b7kHUo=
Message-ID: <1ba727770507120422562d525d@mail.gmail.com>
Date: Tue, 12 Jul 2005 16:52:54 +0530
From: Amrut Joshi <amrut.joshi@gmail.com>
Reply-To: Amrut Joshi <amrut.joshi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SCSI luns
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently linux scsi subsystem doesnt store the 8-byte luns which are
recieved in REPORT_LUNS reply. This information is forver lost once
the scan is over. In my LDD  I need this information. Currently I have
to snoop REPORT_LUNS reply, do scsilun_to_int for all the luns and
store this mapping somewhere. This can be simplified by storing it in
scsi_device. This field will be meaningful only if sdev->scsi_level >=
SCSI_3.

Heres the patch
-----------------------------------------------------------------------------------------------------------------
--- drivers/scsi/scsi_scan.c.orig       2005-06-30 04:30:53.000000000 +0530
+++ drivers/scsi/scsi_scan.c    2005-07-12 16:19:48.533788528 +0530
@@ -1170,6 +1170,7 @@
                                       " aborted\n", devname, lun);
                                break;
                        }
+                        memcpy(sdev->lun_address, lunp,
sizeof(sdev->lun_address));
                }
        }

--- include/scsi/scsi_device.h.orig     2005-06-30 04:30:53.000000000 +0530
+++ include/scsi/scsi_device.h  2005-07-12 16:19:48.534788376 +0530
@@ -58,6 +58,8 @@
                                           could all be from the same event. */

        unsigned int id, lun, channel;
+        struct scsi_lun lun_address;    /* scsi address returned by REPORT_LUNS
+                                         * usable only if
sdev->scsi_lun >= SCSI_3 */

        unsigned int manufacturer;      /* Manufacturer of device, for using
                                         * vendor-specific cmd's */

----------------------------------------------------------------------------------------------------------------------

Please CC replies to me as I am not on the list.

Thanks,
-Amrut!
