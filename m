Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318291AbSIFLcy>; Fri, 6 Sep 2002 07:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318510AbSIFLcy>; Fri, 6 Sep 2002 07:32:54 -0400
Received: from robur.slu.se ([130.238.98.12]:46086 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S318291AbSIFLcx>;
	Fri, 6 Sep 2002 07:32:53 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15736.38178.445310.714015@robur.slu.se>
Date: Fri, 6 Sep 2002 13:44:34 +0200
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@zip.com.au, Martin.Bligh@us.ibm.com, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com, Robert.Olsson@data.slu.se
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David S. Miller writes:
 >    Mala did some testing on this a couple of weeks back.  It appears that
 >    NAPI damaged performance significantly.
 > 
 >    http://www-124.ibm.com/developerworks/opensource/linuxperf/netperf/results/july_02/netperf2.5.25results.htm
 > 

 > Robert can comment on optimal settings

Hopefully yes...

I see other numbers so we have to sort out the differences. Andrew Morton
pinged me about this test last week. So I've had a chance to run some tests. 

Some comments:
Scale to CPU can be dangerous measure w. NAPI due to its adapting behaviour 
where RX interrupts decreases in favour of successive polls.

And NAPI scheme behaves different since we can not assume that all network 
traffic is well-behaved like TCP. System has to be manageable and to "perform"
under any network load not only for well-behaved TCP. So of course we will 
see some differences -- there are no free lunch. Simply we can not blindly
look at one test. IMO NAPI is the best overall performer. The number speaks 
for themselves.

Here is the most recent test...

NAPI kernel path is included in 2.4.20-pre4 the comparison below is mainly 
between e1000 driver w and w/o NAPI and the NAPI port to e1000 is still 
evolving. 

Linux 2.4.20-pre4/UP PIII @ 933 MHz w. Intel's e100 2 port GIGE adapter.
e1000 4.3.2-k1 (current kernel version) and current NAPI patch. For NAPI 
e1000 driver uses RxIntDelay=1. RxIntDewlay=0 caused problem. Non-NAPI
driver RxIntDelay=64. (default)

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
T-put       305   298580    pkts routed.

NOTE! 
With non-NAPI driver this system is "dead" an performes nothing.


Cheers.
						--ro


