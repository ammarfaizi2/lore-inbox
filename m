Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270086AbRHOOfA>; Wed, 15 Aug 2001 10:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269995AbRHOOet>; Wed, 15 Aug 2001 10:34:49 -0400
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:9354 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S270086AbRHOOej>; Wed, 15 Aug 2001 10:34:39 -0400
From: Manfred Bartz <mbartz@optushome.com.au>
Message-ID: <20010815143407.12981.qmail@optushome.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: connect() does not return ETIMEDOUT
In-Reply-To: <20010813140049.28744.qmail@optushome.com.au.suse.lists.linux.kernel> <ouplmkogcmt.fsf@pigdrop.muc.suse.de>
In-Reply-To: Andi Kleen's message of "13 Aug 2001 18:15:06 +0200"
Organization: yes
Date: 16 Aug 2001 00:34:07 +1000
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> It works correct here (2.4.7-something)

Ok, after running tcpdump, it now looks the problem is not with
connect() but elsewhere.  Linux 2.4.8, same results on 2.4.2

The programs which demonstrate the problem, pcap file and
other files are at <http://logi.cc/linux/tcp2a/>.

My experimental server will accept() two connections and the 
backlog is set to 1 (one) in the call to listen().

My experimental client will open up to 100 connections to 
the server.  The first 6 connections succeed immediately.
Subsequent connections succeed at a rate of 2 connections 
every 9 seconds.

Under Solaris, the client succeeds with 4 connections,
the 5th connect() gives ETIMEDOUT after about 4 minutes.

server side:
    /* tcp socket bound to port 7000 */
    listen(listen_fd, 1);  /* backlog set to 1 */
    accept() called twice only.

commented and compacted tcpdump:

The server has now accept()ed 2 connections and does no 
further calls to accept().

--------------------------------------------------
Connection 3, backlog, ok
10:22:01.258195 192.168.1.1.51834 > 192.168.1.11.7000: S 
10:22:01.258283 192.168.1.11.7000 > 192.168.1.1.51834: S ack
10:22:01.258970 192.168.1.1.51834 > 192.168.1.11.7000: . ack

10:22:01.024577 Connection[3] established.  connect()==0

--------------------------------------------------
Connection 4, ?
10:22:01.265549 192.168.1.1.51835 > 192.168.1.11.7000: S 
10:22:01.265634 192.168.1.11.7000 > 192.168.1.1.51835: S ack
10:22:01.266324 192.168.1.1.51835 > 192.168.1.11.7000: . ack

10:22:01.031926 Connection[4] established.  connect()==0

The backlog was set to one, but it completes and queues 
two connections.  Is that because the kernel maintains two 
queues (one each for incomplete and complete connections)?

--------------------------------------------------
Connection 5, ?  should fail
10:22:01.272881 192.168.1.1.51836 > 192.168.1.11.7000: S 
10:22:01.272958 192.168.1.11.7000 > 192.168.1.1.51836: S ack
10:22:01.273650 192.168.1.1.51836 > 192.168.1.11.7000: . ack

10:22:01.039251 Connection[5] established.  connect()==0

10:22:04.866558 192.168.1.11.7000 > 192.168.1.1.51836: S ack
10:22:10.866629 192.168.1.11.7000 > 192.168.1.1.51836: S ack
10:22:22.866793 192.168.1.11.7000 > 192.168.1.1.51836: S ack

--------------------------------------------------
Connection 6, ?  should fail
10:22:01.280139 192.168.1.1.51837 > 192.168.1.11.7000: S 
10:22:01.280223 192.168.1.11.7000 > 192.168.1.1.51837: S ack
10:22:01.280917 192.168.1.1.51837 > 192.168.1.11.7000: . ack

10:22:01.046514 Connection[6] established.  connect()==0

10:22:05.666558 192.168.1.11.7000 > 192.168.1.1.51837: S ack
10:22:11.666637 192.168.1.11.7000 > 192.168.1.1.51837: S ack
10:22:23.666789 192.168.1.11.7000 > 192.168.1.1.51837: S ack

etc. etc...

connect() keeps returning 0 (success) because the client
side sees the full 3-way handshake.

Questions:

Once the backlog is exhausted, shouldn't the server side 
TCP stop sending SYNs and either be quiet or perhaps send 
an appropriate ICMP response?

Why does the server side keep sending SYNs after the connection
handshake was apparently completed?

-- 
Manfred

