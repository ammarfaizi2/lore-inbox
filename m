Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSKNWJb>; Thu, 14 Nov 2002 17:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbSKNWIT>; Thu, 14 Nov 2002 17:08:19 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:34968 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S265320AbSKNWH7>;
	Thu, 14 Nov 2002 17:07:59 -0500
Date: Thu, 14 Nov 2002 21:05:51 +0000
From: Chuck Lever <cel@citi.umich.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new timeout behavior for RPC requests on TCP sockets
Message-ID: <20021114210551.GL28216@skynet.ie>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/PLAIN; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021114133025.13043B-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.24i
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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
