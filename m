Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161072AbVIPPkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbVIPPkN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbVIPPkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:40:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:9923 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161072AbVIPPkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:40:12 -0400
Date: Fri, 16 Sep 2005 12:49:39 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc1-mm1
Message-ID: <20050916174939.GA3916@IBM-BWN8ZTBWAO1>
References: <20050916022319.12bf53f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050916022319.12bf53f3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I still need the following two patches against icom.c (the first
from Alan cox) applied.  With these, 2.6.14-rc1-mm1 compiles and
boots on my power5 machine.

thanks,
-serge

Index: linux-2.6.13-rc7/drivers/serial/icom.c
===================================================================
--- linux-2.6.13-rc7.orig/drivers/serial/icom.c	2005-09-16 15:22:57.000000000 -0500
+++ linux-2.6.13-rc7/drivers/serial/icom.c	2005-09-16 15:27:15.000000000 -0500
@@ -736,6 +736,7 @@ static void recv_interrupt(u16 port_int_
 
 	status = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].flags);
 	while (status & SA_FL_RCV_DONE) {
+		int first = -1;
 
 		trace(icom_port, "FID_STATUS", status);
 		count = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].leLength);
@@ -750,15 +751,17 @@ static void recv_interrupt(u16 port_int_
 			icom_port->recv_buf_pci;
 
 		/* Block copy all but the last byte as this may have status */
-		if(count > 0)
+		if(count > 0) {
+			first = icon->recv_buf[offset];
 			tty_insert_flip_string(tty, icon_port->recv_buf + offset, count - 1);
+		}
 
 		icount = &icom_port->uart_port.icount;
 		icount->rx += count;
 
 		/* Break detect logic */
 		if ((status & SA_FLAGS_FRAME_ERROR)
-		    && (tty->flip.char_buf_ptr[0] == 0x00)) {
+		    && first == 0) {
 			status &= ~SA_FLAGS_FRAME_ERROR;
 			status |= SA_FLAGS_BREAK_DET;
 			trace(icom_port, "BREAK_DET", 0);


Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.13-rc7/drivers/serial/icom.c
===================================================================
--- linux-2.6.13-rc7.orig/drivers/serial/icom.c	2005-09-16 15:27:15.000000000 -0500
+++ linux-2.6.13-rc7/drivers/serial/icom.c	2005-09-16 15:28:26.000000000 -0500
@@ -752,8 +752,8 @@ static void recv_interrupt(u16 port_int_
 
 		/* Block copy all but the last byte as this may have status */
 		if(count > 0) {
-			first = icon->recv_buf[offset];
-			tty_insert_flip_string(tty, icon_port->recv_buf + offset, count - 1);
+			first = icom_port->recv_buf[offset];
+			tty_insert_flip_string(tty, icom_port->recv_buf + offset, count - 1);
 		}
 
 		icount = &icom_port->uart_port.icount;
@@ -804,7 +804,7 @@ static void recv_interrupt(u16 port_int_
 
 		}
 
-		tty_insert_flip_char(tty, icon_port->recv_buf + offset + count - 1, flag);
+		tty_insert_flip_char(tty, *(icom_port->recv_buf + offset + count - 1), flag);
 
 		if (status & SA_FLAGS_OVERRUN)
 			/*

