Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTHUQey (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTHUQey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:34:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:30866 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262758AbTHUQet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:34:49 -0400
Date: Thu, 21 Aug 2003 09:30:37 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: IPMI fix for panic handling
Message-Id: <20030821093037.64962c27.rddunlap@osdl.org>
In-Reply-To: <3F44C380.3060707@mvista.com>
References: <3F44C380.3060707@mvista.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003 08:05:04 -0500 Corey Minyard <cminyard@mvista.com> wrote:

| This patch adds something I missed that previous IPMI drivers did, 
| adding panic information to the event log. Some programs use this 

adding to which event log?

| information to analyze panics. Please apply.


Few corrections below.


diff -u -r1.3 Kconfig
--- drivers/char/ipmi/Kconfig	28 Mar 2003 05:14:18 -0000	1.3
+++ drivers/char/ipmi/Kconfig	19 Aug 2003 14:20:43 -0000
@@ -24,6 +24,18 @@
 	 generate an IPMI event describing the panic to each interface
 	 registered with the message handler.
 
+config IPMI_PANIC_STRING
+	bool 'Generate a OEM events holding the panic string'

I can't decode/translate that quoted string...
'an OEM event' ??
s/holding/containing/ ??

+	depends on IPMI_PANIC_EVENT
+	help
+	  When a panic occurs, this will cause the IPMI message handler to
+	  generate an IPMI OEM type f0 events holding the IPMB address of the
                                       event
+	  panic generator (byte 4 of the event), a sequence number for the
+	  string (byte 5 of the event) and part of the string (the rest of the
+	  event).  Bytes 1, 2, and 3 are the normal usage for an OEM event.
+	  You can fetch these events and use the sequence numbers to piece the
+	  string together.
+
 config IPMI_DEVICE_INTERFACE
        tristate 'Device interface for IPMI'
        depends on IPMI_HANDLER

diff -u -r1.7 ipmi_msghandler.c
--- drivers/char/ipmi/ipmi_msghandler.c	24 May 2003 17:02:51 -0000	1.7
+++ drivers/char/ipmi/ipmi_msghandler.c	19 Aug 2003 14:20:45 -0000
@@ -1813,18 +1829,48 @@
 {
 }
 
-static void send_panic_events(void)
+#ifdef CONFIG_IPMI_PANIC_STRING
+static void event_receiver_fetcher(ipmi_smi_t intf, struct ipmi_smi_msg *msg)
+{
+	if ((msg->rsp[0] == (0x5 << 2))

Some named constants would be good here (defines/macros)
and below.

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

Named constant.

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
                     breadcrumbs
+	   to make the panic events more useful. */
+	if (str) {
+		data[3] = str[0];
+		data[6] = str[1];
+		data[7] = str[2];
+	}
 
 	smi_msg.done = dummy_smi_done_handler;
 	recv_msg.done = dummy_recv_done_handler;
@@ -1865,6 +1913,130 @@
 			       intf->my_address,
 			       intf->my_lun);
 	}
+
+#ifdef CONFIG_IPMI_PANIC_STRING
+	/* On every interface, dump a bunch of OEM event holding the
                                                   events
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

Looks like a Windows interface call.  One parameter/line isn't needed.

--
~Randy   [mantra:  Always include kernel version.]
"Everything is relative."
