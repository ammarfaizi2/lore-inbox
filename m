Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUEYRNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUEYRNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbUEYRNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:13:38 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:11590 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S264984AbUEYRNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:13:04 -0400
Subject: abysmal e1000 performance (DITR)
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Linux Networx
Message-Id: <1085504557.30156.59.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 May 2004 11:02:37 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The DITR (Dynamic Interrupt Throttle Rate) introduced in the 5.x version
of the e1000 driver can limit performance to less than 50% of expected.

I have two machines with secondary e1000 NICs directly connected (no
switch).  I run a test using Netpipe
(http://www.scl.ameslab.gov/netpipe/):

flu2:~ # /tmp/NPtcp -h 10.0.0.1
Send and receive buffers are 16384 and 87380 bytes
(A bug in Linux doubles the requested buffer sizes)
Now starting the main loop
  0:       1 bytes   4999 times -->      0.03 Mbps in     250.03 usec
  1:       2 bytes    399 times -->      0.06 Mbps in     250.02 usec
  2:       3 bytes    399 times -->      0.09 Mbps in     250.02 usec

(mostly uninteresting lines)

 70:   24573 bytes    121 times -->    380.39 Mbps in     492.85 usec
 71:   24576 bytes    135 times -->    380.43 Mbps in     492.86 usec
 72:   24579 bytes    135 times -->    380.49 Mbps in     492.84 usec
 73:   32765 bytes     67 times -->    341.32 Mbps in     732.39 usec
 74:   32768 bytes     68 times -->    341.37 Mbps in     732.35 usec
 75:   32771 bytes     68 times -->    341.41 Mbps in     732.33 usec
 76:   49149 bytes     68 times -->    437.02 Mbps in     858.04 usec
 77:   49152 bytes     77 times -->    451.39 Mbps in     830.77 usec
 78:   49155 bytes     80 times -->    499.57 Mbps in     750.69 usec

That's the best performance, but it drops back down.

 79:   65533 bytes     44 times -->    409.48 Mbps in    1221.00 usec
 80:   65536 bytes     40 times -->    409.42 Mbps in    1221.24 usec
 81:   65539 bytes     40 times -->    409.43 Mbps in    1221.28 usec

Not much different.

121: 8388605 bytes      3 times -->    379.88 Mbps in  168474.49 usec
122: 8388608 bytes      3 times -->    411.24 Mbps in  155625.68 usec
123: 8388611 bytes      3 times -->    395.81 Mbps in  161693.50 usec

And there's the end.

I would expect to see ~900 Mbps performance (in fact, a Broadcom tg3 NIC
in the same machine gives the expected ~900 Mbps performance).  The
older, 4.x e1000 series of drivers gives the ~900 Mbps performance as
expected.  I have traced the abysmal performance to the DITR code.  I
have added some output to the e1000_main.c:e1000_watchdog() section
where the Dynamic interrupt is calculated and set.  It's interesting to
note how the goc (good octet count) and the itr oscillate during the
netpipe run (ritr is the real ITR setting that is written to the e1000
ITR register):

goc(18=9+9) dif(0) ritr(1953) DITR = 2000
goc(0=0+0) dif(0) ritr(488) DITR = 8000
goc(44=22+22) dif(0) ritr(1953) DITR = 2000
goc(0=0+0) dif(0) ritr(488) DITR = 8000
goc(54=27+27) dif(0) ritr(1953) DITR = 2000

(many lines of oscillation and increased activity)

goc(0=0+0) dif(0) ritr(488) DITR = 8000
goc(10558=5299+5258) dif(41) ritr(1930) DITR = 2023
goc(0=0+0) dif(0) ritr(488) DITR = 8000
goc(9996=5228+4768) dif(459) ritr(1717) DITR = 2275
goc(0=0+0) dif(0) ritr(488) DITR = 8000
goc(11180=5378+5801) dif(422) ritr(1754) DITR = 2226
goc(0=0+0) dif(0) ritr(488) DITR = 8000
goc(10817=5304+5512) dif(208) ritr(1846) DITR = 2115


It is very interesting to note that if the 5.x driver is loaded with
InterruptThrottleRate=8000 (the default setting of the 4.x e1000 drivers
- which also disables dynamic adjustment of the ITR) then performance is
~900 Mbps:

119: 6291456 bytes      3 times -->    891.33 Mbps in   53851.83 usec
120: 6291459 bytes      3 times -->    891.34 Mbps in   53851.35 usec
121: 8388605 bytes      3 times -->    895.99 Mbps in   71429.49 usec
122: 8388608 bytes      3 times -->    881.12 Mbps in   72634.50 usec
123: 8388611 bytes      3 times -->    885.65 Mbps in   72263.48 usec

My assessment for the poor performance using is DITR is that this
reduces load on the box by limiting interrupts while increasing latency
to service the packets.  The problem is that this is done irrespective
of the actual load on the system and thus results in gratuitous latency
being added.  In other words: why limit the interrupts and reduce the
load on the system when the system isn't loaded and has nothing better
to do?  This kills performance on systems that have plenty of horsepower
to handle their load as well as service interrupts.

I recommend that the DITR formula should use the system load to scale
the 6000/2000 split, and/or that the 8000 ITR setting be the default and
the dynamic setting of ITR=1 be the option.

--- linux/drivers/net/e1000/e1000_param.c.orig	2004-05-25
18:05:10.000000000 -0700
+++ linux/drivers/net/e1000/e1000_param.c	2004-05-25 18:05:26.000000000
-0700
@@ -224,7 +224,7 @@
 #define MAX_TXABSDELAY            0xFFFF
 #define MIN_TXABSDELAY                 0
 
-#define DEFAULT_ITR                    1
+#define DEFAULT_ITR                 8000
 #define MAX_ITR                   100000
 #define MIN_ITR                      100
 


-- 
Thayne Harbaugh
Linux Networx

