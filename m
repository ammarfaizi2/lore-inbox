Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWDDTZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWDDTZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWDDTZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:25:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:4576 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750819AbWDDTZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:25:21 -0400
X-Authenticated: #704063
Subject: [Patch] Possible double free in net/bluetooth/sco.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: maxk@qualcomm.com
Content-Type: text/plain
Date: Tue, 04 Apr 2006 21:25:18 +0200
Message-Id: <1144178718.12132.4.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixes coverity bug id #1068. 
hci_send_sco() frees skb if (skb->len > hdev->sco_mtu).
Since it returns a negative error value only in this case, we
can directly return here.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1/net/bluetooth/sco.c.orig	2006-04-04 21:19:51.000000000 +0200
+++ linux-2.6.17-rc1/net/bluetooth/sco.c	2006-04-04 21:20:34.000000000 +0200
@@ -255,7 +255,7 @@ static inline int sco_send_frame(struct 
 	}
 
 	if ((err = hci_send_sco(conn->hcon, skb)) < 0)
-		goto fail;
+		return err;
 
 	return count;
 


