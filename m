Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263503AbTD1Gbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 02:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTD1Gbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 02:31:47 -0400
Received: from elaine24.Stanford.EDU ([171.64.15.99]:22686 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263503AbTD1Gbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 02:31:45 -0400
Date: Sun, 27 Apr 2003 23:43:56 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>
cc: mc@cs.stanford.edu
Subject: [CHECKER] 3 potential user-pointer errors in drivers/usb/serial that
 can print out arbitrary kernel data
In-Reply-To: <Pine.GSO.4.44.0304251855390.21961-100000@elaine24.Stanford.EDU>
Message-ID: <Pine.GSO.4.44.0304272336001.15277-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I classfied the errors in my previous report. Here are 3 errors that allow
a malicious user to print out arbitrary kernel data. (the 4th error is at
least bad programming practice.)

All of them are in usb/serial.

Any replies will be appreciated.

---------------------------------------------------------
[BUG] buf is tainted. can print out arbitrary kernel data if debug is on
/home/junfeng/linux-tainted/drivers/usb/serial/empeg.c:225:empeg_write:
ERROR:TAINTED:225:225: passing tainted ptr 'buf' to usb_serial_debug_data
[Callstack:
/home/junfeng/linux-tainted/drivers/usb/serial/safe_serial.c:327:empeg_write((tainted
2))]

	int bytes_sent = 0;
	int transfer_size;

	dbg("%s - port %d", __FUNCTION__, port->number);


Error --->
	usb_serial_debug_data (__FILE__, __FUNCTION__, count, buf);

	while (count > 0) {

---------------------------------------------------------
[BUG] can print out arbitrary kernel data if debug is on
/home/junfeng/linux-tainted/drivers/usb/serial/ipaq.c:371:ipaq_write:
ERROR:TAINTED:371:371: passing tainted ptr 'buf' to usb_serial_debug_data
[Callstack:
/home/junfeng/linux-tainted/drivers/usb/serial/safe_serial.c:327:ipaq_write((tainted
2))]

	int			bytes_sent = 0;
	int			transfer_size;

	dbg("%s - port %d", __FUNCTION__, port->number);


Error --->
	usb_serial_debug_data(__FILE__, __FUNCTION__, count, buf);

	while (count > 0) {
		transfer_size = min(count, PACKET_SIZE);
---------------------------------------------------------
[BUG] can print out arbitrary kernel data if debug is on
/home/junfeng/linux-tainted/drivers/usb/serial/keyspan.c:328:keyspan_write:
ERROR:TAINTED:328:328: dereferencing tainted ptr 'buf' [Callstack: ]


	p_priv = usb_get_serial_port_data(port);
	d_details = p_priv->device_details;

	dbg("%s - for port %d (%d chars [%x]), flip=%d",

Error --->
	    __FUNCTION__, port->number, count, buf[0], p_priv->out_flip);

	for (left = count; left > 0; left -= todo) {
		todo = left;



---------------------------------------------------------
[BUG] at least bad programming practice. call usb_serial_debug_data on
tainted pointer data. it is verified by previous call to copy_*_user.

/home/junfeng/linux-tainted/drivers/usb/serial/io_edgeport.c:1381:edge_write:
ERROR:TAINTED:1381:1381: passing tainted ptr 'data' to
usb_serial_debug_data [Callstack: ]

		fifo->head  += secondhalf;
		// No need to check for wrap since we can not get to end
of fifo in this part
	}

	if (copySize) {

Error --->
		usb_serial_debug_data (__FILE__, __FUNCTION__, copySize,
data);
	}

	send_more_port_data((struct edgeport_serial
*)usb_get_serial_data(port->serial), edge_port);


