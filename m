Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVILRE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVILRE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbVILRE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:04:29 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:7330 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932101AbVILRE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:04:27 -0400
Date: Mon, 12 Sep 2005 12:04:22 -0500
From: serue@us.ibm.com
To: Alan Cox <alan@redhat.com>
Cc: Joel Schopp <jschopp@austin.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Message-ID: <20050912170422.GB6119@sergelap.austin.ibm.com>
References: <20050901035542.1c621af6.akpm@osdl.org> <6970000.1125584568@[10.10.2.4]> <20050901145006.GF5427@devserv.devel.redhat.com> <43176AE8.8060105@austin.ibm.com> <20050901211647.GC25405@devserv.devel.redhat.com> <431771EA.4030809@austin.ibm.com> <20050901214411.GD25405@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901214411.GD25405@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, this patch itself seems to have a few typos, but so does
the 2.6.13-mm{1,2,3}.

Quoting Alan Cox (alan@redhat.com):
> --- drivers/serial/icom.c~	2005-09-01 22:37:16.986829264 +0100
> +++ drivers/serial/icom.c	2005-09-01 22:37:16.986829264 +0100
> @@ -737,6 +737,7 @@
>  
>  	status = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].flags);
>  	while (status & SA_FL_RCV_DONE) {
> +		int first = -1;
>  
>  		trace(icom_port, "FID_STATUS", status);
>  		count = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].leLength);
> @@ -751,15 +752,17 @@
>  			icom_port->recv_buf_pci;
>  
>  		/* Block copy all but the last byte as this may have status */
> -		if(count > 0)
> +		if(count > 0) {
> +			first = icon->recv_buf[offset];
	s/icon/icom_port/ ?

>  			tty_insert_flip_string(tty, icon_port->recv_buf + offset, count - 1);

	s/icon_port/icom_port/ ?

> +		}
>  
>  		icount = &icom_port->uart_port.icount;
>  		icount->rx += count;
>  
>  		/* Break detect logic */
>  		if ((status & SA_FLAGS_FRAME_ERROR)
> -		    && (tty->flip.char_buf_ptr[0] == 0x00)) {
> +		    && first == 0) {
>  			status &= ~SA_FLAGS_FRAME_ERROR;
>  			status |= SA_FLAGS_BREAK_DET;
>  			trace(icom_port, "BREAK_DET", 0);

And in 2.6.13-mm3, we have:

@@ -798,33 +792,26 @@ static void recv_interrupt(u16 port_int_
 			status &= icom_port->read_status_mask;
 
 			if (status & SA_FLAGS_BREAK_DET) {
-				*tty->flip.flag_buf_ptr = TTY_BREAK;
+				flag = TTY_BREAK;
 			} else if (status & SA_FLAGS_PARITY_ERROR) {
 				trace(icom_port, "PARITY_ERROR", 0);
-				*tty->flip.flag_buf_ptr = TTY_PARITY;
+				flag = TTY_PARITY;
 			} else if (status & SA_FLAGS_FRAME_ERROR)
-				*tty->flip.flag_buf_ptr = TTY_FRAME;
+				flag = TTY_FRAME;
 
-			if (status & SA_FLAGS_OVERRUN) {
-				/*
-				 * Overrun is special, since it's
-				 * reported immediately, and doesn't
-				 * affect the current character
-				 */
-				if (tty->flip.count < TTY_FLIPBUF_SIZE) {
-					tty->flip.count++;
-					tty->flip.flag_buf_ptr++;
-					tty->flip.char_buf_ptr++;
-					*tty->flip.flag_buf_ptr = TTY_OVERRUN;
-				}
-			}
 		}
 
-		tty->flip.flag_buf_ptr++;
-		tty->flip.char_buf_ptr++;
-		tty->flip.count++;
-		ignore_char:
-			icom_port->statStg->rcv[rcv_buff].flags = 0;
+		tty_insert_flip_char(tty, icon_port->recv_buf + offset + count - 1, flag);
		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is this meant to be
	tty_insert_flip_char(tty, *(icon_port->recv_buf + offset + count - 1), flag);
?

+
+		if (status & SA_FLAGS_OVERRUN)
+			/*
+			 * Overrun is special, since it's
+			 * reported immediately, and doesn't
+			 * affect the current character
+			 */
+			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+ignore_char:
+		icom_port->statStg->rcv[rcv_buff].flags = 0;
 		icom_port->statStg->rcv[rcv_buff].leLength = 0;
 		icom_port->statStg->rcv[rcv_buff].WorkingLength =
 			(unsigned short int) cpu_to_le16(RCV_BUFF_SZ);

Again, sorry I didn't catch this back in -mm1 or -mm2...

thanks,
-serge
