Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTFINXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 09:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTFINXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 09:23:37 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:50612 "EHLO
	mwinf0304.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264324AbTFINXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 09:23:36 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: chas williams <chas@cmf.nrl.navy.mil>,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Date: Mon, 9 Jun 2003 15:37:13 +0200
User-Agent: KMail/1.5.9
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <200306070350.h573oIsG004491@ginger.cmf.nrl.navy.mil>
In-Reply-To: <200306070350.h573oIsG004491@ginger.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306091537.13345.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> btw, you might get async device 'releases' more often than
> you would like.  some atm devices are usb and could be
> unplugged during operation (yes, that's really bad but it
> would be wise to be prepared for this.)  i actually have
> a cardbus atm interface.  i might eject it accidentally.

Right.  In the speedtouch (USB ATM DSL modem) driver, when the
device is unplugged I would have liked to be able to say to the
ATM layer: I've gone, don't call me any more.  But since there
is no way to do this, instead I do:

- refuse to open any more vccs; fail all attempts to send packets
- call shutdown_atm_dev.  This means that when the last vcc is
closed, atm_dev_close will be called in my driver.
- really shutdown in atm_dev_close

In practice that means that the vcc remains open until pppd realises
that the connection has gone down (no more echo requests getting
through, for example).  Maybe I should push a NULL skb down into
each vcc to get it to close?

Another thing: if the modem is plugged in again, and pppd relaunched,
it would be nice if connections that were open when the modem was
unplugged automagically recovered.  Is that possible?

Ciao,

Duncan.
