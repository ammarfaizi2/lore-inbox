Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUJAQaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUJAQaB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJAQaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:30:01 -0400
Received: from conn.mc.mpls.visi.com ([208.42.156.2]:56706 "EHLO
	conn.mc.mpls.visi.com") by vger.kernel.org with ESMTP
	id S264377AbUJAQ1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:27:13 -0400
Message-ID: <415D84A3.6010105@steinerpoint.com>
Date: Fri, 01 Oct 2004 11:24:03 -0500
From: Al Borchers <alborchers@steinerpoint.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: new locking in change_termios breaks USB serial drivers
References: <415D3408.8070201@steinerpoint.com> <1096630567.21871.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> How much of a problem is this, would it make more sense to make the
> termios locking also include a semaphore to serialize driver side events
> and not the spin lock ?

Its a design decision for the tty layer.  You should choose whatever is
best there and the drivers will have to adapt.

I don't know how many tty drivers have assumed that set_termios can sleep,
like the USB serial drivers have.  If that is an implicit part of tty API
that other drivers depend on, then, if possible, it seems much better to keep
the API the same and continue to allow set_termios to sleep.

I think the USB serial drivers can just queue up urbs to the device
with commands to set the termios settings and return without waiting
for those urbs to complete.  There are potential synchronization issues,
however.  The termios settings might go into different USB queues than
the data, and so it is possible that data sent immediately after a
set_termios might get to the device before the new termios settings.

To correctly support TCSETAW/TCSETSW the USB serial drivers would have to
have two different versions of set_termios--a non sleeping one to be called
through the tty API and a sleeping one to use with TCSETAW/TCSETSW ioctls
so the ioctl would not return until the settings were guaranteed to have
taken effect.  Not many USB serial drivers support TCSETAW/TCSETSW now.

-- Al


