Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264986AbUD2VzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264986AbUD2VzW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264985AbUD2VzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:55:22 -0400
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:38672 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP id S264987AbUD2VxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:53:13 -0400
Message-ID: <15FDCE057B48784C80836803AE3598D50627AC6E@racerx.ixiacom.com>
From: Jan Olderdissen <jan@ixiacom.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Stack sends SYN/ACKs even though accept queue is full
Date: Thu, 29 Apr 2004 14:53:36 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsis:

When the accept queue of a listening socket is full, the stack will SYN/ACK
additional SYNs at a rate of 0.5Hz and put them on the syn queue. Those
connections behave in bandwidth wasting ways if the accept queue remains
full. In particular, the server resends the SYN/ACK multiple times while the
client attempts to communicate thinking it has a valid connection. The
client retransmits its data packets and eventually gives up.

Packet trace:
 
Time        Info
7.381621    1277 > 5555 [SYN] Seq=1955472727 Ack=0 Win=2920 Len=0
7.381712    5555 > 1277 [SYN, ACK] Seq=1971042013 Ack=1955472728 Win=2896
Len=0
7.381776    1277 > 5555 [ACK] Seq=1955472728 Ack=1971042014 Win=2920 Len=0
7.400029    1277 > 5555 [PSH, ACK] Seq=1955472728 Ack=1971042014 Win=2920
Len=90
7.609149    1277 > 5555 [PSH, ACK] Seq=1955472728 Ack=1971042014 Win=2920
Len=90
8.029061    1277 > 5555 [PSH, ACK] Seq=1955472728 Ack=1971042014 Win=2920
Len=90
8.868911    1277 > 5555 [PSH, ACK] Seq=1955472728 Ack=1971042014 Win=2920
Len=90
10.378517   5555 > 1277 [SYN, ACK] Seq=1971042013 Ack=1955472728 Win=2896
Len=0
10.379162   1277 > 5555 [ACK] Seq=1955472818 Ack=1971042014 Win=2920 Len=0
10.548510   1277 > 5555 [PSH, ACK] Seq=1955472728 Ack=1971042014 Win=2920
Len=90
13.907815   1277 > 5555 [PSH, ACK] Seq=1955472728 Ack=1971042014 Win=2920
Len=90
16.377300   5555 > 1277 [SYN, ACK] Seq=1971042013 Ack=1955472728 Win=2896
Len=0
16.378034   1277 > 5555 [ACK] Seq=1955472818 Ack=1971042014 Win=2920 Len=0
20.626501   1277 > 5555 [PSH, ACK] Seq=1955472728 Ack=1971042014 Win=2920
Len=90
28.374887   5555 > 1277 [SYN, ACK] Seq=1971042013 Ack=1955472728 Win=2896
Len=0
28.375489   1277 > 5555 [ACK] Seq=1955472818 Ack=1971042014 Win=2920 Len=0
34.063710   1277 > 5555 [PSH, ACK] Seq=1955472728 Ack=1971042014 Win=2920
Len=90
52.569956   5555 > 1277 [SYN, ACK] Seq=1971042013 Ack=1955472728 Win=2896
Len=0
52.570129   1277 > 5555 [ACK] Seq=1955472818 Ack=1971042014 Win=2920 Len=0
57.380254   1277 > 5555 [FIN, ACK] Seq=1955472818 Ack=1971042014 Win=2920
Len=0
60.938358   1277 > 5555 [FIN, PSH, ACK] Seq=1955472728 Ack=1971042014
Win=2920 Len=90
100.760213  5555 > 1277 [SYN, ACK] Seq=1971042013 Ack=1955472728 Win=2896
Len=0
100.760347  1277 > 5555 [ACK] Seq=1955472819 Ack=1971042014 Win=2920 Len=0

Other TCP connections, IP addresses and various other superfluous
information removed.

Code analysis:

tcp_v4_conn_request() in tcp_ipv4.c contains the following code:

    /* Accept backlog is full. If we have already queued enough
     * of warm entries in syn queue, drop request. It is better than
     * clogging syn queue with openreqs with exponentially increasing
     * timeout.
     */
    if (tcp_acceptq_is_full(sk) && tcp_synq_young(sk) > 1)
        goto drop;

A synq entry is considered young when it hasn't timed out yet as the
following comment in tcp_timer.c indicates:

    /* Normally all the openreqs are young and become mature
     * (i.e. converted to established socket) for first timeout.
     * If synack was not acknowledged for 3 seconds, it means
     * one of the following things: synack was lost, ack was lost,
     * rtt is high or nobody planned to ack (i.e. synflood).
     * When server is a bit loaded, queue is populated with old
     * open requests, reducing effective size of queue.
     * When server is well loaded, queue size reduces to zero
     * after several minutes of work. It is not synflood,
     * it is normal operation. The solution is pruning
     * too old entries overriding normal timeout, when
     * situation becomes dangerous.
     *
     * Essentially, we reserve half of room for young
     * embrions; and abort old ones without pity, if old
     * ones are about to clog our table.
     */

Unfortunately, when a server is really busy and the acceptq remains full,
the connections held on the synq will drop incoming ACK (and other) packets
without compunction as the code from tcp_v4_syn_recv_sock() in tcp_ipv4.c
shows:

    if (tcp_acceptq_is_full(sk))
        goto exit_overflow;

Which leads to the strange packet trace outlined above. 

Because newly accepted connections are considered 'young', two such
connections put on the synq will cause additional SYNs to be dropped until
young connections age and additional connections are SYN/ACKed , etc. Since
the initial TCP timeout is three seconds, you would expect two additional
connections to be accepted every three seconds. However, experiments with
2.4.25 show that number to be two connections every four seconds for unclear
reasons.

In addition to the 2.4.21 sources we mainly work with in our embedded
systems, I checked the 2.4.26 and 2.6.5 sources. They don't appear to differ
in the sections discussed. The packet trace is from 2.4.25.

Conclusion:

Unless I'm missing something material, the stack has no business accepting
connections for which it doesn't have entries in the accept queue. If it is
the intention of the application to have a large number of pending
connections, it should have a long accept queue as it is. Accepting two
additional connections every four seconds does not materially improve the
performance of highly loaded servers.

Perhaps someone on the mailing list can enlighten me as to the point of the
'tcp_synq_young(sk) > 1' condition. The intent seems to be to keep a modicum
of 'warm' connections in the air at all times in case the app eventually
gets around to accepting all the pending connections and an oscillation
effect might ensue. However, the implementation doesn't scale and the effect
of suggesting to the remote app that it has someone to talk to and then just
ignoring all packets it sends appears to be somewhat counterproductive.

Thanks go to Thomas Ameling who was instrumental in tracking down this
issue.

Jan Olderdissen
