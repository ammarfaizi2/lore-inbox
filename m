Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbVIBSqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVIBSqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbVIBSqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:46:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61150 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750877AbVIBSqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:46:44 -0400
Date: Fri, 2 Sep 2005 19:46:42 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] dereference of uninitialized pointer in zatm
Message-ID: <20050902184642.GA5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing breakage from [NET]: Kill skb->list - original was
	assign vcc
	do a bunch of stuff using ZATM_VCC(vcc)->pool as common subexpression
Now we do
	int pos = ZATM_VCC(vcc)->pool;
	assign vcc
	do a bunch of stuff
even though vcc is not even initialized when we enter that block...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-uml-checker/drivers/atm/zatm.c RC13-zatm/drivers/atm/zatm.c
--- RC13-uml-checker/drivers/atm/zatm.c	2005-09-02 03:33:39.000000000 -0400
+++ RC13-zatm/drivers/atm/zatm.c	2005-09-02 03:34:19.000000000 -0400
@@ -417,9 +417,9 @@
 		chan = (here[3] & uPD98401_AAL5_CHAN) >>
 		    uPD98401_AAL5_CHAN_SHIFT;
 		if (chan < zatm_dev->chans && zatm_dev->rx_map[chan]) {
-			int pos = ZATM_VCC(vcc)->pool;
-
+			int pos;
 			vcc = zatm_dev->rx_map[chan];
+			pos = ZATM_VCC(vcc)->pool;
 			if (skb == zatm_dev->last_free[pos])
 				zatm_dev->last_free[pos] = NULL;
 			skb_unlink(skb, zatm_dev->pool + pos);
