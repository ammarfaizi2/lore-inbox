Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758361AbWK2WFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361AbWK2WFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758302AbWK2WEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:04:42 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:6613 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758295AbWK2WEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:04:33 -0500
Message-Id: <20061129220638.365194000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:31 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, maks@sternwelten.at,
       "David S. Miller" <davem@davemloft.net>
Subject: [patch 20/23] BLUETOOTH: Fix unaligned access in hci_send_to_sock.
Content-Disposition: inline; filename=bluetooth-fix-unaligned-access-in-hci_send_to_sock.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David S. Miller <davem@davemloft.net>

The "u16 *" derefs of skb->data need to be wrapped inside of
a get_unaligned().

Thanks to Gustavo Zacarias for the bug report.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/bluetooth/hci_sock.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- linux-2.6.18.4.orig/net/bluetooth/hci_sock.c
+++ linux-2.6.18.4/net/bluetooth/hci_sock.c
@@ -120,10 +120,13 @@ void hci_send_to_sock(struct hci_dev *hd
 			if (!hci_test_bit(evt, &flt->event_mask))
 				continue;
 
-			if (flt->opcode && ((evt == HCI_EV_CMD_COMPLETE && 
-					flt->opcode != *(__u16 *)(skb->data + 3)) ||
-					(evt == HCI_EV_CMD_STATUS && 
-					flt->opcode != *(__u16 *)(skb->data + 4))))
+			if (flt->opcode &&
+			    ((evt == HCI_EV_CMD_COMPLETE &&
+			      flt->opcode !=
+			      get_unaligned((__u16 *)(skb->data + 3))) ||
+			     (evt == HCI_EV_CMD_STATUS &&
+			      flt->opcode !=
+			      get_unaligned((__u16 *)(skb->data + 4)))))
 				continue;
 		}
 

--
