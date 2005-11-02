Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965301AbVKBWIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbVKBWIo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965304AbVKBWIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:08:44 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:52860 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965301AbVKBWIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:08:43 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH/RFC v2] IB: Add SCSI RDMA Protocol (SRP) initiator
X-Message-Flag: Warning: May contain useful information
References: <52r79y91jz.fsf_-_@cisco.com>
	<20051102220358.GA27132@mellanox.co.il>
From: Roland Dreier <rolandd@cisco.com>
Date: Wed, 02 Nov 2005 14:08:35 -0800
In-Reply-To: <20051102220358.GA27132@mellanox.co.il> (Michael S. Tsirkin's
 message of "Thu, 3 Nov 2005 00:03:58 +0200")
Message-ID: <52irva8zz0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 02 Nov 2005 22:08:37.0079 (UTC) FILETIME=[F9352E70:01C5DFF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I replaced the function with:

+static int srp_init_qp(struct srp_target_port *target,
+		       struct ib_qp *qp)
+{
+	struct ib_qp_attr *attr;
+	int ret;
+
+	attr = kmalloc(sizeof *attr, GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	ret = ib_find_cached_pkey(target->srp_host->dev,
+				  target->srp_host->port,
+				  be16_to_cpu(target->path.pkey),
+				  &attr->pkey_index);
+	if (ret)
+		goto out;
+
+	attr->qp_state        = IB_QPS_INIT;
+	attr->qp_access_flags = (IB_ACCESS_REMOTE_READ |
+				    IB_ACCESS_REMOTE_WRITE);
+	attr->port_num        = target->srp_host->port;
+
+	ret = ib_modify_qp(qp, attr,
+			   IB_QP_STATE		|
+			   IB_QP_PKEY_INDEX	|
+			   IB_QP_ACCESS_FLAGS	|
+			   IB_QP_PORT);
+
+out:
+	kfree(attr);
+	return ret;
+}
