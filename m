Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318210AbSHZTRl>; Mon, 26 Aug 2002 15:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318229AbSHZTRl>; Mon, 26 Aug 2002 15:17:41 -0400
Received: from robur.slu.se ([130.238.98.12]:42763 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S318210AbSHZTRk>;
	Mon, 26 Aug 2002 15:17:40 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15722.33143.220568.646900@robur.slu.se>
Date: Mon, 26 Aug 2002 21:28:55 +0200
To: "Mala Anand" <manand@us.ibm.com>
Cc: jamal <hadi@cyberus.ca>, davem@redhat.com, netdev@oss.sgi.com,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       "Bill Hartner" <bhartner@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
In-Reply-To: <OFFFA46B92.252E5659-ON87256C21.000BB73B@boulder.ibm.com>
References: <OFFFA46B92.252E5659-ON87256C21.000BB73B@boulder.ibm.com>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mala Anand writes:
 > I know you don't subscribe to lkml. Have you seen these results?
 > On Numa machine it showed around 3% improvement using SPECweb99.

 In slab terms you moved part of the destructor to the constructor
 but the main problem is still there. The skb entered the "wrong" CPU
 so to be "reused from the slab again" the work has to done regardless
 if it's in the constructor or destructor.

 Eventually if we accept some cache misses a skb could possibly be re-routed
 to the proper slab/CPU for this we would need some skb coloring.

 
 Also I noticed your TCP results w. e1000. 
 Here is what I see:
 
Linux 2.4.20-pre4/UP PIII @ 933 MHz w. Intel's e100 2 port GIGE adapter.
e1000 4.3.2-k1 (current kernel version) and current NAPI patch. For NAPI 
e1000 driver used RxIntDelay=1. RxIntDelay=0 caused problem now. Non-NAPI
driver used RxIntDelay=64. (default)

Three tests: TCP, UDP, packet forwarding.


Netperf. TCP socket size 131070, Single TCP stream. Test length 30 s.

M-size   e1000    NAPI-e1000
============================
      4   20.74    20.69  Mbit/s data received.
    128  458.14   465.26 
    512  836.40   846.71 
   1024  936.11   937.93 
   2048  940.65   939.92 
   4096  940.86   937.59
   8192  940.87   939.95 
  16384  940.88   937.61
  32768  940.89   939.92
  65536  940.90   939.48
 131070  940.84   939.74


Netperf. UDP_STREAM. 1440 pkts. Single UDP stream. Test length 30 s.
         e1000    NAPI-e1000
====================================
         955.7    955.7   Mbit/s data received.


Forwarding test. 1 Mpkts at 970 kpps injected.
          e1000   NAPI-e1000
=============================================
Tput       305   298580   Pkts routed.



Cheers.

						--ro
