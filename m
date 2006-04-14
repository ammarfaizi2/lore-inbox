Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWDNXPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWDNXPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 19:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWDNXPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 19:15:48 -0400
Received: from modeemi.modeemi.cs.tut.fi ([130.230.72.134]:39098 "EHLO
	modeemi.modeemi.cs.tut.fi") by vger.kernel.org with ESMTP
	id S1751441AbWDNXPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 19:15:48 -0400
Date: Sat, 15 Apr 2006 02:15:41 +0300
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] Open IPMI BT overflow
Message-ID: <20060414231541.GR3988@jolt.modeemi.cs.tut.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: shd@jolt.modeemi.cs.tut.fi (Heikki Orsila)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

I was looking into random driver code and found a suspicious looking 
memcpy() in drivers/char/ipmi/ipmi_bt_sm.c on 2.6.17-rc1:

	if ((size < 2) || (size > IPMI_MAX_MSG_LENGTH))
		return -1;
	...
	memcpy(bt->write_data + 3, data + 1, size - 1);

where sizeof bt->write_data is IPMI_MAX_MSG_LENGTH. It looks like the 
memcpy would overflow by 2 bytes if size == IPMI_MAX_MSG_LENGTH. A patch 
attached to limit size to (IPMI_MAX_LENGTH - 2). I'm unfamiliar with the 
driver and interface so it's very possible I'm wrong.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="ipmi_bt_sm-overflow.diff"

diff -urp linux-2.6.17-rc1-org/drivers/char/ipmi/ipmi_bt_sm.c linux-2.6.17-rc1/drivers/char/ipmi/ipmi_bt_sm.c
--- linux-2.6.17-rc1-org/drivers/char/ipmi/ipmi_bt_sm.c	2006-04-03 06:22:10.000000000 +0300
+++ linux-2.6.17-rc1/drivers/char/ipmi/ipmi_bt_sm.c	2006-04-15 02:05:29.000000000 +0300
@@ -165,7 +165,7 @@ static int bt_start_transaction(struct s
 {
 	unsigned int i;
 
-	if ((size < 2) || (size > IPMI_MAX_MSG_LENGTH))
+	if ((size < 2) || (size > (IPMI_MAX_MSG_LENGTH - 2)))
 	       return -1;
 
 	if ((bt->state != BT_STATE_IDLE) && (bt->state != BT_STATE_HOSED))

--wxDdMuZNg1r63Hyj--
