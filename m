Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSLHKLC>; Sun, 8 Dec 2002 05:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSLHKLC>; Sun, 8 Dec 2002 05:11:02 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32527 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265275AbSLHKLB>; Sun, 8 Dec 2002 05:11:01 -0500
Date: Sun, 8 Dec 2002 10:18:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reference counting in console uarts
Message-ID: <20021208101838.A30105@flint.arm.linux.org.uk>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20021208024336.A23637@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021208024336.A23637@devserv.devel.redhat.com>; from zaitcev@redhat.com on Sun, Dec 08, 2002 at 02:43:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 02:43:36AM -0500, Pete Zaitcev wrote:
> I boot my 2.5 boxes using "console=ttyS0,9600" argument,
> and I noticed that something is not right with reference
> counting in this case. It seems that when the console
> is open by kernel initially, this is not accounted
> as an open, and uart_startup is not called. This is ok,
> because the serial console is set up separately. However, later
> every script or a program run by init causes a startup
> and shutdown, literally dozens of them. These oscillations only
> stop when daemons are started and keep console open.

That is correct.  We are unable to call uart_startup when the serial
console is initialised because it may need to allocate memory (as
request_irq does) and the memory allocators may not have been
initialised.

There are two ways around this problem:

1. initialise the port into a state where it can send characters in the
   console write method.

2. don't do the actual hardware shutdown in your shutdown() method (but
   do the normal software shutdown - ie, free irqs etc)

8250 ports in effect implement the first - they don't really care about
their setup to send characters.  We just disable all interrupts from the
chip and then perform polled IO to the port.

In essence, you need your console write method to be able to send
charcters whether or not the port has been initialised or shutdown
by the conventional tty driver methods.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
