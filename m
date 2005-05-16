Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVEPNyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVEPNyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVEPNyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:54:16 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:47767 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261646AbVEPNxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:53:44 -0400
Date: Mon, 16 May 2005 15:49:10 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk
Subject: [PATCH] serial_cs broken on 2.6.12-rc4/2.6.12-rc4-mm2
Message-ID: <20050516134910.GA8565@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  serial_cs's vendor/device identification got broken by Yum Rayan's
change '[PATCH] serial_cs: Reduce stack usage in serial_event()' - it
changed buf type from u_short* to char*, breaking device manufacturer
& card number retrieval.  Due to this my modem stopped from being
recognized as special case.

  Code will work much better if we'll rely on first_tuple's parser
instead of doing parse ourselves.  Code also looks simpler after
change.
					Thanks,
						Petr Vandrovec

Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>


Apply directly on top of RC4.  You'll have to redo my other serial_cs
changes you have in the tree so you end up with state in second patch
below after applying them...  I have no quilt exprience...

--- linux-2.6.12-rc4/drivers/serial/serial_cs.c	2005-05-07 04:21:33.000000000 +0200
+++ linux-2.6.12-rc4/drivers/serial/serial_cs.c	2005-05-16 15:34:27.000000000 +0200
@@ -661,10 +661,10 @@
 	/* Is this a multiport card? */
 	tuple->DesiredTuple = CISTPL_MANFID;
 	if (first_tuple(handle, tuple, parse) == CS_SUCCESS) {
-		info->manfid = le16_to_cpu(buf[0]);
+		info->manfid = parse->manfid.manf;
 		for (i = 0; i < MULTI_COUNT; i++)
 			if ((info->manfid == multi_id[i].manfid) &&
-			    (le16_to_cpu(buf[1]) == multi_id[i].prodid))
+			    (parse->manfid.card == multi_id[i].prodid))
 				break;
 		if (i < MULTI_COUNT)
 			info->multi = multi_id[i].multi;


Apply on top of MM2:
--- linux-2.6.12-rc4-mm2/drivers/serial/serial_cs.c	2005-05-16 13:19:29.000000000 +0200
+++ linux-2.6.12-rc4-mm2/drivers/serial/serial_cs.c	2005-05-16 13:28:08.000000000 +0200
@@ -700,8 +700,8 @@
 	/* Is this a multiport card? */
 	tuple->DesiredTuple = CISTPL_MANFID;
 	if (first_tuple(handle, tuple, parse) == CS_SUCCESS) {
-		info->manfid = le16_to_cpu(buf[0]);
-		info->prodid = le16_to_cpu(buf[1]);
+		info->manfid = parse->manfid.manf;
+		info->prodid = parse->manfid.card;
 		for (i = 0; i < MULTI_COUNT; i++)
 			if ((info->manfid == multi_id[i].manfid) &&
 			    (info->prodid == multi_id[i].prodid))
