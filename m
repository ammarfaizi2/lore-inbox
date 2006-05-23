Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWEWSeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWEWSeB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWEWSdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:33:45 -0400
Received: from mx.pathscale.com ([64.160.42.68]:7863 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751211AbWEWSdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:33:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 10] ipath - enable PE800 receive interrupts on user ports
X-Mercurial-Node: 8d87788e21b1800f357f970cbf6cd738f0d03ec8
Message-Id: <8d87788e21b1800f357f.1148409155@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1148409148@eng-12.pathscale.com>
Date: Tue, 23 May 2006 11:32:35 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed so it works on the PE-800.  It had not previously been updated to
match PE-800 receive interrupt differences from HT-400.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 5d7e365286b3 -r 8d87788e21b1 drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Tue May 23 11:29:16 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Tue May 23 11:29:16 2006 -0700
@@ -1224,6 +1224,10 @@ static unsigned int ipath_poll(struct fi
 
 	if (tail == head) {
 		set_bit(IPATH_PORT_WAITING_RCV, &pd->port_flag);
+		if(dd->ipath_rhdrhead_intr_off) /* arm rcv interrupt */
+			(void)ipath_write_ureg(dd, ur_rcvhdrhead,
+					       dd->ipath_rhdrhead_intr_off
+					       | head, pd->port_port);
 		poll_wait(fp, &pd->port_wait, pt);
 
 		if (test_bit(IPATH_PORT_WAITING_RCV, &pd->port_flag)) {
