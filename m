Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265190AbSKNUTw>; Thu, 14 Nov 2002 15:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265191AbSKNUTw>; Thu, 14 Nov 2002 15:19:52 -0500
Received: from citi.umich.edu ([141.211.92.141]:1850 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S265190AbSKNUTu>;
	Thu, 14 Nov 2002 15:19:50 -0500
Date: Thu, 14 Nov 2002 15:26:43 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new timeout behavior for RPC requests on TCP sockets
In-Reply-To: <Pine.LNX.3.95.1021114133025.13043B-100000@chaos.analogic.com>
Message-ID: <Pine.BSO.4.33.0211141435330.28958-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Richard B. Johnson wrote:

> Because all of the RPC stuff was, initially, user-mode code.

if you mean ti-rpc, that stuff comes from sun.  the linux kernel ONC/RPC
implementation is not based on the ti-rpc code because, being Transport
Independent, ti-rpc is less than optimally efficient.  also, it is
covered by a restrictive license agreement, so that code base can't be
included in the linux kernel.

> Now, when something goes wrong with that code, should
> that code be fixed, or should the unrelated TCP/IP code be modified
> to accommodate?

obviously the RPC client should be fixed....

> I think the time-outs should be put at the correct
> places and not added to generic network code.

...which is exactly what i did.

the new RPC retransmission logic is in net/sunrpc/clnt.c:call_timeout,
which is strictly a part of the RPC client's finite state machine.
underlying TCP retransmit behavior is not changed by this patch.  the
changes apply to the RPC client only, which resides above the socket
layer.

let me go over the changes again.  the RPC client sets a timeout after
sending each request.  if it doesn't receive a valid reply for a request
within the timeout interval, a "minor" timeout occurs.  after each
timeout, the RPC client doubles the timeout interval until it reaches a
maximum value.

for RPC over UDP, short timeouts and retransmission back-off make sense.
for TCP, retransmission is built into the underlying protocol, so it makes
more sense to use a constant long retransmit timeout.

a "major" timeout occurs after several "minor" timeouts.  this is an
ad-hoc mechanism for detecting that a server is actually down, rather than
just a few requests have been lost.  a "server not responding" message in
the kernel log appears when a major timeout occurs.

for UDP, there is no way a client can tell the server has gone away except
by noticing that the server is not sending any replies.  TCP sockets
require a bit more cleanup when one end dies, however, since both ends
maintain some connection state.

i've changed the RPC client's timeout behavior when it uses a TCP socket
rather than a UDP socket to connect to a server:

+  after a minor RPC retransmit timeout on a TCP socket, the RPC client
   uses the same retransmit timeout value when retransmitting the request
   rather than doubling it, as it would on a UDP socket.

+  after a major RPC retransmit timeout on a TCP socket, close the socket.
   the RPC finite state machine will notice the socket is no longer
   connected, and attempt to reestablish a connection when it retries
   the request again.

this means that after a few retransmissions, the RPC client closes the
transport socket.  if a server hasn't responded after several retransmissions,
the client now assumes that it has crashed and has lost all connection
state, so it will reestablish a fresh connection with the server.

this behavior is recommended for NFSv2 and v3 over TCP, and is required
for NFSv4 over TCP (RFC3010).

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>


