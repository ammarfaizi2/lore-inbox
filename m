Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264871AbUDWQ43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbUDWQ43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbUDWQ43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:56:29 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:14457 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264871AbUDWQ4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:56:22 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Date: Fri, 23 Apr 2004 11:55:59 -0500
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <200404230802.42293.dtor_core@ameritech.net> <1082730412.23959.118.camel@pegasus>
In-Reply-To: <1082730412.23959.118.camel@pegasus>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404231156.03106.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 April 2004 09:26 am, Marcel Holtmann wrote:
> I can't tell you anything about the hiddev problem, but for the PCMCIA
> subsystem we have the problem that right now it is not integrated into
> the driver model. Maybe a dummy integration for PCMCIA would be nice or
> can we get a device_simple like we have class_simple?
> 
I wonder if===== drivers/net/wireless/atmel_cs.c 1.11 vs edited =====
--- 1.11/drivers/net/wireless/atmel_cs.c	Thu Feb  5 05:04:40 2004
+++ edited/drivers/net/wireless/atmel_cs.c	Fri Apr 23 11:43:42 2004
@@ -348,17 +348,13 @@
 	{ 0, 0, "11WAVE/11WP611AL-E", "atmel_at76c502e%s.bin", "11WAVE WaveBuddy" } 
 };
 
-/* This is strictly temporary, until PCMCIA devices get integrated into the device model. */
-static struct device atmel_device = {
-        .bus_id    = "pcmcia",
-};
-
 static void atmel_config(dev_link_t *link)
 {
 	client_handle_t handle;
 	tuple_t tuple;
 	cisparse_t parse;
 	local_info_t *dev;
+	struct device *atmel_device;
 	int last_fn, last_ret;
 	u_char buf[64];
 	int card_index = -1, done = 0;
@@ -538,14 +534,25 @@
 		       "atmel: cannot assign IRQ: check that CONFIG_ISA is set in kernel config.");
 		goto cs_failed;
 	}
-	
+
+	CS_CHECK(GetSysDevice, pcmcia_get_sys_device(link->handle, &atmel_device));
+
+	if (!atmel_device) {
+		printk(KERN_ALERT "atmel: cannot get sys device from the card.\n");
+		goto cs_failed;
+	}
+
 	((local_info_t*)link->priv)->eth_dev = 
 		init_atmel_card(link->irq.AssignedIRQ,
 				link->io.BasePort1,
 				card_index == -1 ? NULL :  card_table[card_index].firmware,
-				&atmel_device,
+				atmel_device,
 				card_present, 
 				link);
+
+	put_device(atmel_device);
+	atmel_device = NULL;
+
 	if (!((local_info_t*)link->priv)->eth_dev) 
 		goto cs_failed;
 	
===== drivers/pcmcia/cs.c 1.78 vs edited =====
--- 1.78/drivers/pcmcia/cs.c	Mon Apr 19 03:12:13 2004
+++ edited/drivers/pcmcia/cs.c	Fri Apr 23 11:51:19 2004
@@ -1009,6 +1009,24 @@
     return CS_SUCCESS;
 } /* get_configuration_info */
 
+/*====================================================================*/
+
+int pcmcia_get_sys_device(client_handle_t handle, struct device **sys_dev)
+{
+	struct pcmcia_socket *s;
+
+	if (CHECK_HANDLE(handle))
+		return CS_BAD_HANDLE;
+
+	s = SOCKET(handle);
+	if (!(s->state & SOCKET_PRESENT))
+		return CS_NO_CARD;
+
+	*sys_dev = get_device(s->dev.dev);
+
+	return CS_SUCCESS;
+} /* get_sys_device */
+
 /*======================================================================
 
     Return information about this version of Card Services.
@@ -2109,6 +2127,7 @@
 EXPORT_SYMBOL(pcmcia_get_next_tuple);
 EXPORT_SYMBOL(pcmcia_get_next_window);
 EXPORT_SYMBOL(pcmcia_get_status);
+EXPORT_SYMBOL(pcmcia_get_sys_device);
 EXPORT_SYMBOL(pcmcia_get_tuple_data);
 EXPORT_SYMBOL(pcmcia_insert_card);
 EXPORT_SYMBOL(pcmcia_map_mem_page);
===== drivers/pcmcia/ds.c 1.49 vs edited =====
--- 1.49/drivers/pcmcia/ds.c	Sun Mar 14 15:36:00 2004
+++ edited/drivers/pcmcia/ds.c	Fri Apr 23 11:51:47 2004
@@ -307,7 +307,8 @@
     { ResumeCard,			"ResumeCard" },
     { EjectCard,			"EjectCard" },
     { InsertCard,			"InsertCard" },
-    { ReplaceCIS,			"ReplaceCIS" }
+    { ReplaceCIS,			"ReplaceCIS" },
+    { GetSysDevice,			"GetSysDevice" }
 };
 
 
===== include/pcmcia/cs.h 1.9 vs edited =====
--- 1.9/include/pcmcia/cs.h	Sun Mar 14 15:36:00 2004
+++ edited/include/pcmcia/cs.h	Fri Apr 23 11:47:26 2004
@@ -418,9 +418,11 @@
     SetEventMask, SetRegion, ValidateCIS, VendorSpecific,
     WriteMemory, BindDevice, BindMTD, ReportError,
     SuspendCard, ResumeCard, EjectCard, InsertCard, ReplaceCIS,
-    GetFirstWindow, GetNextWindow, GetMemPage
+    GetFirstWindow, GetNextWindow, GetMemPage, GetSysDevice
 };
 
+struct device;
+
 int pcmcia_access_configuration_register(client_handle_t handle, conf_reg_t *reg);
 int pcmcia_deregister_client(client_handle_t handle);
 int pcmcia_get_configuration_info(client_handle_t handle, config_info_t *config);
@@ -431,6 +433,7 @@
 int pcmcia_get_first_window(window_handle_t *win, win_req_t *req);
 int pcmcia_get_next_window(window_handle_t *win, win_req_t *req);
 int pcmcia_get_status(client_handle_t handle, cs_status_t *status);
+int pcmcia_get_sys_device(client_handle_t handle, struct device **sys_dev);
 int pcmcia_get_mem_page(window_handle_t win, memreq_t *req);
 int pcmcia_map_mem_page(window_handle_t win, memreq_t *req);
 int pcmcia_modify_configuration(client_handle_t handle, modconf_t *mod);
