Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTLXKog (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 05:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTLXKog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 05:44:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7430 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263528AbTLXKoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 05:44:30 -0500
Date: Wed, 24 Dec 2003 10:44:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-pcmcia@lists.infradead.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/7] more CardServices() removals (drivers/serial)
Message-ID: <20031224104426.B11040@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-pcmcia@lists.infradead.org,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this is the last patch for removal of CardServices()

--- orig/drivers/serial/serial_cs.c	Sun Sep 28 09:55:09 2003
+++ linux/drivers/serial/serial_cs.c	Tue Dec 23 14:58:23 2003
@@ -149,9 +149,9 @@
 		info->link.dev = NULL;
 
 		if (!info->slave) {
-			CardServices(ReleaseConfiguration, info->link.handle);
-			CardServices(ReleaseIO, info->link.handle, &info->link.io);
-			CardServices(ReleaseIRQ, info->link.handle, &info->link.irq);
+			pcmcia_release_configuration(info->link.handle);
+			pcmcia_release_io(info->link.handle, &info->link.io);
+			pcmcia_release_irq(info->link.handle, &info->link.irq);
 		}
 
 		info->link.state &= ~DEV_CONFIG;
@@ -211,7 +211,7 @@
 	client_reg.event_handler = &serial_event;
 	client_reg.Version = 0x0210;
 	client_reg.event_callback_args.client_data = link;
-	ret = CardServices(RegisterClient, &link->handle, &client_reg);
+	ret = pcmcia_register_client(&link->handle, &client_reg);
 	if (ret != CS_SUCCESS) {
 		cs_error(link->handle, RegisterClient, ret);
 		serial_detach(link);
@@ -256,7 +256,7 @@
 	serial_remove(link);
 
 	if (link->handle) {
-		ret = CardServices(DeregisterClient, link->handle);
+		ret = pcmcia_deregister_client(link->handle);
 		if (ret != CS_SUCCESS)
 			cs_error(link->handle, DeregisterClient, ret);
 	}
@@ -306,10 +306,10 @@
 	i = CardServices(fn, handle, tuple);
 	if (i != CS_SUCCESS)
 		return CS_NO_MORE_ITEMS;
-	i = CardServices(GetTupleData, handle, tuple);
+	i = pcmcia_get_tuple_data(handle, tuple);
 	if (i != CS_SUCCESS)
 		return i;
-	return CardServices(ParseTuple, handle, tuple, parse);
+	return pcmcia_parse_tuple(handle, tuple, parse);
 }
 
 #define first_tuple(a, b, c) get_tuple(GetFirstTuple, a, b, c)
@@ -330,7 +330,7 @@
 	int i, j, try;
 
 	/* If the card is already configured, look up the port and irq */
-	i = CardServices(GetConfigurationInfo, handle, &config);
+	i = pcmcia_get_configuration_info(handle, &config);
 	if ((i == CS_SUCCESS) && (config.Attributes & CONF_VALID_CLIENT)) {
 		ioaddr_t port = 0;
 		if ((config.BasePort2 != 0) && (config.NumPorts2 == 8)) {
@@ -367,9 +367,7 @@
 				link->io.BasePort1 = cf->io.win[0].base;
 				link->io.IOAddrLines = (try == 0) ?
 				    16 : cf->io.flags & CISTPL_IO_LINES_MASK;
-				i =
-				    CardServices(RequestIO, link->handle,
-						 &link->io);
+				i = pcmcia_request_io(link->handle, &link->io);
 				if (i == CS_SUCCESS)
 					goto found_port;
 			}
@@ -389,8 +387,7 @@
 			for (j = 0; j < 5; j++) {
 				link->io.BasePort1 = base[j];
 				link->io.IOAddrLines = base[j] ? 16 : 3;
-				i = CardServices(RequestIO, link->handle,
-						 &link->io);
+				i = pcmcia_request_io(link->handle, &link->io);
 				if (i == CS_SUCCESS)
 					goto found_port;
 			}
@@ -406,14 +403,14 @@
 		return -1;
 	}
 
-	i = CardServices(RequestIRQ, link->handle, &link->irq);
+	i = pcmcia_request_irq(link->handle, &link->irq);
 	if (i != CS_SUCCESS) {
 		cs_error(link->handle, RequestIRQ, i);
 		link->irq.AssignedIRQ = 0;
 	}
 	if (info->multi && (info->manfid == MANFID_3COM))
 		link->conf.ConfigIndex &= ~(0x08);
-	i = CardServices(RequestConfiguration, link->handle, &link->conf);
+	i = pcmcia_request_configuration(link->handle, &link->conf);
 	if (i != CS_SUCCESS) {
 		cs_error(link->handle, RequestConfiguration, i);
 		return -1;
@@ -433,7 +430,7 @@
 	config_info_t config;
 	int i, base2 = 0;
 
-	i = CardServices(GetConfigurationInfo, handle, &config);
+	i = pcmcia_get_configuration_info(handle, &config);
 	if (i != CS_SUCCESS) {
 		cs_error(handle, GetConfigurationInfo, i);
 		return -1;
@@ -458,7 +455,7 @@
 			link->io.BasePort1 = cf->io.win[0].base;
 			link->io.IOAddrLines =
 			    cf->io.flags & CISTPL_IO_LINES_MASK;
-			i = CardServices(RequestIO, link->handle, &link->io);
+			i = pcmcia_request_io(link->handle, &link->io);
 			base2 = link->io.BasePort1 + 8;
 			if (i == CS_SUCCESS)
 				break;
@@ -478,9 +475,7 @@
 				link->io.BasePort2 = cf->io.win[1].base;
 				link->io.IOAddrLines =
 				    cf->io.flags & CISTPL_IO_LINES_MASK;
-				i =
-				    CardServices(RequestIO, link->handle,
-						 &link->io);
+				i = pcmcia_request_io(link->handle, &link->io);
 				base2 = link->io.BasePort2;
 				if (i == CS_SUCCESS)
 					break;
@@ -494,7 +489,7 @@
 		return -1;
 	}
 
-	i = CardServices(RequestIRQ, link->handle, &link->irq);
+	i = pcmcia_request_irq(link->handle, &link->irq);
 	if (i != CS_SUCCESS) {
 		printk(KERN_NOTICE
 		       "serial_cs: no usable port range found, giving up\n");
@@ -506,7 +501,7 @@
 		link->conf.Present |= PRESENT_EXT_STATUS;
 		link->conf.ExtStatus = ESR_REQ_ATTN_ENA;
 	}
-	i = CardServices(RequestConfiguration, link->handle, &link->conf);
+	i = pcmcia_request_configuration(link->handle, &link->conf);
 	if (i != CS_SUCCESS) {
 		cs_error(link->handle, RequestConfiguration, i);
 		return -1;
@@ -543,9 +538,6 @@
 
 ======================================================================*/
 
-#define CS_CHECK(fn, args...) \
-while ((last_ret=CardServices(last_fn=(fn), args))!=0) goto cs_failed
-
 void serial_config(dev_link_t * link)
 {
 	client_handle_t handle = link->handle;
@@ -619,10 +611,18 @@
 
 	if (info->manfid == MANFID_IBM) {
 		conf_reg_t reg = { 0, CS_READ, 0x800, 0 };
-		CS_CHECK(AccessConfigurationRegister, link->handle, &reg);
+		last_ret = pcmcia_access_configuration_register(link->handle, &reg);
+		if (last_ret) {
+			last_fn = AccessConfigurationRegister;
+			goto cs_failed;
+		}
 		reg.Action = CS_WRITE;
 		reg.Value = reg.Value | 1;
-		CS_CHECK(AccessConfigurationRegister, link->handle, &reg);
+		last_ret = pcmcia_access_configuration_register(link->handle, &reg);
+		if (last_ret) {
+			last_fn = AccessConfigurationRegister;
+			goto cs_failed;
+		}
 	}
 
 	link->dev = &info->node[0];
@@ -668,16 +668,15 @@
 		/* Fall through... */
 	case CS_EVENT_RESET_PHYSICAL:
 		if ((link->state & DEV_CONFIG) && !info->slave)
-			CardServices(ReleaseConfiguration, link->handle);
+			pcmcia_release_configuration(link->handle);
 		break;
 
 	case CS_EVENT_PM_RESUME:
 		link->state &= ~DEV_SUSPEND;
 		/* Fall through... */
 	case CS_EVENT_CARD_RESET:
 		if (DEV_OK(link) && !info->slave)
-			CardServices(RequestConfiguration, link->handle,
-				     &link->conf);
+			pcmcia_request_configuration(link->handle, &link->conf);
 		break;
 	}
 	return 0;

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
