Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129818AbRBVQMJ>; Thu, 22 Feb 2001 11:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130089AbRBVQL6>; Thu, 22 Feb 2001 11:11:58 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59265 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129818AbRBVQLq>; Thu, 22 Feb 2001 11:11:46 -0500
Date: Thu, 22 Feb 2001 11:11:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.1 network (socket) performance
Message-ID: <Pine.LNX.3.95.1010222110641.2828A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, I am trying to find the reason for very, very poor network
performance with sustained data transfers on Linux 2.4.1. I found
a work-around, but don't think user-mode code should have to provide
such work-arounds.

   In the following, with Linux 2.4.1, on a dedicated 100/Base
   link:

        s = socket connected to DISCARD (null-sink) server.

        while(len)
        {
            stat = write(s, buf, min(len, MTU));
            /* Yes, I do check for an error */
            buf += stat;
            len -= stat;
        }

Data length is 0x00010000 bytes.

MTU              Average trans rate   Fastest trans rate
----             -----------------    -----------------
65536            0.468 Mb/s           0.902 Mb/s
32768            0.684 Mb/s           0.813 Mb/s
16384            2.989 Mb/s           3.121 Mb/s
8192             5.211 Mb/s           6.160 Mb/s
4094             8.212 Mb/s           9.101 Mb/s
2048             8.561 Mb/s           9.280 Mb/s
1024             7.250 Mb/s           7.500 Mb/s
512              4.818 Mb/s           5.107 Mb/s

As you can see, there is a maximum data length that can be
handled with reasonable speed from a socket. Trying to find
out what that was, I discovered that the best MTU was 3924.
I don't know why. It shows:

MTU              Average trans rate   Fastest trans rate
----             -----------------    -----------------
3924             8.920 Mb/s           9.31 Mb/s

If the user's data length is higher than this, there is a 1/100th
of a second wait between packets.  The larger the user's data length,
the more the data gets chopped up into 1/100th of a second intervals.

It looks as though user data that can't fit into two Ethernet packets
is queued until the next time-slice on a 100 Hz system. This severely
hurts sustained data performance. The performance with a single
64k data buffer is abysmal. If it gets chopped up into 2048 byte
blocks in user-space, it's reasonable.

Both machines are Dual Pentium 600 MHz machines with identical eepro100
Ethernet boards. I substituted, LANCE (Hewlett Packard), and 3COM boards
(3c59x) with essentially no change.

Does this point out a problem? Or should user-mode code be required
to chop up data lengths to something more "reasonable" for the kernel?
If so, how does the user know what "reasonable" is?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


