Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422773AbWHYS1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422773AbWHYS1L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422778AbWHYSZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:37 -0400
Received: from mx.pathscale.com ([64.160.42.68]:45186 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422773AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 21 of 23] IB/ipath - fix return value from ipath_poll
X-Mercurial-Node: 1f9c75c844a96aa8f1e376e85883c54365d8b737
Message-Id: <1f9c75c844a96aa8f1e3.1156530286@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:46 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This stops the generic poll code from waiting for a timeout.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_file_ops.c b/drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri Aug 25 11:19:45 2006 -0700
@@ -1150,6 +1150,7 @@ static unsigned int ipath_poll(struct fi
 	struct ipath_portdata *pd;
 	u32 head, tail;
 	int bit;
+	unsigned pollflag = 0;
 	struct ipath_devdata *dd;
 
 	pd = port_fp(fp);
@@ -1186,9 +1187,12 @@ static unsigned int ipath_poll(struct fi
 			clear_bit(IPATH_PORT_WAITING_RCV, &pd->port_flag);
 			pd->port_rcvwait_to++;
 		}
+		else
+			pollflag = POLLIN | POLLRDNORM;
 	}
 	else {
 		/* it's already happened; don't do wait_event overhead */
+		pollflag = POLLIN | POLLRDNORM;
 		pd->port_rcvnowait++;
 	}
 
@@ -1196,7 +1200,7 @@ static unsigned int ipath_poll(struct fi
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
 			 dd->ipath_rcvctrl);
 
-	return 0;
+	return pollflag;
 }
 
 static int try_alloc_port(struct ipath_devdata *dd, int port,
