Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264196AbRFLGGZ>; Tue, 12 Jun 2001 02:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264205AbRFLGGQ>; Tue, 12 Jun 2001 02:06:16 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:17659 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S264196AbRFLGGB>; Tue, 12 Jun 2001 02:06:01 -0400
Message-Id: <200106120605.f5C65f402129@smtp1.Stanford.EDU>
Content-Type: text/plain; charset=US-ASCII
From: Praveen Srinivasan <praveens@stanford.edu>
Organization: Stanford University
To: linux-kernel@vger.kernel.org
Subject: [PATCH] megaraid.c
Date: Mon, 11 Jun 2001 23:05:46 -0700
X-Mailer: KMail [version 1.2.2]
Cc: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch fixes an instance where an allocation is checked, but only after 
the pointer is memset() - moving the memset further down in the function 
fixes this.

Praveen Srinivasan

--- ../linux-fresh/./drivers/scsi/megaraid.c    Fri Apr 27 13:59:18 2001
+++ ./drivers/scsi/megaraid.c   Wed May 23 12:31:01 2001
@@ -4115,7 +4115,7 @@
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)        /* 0x020400 */
                scsicmd = (Scsi_Cmnd *) kmalloc (sizeof (Scsi_Cmnd),
                                                 GFP_KERNEL | GFP_DMA);
-               memset (scsicmd, 0, sizeof (Scsi_Cmnd));
+
 #else
                scsicmd = (Scsi_Cmnd *) scsi_init_malloc (sizeof (Scsi_Cmnd),
                                                          GFP_ATOMIC | 
GFP_DMA);
@@ -4127,6 +4127,9 @@
                        return -ENOMEM;
                }
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0) /* 0x020400 */
+               memset (scsicmd, 0, sizeof (Scsi_Cmnd));
+#endif
                scsicmd->host = NULL;
 
                /*
