Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129926AbRCAUbK>; Thu, 1 Mar 2001 15:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129910AbRCAUah>; Thu, 1 Mar 2001 15:30:37 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129875AbRCAUa2>;
	Thu, 1 Mar 2001 15:30:28 -0500
Date: Sat, 1 Jan 2000 01:38:17 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.1 network (socket) performance
Message-ID: <20000101013817.B28@(none)>
In-Reply-To: <Pine.LNX.3.95.1010222110641.2828A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.95.1010222110641.2828A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Feb 22, 2001 at 11:11:28AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hello, I am trying to find the reason for very, very poor network
> performance with sustained data transfers on Linux 2.4.1. I found
> a work-around, but don't think user-mode code should have to provide
> such work-arounds.
> 
>    In the following, with Linux 2.4.1, on a dedicated 100/Base
>    link:
> 
>         s = socket connected to DISCARD (null-sink) server.
> 
>         while(len)
>         {
>             stat = write(s, buf, min(len, MTU));
>             /* Yes, I do check for an error */
>             buf += stat;
>             len -= stat;
>         }
> 
> Data length is 0x00010000 bytes.
> 
> MTU              Average trans rate   Fastest trans rate
> ----             -----------------    -----------------
> 65536            0.468 Mb/s           0.902 Mb/s
> 32768            0.684 Mb/s           0.813 Mb/s
> 16384            2.989 Mb/s           3.121 Mb/s
> 8192             5.211 Mb/s           6.160 Mb/s
> 4094             8.212 Mb/s           9.101 Mb/s
> 2048             8.561 Mb/s           9.280 Mb/s
> 1024             7.250 Mb/s           7.500 Mb/s
> 512              4.818 Mb/s           5.107 Mb/s
> 
> As you can see, there is a maximum data length that can be
> handled with reasonable speed from a socket. Trying to find
> out what that was, I discovered that the best MTU was 3924.
> I don't know why. It shows:

Looks like that's page_size - epsilon.

> MTU              Average trans rate   Fastest trans rate
> ----             -----------------    -----------------
> 3924             8.920 Mb/s           9.31 Mb/s

But even this is *not* reasonable speed for 100MBit ethernet!

> If the user's data length is higher than this, there is a 1/100th
> of a second wait between packets.  The larger the user's data length,
> the more the data gets chopped up into 1/100th of a second intervals.
> 
> It looks as though user data that can't fit into two Ethernet packets
> is queued until the next time-slice on a 100 Hz system. This severely
> hurts sustained data performance. The performance with a single
> 64k data buffer is abysmal. If it gets chopped up into 2048 byte
> blocks in user-space, it's reasonable.
> 
> Both machines are Dual Pentium 600 MHz machines with identical eepro100
> Ethernet boards. I substituted, LANCE (Hewlett Packard), and 3COM boards
> (3c59x) with essentially no change.

Strange. Do you have interrupts working okay? [I'm able to get 4Mbit with
ne2000 hooked on timer IRQ, so this is not totally stupid Question.]

> Does this point out a problem? Or should user-mode code be required

Definitely problem.

> to chop up data lengths to something more "reasonable" for the kernel?
> If so, how does the user know what "reasonable" is?

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

