Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUJHTB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUJHTB1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 15:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264648AbUJHTBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 15:01:21 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:45489 "EHLO
	mailfe04.swip.net") by vger.kernel.org with ESMTP id S263769AbUJHS7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:59:55 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Fri, 8 Oct 2004 20:59:50 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, sebastien.hinderer@libertysurf.fr
Subject: Re: [Patch] new serial flow control
Message-ID: <20041008185949.GA2275@bouh.is-a-geek.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Russell King <rmk@arm.linux.org.uk>,
	sebastien.hinderer@libertysurf.fr
References: <200410051249_MC3-1-8B8B-5504@compuserve.com> <20041005172522.GA2264@bouh.is-a-geek.org> <1097176130.31557.117.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1097176130.31557.117.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 07 oct 2004 à 20:08:56 +0100, Alan Cox wrote:
> On Maw, 2004-10-05 at 18:25, Samuel Thibault wrote:
> > No: data actually pass _after_ CTS and RTS are lowered back: the flow control
> > only indicate the beginning of one frame.
> 
> Ok I've pondered this somewhat. I don't think the hack proposed is the
> right answer for this. I believe you should implement a simple line
> discipline for this device so that it stays out of the general code.
> 
> Right now that poses a challenge but if drivers were to implement
> ldisc->modem_change() or a similar callback for such events an ldisc
> could then handle many of the grungy suprises and handle them once and
> in one place.

Serial drivers should then at least (when seeing ldisc->modem_change
!= NULL) do no RTS/CTS/DTR/etc handling at all (to avoid interfering),
and activate "MSI" for calling modem_change in the interrupt handler.

Being able to call port->ops->start/stop_tx by some way will also be
necessary, by grouping 
{
  struct uart_state *state = tty->driver_data;
  struct uart_port *port = state->port;
  tty->hw_stopped = 0;
  port->ops->start_tx(port, 0);
  uart_write_wakeup(port);
}
and its dual in some function for instance.

Regards,
Samuel Thibault
