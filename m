Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbRBLPyd>; Mon, 12 Feb 2001 10:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131310AbRBLPyX>; Mon, 12 Feb 2001 10:54:23 -0500
Received: from big-relay-1.ftel.co.uk ([192.65.220.123]:51358 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S131309AbRBLPyM>; Mon, 12 Feb 2001 10:54:12 -0500
Message-ID: <3A88071D.78A3D1FA@ftel.co.uk>
Date: Mon, 12 Feb 2001 15:54:05 +0000
From: Paul Flinders <P.Flinders@ftel.co.uk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dropping UDP packets on send
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get some rough figures for the sort of performance
I could expect from a load-balancing application whose job would
be to re-direct incomming UDP packets to a set of target systems
(and handle fail-over etc).

To test this I wrote a very simple application that sends UDP packets
out as fast as possible, one which reads them as fast as possible but
does noting except the copy to user space and one which distributes
them reading a packet then sending it on to a destination, doing a round-
robin allocation of destinations.

The sender is as follows

    memset(buf, '\0', blocksize);
    while (--count >= 0) {
        *(unsigned short *)buf = ++seq;
        *(unsigned short *)(buf+2) = (unsigned short)lrand48();

        if ((r = write(sock, buf, blocksize)) != blocksize)
            ++write_errs;
    }

blocksize is 64

Up to about 1-2,000,000 packets I get about 100,000 packets per second
sent, the reader can keep up, the fowarding application can't - it tops
out at 34,000 packets per second or so (but it's simplistic as I only
want approximate figures - I can think of a couple of ways to improve
it).

If I try to send more than 2,000,000 packets something odd happens
the sender competes faster than expected but it doesn't send all of
the packets as seen by looking at the TX packet count. I don't see
any write failures (i.e write always returns 64 and write_errs is
always zero after the run).

Is this "expected" behaviour or is there a problem?

sender/distributer are running 2.4.1-pre7 on dual-processor PIII 866s
with 1G of PC-133 SDRAM and 3c905b/c ethernet cards (sender has
the "b" but if I swap over and send using the "c" I get the same result).


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
