Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289026AbSAZHYd>; Sat, 26 Jan 2002 02:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289032AbSAZHYP>; Sat, 26 Jan 2002 02:24:15 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:58637 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289026AbSAZHXz>; Sat, 26 Jan 2002 02:23:55 -0500
Message-ID: <3C525804.5653DC83@zip.com.au>
Date: Fri, 25 Jan 2002 23:17:24 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "A. Castro" <btcal@earthlink.net>
CC: linux-kernel@vger.kernel.org, "David F. Skoll" <dfs@roaringpenguin.com>
Subject: Re: linux select() bug hit
In-Reply-To: <3C5251BD.7000208@earthlink.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A. Castro" wrote:
> 
> Please CC'ed any answers/questions. I'm not on the mailing list.
> 
> Greetings,
> 
> Reason for posting/sending this email.
> 
> 1. the actual message:
> pppoe[1857]: Linux select bug hit! This message is harmless, but please
> ask the Linux kernel developers to fix it.
> 

hmm. Source is at http://www.roaringpenguin.com/pppoe/rp-pppoe-3.3.tar.gz

They have this:

            /* There is a bug in Linux's select which returns a descriptor
             * as readable if N_HDLC line discipline is on, even if
             * it isn't really readable.  This return happens only when
             * select() times out.  To avoid blocking forever in read(),
             * make descriptor 0 non-blocking */
            flags = fcntl(0, F_GETFL);
            if (flags < 0) fatalSys("fcntl(F_GETFL)");
            if (fcntl(0, F_SETFL, (long) flags | O_NONBLOCK) < 0) {
                fatalSys("fcntl(F_SETFL)");
            }

and later this:

syncReadFromPPP(PPPoEConnection *conn, PPPoEPacket *packet)
{
    int r;
#ifndef HAVE_N_HDLC
    struct iovec vec[2];
    unsigned char dummy[2];
    vec[0].iov_base = (void *) dummy;
    vec[0].iov_len = 2;
    vec[1].iov_base = (void *) packet->payload;
    vec[1].iov_len = ETH_DATA_LEN - PPPOE_OVERHEAD;

    /* Use scatter-read to throw away the PPP frame address bytes */
    r = readv(0, vec, 2);
#else
    /* Bloody hell... readv doesn't work with N_HDLC line discipline... GRR! */
    unsigned char buf[ETH_DATA_LEN - PPPOE_OVERHEAD + 2];
    r = read(0, buf, ETH_DATA_LEN - PPPOE_OVERHEAD + 2);
    if (r >= 2) {
        memcpy(packet->payload, buf+2, r-2);
    }
#endif
    if (r < 0) {
        /* Catch the Linux "select" bug */
        if (errno == EAGAIN) {
            rp_fatal("Linux select bug hit!  This message is harmless, but please ask the Linux kernel developers to fix it.");
        }
        fatalSys("read (syncReadFromPPP)");
    }

and

    struct timeval *tvp = NULL;
 ...
    for (;;) {
        if (optInactivityTimeout > 0) {
            tv.tv_sec = optInactivityTimeout;
            tv.tv_usec = 0;
            tvp = &tv;
        }
        FD_ZERO(&readable);
        FD_SET(0, &readable);     /* ppp packets come from stdin */
        if (conn->discoverySocket >= 0) {
            FD_SET(conn->discoverySocket, &readable);
        }
        FD_SET(conn->sessionSocket, &readable);
        while(1) {
            r = select(maxFD, &readable, NULL, NULL, tvp);
            if (r >= 0 || errno != EINTR) break;
        }
 ...
        /* Handle ready sockets */
        if (FD_ISSET(0, &readable)) {
            if (conn->synchronous) {
                syncReadFromPPP(conn, &packet);
            } else {
                asyncReadFromPPP(conn, &packet);
            }
        }

So as the comment says, they are claiming that select() is returning
"yes" for an O_NONBLOCK descriptor which has N_HDLC line disc pushed
onto it, if the select times out.  So a subsequent read() on that
descriptor returns -1 (EAGAIN).

And from a quick read, the code looks OK.  select() says there's
activity on fd 0, but there isn't.

Can any ABI gurus confirm that this is actually a kernel bug?

-
