Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTD2HMi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 03:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbTD2HMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 03:12:38 -0400
Received: from granite.he.net ([216.218.226.66]:31758 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261974AbTD2HMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 03:12:36 -0400
Date: Tue, 29 Apr 2003 00:25:00 -0700
From: Greg KH <greg@kroah.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chris@wirex.com>,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] 3 potential user-pointer errors in drivers/usb/serial that can print out arbitrary kernel data
Message-ID: <20030429072500.GA4616@kroah.com>
References: <Pine.GSO.4.44.0304251855390.21961-100000@elaine24.Stanford.EDU> <Pine.GSO.4.44.0304272336001.15277-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0304272336001.15277-100000@elaine24.Stanford.EDU>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 11:43:56PM -0700, Junfeng Yang wrote:
> 
> ---------------------------------------------------------
> [BUG] buf is tainted. can print out arbitrary kernel data if debug is on
> /home/junfeng/linux-tainted/drivers/usb/serial/empeg.c:225:empeg_write:
> ERROR:TAINTED:225:225: passing tainted ptr 'buf' to usb_serial_debug_data
> [Callstack:
> /home/junfeng/linux-tainted/drivers/usb/serial/safe_serial.c:327:empeg_write((tainted
> 2))]
> 
> 	int bytes_sent = 0;
> 	int transfer_size;
> 
> 	dbg("%s - port %d", __FUNCTION__, port->number);
> 
> 
> Error --->
> 	usb_serial_debug_data (__FILE__, __FUNCTION__, count, buf);
> 
> 	while (count > 0) {

Real problem, I'll fix it.

> ---------------------------------------------------------
> [BUG] can print out arbitrary kernel data if debug is on
> /home/junfeng/linux-tainted/drivers/usb/serial/ipaq.c:371:ipaq_write:
> ERROR:TAINTED:371:371: passing tainted ptr 'buf' to usb_serial_debug_data
> [Callstack:
> /home/junfeng/linux-tainted/drivers/usb/serial/safe_serial.c:327:ipaq_write((tainted
> 2))]
> 
> 	int			bytes_sent = 0;
> 	int			transfer_size;
> 
> 	dbg("%s - port %d", __FUNCTION__, port->number);
> 
> 
> Error --->
> 	usb_serial_debug_data(__FILE__, __FUNCTION__, count, buf);

Real problem, I'll fix it.

> ---------------------------------------------------------
> [BUG] can print out arbitrary kernel data if debug is on
> /home/junfeng/linux-tainted/drivers/usb/serial/keyspan.c:328:keyspan_write:
> ERROR:TAINTED:328:328: dereferencing tainted ptr 'buf' [Callstack: ]
> 
> 
> 	p_priv = usb_get_serial_port_data(port);
> 	d_details = p_priv->device_details;
> 
> 	dbg("%s - for port %d (%d chars [%x]), flip=%d",
> 
> Error --->
> 	    __FUNCTION__, port->number, count, buf[0], p_priv->out_flip);

Real problem, I'll fix it.

> ---------------------------------------------------------
> [BUG] at least bad programming practice. call usb_serial_debug_data on
> tainted pointer data. it is verified by previous call to copy_*_user.
> 
> /home/junfeng/linux-tainted/drivers/usb/serial/io_edgeport.c:1381:edge_write:
> ERROR:TAINTED:1381:1381: passing tainted ptr 'data' to
> usb_serial_debug_data [Callstack: ]
> 
> 		fifo->head  += secondhalf;
> 		// No need to check for wrap since we can not get to end
> of fifo in this part
> 	}
> 
> 	if (copySize) {
> 
> Error --->
> 		usb_serial_debug_data (__FILE__, __FUNCTION__, copySize,
> data);

Again, a real problem, I'll fix it.

Thanks a lot for finding these, I think these problems are also in
2.4...


greg k-h
