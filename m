Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132864AbRDXILa>; Tue, 24 Apr 2001 04:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132883AbRDXILV>; Tue, 24 Apr 2001 04:11:21 -0400
Received: from roll.cefriel.it ([131.175.53.4]:6414 "EHLO roll.cefriel.it")
	by vger.kernel.org with ESMTP id <S132864AbRDXILP>;
	Tue, 24 Apr 2001 04:11:15 -0400
Message-ID: <76D2776C1B442B4C90E1F95FCA217C46866D65@roll.cefriel.it>
From: Paolo Castagna <castagna@cefriel.it>
To: linux-kernel@vger.kernel.org
Subject: [help] TCP rate control and Linux TCP/IP Stack?
Date: Tue, 24 Apr 2001 10:11:15 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm an Italian student and I'm doing a Master Thesis on TCP rate 
control.

TCP rate control is a new technique for transparently augmenting 
end-to-end TCP performance by controlling the sending rate of a TCP 
source. The sending rate of a TCP source is determined by its window
size, the round trip time and the rate of acknowledgments. 
TCP rate control affects these aspects by modifying the ack number 
and receiver window fields in acknowledgments and by modulating the 
acknowledgment rate. From a performance viewpoint a key benefit of 
TCP rate control is to avoid adverse performance effects due to 
packet losses such as reduced goodput and unfairness or large spread
in per-user goodputs. Further, TCP rate control positively affects
performance even if the bottleneck is non-local and the end-host
TCP implementations are non-conforming. [see article below]

I would like to know your opinions about that, and if there is 
already something similar in the Linux world. I've already see 
the kernel sources but I didn't find something like that. Yes,
I know CBQ, traffic shaping (classic), netfilter.

I'll appreciate suggestion about how to implement such ideas,
TCP rate control, I mean, on Linux, specifically in the 
kernel 2.4.x

There are two algorithms in the TCP rate control technique, as 
describe in the paper below, may be usefull for you to have the
algorithms:

---------------------------------------------------------------------

Algorithm 1 - Rate Allocation Algorithm

The goal of this algorithm is to allocate max-min fair rates to 
competing TCP flows. Initially, equal rate allocations are given to 
all competing flows. Then sending rates of flows are estimated by 
maintaining an exponential average over a rate sampling interval.
When a flow does not to utilize its allocation, it is labeled as 
bottlenecked. Excess allocation is stripped off from all such 
bottlenecked flows and allocated to non-bottlenecked or hungry flows. 
This step is repeated until there is no residual bandwidth to 
allocate or all flows are bottlenecked. This algorithm is invoked 
every time a new flow begins, a flow terminates or when the rate 
sampling interval expires. The resulting rate allocations are 
stored into a table. 

---------------------------------------------------------------------

1. For each flow i, let Ri be the measured rate 
   and Ai be the allocated rate.

2. If N is the total number of flows and B is the bottleneck
   capacity, the initial allocation for each flow i is

     Ai = B / N                                      (2)

3. If Ri < (p * Ai) for some satisfaction percentage p 
   (a statically chosen parameter), then mark flow i as 
   bottlenecked, else mark it as hungry.

4. Let U be the aggregate residual bandwidth i.e the
   bandwidth which remains unutilized by the bottlenecked
   flows.

5. Distribute this residual bandwidth evenly over all the
   hungry flows. If H is the total number of hungry flows, 
   the new allocation for a hungry flow j is given by

     Aj = Aj + (U / H)                               (3)

6. For each bottlenecked flow k the new allocation is
   given by

     Ak = (Ak + Rk) / 2                              (4)

   So for bottlenecked flows, the allocation approaches
   the measured rate over successive iterations of the
   algorithm.

---------------------------------------------------------------------

About this algorithm, I've a problem... how can I measure the rate
Ri for each TCP flow? I've found NeTraMet on this URL:
http://www.auckland.ac.nz/net/Accounting/ntm.Release.note.html
... and I've also read the discussion about that on linux-kernel 
mailing list. Where is the best place to make a such thing? 
I've thought in /net/core/dev.c in function dev_queue_xmit. 
And, again, how can I associate the rate Ri to each TCP flow?

---------------------------------------------------------------------

Algorithm 2 - Rate Enforcement Algorithm

This algorithm enforces the rate allocation by converting the rate 
to a window value. Additionally, it spaces out the acknowledgments 
of a flow, so that they are evenly distributed over its RTT.

---------------------------------------------------------------------

1. For each flow i let

     wi = the calculated window size in units of packets.
     Di = the inter-ack spacing in seconds.
     RTTi = the round trip time (RTT) of flow i, ideally
     not including queuing delays, in seconds.
     MSSi = the maximum segment size of flow i, in bytes.
     Ai = the rate allocation in bytes/s.

2. Observe that for each flow i, we have:

     wi * MSSi = Ai * RTTi                           (5)

   So the window value can be calculated as, 
   
     wi = (Ai * RTTi) / MSSi                         (6)

3. The inter-ack spacing time (RTTi/wi) can also be
   obtained from equation (5):

     Di = RTTi / wi = MSSi / Ai                      (7)

4. For each flow i, acks (if available) are clocked out
   at intervals of Di with the receiver window field set
   to Wi. 

5. The receiver window field of the ack of flow i is set as:

     Wi = min(wi * MSSi , actual receiver window)    (8)

6. The ack number field in the header is determined based
   upon two variables (max and min sequence number) used to 
   denote the ack queue. In the common case, the ack number 
   would be chosen to progress by one MSSi.
   
---------------------------------------------------------------------

About this algorithm, where is, for you, the best place
where to do a such thing? In general I'd like to do only minor
changes possible in the kernel sources, and I would like to 
implement a module for TCP rate control.
I've also found an usefull paper by Glenn Herrin, I've try the
example with the kernel v2.4.3 but I've some problem with it: 
when I export a symbol from the kernel, using EXPORT_SYMBOL and I 
try to use it from a module I have the error: "undefined symbol in 
mymodule" even if it's listed in /boot/System.map 

---------------------------------------------------------------------

Papers:

o Shrikrishna Karandikar, Shivkumar Kalyanaraman, 
  Prasad Bagal, Bob Packer, 
  "TCP Rate Control",
  Computer Communication Review, a publication of ACM SIGCOMM, 
  volume 30, number 1, January 2000. ISSN # 0146-4833. 
  URL:
http://www.acm.org/sigcomm/ccr/archive/2000/jan00/ccr-200001-kara.html

o Glenn Herrin,
  Linux IP Networking, 
  A Guide to the Implementation and 
  Modification of the Linux Protocol Stack 
  TR 00-04, May 31, 2000 
  URL: http://kernelnewbies.org/documents/ipnetworking/

o Others interesting papers:
  URL:
http://www.ecse.rpi.edu/Homepages/shivkuma/research/papers-rpi.html#tcp

---------------------------------------------------------------------

Commercial products based on idea of TCP Rate Control:

o Packeteer - http://www.packeteer.com/ (*) [nasdaq: PKTR]
o Allot - http://www.allot.com/

(*) I know about patents.

---------------------------------------------------------------------

I beg your pardon for the lenght of this message, and also for my
bad english :/ I hope this is the right place for a such discussion, 
if not, please, excuse me, and if you know send me some references.

Greetings,
Paolo Castagna.

---------------------------------------------------------------------

PS:
Keywords:  TCP, TCP Rate Control, Congestion Control, Ack Bucket.
Not pertinet: ECN, SACK, Tocken Bucket, Queueing Disciplines, CBQ, 
WFF, Filters, RED, ...
