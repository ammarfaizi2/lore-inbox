Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTAFL2Q>; Mon, 6 Jan 2003 06:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266627AbTAFL2Q>; Mon, 6 Jan 2003 06:28:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31238 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266615AbTAFL2P>; Mon, 6 Jan 2003 06:28:15 -0500
Date: Mon, 6 Jan 2003 11:36:49 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, miles@gnu.org, dwmw2@redhat.com
Subject: Re: [SERIAL] change_speed -> settermios change
Message-ID: <20030106113649.A21952@flint.arm.linux.org.uk>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	linux-kernel@vger.kernel.org, miles@gnu.org, dwmw2@redhat.com
References: <20030103161916.A19992@flint.arm.linux.org.uk> <20030105.230218.84729944.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030105.230218.84729944.davem@redhat.com>; from davem@redhat.com on Sun, Jan 05, 2003 at 11:02:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 11:02:18PM -0800, David S. Miller wrote:
> Hmmm, maybe it's a better idea to store the min/max in the UART port
> structure and have the upper layer do the limiting before we call
> down into the driver?

I like that idea.  However, I'd rather not put these in the uart port
structure because:

1. the max/min would be dependent on the uart clock rate for ports which
   use a clock divisor.

2. the max/min rate may require driver specific knowledge (eg, when the
   port supports *2 and *4 high speed modes)

3. the max/min might be constant for certain ports (eg, sunsab, nb85e)

I'm currently considering whether to pass the max / min into
uart_get_baud_rate(), along with the old termios:

a) move the loop out of uart_get_divisor() into uart_get_baud_rate()
b) uart_get_divisor() would be responsible for providing
   uart_get_baud_rate() with the appropriate min/max for case (1).
c) for case (2), the driver itself would pass these parameters itself.
   Whether or not the min/max depend on the uart clock rate is something
   which only the driver itself can know.

There is a fourth case which I didn't list above:

4. ports that use the raw baud rate may not support all baud rates that
   we are able to pass between a maximum and minimum.

This is outside our current scope at the moment (the usb serial drivers),
and from reading the usb code, it is unclear whether this is an issue for
any of these drivers.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

