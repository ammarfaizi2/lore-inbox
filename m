Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUJASUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUJASUi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 14:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUJAST3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 14:19:29 -0400
Received: from corb.mc.mpls.visi.com ([208.42.156.1]:23717 "EHLO
	corb.mc.mpls.visi.com") by vger.kernel.org with ESMTP
	id S265996AbUJASRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 14:17:55 -0400
Message-ID: <415D9E96.1030207@steinerpoint.com>
Date: Fri, 01 Oct 2004 13:14:46 -0500
From: Al Borchers <alborchers@steinerpoint.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: new locking in change_termios breaks USB
 serial drivers
References: <415D3408.8070201@steinerpoint.com>	 <1096630567.21871.4.camel@localhost.localdomain>	 <415D84A3.6010105@steinerpoint.com> <1096645773.21958.54.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> In a waiting case the driver will get
> 
> 	->chars_in_buffer
> 		until it returns zero
> 	->wait_until_sent
> 	->change_termios
>
> which serializes with respect to the one writer. If you have a writer
> during a termios change by another well tough luck, you lose and I've
> no intention of changing that behaviour unless someone cites a standard
> requiring it.

Right, of course.

My comments about TCSETAW just muddled the issue.  Scratch those.

The problem is that a non-sleeping USB serial set_termios has to
return before it can be sure the termios settings have taken effect.
With USB we can send an urb to the device telling it to change termios
settings, but without waiting for the urb callback we don't know
that the device has received the command and actually changed the
settings.

So data written immediately following the set_termios, in the same
process, might possibly be sent out the serial port before the
termios changes have taken effect.

There are several solutions:

* The tty layer could use a semaphore so the USB serial set_termios could
   sleep until the new termios settings have taken effect before returning.

* The USB serial driver could hold off sending data to the device after a
   non-sleeping set_termios until it knew the settings had taken effect in
   the device.

* Maybe in practice this is not a problem--we can just say "set_termios
   for USB serial devices will change the termios settings as soon as
   possible, but there is a slight chance data written immediately after
   set termios might go out under the previous termios settings".

* Or ... other suggestions?

-- Al

