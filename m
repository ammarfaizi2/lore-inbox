Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWELXpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWELXpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWELXot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:49 -0400
Received: from mx.pathscale.com ([64.160.42.68]:62121 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932282AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 39 of 53] ipath - count PE800 receive interrupts on user ports
X-Mercurial-Node: 5b565c24d62ad0e355aeab94362107c15acb9e7f
Message-Id: <5b565c24d62ad0e355ae.1147477404@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:24 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed so it works on the PE-800.  It had not previously been updated to
match PE-800 receive interrupt differences from HT-400.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r e9306861dc6a -r 5b565c24d62a drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri May 12 15:55:28 2006 -0700
@@ -1172,6 +1172,10 @@ static unsigned int ipath_poll(struct fi
 
 	if (tail == head) {
 		set_bit(IPATH_PORT_WAITING_RCV, &pd->port_flag);
+		if(dd->ipath_rhdrhead_intr_off) /* arm rcv interrupt */
+			(void)ipath_write_ureg(dd, ur_rcvhdrhead,
+					       dd->ipath_rhdrhead_intr_off
+					       | head, pd->port_port);
 		poll_wait(fp, &pd->port_wait, pt);
 
 		if (test_bit(IPATH_PORT_WAITING_RCV, &pd->port_flag)) {
