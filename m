Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbTDBDce>; Tue, 1 Apr 2003 22:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbTDBDce>; Tue, 1 Apr 2003 22:32:34 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:34437 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261401AbTDBDca>; Tue, 1 Apr 2003 22:32:30 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 1 Apr 2003 19:41:19 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: loopback behaviour under high load ...
Message-ID: <Pine.LNX.4.50.0304011826340.1932-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this started with a report from an epoll user and I partially followed
the thing. Using the epoll enabled http server+loader and having the
server and the loader hooked through the loopback interface, this user was
looking at connections that occasionally got stuck. The epoll
server+loader are here :

http://www.xmailserver.org/linux-patches/epoll-lib-0.7.tar.gz

and it needs :

http://www.xmailserver.org/libpcl.html

What happened is that under high transaction load, a few connections get
stuck and they complete after a while ( here "a while" ~= 120 sec ). I
initially thought it was an epoll problem, that was losing events. So I
modified the scheduler to call coroutines ( that call read() ) even if no
events were available, and read() indeed returns EAGAIN. In fact, looking
at a netstat output, the data result still inside the output queue of the
sending socket ( write-side write() completed successfully ). The data
remains there even if the load goes to zero, and the stall of those few
connections last for about 120 sec. This happens *only* under very high
load. I coded a very simple echo client+server :

http://www.xmailserver.org/echocs-0.1.tar.gz

using Niels libevent library ( last snapshot ) :

http://www.monkey.org/~provos/libevent/

and it does not happen using this load ( both using poll/select/epoll has
notification API ). This because, while the http load in the first test
tops 30000 transaction/sec on my machine, the echo client+server remains
at no more than 5000 transaction/sec. Also, by putting a micro delay
between the http client connect() and send(), the problem goes away. Very
likely because the load drop significantly. The user that reported me this
behaviour has been able to catch this with tcpdump, and this is his report:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hello Davide,

I believe I've pin-pointed the problem.  The problem is that the server is
sending out a second redundant SYN (Synchronize) segment to the client in
response to the client's attempt to write (PUSH) data to the server after
the connection is established:

I ran "tcpdump -i lo" and generated dumps for a good connection and for a
bad connection:



Here is the "tcpdump -i lo" for a GOOD connection
(98% of the connections run this way):
---------------------------------------------------------------------------
Line  1:  11:09:50.893716 localhost.48056 > localhost.webcache: S
3760485494:3760485494(0) win 32767 <mss 16396,sackOK,timestamp 19532466
19520760,nop,wscale 11> (DF)

Line  2:  11:09:50.893839 localhost.webcache > localhost.48056: S
3755548309:3755548309(0) ack 3760485495 win 32767 <mss
16396,sackOK,timestamp 19532467 19532466,nop,wscale 11> (DF)

Line  3:  11:09:50.893924 localhost.48056 > localhost.webcache: . ack 1 win
15 <nop,nop,timestamp 19532467 19532467> (DF)

...
Line  4:  11:09:51.304909 localhost.48056 > localhost.webcache: P 1:6(5) ack
1 win 15 <nop,nop,timestamp 19532878 19532467> (DF)

Line  5:  11:09:51.304955 localhost.webcache > localhost.48056: . ack 6 win
15 <nop,nop,timestamp 19532878 19532878> (DF)

...
Line  6:  11:09:51.470790 localhost.webcache > localhost.48056: P 1:6(5) ack
6 win 15 <nop,nop,timestamp 19533044 19532878> (DF)

Line  7:  11:09:51.470829 localhost.48056 > localhost.webcache: . ack 6 win
15 <nop,nop,timestamp 19533044 19533044> (DF)

...
Line  8:  11:09:51.470895 localhost.webcache > localhost.48056: F 6:6(0) ack
6 win 15 <nop,nop,timestamp 19533044 19533044> (DF)

...
Line  9:  11:09:51.511472 localhost.48056 > localhost.webcache: . ack 7 win
15 <nop,nop,timestamp 19533084 19533044> (DF)

...
Line 10:  11:09:51.611947 localhost.48056 > localhost.webcache: F 6:6(0) ack
7 win 15 <nop,nop,timestamp 19533185 19533044> (DF)

Line 11:  11:09:51.611981 localhost.webcache > localhost.48056: . ack 7 win
15 <nop,nop,timestamp 19533185 19533185> (DF)




Here is the "tcpdump -i lo" for a HUNG connection
(All hung connections run this way):
----------------------------------------------------------------------------
Line  1:  11:09:51.399251 localhost.49186 > localhost.webcache: S
3745756949:3745756949(0) win 32767 <mss 16396,sackOK,timestamp 19532972
19532939,nop,wscale 11> (DF)

Line  2:  11:09:51.399287 localhost.webcache > localhost.49186: S
3755771471:3755771471(0) ack 3745756950 win 32767 <mss
16396,sackOK,timestamp 19532972 19532972,nop,wscale 11> (DF)

Line  3:  11:09:51.399337 localhost.49186 > localhost.webcache: . ack 1 win
15 <nop,nop,timestamp 19532972 19532972> (DF)
...

Line  4:  11:09:51.426500 localhost.49186 > localhost.webcache: P 1:6(5) ack
1 win 15 <nop,nop,timestamp 19532999 19532972> (DF)
...

Line  5:  11:09:54.954548 localhost.webcache > localhost.49186: S
3755771471:3755771471(0) ack 3745756950 win 32767 <mss
16396,sackOK,timestamp 19536528 19532999,nop,wscale 11> (DF)

Line  6:  11:09:54.954641 localhost.49186 > localhost.webcache: . ack 1 win
15 <nop,nop,timestamp 19536528 19536528,nop,nop,sack sack 1 {0:1} > (DF)


*** HERE THERE IS A 120 SECOND DELAY!!!!!
(Line 5 above is in error.  In Line 5 the server is re-transmitting a SYN to
the client (effectively repeating what it did in Line 2).   Compare this
to Line 5 in the "good connection"

So, the client sent

"SYN 3745756949:3745756949(0)" to the server (Line 1),

the server responded correctly with

"SYN 3755771471:3755771471(0) ACK 3745756950" (Line 2),

the client then acknowledged with

"ACK 3755771472" (actually, a normalized "ACK 1") (Line 3).

All of this is as it should be.

At this point, the client has CONNECTed and the server has ACCEPTed.


Now, the client attempts to WRITE by PUSHing 5 bytes:

"P 1:6(5)" (The client is sending the word "Hello") (Line 4).

At this point, the server is SUPPOSED to acknowledge 6 bytes received
via

"ACK 6" (as in Line 5 in the good server connection).

However, instead, the server ERRONEOUSLY responds to the client's PUSH
with a repeat of its SYN -

"S 3755771471:3755771471(0) ack 3745756950".

In other words, it repeats line 2.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It seems that the server does not see the client ack at line 3 and it's
trying to resend the SYN ack. But the client saw the initial SYN ack
from the server, that made connect() to return successfully. Running an
ifconfig after a failing run shows no trace of dropped packets (
netdev_max_backlog has been increased to 1000 ) on the user machine :

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:526602 errors:0 dropped:0 overruns:0 frame:0
          TX packets:526602 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:42045594 (40.0 Mb)  TX bytes:42045594 (40.0 Mb)

To make things short, this is what happens ( on a few connections of the
whole test set ) :

1) Client connect() ... OK
2) Server accept() ... OK
3) Client send request ... OK
4) Server read request ... HUNG for ~120 sec, even if the load last a few
	seconds, then the transaction completes successfully

And netstat shows Recv-Q=0 for the server socket, and Send-Q=N for the
client socket. This has been tested on 2.5.66 vanilla.
I'm running out of options here ...




- Davide

