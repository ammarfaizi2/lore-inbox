Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKDCdi>; Fri, 3 Nov 2000 21:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129332AbQKDCd3>; Fri, 3 Nov 2000 21:33:29 -0500
Received: from [63.95.244.10] ([63.95.244.10]:48379 "EHLO mailhub.webgain.com")
	by vger.kernel.org with ESMTP id <S129164AbQKDCdY>;
	Fri, 3 Nov 2000 21:33:24 -0500
Message-Id: <5.0.0.25.0.20001103173708.034fb360@stargate>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Fri, 03 Nov 2000 18:32:19 -0700
To: linux-kernel@vger.kernel.org
From: Thomas Pollinger <tpolling@rhone.ch>
Subject: Re: [BUG REPORT] TCP/IP weirdness in 2.2.15
Cc: stephenl@zeus.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen

I've been experiencing similar problems with what would seem at first a 
completely unrelated problem. To make things short:

I have the following configuration:
- CVS server (vers. 1.10.4) running on HPUX B.11.00
- different CVS clients (running different cvs client versions: 1.10.4/7/8):
  - Win NT (PIII, 512MB, 3c905 10/100)
  - Debian 2.2.17 (PII, 256MB, 3c905, main client tester)
  - Mandrake 2.2.x (3c905)
  - RedHat 6.2 (Laptop, different Ethernet card)
  - SuSE 2.2.10 (PII, 256MB, 3c905)

Running a 'cvs get' on the Linux clients of a larger source tree eventually 
hangs the client in the middle of the get process. The hang is *always* 
reproduceable (however it does not always hang at the same place, sometimes 
after 1', sometimes after 5' to 10'). Several runs on Win NT did not show 
this problem.

Running a strace on the client and server reveals that the client gets 
stuck in a read(3, resp. recv(3, call (a recompiled the cvs client to not 
use file descriptors for an additional test) and blocks forever (I left it 
once during one night). The server tries first to send to the client, but 
gets an EWOULDBLOCK error back. The server tries to send to the client for 
about 5' during which no packets are accepted by the client. tcpdump 
revealed that after the hang, sometimes the client did not accept any 
packets (ack 0), sometimes it replied . ack 7678261 back (this will go 
forever if the client won't be killed). The server replies: P 
7678261:76784009 (1448) ack 612 win 32768 ... indefinitely.

To keep the mail short, I can run a test and send all related logs if needed.

I first thought that I got not a recent network driver and compiled a more 
recent one (v0.99H 12Jun00 was old, new: 16Aug00 <2.2.17-pre17>) - but the 
behaviour was the same.

At last, I tried to do the same on another HP-UX box and there was no 
blocking at all.
What is interesting to know is that between the HP-UX server and the HP 
client is a Linux router with a 3c905 card, 2.2.14 kernel.

Regards,
Pollinger Thomas


--------------------------------------------------------------------------------------------------------------
Below the original mail from Stephen (as it has been a while ago this 
message was posted):

Hi Folks,
I'm seeing some very strange behaviour here with TCP/IP connections
(or at least, it looks strange to me) - under heavy load, it appears
connections are spuriously dropped.
Bear with me while I give a little background...
...I'm actually trying to perform some SPECweb99 benchmarking; I have
a test bed of 5 clients and 1 server. For those of you who are not
familiar with SPECweb99, let's just say that it tries to simulate
'real world' traffic - a mixture of HTTP GET, POST, static and dynamic
GET, keepalive connections, non-keepalive connections... basically
hammer the server as hard as you can until it grinds to a halt. Each
client has one controlling (parent) process which forks off N children
to generate the HTTP load. One client is a designated 'prime client'
which synchronises the rest of the clients. If you're interested in
more SPEC info, there's a very informative whitepaper on their
website, have a look at http://www.spec.org/osg/web99
The "dropped connection" manifests itself by the SPEC run 'hanging' -
at the end of the test there is one or more child processes on one or
more clients stuck in a read(2), trying to read from a
socket. (usually, one child process on one client).
If I do a netstat on the client I see an ESTABLISHED connection:
[stephenl@spec1 stephenl]$ netstat -t
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address Foreign Address State
[...]
tcp 0 0 spec1.specweb.zeus:6426 spec6.specweb.zeus.:www ESTABLISHED
[...]
[stephenl@spec1 stephenl]$
(spec1 is the client, spec6 is the server. As it happens, spec1 is
also my prime client - this is just a coincidence in this particular
lockup)
If I hop over to the server and do a netstat there, I
see... nothing. No ESTABLISHED connection, no TIME_WAIT, no
CLOSE_WAIT. Nothing.
Question: is this valid? (I think it may be, if the server
crashed. Which it didn't - all machines have enjoyed a nice long
uptime :-)
I've done more digging. I captured tcpdumps of the entire SPEC run, on
all machines. I added lots of extra debugging logs to the client code,
I ran 'netstat -tn' every 10 seconds on all machines for the duration
of the test. Oh yes, and the webserver logs.
Here is what I've found...
Debugging logfile
-----------------
The client creates a socket, binds a port to it and connects to the
webserver. It write()s a HTTP GET request, and read()s a file back. So
far so good. Without closing the socket, another request is sent and
another file is received (on keepalives, there are a random number of
HTTP requests performed - on average, 10). Now here is where it gets
interesting... still without closing the socket, write() another HTTP
request and go to read() the file... the read() sits there and this
child is effectively dead. I've observed it to hang on anywhere from
the 2nd request to the 7th or 8th request.
tcpdump logs
------------
This matches perfectly what I've just detailed above... I see all the
previous requests on this port, I see the server send the previous
file, I see the client ACK this, I see the client send the final,
fatal GET... I see the server ACK this. I see this on both the client
AND server tcpdump logfiles - they both perfectly match. After the
final, fatal ACK I see... nothing. The client never sends any more
packets, the server never sends any more packets. Specifically I see
no FIN from either end.
webserver logs
--------------
I see all requests from the offending client up to and including the
previous request. The offending GET never makes it to the server logs.
netstat logs
------------
Running a 'netstat -tn' every 10 seconds on the client, I see the
connection spring into existence somewhere through the test (sometimes
near the beginning of the test, sometimes near the end. On average
about halfway through, on a 10-minute run). Once the connection has
been made, it is reported as 'ESTABLISHED' until I terminate the stuck
process... Running a 'netstat -tn' every 10 seconds on the server, I
see the connection spring into existence at the same time; I see the
same connection 10 seconds later; 20 seconds later it has vanished. No
CLOSE, no CLOSE_WAIT. Not, even, a TIME_WAIT. According to netstat,
the connection on the server simply vanished. I'm *sure* this is just
plain wrong - but it's what I see.
misc logs
---------
No error messages in the webserver log; nothing in 'dmesg', nothing in
/var/spool/*
---

I've searched the archives best as I can but couldn't find anything
relevant (actually I've been loosely following linux-kernel for the
past 2 years, and I would expect to remember if I'd seen this before,
but I'm sure better minds can advise!)

Please help me folks, I've spent hours tracking it down this far, and
it's starting to wear me down :-/

I'd really appreciate info on how to go about debugging from
here... or a pointer as to what I'm doing wrong (am I doing something
wrong?)

---

I'm deliberately not going to include .config files etc here - this
mail is getting long enough as it is. Of course all information is
available - just ask. But I will give a concise system description:

All clients are identical, Celeron 500's with IDE subsystem and twin
EEPRO10/100 NICs (actually I'm only using 1 NIC for my tests at
present).

The server is basically the same as the client, except it has a PIII
700.

All systems were originally installed with RedHat 6.0, the only thing
that has changed is now ALL machines have linux kernel 2.2.15 (and I
hoped that would fix my problems :-)

Webserver software is Zeus 3.3.6.

The server has had /proc/sys/fs/{file,inode}-max raised to cope with
the big fileset (and the PAM limits raised)

That's all I can think of for now, so I'll stop typing here. Any
feedback would be deeply appreciated,

Best regards,
Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to "majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
