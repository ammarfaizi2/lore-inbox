Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264747AbSJOUfV>; Tue, 15 Oct 2002 16:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264750AbSJOUfU>; Tue, 15 Oct 2002 16:35:20 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:38811 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264747AbSJOUe3>;
	Tue, 15 Oct 2002 16:34:29 -0400
Subject: Re: 2.5.x opps stopping serial
From: Paul Larson <plars@linuxtestproject.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <200210110845.24687.tomlins@cam.org>
References: <3DA683F4.944DFC11@digeo.com> 
	<200210110845.24687.tomlins@cam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 15 Oct 2002 15:33:07 -0500
Message-Id: <1034713993.17565.34.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-11 at 07:45, Ed Tomlinson wrote:
> Hi,
> 
> I have been seeing this during shutdown ever since I started using 2.5.  Figured
> I really should report it...   There are three serial ports.  One for a serial console,
> the second for a backUPS ups, the third for a (real) modem.  Dist is debian sid.
> 
> Saving state of known serial devices... Unable to handle kernel NULL pointer dereference at virtual addres
Looks like it might be similar to one I saw with smatch recently.  There
are several places in core.c that check info->tty before dereferencing
it, but others that don't.  I don't think this will fix the one you are
seeing, but if it's easily reproducible you could try doing something
similar in uart_block_til_ready.

--- linux-2.5/drivers/serial/core.c	Wed Oct  9 13:45:11 2002
+++ linux-corefix/drivers/serial/core.c	Wed Oct  9 13:50:09 2002
@@ -207,7 +207,7 @@
 			 * Setup the RTS and DTR signals once the
 			 * port is open and ready to respond.
 			 */
-			if (info->tty->termios->c_cflag & CBAUD)
+			if (info->tty && (info->tty->termios->c_cflag & CBAUD))
 				uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
 		}
 
Thanks,
Paul Larson

