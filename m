Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291279AbSBGUbY>; Thu, 7 Feb 2002 15:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291280AbSBGUbS>; Thu, 7 Feb 2002 15:31:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:49796 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S291279AbSBGUbK>; Thu, 7 Feb 2002 15:31:10 -0500
Date: Thu, 7 Feb 2002 15:33:54 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: "Perches, Joe" <joe.perches@spirentcom.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: want opinions on possible glitch in 2.4 network error reporti ng
In-Reply-To: <3C62CB25.75487AD5@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1020207151325.10014A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Chris Friesen wrote:

> "Richard B. Johnson" wrote:
> > 
> > On Thu, 7 Feb 2002, Perches, Joe wrote:
> > [SNIPPED..]

> 
> Is there any syscall that can guarantee that a single packet has been sent out
> over the wire?  Suppose I want to broadcast an ARP packet.  If I make a packet
> socket and call sendto() on it, I want a guarantee that the packet will make it
> out onto the wire, or the sendto() should fail.

No. Look at how it works. You can guarantee that a packet gets into
the SNIC (Serial Network Interface Controller). If it is congested
or blocked, the hardware will retry for a number of times (typically 15).

However, after that, all bets are off. Note that it is possible for
a physical link to be disconnected at any time. Your SNIC may be connected
to a hub or switch so it "thinks" everything is fine. The message went
out over-the-wire. However, it just fell out the end of a fibre link
connecting your sub-nets and you will never know it at all.

Physical links are, by definition, not reliable links. To obtain a
reliable link, you need to establish a "connection". A connection uses
the basic unreliable UDP and unreliable physical links for lower-level
transfer, in conjunction with end-points that will continue to do whatever
is necessary to send/receive buffers of data (not packets). The buffer you
provide is guaranteed to get there, intact, if you wait long enough. What
is never guaranteed is the time for the buffer to get to its destination.
This time may be several days (no joke). This is useful! You can have
a ftp transfer in progress and have a router crash. After the router
comes back up, the transfer will continue.

> 
> UDP failing I can understand (kind of, anyway) but for raw sockets, packet
> sockets, etc. I think there should be at least some kind of mechanism to
> bypass
> all the congestion controls and either shove the packet onto the device's tx
> buffer or return a failure code.
> 

See above.

> The possibility of random dropping of packets in the kernel means that an
> infinite loop on sendto() will chew up the entire machine even if you've only
> got a 10Mbit/s link.  This seems just wrong.
>

This is the basic reason why the return-value of sento() should be
ignored, even though Alan doesn't agree. Basically, if you give
valid parameters to sendto() (correct socket, pointer to correct
structure, etc), you can just ignore the return value. Its not useful
in the overall scheme. If you must make sure that a UDP packet got
to a receiver, then the receiver must (somehow) hand-shake with you.
How you do the handshake is entirely up to you. UDP stands for
User Datagram Protocol. It's a quick-fling out the spicket. How you
handle lost messages is up to the user.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


