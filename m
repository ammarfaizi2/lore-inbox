Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUCaQgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUCaQgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:36:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53380 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262051AbUCaQfd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:35:33 -0500
Date: Wed, 31 Mar 2004 11:36:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Powers-of-two - 7 for recv() length??
Message-ID: <Pine.LNX.4.53.0403311128200.11700@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linux version 2.4.24

Given a TCP/IP server feeding data as fast as it can
to a stream connection on a dedicated link, and a
client receiving that data, I observe that the data
received is usually a (power-off-two - 7) bytes in
length, followed by the 7 bytes returned by the next
recv() call.

It makes no difference if Nagle is turned OFF (TCP_NODELAY).

Very bad!
Recv value was 114681
Remaining length was was 409607
Very bad!
Recv value was 7
Remaining length was was 0
Very bad!
Recv value was 65529
Remaining length was was 458759
Very bad!
Recv value was 7
Remaining length was was 0
Very bad!
Recv value was 65529
Remaining length was was 458759
Very bad!
Recv value was 7
Remaining length was was 0
Very bad!
Recv value was 65529
Remaining length was was 458759
Very bad!
Recv value was 7
Remaining length was was 0
Very bad!
Recv value was 65529
Remaining length was was 458759
Very bad!
Recv value was 7
Remaining length was was 0
Very bad!
Recv value was 65529
Remaining length was was 458759
Very bad!
Recv value was 7
Remaining length was was 0
Very bad!
Recv value was 65529
Remaining length was was 458759
Very bad!
Recv value was 7
Remaining length was was 0
Very bad!
Recv value was 65529
Remaining length was was 458759
[SNIPPED....]

Code snippet:

            len = BUF_LEN;
            while(len)
            {
                if((ret = recv(s, cp, len, 0 )) <= 0)
                {
                    if(errno == EINTR)
                        continue;
                    handler(0);
                }
                len -= ret;
                cp  += ret;
                if(ret & 1)
                {
                    fprintf(stderr, "Very bad!\n");
                    fprintf(stderr, "Recv value was %d\n", ret);
                    fprintf(stderr, "Remaining length was was %u\n", len);
                }
            }

Given that the transport sends only even numbers of bytes, I
would guess that there is considerable overhead associated with
the 7-byte break. This likely points to something being
broken and some work-around incorporated to "fix" it. The
additional calls necessary to receive a mere 7 bytes into
a buffer that expects to get filled with 1/2 megabytes,
seriously reduces the through-put, not only because of the
additional call, but because of the remaining odd-byte
buffer alignment necessary for the next recv() call.

Could somebody who understands the network code please
find out what is going on. I can't find Alexy who used
to handle these kinds of problems off the list.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


