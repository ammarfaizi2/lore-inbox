Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWDZPOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWDZPOx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 11:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWDZPOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 11:14:53 -0400
Received: from www19.your-server.de ([213.133.104.19]:64266 "EHLO
	www19.your-server.de") by vger.kernel.org with ESMTP
	id S932476AbWDZPOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 11:14:52 -0400
From: Uli Luckas <u.luckas@road-gmbh.de>
Organization: Road GmbH
To: linux-kernel@vger.kernel.org
Subject: Bug in 8250/serial_core suspend code.
Date: Wed, 26 Apr 2006 17:14:48 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261714.48363.u.luckas@road-gmbh.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
there is a bug in recent kernel's suspend code for serial drivers, at least 
for 8250 and pxa, probably others though.

When suspending (e.g. apm --suspend) a machine, the serial_core suspend code 
tries to disable modem control lines (including RTS):
http://sosdg.org/~coywolf/lxr/source/drivers/serial/serial_core.c?v=2.6;a=arm#L1926
This is needed to stop the other side of a serial link from sending any data 
after our serial port has been disabled.

Now in line 1937 ops->shutdown(port) is called. For 8250 this points to 
serial8250_shutdown, for pxa to serial_pxa_shutdown. Both call 
xxx__set_mctrl(&up->port, up->port.mctrl) which will restore the old control 
line values and reverse the intended effect.

I am not quite sure about the right approach to fixing this. Should 
uart_suspend_port set port.mctrl to 0 after saveing it's old value? Or should 
serial8250_shutdown simply set port.mctrl to 0?

Please also reply in private mail, as I am not subscribed.

Thanks for your help
Uli
