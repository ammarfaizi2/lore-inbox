Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132872AbRANSac>; Sun, 14 Jan 2001 13:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132946AbRANSaW>; Sun, 14 Jan 2001 13:30:22 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:60072 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S132872AbRANSaN>;
	Sun, 14 Jan 2001 13:30:13 -0500
Date: Sun, 14 Jan 2001 13:29:22 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Is sendfile all that sexy?
Message-ID: <Pine.GSO.4.30.0101141237020.12354-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I thought i'd run some tests on the new zerocopy patches
(this is using a hacked ttcp which knows how to do sendfile
and does MSG_TRUNC for true zero-copy receive, if you know what i mean
;-> ).

2 back to back SMP 2*PII-450Mhz hooked up via 1M acenics (gigE).
MTU 9K.

Before getting excited i had the courage to give plain 2.4.0-pre3 a whirl
and somethings bothered me.

test1:
------

regular ttcp, no ZC and no sendfile. send as much as you can in 15secs;
actually 8192 byte chunks, 2048 of them at a time. Repeat until 15 secs is
complete.

Repeat the test 5 times to narrow experimental deviation.

Throughput: ~99MB/sec (for those obsessed with Mbps ~810Mbps)
CPU abuse: server side 87% client side 22% (the CPU measurement could do
with some work and proper measure for SMP).

test2:
------

sendfile server.
created a file which is 8192*2048 bytes. Again the same 15 second
exercise as test1 (and the 5-set thing):

- throughput: 86MB/sec
- CPU: server 100%, client 17%

So i figured, no problem i'll re-run it with a file 10 times larger.
**I was dissapointed to see no improvement.**

Looking at the system calls being made:

with the non-sendfile version, approximately 182K write-to-socket system
calls were made each writing 8192 bytes, Each call lasted on average
0.08ms.
With sendfile test2: 78 calls were made, each sending the file
size 8192*2048 bytes; each lasted about 199 msecs

TWO observations:
- Given Linux's non-pre-emptability of the kernel i get the feeling that
sendfile could starve other user space programs. Imagine trying to send a
1Gig file on 10Mbps pipe in one shot.
- It doesnt matter if you break down the file into chunks for
self-pre-emption; sendfile is still a pig.

I have a feeling i am missing some very serious shit. So enlighten me.
Has anyone done similar tests?

Anyways, the struggle continues next with zc patches.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
