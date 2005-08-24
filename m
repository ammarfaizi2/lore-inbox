Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbVHXSW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbVHXSW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVHXSW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:22:58 -0400
Received: from pat.qlogic.com ([198.70.193.2]:52876 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S1751350AbVHXSW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:22:57 -0400
Date: Wed, 24 Aug 2005 11:22:52 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc7 qla2xxx unaligned accesses
Message-ID: <20050824182252.GC8205@plap.qlogic.org>
References: <13194.1124864517@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13194.1124864517@kao2.melbourne.sgi.com>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 24 Aug 2005 18:22:52.0908 (UTC) FILETIME=[D75632C0:01C5A8D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2005, Keith Owens wrote:

> 2.6.13-rc7 + kdb on ia64.  The qla2xxx drivers are getting unaligned
> accesses at startup.
> 
> qla2300 0000:01:02.0: Found an ISP2312, irq 66, iobase 0xc00000080f300000
> qla2300 0000:01:02.0: Configuring PCI space...
> PCI: slot 0000:01:02.0 has incorrect PCI cache line size of 0 bytes, correcting to 128
> qla2300 0000:01:02.0: Configure NVRAM parameters...
> qla2300 0000:01:02.0: Verifying loaded RISC code...
> qla2300 0000:01:02.0: Waiting for LIP to complete...
> qla2300 0000:01:02.0: Cable is unplugged...
> scsi1 : qla2xxx
> kernel unaligned access to 0xe00000300667800c, ip=0xa0000001005cd0b1

Yes, I have a fix for this in my patch-queue.  I'll attach it here for
reference.  I'll forward onto linux-scsi post 2.6.13.

--
av

---

On some platforms the hard-casting of the 8 byte node_name
and port_name arrays to an u64 would cause unaligned-access
warnings.  Generalize the conversions with consistent
shifting of WWN bytes.

Signed-off-by: Andrew Vasquez <andrew.vasquez@qlogic.com>
---

 drivers/scsi/qla2xxx/qla_attr.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

24e16c86578498fd71a3e33bebbd8be7323a03c6
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -345,6 +345,15 @@ struct class_device_attribute *qla2x00_h
 
 /* Host attributes. */
 
+static u64
+wwn_to_u64(uint8_t *wwn)
+{
+	return (u64)wwn[0] << 56 | (u64)wwn[1] << 48 |
+	    (u64)wwn[2] << 40 | (u64)wwn[3] << 32 |
+	    (u64)wwn[4] << 24 | (u64)wwn[5] << 16 |
+	    (u64)wwn[6] <<  8 | (u64)wwn[7];
+}
+
 static void
 qla2x00_get_host_port_id(struct Scsi_Host *shost)
 {
@@ -360,16 +369,16 @@ qla2x00_get_starget_node_name(struct scs
 	struct Scsi_Host *host = dev_to_shost(starget->dev.parent);
 	scsi_qla_host_t *ha = to_qla_host(host);
 	fc_port_t *fcport;
-	uint64_t node_name = 0;
+	u64 node_name = 0;
 
 	list_for_each_entry(fcport, &ha->fcports, list) {
 		if (starget->id == fcport->os_target_id) {
-			node_name = *(uint64_t *)fcport->node_name;
+			node_name = wwn_to_u64(fcport->node_name);
 			break;
 		}
 	}
 
-	fc_starget_node_name(starget) = be64_to_cpu(node_name);
+	fc_starget_node_name(starget) = node_name;
 }
 
 static void
@@ -378,16 +387,16 @@ qla2x00_get_starget_port_name(struct scs
 	struct Scsi_Host *host = dev_to_shost(starget->dev.parent);
 	scsi_qla_host_t *ha = to_qla_host(host);
 	fc_port_t *fcport;
-	uint64_t port_name = 0;
+	u64 port_name = 0;
 
 	list_for_each_entry(fcport, &ha->fcports, list) {
 		if (starget->id == fcport->os_target_id) {
-			port_name = *(uint64_t *)fcport->port_name;
+			port_name = wwn_to_u64(fcport->port_name);
 			break;
 		}
 	}
 
-	fc_starget_port_name(starget) = be64_to_cpu(port_name);
+	fc_starget_port_name(starget) = port_name;
 }
 
 static void
@@ -460,9 +469,7 @@ struct fc_function_template qla2xxx_tran
 void
 qla2x00_init_host_attr(scsi_qla_host_t *ha)
 {
-	fc_host_node_name(ha->host) =
-	    be64_to_cpu(*(uint64_t *)ha->init_cb->node_name);
-	fc_host_port_name(ha->host) =
-	    be64_to_cpu(*(uint64_t *)ha->init_cb->port_name);
+	fc_host_node_name(ha->host) = wwn_to_u64(ha->init_cb->node_name);
+	fc_host_port_name(ha->host) = wwn_to_u64(ha->init_cb->port_name);
 	fc_host_supported_classes(ha->host) = FC_COS_CLASS3;
 }

