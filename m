Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbTGGFkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 01:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbTGGFkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 01:40:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:45965 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266831AbTGGFkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 01:40:16 -0400
Message-ID: <3F090A4F.10004@us.ibm.com>
Date: Sun, 06 Jul 2003 22:51:11 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Albrecht <palbrecht@qwest.net>
CC: linux-kernel@vger.kernel.org, netdev <netdev@oss.sgi.com>
Subject: Re: question about linux tcp request queue handling
References: <3F08858E.8000907@us.ibm.com> <001a01c3441c$6fe111a0$6801a8c0@oemcomputer> <3F08B7E2.7040208@us.ibm.com> <000d01c3444f$e6439600$6801a8c0@oemcomputer>
In-Reply-To: <000d01c3444f$e6439600$6801a8c0@oemcomputer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Albrecht wrote:

>>When you set a the backlog to 1 in the listen call, what is
>>being capped is the accept queue. So I would expect your
>>server to allow only one of those requests in the accept
>>queue, and the kernel will drop the other two requests.

> What you get when you set backlog to one is operating system dependent.

You asked about Linux 2.4.18, and I was speaking
strictly for it. This is after all linux-netdev :).

> Tracing the flows with tcpdump, I get two clean handshakes so presumeably,
> for linux, one means two.  The third connection request *isn't* dropped;

Again, youre limiting the number of connnection requests
that are allowed to wait in the *accept* queue, where
we move to once we're ESTABLISHED.  You arent limiting
a request sitting in the SYN queue.

> according to netstat, it's placed in the syn_recd state.  I thought
> berkeley-derived implementations followed the rule that if there is no room
> on the backlog queue for the new connection, tcp ignored the the received
> syn.

>>Actually, details, but we also apply some other conditions
>>before we actually drop the connection request - we try not to be
>>so harsh if the syn queue is still fairly empty..
>>
> 
> 
> Irrespective of whatever conditions linux applies, how can the connection
> enter the syn_recd state if the backlog limit would be exceeded?  What's the
> client supposed to do with the syn/ack from the server? What's the server
> supposed to do with the ack it get's back from the client?

Er, complete the 3 way handshake? If the client gets the syn/ack, it
should send a SYN in response, and move to ESTABLISHED state. If the
server gets an ack back from the client, we process the ack. Our
processing involves moving the request from the syn queue to the
accept queue. Should the accept queue be full (which could occur
anytime - eg it could have occurred *after* the server recvd this
SYN) we would drop the request.  Should the client then send data,
it would get a RST, letting it know our side (srvr) has had to
throw the connection away.  Its quite possible that the accept queue
clears and a request can be moved from the SYN queue to the
accept queue in the interval of the handshake being completed (?)

If we get a SYN, it doesn't seem unreasonable that we enter
SYN_RCVD state :).

thanks,
Nivedita






