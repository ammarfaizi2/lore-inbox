Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278954AbRKAOBM>; Thu, 1 Nov 2001 09:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278959AbRKAOBC>; Thu, 1 Nov 2001 09:01:02 -0500
Received: from adsl-63-197-0-76.dsl.snfc21.pacbell.net ([63.197.0.76]:51469
	"HELO www.pmonta.com") by vger.kernel.org with SMTP
	id <S278954AbRKAOAt>; Thu, 1 Nov 2001 09:00:49 -0500
From: Peter Monta <pmonta@pmonta.com>
To: linux-kernel@vger.kernel.org
Subject: ns83820: UDP not working?
Message-Id: <20011101140048.A0B441C5@www.pmonta.com>
Date: Thu,  1 Nov 2001 06:00:48 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't seem to get a UDP test (ttcp -u) to work with the
ns83820 driver.  I'm using DGE-500T cards on both ends, with
a point-to-point link (no switch), if it matters.  ttcp -u
works as expected on the 100baseT interfaces also in the
boxes.  The kernel is 2.4.14-pre3.

Here is what ifconfig shows after waiting ten seconds,
then interrupting ttcp:

(receiver, "ttcp -r -u -s")

eth1      Link encap:Ethernet  HWaddr xx:xx:xx:xx:xx:xx
          inet addr:10.1.1.1  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:44 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:59124 (57.7 kb)  TX bytes:42 (42.0 b)

(transmitter, "ttcp -t -u -s 10.1.1.1")

eth1      Link encap:Ethernet  HWaddr xx:xx:xx:xx:xx:xx
          inet addr:10.1.1.2  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:64 (64.0 b)  TX bytes:42 (42.0 b)

TCP works fine.

I suspect the UDP transmit rapidly fills up the TX queue, but
then things never get unblocked for some reason.  Some of the
trials show 127 or 128 packets having been transmitted, which
might be related to the TX ring size of 256 packets and what
looks like some internal tx_size/2 flow control logic.  With TCP
so many packets in the TX queue is unlikely, I guess, due to
the window.

I can get continuous UDP transmit to work with small enough
packets:

[200 byte UDP payload:]

s0# ttcp -t -u -s -l 200 -n 10000 225.5.5.6
ttcp-t: buflen=200, nbuf=10000, align=16384/0, port=5001  udp  -> 225.5.5.6
ttcp-t: socket
ttcp-t: 2000000 bytes in 0.07 real seconds = 27377.70 KB/sec +++
ttcp-t: 10006 I/O calls, msec/call = 0.01, calls/sec = 140257.92
ttcp-t: 0.0user 0.0sys 0:00real 42% 0i+0d 0maxrss 0+1pf 0+0csw

[300 byte UDP payload:]

s0# ttcp -t -u -s -l 300 -n 10000 225.5.5.6
ttcp-t: buflen=300, nbuf=10000, align=16384/0, port=5001  udp  -> 225.5.5.6
ttcp-t: socket

(hangs)

Cheers,
Peter Monta
