Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUJAQwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUJAQwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUJAQwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:52:15 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:32658 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264954AbUJAQwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:52:13 -0400
Subject: Re: new locking in change_termios breaks USB serial drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Al Borchers <alborchers@steinerpoint.com>
Cc: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <415D84A3.6010105@steinerpoint.com>
References: <415D3408.8070201@steinerpoint.com>
	 <1096630567.21871.4.camel@localhost.localdomain>
	 <415D84A3.6010105@steinerpoint.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096645773.21958.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 01 Oct 2004 16:49:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-10-01 at 17:24, Al Borchers wrote:
> Its a design decision for the tty layer.  You should choose whatever is
> best there and the drivers will have to adapt.

>From a tty layer I don't think there is a motivation to enforce no
sleep. Hopefully nobody has a reason to need to fiddle with termios
data in their IRQ handlers ?

> To correctly support TCSETAW/TCSETSW the USB serial drivers would have to
> have two different versions of set_termios--a non sleeping one to be called

Providing the driver isnt sticking its nose into ->ioctl the tty layer
core already correctly handles TCSETAW for you because it uses
tty_wait_until_sent before issuing the change. You don't have to deal
with that providing you've implemented driver->chars_in_buffer, and
if neccessary ->wait_until_sent.

In a waiting case the driver will get

	->chars_in_buffer
		until it returns zero
	->wait_until_sent
	->change_termios

which serializes with respect to the one writer. If you have a writer
during a termios change by another well tough luck, you lose and I've
no intention of changing that behaviour unless someone cites a standard
requiring it.


