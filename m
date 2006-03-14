Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWCNLM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWCNLM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 06:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWCNLM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 06:12:57 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:15119 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751211AbWCNLM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 06:12:57 -0500
Date: Tue, 14 Mar 2006 12:12:48 +0100
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
       maxk@qualcomm.com, bluez-devel@lists.sourceforge.net
Subject: [PATCH] Fix SCO on Broadcom Bluetooth adapters
Message-ID: <20060314111248.GA75477@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>, marcel@holtmann.org,
	maxk@qualcomm.com, bluez-devel@lists.sf.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcom USB Bluetooth adapters report a maximum of zero SCO packets
in-flight, killing SCO.  Use a reasonable count instead in that case.

Signed-off-by: Olivier Galibert <galibert@pobox.com>

---

I don't think that could be reasonably done as a quirk.  Simple
examination of the .inf coming with the windows driver shows that 100+
different models may be having this problem.  Also, it can't break
already working adapters, so why bother.

 net/bluetooth/hci_event.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -324,6 +324,13 @@ static void hci_cc_info_param(struct hci
 		hdev->acl_pkts = hdev->acl_cnt = __le16_to_cpu(bs->acl_max_pkt);
 		hdev->sco_pkts = hdev->sco_cnt = __le16_to_cpu(bs->sco_max_pkt);
 
+		/* Some buggy USB bluetooth adapters, Broadcom in
+		   particular, answer zero as the max number of sco
+		   packets in flight.  Use a reasonable value
+		   instead */
+		if (hdev->sco_pkts == 0)
+			hdev->sco_pkts = hdev->sco_cnt = 8
+
 		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
 			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);
 		break;
