Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVIVNZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVIVNZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVIVNZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:25:23 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:2228 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030299AbVIVNZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:25:21 -0400
Message-ID: <030801c5bf79$114d3df0$ce677c0a@CARREN>
From: "Hironobu Ishii" <hishii@soft.fujitsu.com>
To: <minyard@mvista.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipmi_msghandler: inconsistent spin_lock usage
Date: Thu, 22 Sep 2005 22:24:27 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

I found a inconsistent spin_lock usage in ipmi_smi_msg_received.

Best regards,
  Hironobu Ishii

Signed-off-by: Hironobu Ishii <hishii@soft.fujitsu.com>
------
diff -urNp linux-2.6.14-rc1.org/drivers/char/ipmi/ipmi_msghandler.c linux-2.6.14-rc1/drivers/char/ipmi/ipmi_msghandler.c
--- linux-2.6.14-rc1.org/drivers/char/ipmi/ipmi_msghandler.c 2005-09-13 12:12:09.000000000 +0900
+++ linux-2.6.14-rc1/drivers/char/ipmi/ipmi_msghandler.c 2005-09-22 16:37:48.623052375 +0900
@@ -2620,7 +2620,7 @@ void ipmi_smi_msg_received(ipmi_smi_t   
  spin_lock_irqsave(&(intf->waiting_msgs_lock), flags);
  if (!list_empty(&(intf->waiting_msgs))) {
   list_add_tail(&(msg->link), &(intf->waiting_msgs));
-  spin_unlock(&(intf->waiting_msgs_lock));
+  spin_unlock_irqrestore(&(intf->waiting_msgs_lock), flags);
   goto out_unlock;
  }
  spin_unlock_irqrestore(&(intf->waiting_msgs_lock), flags);
@@ -2629,9 +2629,9 @@ void ipmi_smi_msg_received(ipmi_smi_t   
  if (rv > 0) {
   /* Could not handle the message now, just add it to a
                    list to handle later. */
-  spin_lock(&(intf->waiting_msgs_lock));
+  spin_lock_irqsave(&(intf->waiting_msgs_lock), flags);
   list_add_tail(&(msg->link), &(intf->waiting_msgs));
-  spin_unlock(&(intf->waiting_msgs_lock));
+  spin_unlock_irqrestore(&(intf->waiting_msgs_lock), flags);
  } else if (rv == 0) {
   ipmi_free_smi_msg(msg);
  }

