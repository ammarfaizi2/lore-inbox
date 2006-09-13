Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWIMSsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWIMSsZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWIMSsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:48:25 -0400
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:6117 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751106AbWIMSsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:48:24 -0400
Date: Wed, 13 Sep 2006 13:50:12 -0500
From: Corey Minyard <minyard@acm.org>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>
Subject: [PATCH] IPMI: fix handling of OEM flags
Message-ID: <20060913185012.GA13036@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If one of the OEM flags becomes set in the flags from the
hardware, the driver could hang if no OEM handler was set.
Fix the code to handle this.  This was tested by setting
the flags by hand after they were fetched.

Signed-off-by: Corey Minyard <minyard@acm.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>

Index: linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.17.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.17/drivers/char/ipmi/ipmi_si_intf.c
@@ -403,10 +403,10 @@ static void handle_flags(struct smi_info
 			smi_info->curr_msg->data,
 			smi_info->curr_msg->data_size);
 		smi_info->si_state = SI_GETTING_EVENTS;
-	} else if (smi_info->msg_flags & OEM_DATA_AVAIL) {
-		if (smi_info->oem_data_avail_handler)
-			if (smi_info->oem_data_avail_handler(smi_info))
-				goto retry;
+	} else if (smi_info->msg_flags & OEM_DATA_AVAIL &&
+	           smi_info->oem_data_avail_handler) {
+		if (smi_info->oem_data_avail_handler(smi_info))
+			goto retry;
 	} else {
 		smi_info->si_state = SI_NORMAL;
 	}
