Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264468AbUEMTYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264468AbUEMTYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUEMTXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:23:24 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:34275 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S264471AbUEMTPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:15:24 -0400
Date: Thu, 13 May 2004 21:15:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (5/6): zfcp host adapter.
Message-ID: <20040513191519.GF2916@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: zfcp host adapter.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

zfcp host adapter change:
 - Prevent infinite retry of SCSI commands when FCP adapter is unavailable.
 - Always queue error recovery structure to the error recovery running list.
 - Add help text to zfcp config option.

diffstat:
 drivers/s390/scsi/zfcp_ccw.c |    8 +++++++-
 drivers/s390/scsi/zfcp_erp.c |    5 +++--
 drivers/s390/scsi/zfcp_fsf.c |    4 ++--
 drivers/scsi/Kconfig         |   11 ++++++++++-
 4 files changed, 22 insertions(+), 6 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_ccw.c linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c
--- linux-2.6/drivers/s390/scsi/zfcp_ccw.c	Mon May 10 04:32:26 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c	Thu May 13 21:01:04 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_CCW_C_REVISION "$Revision: 1.52 $"
+#define ZFCP_CCW_C_REVISION "$Revision: 1.54 $"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -232,14 +232,19 @@
 	case CIO_GONE:
 		ZFCP_LOG_NORMAL("adapter %s: device gone\n",
 				zfcp_get_busid_by_adapter(adapter));
+		debug_text_event(adapter->erp_dbf,1,"dev_gone");
+		zfcp_erp_adapter_shutdown(adapter, 0);
 		break;
 	case CIO_NO_PATH:
 		ZFCP_LOG_NORMAL("adapter %s: no path\n",
 				zfcp_get_busid_by_adapter(adapter));
+		debug_text_event(adapter->erp_dbf,1,"no_path");
+		zfcp_erp_adapter_shutdown(adapter, 0);
 		break;
 	case CIO_OPER:
 		ZFCP_LOG_NORMAL("adapter %s: operational again\n",
 				zfcp_get_busid_by_adapter(adapter));
+		debug_text_event(adapter->erp_dbf,1,"dev_oper");
 		zfcp_erp_modify_adapter_status(adapter,
 					       ZFCP_STATUS_COMMON_RUNNING,
 					       ZFCP_SET);
@@ -247,6 +252,7 @@
 					ZFCP_STATUS_COMMON_ERP_FAILED);
 		break;
 	}
+	zfcp_erp_wait(adapter);
 	up(&zfcp_data.config_sema);
 	return 1;
 }
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	Mon May 10 04:32:02 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c	Thu May 13 21:01:04 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.51 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.52 $"
 
 #include "zfcp_ext.h"
 
@@ -2540,6 +2540,7 @@
 		atomic_clear_mask(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
 				  &adapter->status);
 		ZFCP_LOG_DEBUG("Doing exchange config data\n");
+		zfcp_erp_action_to_running(erp_action);
 		zfcp_erp_timeout_init(erp_action);
 		if (zfcp_fsf_exchange_config_data(erp_action)) {
 			retval = ZFCP_ERP_FAILED;
@@ -2566,7 +2567,7 @@
 		 * _must_ be the one belonging to the 'exchange config
 		 * data' request.
 		 */
-		down_interruptible(&adapter->erp_ready_sem);
+		down(&adapter->erp_ready_sem);
 		if (erp_action->status & ZFCP_STATUS_ERP_TIMEDOUT) {
 			ZFCP_LOG_INFO("error: exchange of configuration data "
 				      "for adapter %s timed out\n",
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Mon May 10 04:32:54 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Thu May 13 21:01:04 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.45 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.46 $"
 
 #include "zfcp_ext.h"
 
@@ -412,7 +412,7 @@
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		atomic_set_mask(ZFCP_STATUS_ADAPTER_HOST_CON_INIT,
 				&(adapter->status));
-		debug_text_event(adapter->erp_dbf, 4, "prot_con_init");
+		debug_text_event(adapter->erp_dbf, 3, "prot_con_init");
 		break;
 
 	case FSF_PROT_DUPLICATE_REQUEST_ID:
diff -urN linux-2.6/drivers/scsi/Kconfig linux-2.6-s390/drivers/scsi/Kconfig
--- linux-2.6/drivers/scsi/Kconfig	Thu May 13 21:00:43 2004
+++ linux-2.6-s390/drivers/scsi/Kconfig	Thu May 13 21:01:04 2004
@@ -1736,8 +1736,17 @@
 #      bool 'Cyberstorm Mk III SCSI support (EXPERIMENTAL)' CONFIG_CYBERSTORMIII_SCSI
 
 config ZFCP
-	tristate "IBM z900 OpenFCP/SCSI support"
+	tristate "FCP host bus adapter driver for IBM eServer zSeries"
 	depends on ARCH_S390 && SCSI
+	help
+          If you want to access SCSI devices attached to your IBM eServer
+          zSeries by means of Fibre Channel interfaces say Y.
+          For details please refer to the documentation provided by IBM at
+          <http://oss.software.ibm.com/developerworks/opensource/linux390>
+
+          This driver is also available as a module. This module will be
+          called zfcp. If you want to compile it as a module, say M here
+          and read Documentation/modules.txt.
 
 endmenu
 
