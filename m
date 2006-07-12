Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWGLIQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWGLIQT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWGLIQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:16:19 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48802 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750816AbWGLIQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:16:16 -0400
Date: Wed, 12 Jul 2006 17:19:30 +0900
From: Sakurai Hiroomi <sakurai_hiro@soft.fujitsu.com>
X-Mailer: EdMax Ver2.85.5F
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Help: strange messages from kernel on IA64 platform
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060712081614.765261C013@mail2-sv.soft.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I saw same message.

When GAM(Global Array Manager) is started, The following message output.
kernel: kernel unaligned access to 0xe0000001fe1080d4, ip=0xa000000200053371

The uioc structure used by ioctl is defined by packed,
the allignment of each member are disturbed.
In a 64 bit structure, the allignment of member doesn't fit 64 bit
boundary. this causes this messages.
In a 32 bit structure, we don't see the message because the allinment
of member fit 32 bit boundary even if packed is specified. 

patch
I Add 32 bit dummy member to fit 64 bit boundary. I tested.
We confirmed this patch fix the problem by IA64 server.

******************************************************************************
--- linux-2.6.9/drivers/scsi/megaraid/megaraid_ioctl.h.orig	2006-04-03 17:13:03.000000000 +0900
+++ linux-2.6.9/drivers/scsi/megaraid/megaraid_ioctl.h	2006-04-03 17:14:09.000000000 +0900
@@ -132,6 +132,10 @@
 /* Driver Data: */
         void __user *           user_data;
         uint32_t                user_data_len;
+
+        /* 64bit alignment */
+        uint32_t                pad_0xBC;
+
         mraid_passthru_t        __user *user_pthru;
 
         mraid_passthru_t        *pthru32;
******************************************************************************

I'm not participated in the linux-scsi mailing list.
Please reply to the following addresses. 

    E-Mail : sakurai_hiro@soft.fujitsu.com


Best regards,
Hiroomi Sakurai


