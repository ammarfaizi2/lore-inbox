Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbTJXVYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbTJXVYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:24:53 -0400
Received: from smtp01.web.de ([217.72.192.180]:28932 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262647AbTJXVYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:24:48 -0400
From: Heinz-Georg Sawicki <hgsawicki@web.de>
Reply-To: hgsawicki@web.de
To: linux-kernel@vger.kernel.org
Subject: Bug+Bugfix: Serialdriver 2.6.0-test8(setting custum speed)
Date: Fri, 24 Oct 2003 23:19:57 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310242319.59470.hgsawicki@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

First excuse me for my bad english.
In case of custom speed the routine   uart_get_divisor  in  serial_core.c  
must calcuate the custom baudrate and return it to the caller. It may look
somewhat like this:

unsigned int
uart_get_divisor(struct uart_port *port, unsigned int* pBaud)
{
	unsigned int quot;

	/*
	 * Old custom speed handling.
	 */
	if (*pBaud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
    {
		quot = port->custom_divisor;
        *pBaud = port->uartclk / (16 * quot);
    }
	else
		quot = port->uartclk / (16 * (*pBaud));

	return quot;
}

This is necessary because  serial8250_set_termios  in   8250.c   uses the 
baudrate for setting the fifotriggerlevel

		if (baud < 2400)
			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
#ifdef CONFIG_SERIAL_8250_RSA
		else if (up->port.type == PORT_RSA)
			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_14;
#endif
		else
			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_8;

In my case i setup a customdivisor of 11520 to get a baudrate of 10 baud, to 
receive the dcf77-signal(UART 16550A, PC-Hardware). Instead of one byte per 
second i received 8 bytes at once because of the wrong triggerlevel. By 
setting the triggerlevel always to one 
		:
		else
			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;

i checked that this was the cause for the problem.

By the way, the comment

	/*
	 * Old custom speed handling.
	 */
 
says, that this is the old way for setting up a custom speed. Can you please 
tell me the new way for doing this. Thanks.

Have a nice day,

	Heinz-Georg Sawicki

