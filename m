Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbTHUREL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 13:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbTHUREL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 13:04:11 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:5587 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262826AbTHURDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 13:03:02 -0400
Message-ID: <3F44F90B.7060101@mvista.com>
Date: Thu, 21 Aug 2003 11:53:31 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: IPMI fix for panic handling
References: <3F44C380.3060707@mvista.com> <20030821093037.64962c27.rddunlap@osdl.org>
In-Reply-To: <20030821093037.64962c27.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Thu, 21 Aug 2003 08:05:04 -0500 Corey Minyard <cminyard@mvista.com> wrote:
>
>| This patch adds something I missed that previous IPMI drivers did, 
>| adding panic information to the event log. Some programs use this 
>
>adding to which event log?
>
This is the IPMI event log (the System Event Log).

>
>| information to analyze panics. Please apply.
>
>
>Few corrections below.
>
>
>diff -u -r1.3 Kconfig
>--- drivers/char/ipmi/Kconfig	28 Mar 2003 05:14:18 -0000	1.3
>+++ drivers/char/ipmi/Kconfig	19 Aug 2003 14:20:43 -0000
>@@ -24,6 +24,18 @@
> 	 generate an IPMI event describing the panic to each interface
> 	 registered with the message handler.
> 
>+config IPMI_PANIC_STRING
>+	bool 'Generate a OEM events holding the panic string'
>
>I can't decode/translate that quoted string...
>'an OEM event' ??
>s/holding/containing/ ??
>
I'll work on that.  Is the description below good enough?

>
>+	depends on IPMI_PANIC_EVENT
>+	help
>+	  When a panic occurs, this will cause the IPMI message handler to
>+	  generate an IPMI OEM type f0 events holding the IPMB address of the
>                                       event
>+	  panic generator (byte 4 of the event), a sequence number for the
>+	  string (byte 5 of the event) and part of the string (the rest of the
>+	  event).  Bytes 1, 2, and 3 are the normal usage for an OEM event.
>+	  You can fetch these events and use the sequence numbers to piece the
>+	  string together.
>+
> config IPMI_DEVICE_INTERFACE
>        tristate 'Device interface for IPMI'
>        depends on IPMI_HANDLER
>
>diff -u -r1.7 ipmi_msghandler.c
>--- drivers/char/ipmi/ipmi_msghandler.c	24 May 2003 17:02:51 -0000	1.7
>+++ drivers/char/ipmi/ipmi_msghandler.c	19 Aug 2003 14:20:45 -0000
>@@ -1813,18 +1829,48 @@
> {
> }
> 
>-static void send_panic_events(void)
>+#ifdef CONFIG_IPMI_PANIC_STRING
>+static void event_receiver_fetcher(ipmi_smi_t intf, struct ipmi_smi_msg *msg)
>+{
>+	if ((msg->rsp[0] == (0x5 << 2))
>
>Some named constants would be good here (defines/macros)
>and below.
>
Ok, I'm being lazy.

>+
>+		/* Request the device info from the local MC. */
>+		msg.netfn = 0x06; /* App. */
>+		msg.cmd = 0x01; /* Get device id cmd */
>+		msg.data = NULL;
>+		msg.data_len = 0;
>+		intf->null_user_handler = device_id_fetcher;
>+		i_ipmi_request(NULL,
>+			       intf,
>+			       &addr,
>+			       0,
>+			       &msg,
>+			       &smi_msg,
>+			       &recv_msg,
>+			       0,
>+			       intf->my_address,
>+			       intf->my_lun);
>
>Looks like a Windows interface call.  One parameter/line isn't needed.
>
It seems to me that with a function with this many parameter calls, it's 
a lot easier to handle them one per line, since counting lines is a lot 
easier than finding commas.  I'd prefer to leave this as is (I'll work 
on reducing the number of parameters, which is the real problem :-), but 
I'm not picky either way.  I didn't know Windows developers did this.

-Corey

