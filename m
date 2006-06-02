Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWFBGtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWFBGtV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWFBGtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:49:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52154 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751214AbWFBGtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:49:21 -0400
Date: Thu, 1 Jun 2006 23:48:33 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-Id: <20060601234833.adf12249.zaitcev@redhat.com>
In-Reply-To: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 00:03:06 -0300, "Luiz Fernando N.Capitulino" <lcapitulino@mandriva.com.br> wrote:

This looks interesting, although I do not know if it buys us much.
The code seems sane at first view. The private lock inside pl2303
saves you from the most obvious races.

>  The tests I've done so far weren't anything serious: as the mobile supports a
> AT command set, I have used the ones (with minicom) which transfers more data.
> Of course that I also did module load/unload tests, tried to disconnect the
> device while it's transfering data and so on.

Next, it would be nice to test if PPP works, and if getty and shell work
(with getty driving the USB-to-serial adapter).

> +static void serial_send_xchar(struct uart_port *port, char ch)
> +{
> +	USBSERIAL_PORT->serial->type->uart_ops->send_xchar(port, ch);
>  }

I think you just inherited a mistake in usb-serial design. It attempts
to act as an adaptation layer (like, say, USB core itself) instead of
a library like libata. Why can't the UART framework call pl2303?

Also this meaningless obfuscation has to go:

> +#define USBSERIAL_PORT ((struct usb_serial_port *)port)
> +static void pl2303_start_tx(struct uart_port *port)
> +{
> +	struct usb_serial_port *usp = USBSERIAL_PORT;

Greetings,
-- Pete
