Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVGESjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVGESjw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 14:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVGESjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 14:39:52 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:27050 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261924AbVGESiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 14:38:21 -0400
From: trmcneal@comcast.net
To: linux-kernel@vger.kernel.org
Subject: TCP connection timeouts during testing
Date: Tue, 05 Jul 2005 18:38:17 +0000
Message-Id: <070520051838.6442.42CAD3990005E0E10000192A2200761394040E0A020C039D9B@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: dHJtY25lYWxAY29tY2FzdC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

I sent this out on the linux-net mailing list, but got no response at all,
so I'm going to try linux-kern.  This problem happens with both 2.4 and
2.6 kernels, using a variety of platforms and NICs.

Anyway, I've been working with some TCP networking tests which have
multiple clients opening nonblocking sockets to a single server port,
sending a short message, and then closing the socket, 100,000 times.
Since the socket is non-blocking, it generally tries to connect and then
does a poll since the socket is busy.  The test fails if the poll times out in
10 seconds.  It fails consistently on Linux servers but succeeds on Solaris
servers; the client is a non-issue.

The tcpdumps I've seen show that the server is getting a lot of retries,
largely because  many clients think the 3-way TCP connection handshake
(SYN from the client, SYN/ACK from the server, ACK from the client)
is complete, when the server actually doesn't get the final ACK; The client 
starts sending and then retransmitting the data, and the server keeps sending
back the SYN/ACK part of the handshake, whereupon the client resends
the ACK (which the server doesn't get), and starts sending and resending
the data again.

Eventually the server starts sending RST to everything and stops listening;
I've been able to make the test pass by bringing down the total number of
synack retries (sysctl -w net.ipv4.tcp_synack_retries="3"), but that doesn't
help much in the test, since the connection doesn't get made, and the data
isn't sent, causing a data confirmation failure rather than a timeout failure.

Any suggestions about what to do?  I tried increasing  the 
net.ipv4.tcp_max_syn_backlog value, but it didn't help.  I thought I saw
that RST getting generated when I ran out of some resource, but I'm looking
at the code again and am not sure what I saw before.  

Tom McNeal

--
Tom McNeal
(650)906-0761(cell)
(650)964-8459(fax)
