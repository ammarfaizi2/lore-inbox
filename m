Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbTHUNox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 09:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbTHUNno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 09:43:44 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:17547 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262675AbTHUNGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 09:06:54 -0400
Message-ID: <3F44C380.3060707@mvista.com>
Date: Thu, 21 Aug 2003 08:05:04 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: IPMI fix for panic handling
Content-Type: multipart/mixed;
 boundary="------------080104050708080509010704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080104050708080509010704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds something I missed that previous IPMI drivers did, 
adding panic information to the event log. Some programs use this 
information to analyze panics. Please apply.

Thanks,

-Corey

--------------080104050708080509010704
Content-Type: text/plain;
 name="ipmi-panicinfo.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi-panicinfo.diff"

Index: drivers/char/ipmi/Kconfig
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/char/ipmi/Kconfig,v
retrieving revision 1.3
diff -u -r1.3 Kconfig
--- drivers/char/ipmi/Kconfig	28 Mar 2003 05:14:18 -0000	1.3
+++ drivers/char/ipmi/Kconfig	19 Aug 2003 14:20:43 -0000
@@ -24,6 +24,18 @@
 	 generate an IPMI event describing the panic to each interface
 	 registered with the message handler.
 
+config IPMI_PANIC_STRING
+	bool 'Generate a OEM events holding the panic string'
+	depends on IPMI_PANIC_EVENT
+	help
+	  When a panic occurs, this will cause the IPMI message handler to
+	  generate an IPMI OEM type f0 events holding the IPMB address of the
+	  panic generator (byte 4 of the event), a sequence number for the
+	  string (byte 5 of the event) and part of the string (the rest of the
+	  event).  Bytes 1, 2, and 3 are the normal usage for an OEM event.
+	  You can fetch these events and use the sequence numbers to piece the
+	  string together.
+
 config IPMI_DEVICE_INTERFACE
        tristate 'Device interface for IPMI'
        depends on IPMI_HANDLER
Index: drivers/char/ipmi/ipmi_msghandler.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/char/ipmi/ipmi_msghandler.c,v
retrieving revision 1.7
diff -u -r1.7 ipmi_msghandler.c
--- drivers/char/ipmi/ipmi_msghandler.c	24 May 2003 17:02:51 -0000	1.7
+++ drivers/char/ipmi/ipmi_msghandler.c	19 Aug 2003 14:20:45 -0000
@@ -169,6 +169,19 @@
 	/* My LUN.  This should generally stay the SMS LUN, but just in
 	   case... */
 	unsigned char my_lun;
+
+	/* The event receiver for my BMC, only really used at panic
+	   shutdown as a place to store this. */
+	unsigned char event_receiver;
+	unsigned char event_receiver_lun;
+	unsigned char local_sel_device;
+	unsigned char local_event_generator;
+
+	/* A cheap hack, if this is non-null and a message to an
+	   interface comes in with a NULL user, call this routine with
+	   it.  Note that the message will still be freed by the
+	   caller.  This only works on the system interface. */
+	void (*null_user_handler)(ipmi_smi_t intf, struct ipmi_smi_msg *msg);
 };
 
 int
@@ -1465,6 +1478,9 @@
 	}
 
 	if (!found) {
+		/* Special handling for NULL users. */
+		if (!recv_msg->user && intf->null_user_handler)
+			intf->null_user_handler(intf, msg);
 		/* The user for the message went away, so give up. */
 		ipmi_free_recv_msg(recv_msg);
 	} else {
@@ -1813,18 +1829,48 @@
 {
 }
 
-static void send_panic_events(void)
+#ifdef CONFIG_IPMI_PANIC_STRING
+static void event_receiver_fetcher(ipmi_smi_t intf, struct ipmi_smi_msg *msg)
+{
+	if ((msg->rsp[0] == (0x5 << 2))
+	    && (msg->rsp[1] == 1)
+	    && (msg->rsp[2] == 0))
+	{
+		/* A get event receiver command, save it. */
+		intf->event_receiver = msg->rsp[3];
+		intf->event_receiver_lun = msg->rsp[4] & 0x3;
+	}
+}
+
+static void device_id_fetcher(ipmi_smi_t intf, struct ipmi_smi_msg *msg)
+{
+	if ((msg->rsp[0] == (0x7 << 2))
+	    && (msg->rsp[1] == 1)
+	    && (msg->rsp[2] == 0))
+	{
+		/* A get device id command, save if we are an event
+		   receiver or generator. */
+		intf->local_sel_device = (msg->rsp[8] >> 2) & 1;
+		intf->local_event_generator = (msg->rsp[8] >> 5) & 1;
+	}
+}
+#endif
+
+static void send_panic_events(char *str)
 {
 	struct ipmi_msg                   msg;
 	ipmi_smi_t                        intf;
-	unsigned char                     data[8];
+	unsigned char                     data[16];
 	int                               i;
-	struct ipmi_system_interface_addr addr;
+	struct ipmi_system_interface_addr *si;
+	struct ipmi_addr                  addr;
 	struct ipmi_smi_msg               smi_msg;
 	struct ipmi_recv_msg              recv_msg;
 
-	addr.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
-	addr.channel = IPMI_BMC_CHANNEL;
+	si = (struct ipmi_system_interface_addr *) &addr;
+	si->addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	si->channel = IPMI_BMC_CHANNEL;
+	si->lun = 0;
 
 	/* Fill in an event telling that we have failed. */
 	msg.netfn = 0x04; /* Sensor or Event. */
@@ -1837,12 +1883,13 @@
 	data[4] = 0x6f; /* Sensor specific, IPMI table 36-1 */
 	data[5] = 0xa1; /* Runtime stop OEM bytes 2 & 3. */
 
-	/* These used to have the first three bytes of the panic string,
-	   but not only is that not terribly useful, it's not available
-	   any more. */
-	data[3] = 0;
-	data[6] = 0;
-	data[7] = 0;
+	/* Put a few breadcrums in.  Hopefully later we can add more things
+	   to make the panic events more useful. */
+	if (str) {
+		data[3] = str[0];
+		data[6] = str[1];
+		data[7] = str[2];
+	}
 
 	smi_msg.done = dummy_smi_done_handler;
 	recv_msg.done = dummy_recv_done_handler;
@@ -1853,10 +1900,11 @@
 		if (intf == NULL)
 			continue;
 
+		/* Send the event announcing the panic. */
 		intf->handlers->set_run_to_completion(intf->send_info, 1);
 		i_ipmi_request(NULL,
 			       intf,
-			       (struct ipmi_addr *) &addr,
+			       &addr,
 			       0,
 			       &msg,
 			       &smi_msg,
@@ -1865,6 +1913,130 @@
 			       intf->my_address,
 			       intf->my_lun);
 	}
+
+#ifdef CONFIG_IPMI_PANIC_STRING
+	/* On every interface, dump a bunch of OEM event holding the
+	   string. */
+	if (!str) 
+		return;
+
+	for (i=0; i<MAX_IPMI_INTERFACES; i++) {
+		char                  *p = str;
+		struct ipmi_ipmb_addr *ipmb;
+		int                   j;
+
+		intf = ipmi_interfaces[i];
+		if (intf == NULL)
+			continue;
+
+		/* First job here is to figure out where to send the
+		   OEM events.  There's no way in IPMI to send OEM
+		   events using an event send command, so we have to
+		   find the SEL to put them in and stick them in
+		   there. */
+
+		/* Get capabilities from the get device id. */
+		intf->local_sel_device = 0;
+		intf->local_event_generator = 0;
+		intf->event_receiver = 0;
+
+		/* Request the device info from the local MC. */
+		msg.netfn = 0x06; /* App. */
+		msg.cmd = 0x01; /* Get device id cmd */
+		msg.data = NULL;
+		msg.data_len = 0;
+		intf->null_user_handler = device_id_fetcher;
+		i_ipmi_request(NULL,
+			       intf,
+			       &addr,
+			       0,
+			       &msg,
+			       &smi_msg,
+			       &recv_msg,
+			       0,
+			       intf->my_address,
+			       intf->my_lun);
+
+		if (intf->local_event_generator) {
+			/* Request the event receiver from the local MC. */
+			msg.netfn = 0x04; /* Sensor or Event. */
+			msg.cmd = 0x01; /* Get Event Receiver cmd */
+			msg.data = NULL;
+			msg.data_len = 0;
+			intf->null_user_handler = event_receiver_fetcher;
+			i_ipmi_request(NULL,
+				       intf,
+				       &addr,
+				       0,
+				       &msg,
+				       &smi_msg,
+				       &recv_msg,
+				       0,
+				       intf->my_address,
+				       intf->my_lun);
+		}
+		intf->null_user_handler = NULL;
+
+		/* Validate the event receiver.  The low bit must not
+		   be 1 (it must be a valid IPMB address), it cannot
+		   be zero, and it must not be my address. */
+                if (((intf->event_receiver & 1) == 0)
+		    && (intf->event_receiver != 0)
+		    && (intf->event_receiver != intf->my_address))
+		{
+			/* The event receiver is valid, send an IPMB
+			   message. */
+			ipmb = (struct ipmi_ipmb_addr *) &addr;
+			ipmb->addr_type = IPMI_IPMB_ADDR_TYPE;
+			ipmb->channel = 0; /* FIXME - is this right? */
+			ipmb->lun = intf->event_receiver_lun;
+			ipmb->slave_addr = intf->event_receiver;
+		} else if (intf->local_sel_device) {
+			/* The event receiver was not valid (or was
+			   me), but I am an SEL device, just dump it
+			   in my SEL. */
+			si = (struct ipmi_system_interface_addr *) &addr;
+			si->addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+			si->channel = IPMI_BMC_CHANNEL;
+			si->lun = 0;
+		} else
+			continue; /* No where to send the event. */
+
+		
+		msg.netfn = 0x0a; /* Storage. */
+		msg.cmd = 0x44; /* Add SEL entry command. */
+		msg.data = data;
+		msg.data_len = 16;
+
+		j = 0;
+		while (*p) {
+			int size = strlen(p);
+
+			if (size > 11)
+				size = 11;
+			data[0] = 0;
+			data[1] = 0;
+			data[2] = 0xf0; /* OEM event without timestamp. */
+			data[3] = intf->my_address;
+			data[4] = j++; /* sequence # */
+			/* Always give 11 bytes, so strncpy will fill
+			   it with zeroes for me. */
+			strncpy(data+5, p, 11);
+			p += size;
+
+			i_ipmi_request(NULL,
+				       intf,
+				       &addr,
+				       0,
+				       &msg,
+				       &smi_msg,
+				       &recv_msg,
+				       0,
+				       intf->my_address,
+				       intf->my_lun);
+		}
+	}	
+#endif /* CONFIG_IPMI_PANIC_STRING */
 }
 #endif /* CONFIG_IPMI_PANIC_EVENT */
 
@@ -1891,7 +2063,7 @@
 	}
 
 #ifdef CONFIG_IPMI_PANIC_EVENT
-	send_panic_events();
+	send_panic_events(ptr);
 #endif
 
 	return NOTIFY_DONE;

--------------080104050708080509010704--

