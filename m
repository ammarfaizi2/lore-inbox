Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbSKPUf4>; Sat, 16 Nov 2002 15:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbSKPUfz>; Sat, 16 Nov 2002 15:35:55 -0500
Received: from almesberger.net ([63.105.73.239]:16143 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267351AbSKPUfz>; Sat, 16 Nov 2002 15:35:55 -0500
Date: Sat, 16 Nov 2002 17:42:44 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lan based kgdb
Message-ID: <20021116174244.J1407@almesberger.net>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay> <ar3op8$f20$1@penguin.transmeta.com> <20021115222430.GA1877@tahoe.alcove-fr> <ar4h11$g7n$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar4h11$g7n$1@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Nov 16, 2002 at 04:19:45AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> And I suspect you're better off losing packets (very rarely over any
> normal local network) if that means that your debugger needs only
> minimal support. You can always re-type.

Of course, if your virtual LAN has several machines that all think
that congestion control only makes sense in a WAN setting, loss may
get quite common :-) I still have fond memories of shared Ethernet
melting down under the load of dozens of diskless clients rebooting
after some problem hit the cluster ...

Loss recovery doesn't have to be painful, and it can still be real
time. When sending, include the packet sequence number, and the
sequence number of the earliest packet buffered. Buffer up to N
packets after sending. Packets older than current_sequence-N drop
off the buffer and cannot be recovered. Receiver can request
retransmission of specific buffered packets. Retransmitted packets
carry an up to date earliest packet buffered sequence number.

This way, it's up to the receiver to decide what to do with lost
packets, e.g. request retransmission, and wait up to a certain
deadline, just flag the loss and proceed, of maybe flag the loss,
request retransmission, and when receiving the missing packet,
redraw the output.

Congestion control would be very good to have, though. As soon as
you put something on IP, it's almost guaranteed to eventually end
up crossing a WAN.

Crazy idea: maybe one could combine the ideas from MCORE and RT
Linux: use a dispatcher for basic system resources (interrupts,
etc.), and run two kernels. One of them would just run the
debugger and serve its communication needs. That would leave
things still relatively close to hardware (unlike just using
UML).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
