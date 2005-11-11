Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVKKLyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVKKLyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 06:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVKKLyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 06:54:13 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:41381 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750736AbVKKLyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 06:54:11 -0500
Message-ID: <031001c5e6b6$9de0d100$c8a0220a@CARREN>
From: "Hironobu Ishii" <hishii@soft.fujitsu.com>
To: "Corey Minyard" <minyard@acm.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.14-git13] ipmi: inconsistent spin_lock in ipmi_smi_msg_received
Date: Fri, 11 Nov 2005 20:52:45 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0306_01C5E701.DE2E0A70"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0306_01C5E701.DE2E0A70
Content-Type: text/plain;
	format=flowed;
	charset="iso-2022-jp";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Corey,

You revert a patch by mistake in the following patch 
      > Date Fri, 21 Oct 2005 09:49:09 -0500 
      > From Corey Minyard <> 
      > Subject [PATCH 1/9] ipmi: use refcount in message handler 

 (http://lkml.org/lkml/2005/10/21/85)


Signed-off-by: Hironobu Ishii <hishii@soft.fujitsu.com>


------=_NextPart_000_0306_01C5E701.DE2E0A70
Content-Type: text/plain;
	format=flowed;
	name="ipmi_trivial.txt";
	reply-type=original
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ipmi_trivial.txt"

diff -urNp linux-2.6.14-git13/drivers/char/ipmi/ipmi_msghandler.c =
linux-2.6.14-git13.modified/drivers/char/ipmi/ipmi_msghandler.c=0A=
--- linux-2.6.14-git13/drivers/char/ipmi/ipmi_msghandler.c	2005-11-11 =
10:50:37.000000000 +0900=0A=
+++ linux-2.6.14-git13.modified/drivers/char/ipmi/ipmi_msghandler.c	=
2005-11-11 19:53:21.000000000 +0900=0A=
@@ -2648,7 +2648,7 @@ void ipmi_smi_msg_received(ipmi_smi_t   =0A=
 	spin_lock_irqsave(&intf->waiting_msgs_lock, flags);=0A=
 	if (!list_empty(&intf->waiting_msgs)) {=0A=
 		list_add_tail(&msg->link, &intf->waiting_msgs);=0A=
-		spin_unlock(&intf->waiting_msgs_lock);=0A=
+		spin_unlock_irqrestore(&intf->waiting_msgs_lock, flags);=0A=
 		goto out;=0A=
 	}=0A=
 	spin_unlock_irqrestore(&intf->waiting_msgs_lock, flags);=0A=
@@ -2657,9 +2657,9 @@ void ipmi_smi_msg_received(ipmi_smi_t   =0A=
 	if (rv > 0) {=0A=
 		/* Could not handle the message now, just add it to a=0A=
                    list to handle later. */=0A=
-		spin_lock(&intf->waiting_msgs_lock);=0A=
+		spin_lock_irqsave(&intf->waiting_msgs_lock, flags);=0A=
 		list_add_tail(&msg->link, &intf->waiting_msgs);=0A=
-		spin_unlock(&intf->waiting_msgs_lock);=0A=
+		spin_unlock_irqrestore(&intf->waiting_msgs_lock, flags);=0A=
 	} else if (rv =3D=3D 0) {=0A=
 		ipmi_free_smi_msg(msg);=0A=
 	}=0A=

------=_NextPart_000_0306_01C5E701.DE2E0A70--

