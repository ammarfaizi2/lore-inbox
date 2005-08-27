Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbVH0MDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVH0MDk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 08:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVH0MDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 08:03:39 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:20203 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030364AbVH0MDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 08:03:38 -0400
Date: Sat, 27 Aug 2005 14:01:36 +0200
From: Andreas Herrmann <aherrman@de.ibm.com>
To: James Bottomley <jejb@steeleye.com>
Cc: Linux SCSI <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] zfcp: add rports to enable scsi_add_device to work again
Message-ID: <20050827120136.GA8412@lion28.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch fixes a severe problem with 2.6.13-rc7.

Due to recent SCSI changes it is not possible to add any
LUNs to the zfcp device driver anymore. With registration
of remote ports this is fixed.

Please integrate the patch in the 2.6.13 kernel or if it
is already too late for this release then please integrate it
in 2.6.13.1

Thanks a lot.


Regards,

Andreas


Signed-off-by: Andreas Herrmann <aherrman@de.ibm.com>

diffstat:
 zfcp_aux.c  |   29 +++++++----------------------
 zfcp_ccw.c  |   10 ++++++++++
 zfcp_def.h  |    2 +-
 zfcp_erp.c  |   25 ++++++++++++++++++++++---
 zfcp_ext.h  |    2 ++
 zfcp_fsf.c  |    1 +
 zfcp_scsi.c |   25 ++++++++++++++++++++-----
 7 files changed, 63 insertions(+), 31 deletions(-)

diff -urN linux-2.6.13-rcx/drivers/s390/scsi/zfcp_aux.c linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6.13-rcx/drivers/s390/scsi/zfcp_aux.c	2005-08-25 10:53:15.000000000 +0200
+++ linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_aux.c	2005-08-27 13:05:17.000000000 +0200
@@ -1299,13 +1299,10 @@
 zfcp_port_enqueue(struct zfcp_adapter *adapter, wwn_t wwpn, u32 status,
 		  u32 d_id)
 {
-	struct zfcp_port *port, *tmp_port;
+	struct zfcp_port *port;
 	int check_wwpn;
-	scsi_id_t scsi_id;
-	int found;
 
 	check_wwpn = !(status & ZFCP_STATUS_PORT_NO_WWPN);
-
 	/*
 	 * check that there is no port with this WWPN already in list
 	 */
@@ -1368,7 +1365,7 @@
 	} else {
 		snprintf(port->sysfs_device.bus_id,
 			 BUS_ID_SIZE, "0x%016llx", wwpn);
-	port->sysfs_device.parent = &adapter->ccw_device->dev;
+		port->sysfs_device.parent = &adapter->ccw_device->dev;
 	}
 	port->sysfs_device.release = zfcp_sysfs_port_release;
 	dev_set_drvdata(&port->sysfs_device, port);
@@ -1388,24 +1385,8 @@
 
 	zfcp_port_get(port);
 
-	scsi_id = 1;
-	found = 0;
 	write_lock_irq(&zfcp_data.config_lock);
-	list_for_each_entry(tmp_port, &adapter->port_list_head, list) {
-		if (atomic_test_mask(ZFCP_STATUS_PORT_NO_SCSI_ID,
-				     &tmp_port->status))
-			continue;
-		if (tmp_port->scsi_id != scsi_id) {
-			found = 1;
-			break;
-		}
-		scsi_id++;
-	}
-	port->scsi_id = scsi_id;
-	if (found)
-		list_add_tail(&port->list, &tmp_port->list);
-	else
-		list_add_tail(&port->list, &adapter->port_list_head);
+	list_add_tail(&port->list, &adapter->port_list_head);
 	atomic_clear_mask(ZFCP_STATUS_COMMON_REMOVE, &port->status);
 	atomic_set_mask(ZFCP_STATUS_COMMON_RUNNING, &port->status);
 	if (d_id == ZFCP_DID_DIRECTORY_SERVICE)
@@ -1422,11 +1403,15 @@
 void
 zfcp_port_dequeue(struct zfcp_port *port)
 {
+	struct fc_port *rport;
+
 	zfcp_port_wait(port);
 	write_lock_irq(&zfcp_data.config_lock);
 	list_del(&port->list);
 	port->adapter->ports--;
 	write_unlock_irq(&zfcp_data.config_lock);
+	if (port->rport)
+		fc_remote_port_delete(rport);
 	zfcp_adapter_put(port->adapter);
 	zfcp_sysfs_port_remove_files(&port->sysfs_device,
 				     atomic_read(&port->status));
diff -urN linux-2.6.13-rcx/drivers/s390/scsi/zfcp_ccw.c linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_ccw.c
--- linux-2.6.13-rcx/drivers/s390/scsi/zfcp_ccw.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_ccw.c	2005-08-27 13:28:35.000000000 +0200
@@ -202,9 +202,19 @@
 zfcp_ccw_set_offline(struct ccw_device *ccw_device)
 {
 	struct zfcp_adapter *adapter;
+	struct zfcp_port *port;
+	struct fc_port *rport;
 
 	down(&zfcp_data.config_sema);
 	adapter = dev_get_drvdata(&ccw_device->dev);
+	/* might be racy, but we cannot take config_lock due to the fact that
+	   fc_remote_port_delete might sleep */
+	list_for_each_entry(port, &adapter->port_list_head, list)
+		if (port->rport) {
+			rport = port->rport;
+			port->rport = NULL;
+			fc_remote_port_delete(rport);
+		}
 	zfcp_erp_adapter_shutdown(adapter, 0);
 	zfcp_erp_wait(adapter);
 	zfcp_adapter_scsi_unregister(adapter);
diff -urN linux-2.6.13-rcx/drivers/s390/scsi/zfcp_def.h linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_def.h
--- linux-2.6.13-rcx/drivers/s390/scsi/zfcp_def.h	2005-08-25 10:53:15.000000000 +0200
+++ linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_def.h	2005-08-26 19:00:18.000000000 +0200
@@ -906,6 +906,7 @@
  */
 struct zfcp_port {
 	struct device          sysfs_device;   /* sysfs device */
+	struct fc_rport        *rport;         /* rport of fc transport class */
 	struct list_head       list;	       /* list of remote ports */
 	atomic_t               refcount;       /* reference count */
 	wait_queue_head_t      remove_wq;      /* can be used to wait for
@@ -916,7 +917,6 @@
 						  list */
 	u32		       units;	       /* # of logical units in list */
 	atomic_t	       status;	       /* status of this remote port */
-	scsi_id_t	       scsi_id;	       /* own SCSI ID */
 	wwn_t		       wwnn;	       /* WWNN if known */
 	wwn_t		       wwpn;	       /* WWPN */
 	fc_id_t		       d_id;	       /* D_ID */
diff -urN linux-2.6.13-rcx/drivers/s390/scsi/zfcp_erp.c linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6.13-rcx/drivers/s390/scsi/zfcp_erp.c	2005-08-25 10:53:15.000000000 +0200
+++ linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_erp.c	2005-08-27 12:38:50.000000000 +0200
@@ -3360,13 +3360,32 @@
 		if ((result == ZFCP_ERP_SUCCEEDED)
 		    && (!atomic_test_mask(ZFCP_STATUS_UNIT_TEMPORARY,
 					  &unit->status))
-		    && (!unit->device))
- 			scsi_add_device(unit->port->adapter->scsi_host, 0,
- 					unit->port->scsi_id, unit->scsi_lun);
+		    && !unit->device
+		    && port->rport)
+ 			scsi_add_device(port->adapter->scsi_host, 0,
+ 					port->rport->scsi_target_id,
+					unit->scsi_lun);
 		zfcp_unit_put(unit);
 		break;
 	case ZFCP_ERP_ACTION_REOPEN_PORT_FORCED:
 	case ZFCP_ERP_ACTION_REOPEN_PORT:
+		if ((result == ZFCP_ERP_SUCCEEDED)
+		    && !atomic_test_mask(ZFCP_STATUS_PORT_NO_WWPN,
+					 &port->status)
+		    && !port->rport) {
+			struct fc_rport_identifiers ids;
+			ids.node_name = port->wwnn;
+			ids.port_name = port->wwpn;
+			ids.port_id = port->d_id;
+			ids.roles = FC_RPORT_ROLE_FCP_TARGET;
+			port->rport =
+				fc_remote_port_add(adapter->scsi_host, 0, &ids);
+			if (!port->rport)
+				ZFCP_LOG_NORMAL("failed registration of rport"
+						"(adapter %s, wwpn=0x%016Lx)\n",
+						zfcp_get_busid_by_port(port),
+						port->wwpn);
+		}
 		zfcp_port_put(port);
 		break;
 	case ZFCP_ERP_ACTION_REOPEN_ADAPTER:
diff -urN linux-2.6.13-rcx/drivers/s390/scsi/zfcp_ext.h linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6.13-rcx/drivers/s390/scsi/zfcp_ext.h	2005-08-25 10:53:15.000000000 +0200
+++ linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_ext.h	2005-08-26 19:00:18.000000000 +0200
@@ -143,6 +143,8 @@
 				   struct scsi_cmnd *, struct timer_list *);
 extern int zfcp_scsi_command_sync(struct zfcp_unit *, struct scsi_cmnd *,
 				  struct timer_list *);
+extern void zfcp_set_fc_host_attrs(struct zfcp_adapter *);
+extern void zfcp_set_fc_rport_attrs(struct zfcp_port *);
 extern struct scsi_transport_template *zfcp_transport_template;
 extern struct fc_function_template zfcp_transport_functions;
 
diff -urN linux-2.6.13-rcx/drivers/s390/scsi/zfcp_fsf.c linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6.13-rcx/drivers/s390/scsi/zfcp_fsf.c	2005-08-25 10:53:15.000000000 +0200
+++ linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_fsf.c	2005-08-26 19:00:18.000000000 +0200
@@ -2062,6 +2062,7 @@
 		zfcp_erp_adapter_shutdown(adapter, 0);
 		return -EIO;
 	}
+	zfcp_set_fc_host_attrs(adapter);
 	return 0;
 }
 
diff -urN linux-2.6.13-rcx/drivers/s390/scsi/zfcp_scsi.c linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6.13-rcx/drivers/s390/scsi/zfcp_scsi.c	2005-08-25 10:53:15.000000000 +0200
+++ linux-2.6.13-zfcpfctc/drivers/s390/scsi/zfcp_scsi.c	2005-08-26 19:05:10.000000000 +0200
@@ -389,7 +389,7 @@
 	struct zfcp_unit *unit, *retval = NULL;
 
 	list_for_each_entry(port, &adapter->port_list_head, list) {
-		if (id != port->scsi_id)
+		if (!port->rport || (id != port->rport->scsi_target_id))
 			continue;
 		list_for_each_entry(unit, &port->unit_list_head, list) {
 			if (lun == unit->scsi_lun) {
@@ -408,7 +408,7 @@
 	struct zfcp_port *port;
 
 	list_for_each_entry(port, &adapter->port_list_head, list) {
-		if (id == port->scsi_id)
+		if (port->rport && (id == port->rport->scsi_target_id))
 			return port;
 	}
 	return (struct zfcp_port *) NULL;
@@ -634,7 +634,6 @@
 {
 	int retval;
 	struct zfcp_unit *unit = (struct zfcp_unit *) scpnt->device->hostdata;
-	struct Scsi_Host *scsi_host = scpnt->device->host;
 
 	if (!unit) {
 		ZFCP_LOG_NORMAL("bug: Tried reset for nonexistent unit\n");
@@ -729,7 +728,6 @@
 {
 	int retval = 0;
 	struct zfcp_unit *unit;
-	struct Scsi_Host *scsi_host = scpnt->device->host;
 
 	unit = (struct zfcp_unit *) scpnt->device->hostdata;
 	ZFCP_LOG_NORMAL("bus reset because of problems with "
@@ -753,7 +751,6 @@
 {
 	int retval = 0;
 	struct zfcp_unit *unit;
-	struct Scsi_Host *scsi_host = scpnt->device->host;
 
 	unit = (struct zfcp_unit *) scpnt->device->hostdata;
 	ZFCP_LOG_NORMAL("host reset because of problems with "
@@ -833,6 +830,7 @@
 	shost = adapter->scsi_host;
 	if (!shost)
 		return;
+	fc_remove_host(shost);
 	scsi_remove_host(shost);
 	scsi_host_put(shost);
 	adapter->scsi_host = NULL;
@@ -906,6 +904,18 @@
 	read_unlock_irqrestore(&zfcp_data.config_lock, flags);
 }
 
+void
+zfcp_set_fc_host_attrs(struct zfcp_adapter *adapter)
+{
+	struct Scsi_Host *shost = adapter->scsi_host;
+
+	fc_host_node_name(shost) = adapter->wwnn;
+	fc_host_port_name(shost) = adapter->wwpn;
+	strncpy(fc_host_serial_number(shost), adapter->serial_number,
+                min(FC_SERIAL_NUMBER_SIZE, 32));
+	fc_host_supported_classes(shost) = FC_COS_CLASS2 | FC_COS_CLASS3;
+}
+
 struct fc_function_template zfcp_transport_functions = {
 	.get_starget_port_id = zfcp_get_port_id,
 	.get_starget_port_name = zfcp_get_port_name,
@@ -913,6 +923,11 @@
 	.show_starget_port_id = 1,
 	.show_starget_port_name = 1,
 	.show_starget_node_name = 1,
+	.show_rport_supported_classes = 1,
+	.show_host_node_name = 1,
+	.show_host_port_name = 1,
+	.show_host_supported_classes = 1,
+	.show_host_serial_number = 1,
 };
 
 /**
