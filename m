Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264560AbRFOXLV>; Fri, 15 Jun 2001 19:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264563AbRFOXLL>; Fri, 15 Jun 2001 19:11:11 -0400
Received: from sense-robertk-129.oz.net ([216.39.160.129]:46465 "HELO
	mail.kleemann.org") by vger.kernel.org with SMTP id <S264560AbRFOXK7>;
	Fri, 15 Jun 2001 19:10:59 -0400
Date: Fri, 15 Jun 2001 16:10:52 -0700 (PDT)
From: Robert Kleemann <robert@kleemann.org>
X-X-Sender: <robert@localhost.localdomain>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Mike Black <mblack@csihq.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <200106151829.f5FITGp162144@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.33.0106151602480.1149-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First a little more data on the problem.

1) I've never seen it with the client and server program on the same
   computer.

2) It only repros on some systems.  If I can repro it on some systems
   and then make the client the server and the server the client the
   bug will often fail to repro.

3) Once it repros it _consistently_ repros seemingly independent of
   kernel versions.

Second, I really don't think it is a problem with the server.  Running
the test a few times I get the following behavior. The client reads up
to message #19 before failing to ack, the server program keeps
executing "prints" until the send buffer fills and then blocks on the
next print at message #25.  "netstat -t" on the server shows the
following

tcp        0   8688 manny-out:20001         glottis:33193           ESTABLISHED

If I run the test a few more times, the client will block on a
different message (6,5,10,etc) and the server program will continue to
fill the buffer with the same amount of data before blocking.

What is more interesting to me is that if I add print statements
before and after the client "recv" call then it appears that the
client is blocking within the receive call.  If I packet sniff the
client then I see lots of packets from the server with happy acks from
the client until one packet does not receive an ack.  The server then
does the right thing and resends the non-acked packet at increasing
time intervals.  Eventually the client sends an ack for the previously
received packet (not the most recent that is being resent.  This
exchange continues indefinitely.  I've appended a commented packet log
to the end of this email.

So the client app is in the recv call waiting for data and the
interface is receiving the packet that should satisfy that block.  Why
would the client not be sending an ack?  If the buffer is full then
shouldn't the thread be returning from the recv call and releasing
some of that data?

One person emailed me a possible gotcha is that SIGINT is being
triggered somehow by the system call but I added a trap to the
original java app and now to the little perl script and it seems to
never be triggered.

Any other ideas for areas to investigate?

Robert.

Here are the logs.

packet A sent
20:15:21.703718 < manny.20001 > glottis-in.33088: P 14729:14984(255) ack 1 win 5792 <nop,nop,timestamp 925740 16355479> (DF)

packet B sent
20:15:21.713719 < manny.20001 > glottis-in.33088: . 14984:16432(1448) ack 1 win 5792 <nop,nop,timestamp 925741 16355479> (DF)

ack up to packet B
20:15:21.713719 > glottis-in.33088 > manny.20001: . 1:1(0) ack 16432 win 34752 <nop,nop,timestamp 16355480 925740> (DF)

packet C sent
20:15:21.713719 < manny.20001 > glottis-in.33088: P 16432:16714(282) ack 1 win 5792 <nop,nop,timestamp 925741 16355480> (DF)

packet D sent
20:15:21.713719 < manny.20001 > glottis-in.33088: . 16714:18162(1448) ack 1 win 5792 <nop,nop,timestamp 925742 16355480> (DF)

ack up to packet D
20:15:21.713719 > glottis-in.33088 > manny.20001: . 1:1(0) ack 18162 win 37648 <nop,nop,timestamp 16355480 925741> (DF)

packet E sent
20:15:21.723719 < manny.20001 > glottis-in.33088: P 18162:18420(258) ack 1 win 5792 <nop,nop,timestamp 925742 16355480> (DF)

packet F sent
20:15:21.733719 < manny.20001 > glottis-in.33088: . 18420:19868(1448) ack 1 win 5792 <nop,nop,timestamp 925743 16355480> (DF)

packet G sent
20:15:21.743719 < manny.20001 > glottis-in.33088: . 19868:21316(1448) ack 1 win 5792 <nop,nop,timestamp 925744 16355480> (DF)

ack up to packet E
20:15:21.743719 > glottis-in.33088 > manny.20001: . 1:1(0) ack 18420 win 37648 <nop,nop,timestamp 16355483 925742,nop,nop, sack 1 {19868:21316} > (DF)

packet H sent
20:15:21.743719 < manny.20001 > glottis-in.33088: P 21316:22139(823) ack 1 win 5792 <nop,nop,timestamp 925744 16355483> (DF)

ack up to packet E
20:15:21.743719 > glottis-in.33088 > manny.20001: . 1:1(0) ack 18420 win 37648 <nop,nop,timestamp 16355483 925742,nop,nop, sack 1 {19868:22139} > (DF)

packet I sent
20:15:21.763720 < manny.20001 > glottis-in.33088: . 22139:23587(1448) ack 1 win 5792 <nop,nop,timestamp 925746 16355483> (DF)

ack up to packet E
20:15:21.763720 > glottis-in.33088 > manny.20001: . 1:1(0) ack 18420 win 37648 <nop,nop,timestamp 16355485 925742,nop,nop, sack 1 {19868:23587} > (DF)

resend packet F many times in increasing time intervals. Why does the
client not ack this?
20:15:21.763720 < manny.20001 > glottis-in.33088: . 18420:19868(1448) ack 1 win 5792 <nop,nop,timestamp 925746 16355485> (DF)
20:15:21.973726 < manny.20001 > glottis-in.33088: . 18420:19868(1448) ack 1 win 5792 <nop,nop,timestamp 925768 16355485> (DF)
20:15:22.413738 < manny.20001 > glottis-in.33088: . 18420:19868(1448) ack 1 win 5792 <nop,nop,timestamp 925812 16355485> (DF)
20:15:23.293761 < manny.20001 > glottis-in.33088: . 18420:19868(1448) ack 1 win 5792 <nop,nop,timestamp 925900 16355485> (DF)
20:15:25.053809 < manny.20001 > glottis-in.33088: . 18420:19868(1448) ack 1 win 5792 <nop,nop,timestamp 926076 16355485> (DF)
20:15:28.573905 < manny.20001 > glottis-in.33088: . 18420:19868(1448) ack 1 win 5792 <nop,nop,timestamp 926428 16355485> (DF)
20:15:35.614095 < manny.20001 > glottis-in.33088: . 18420:19868(1448) ack 1 win 5792 <nop,nop,timestamp 927132 16355485> (DF)

ack up to packet E
20:15:41.964268 > glottis-in.33088 > manny.20001: F 1:1(0) ack 18420 win 37648 <nop,nop,timestamp 16357505 925742,nop,nop, sack 1 {19868:23587} > (DF)

Not sure what this is for...
20:15:41.964268 < manny.20001 > glottis-in.33088: . 23587:23587(0) ack 2 win 5792 <nop,nop,timestamp 927767 16357505> (DF)

