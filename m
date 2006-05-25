Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWEYADU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWEYADU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWEYADU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:03:20 -0400
Received: from rex.snapgear.com ([203.143.235.140]:18569 "EHLO moreton.com.au")
	by vger.kernel.org with ESMTP id S932338AbWEYADT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:03:19 -0400
Date: Thu, 25 May 2006 10:03:03 +1000
From: David McCullough <david_mccullough@au.securecomputing.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ACRYPTO] New asynchronous crypto layer release.
Message-ID: <20060525000303.GA10181@beast>
References: <20060521131429.GA9789@2ka.mipt.ru> <20060523230443.GG15545@beast> <20060524071252.GA24694@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524071252.GA24694@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin Evgeniy Polyakov lays it down ...
> On Wed, May 24, 2006 at 09:04:43AM +1000, David McCullough (david_mccullough@au.securecomputing.com) wrote:
> > 
> > Hi Evgeniy,
> 
> Hello David.
> 
> > Just interested in the results you are getting below for
> > comparison to what I see under OCF with Openswan.
> > 
> > What sort of hifn card were you using in the test below,
> > was it a 7956 PCIX (ie., 64bit?)
> > 
> > How did you measure the throughput  ?
> 
> It is racoon transport setup with ESP4 only ecryption with AES-128 CBC
> mode.
> 
> Hardware.
> FC4 vanilla kernel 2.6.16-1.2069_FC4smp runs on P3 3 Ghz with HT
> enabled, 512 Mb of RAM, sk98lin gigabit ethernet.
> Acrypto kernel runs on Xeon 2.4 Ghz with HT enabled with 1Gb of RAM 
> and e1000 gigabit ethernet adapter (in pci-x slot).
> HIFN card is old 7955 (it was quite challenging to bring it to Russia
> when I started acrypto developemnt several years ago, so no new toys) 
> in PCI-X slot.
> When HIFN driver is not loaded, asynchronous SW crypto provider is
> loaded for one processor.
> 
> Benchmark is scp (yes, it encrypt packets too to simulate some real work
> on hosts) of big files over the gigabit link.
> 
> > I can post the OCF numbers,  but it doesn't mean a lot
> > unless it's a fair comparison :-)

Here are the numbers,  although the test is somewhat different,
I have left the full output report from iperf for reference.
Hopefully it's not too hard to find the info in there :-)

Cheers,
Davidm


OCF test results on uniprocessor x86 hardware: 20060512
-------------------------------------------------------

The setup used for these tests follows,  the raw speed of each link
was measured using tcpblast for a rough check before starting.

      A                  B                   C                    D
   2400 AMD  --------  2.4 Xeon  --------  2.8 Xeon  --------  1.0G PentiumII
              890Mbits             940Mbits          940Mbits

System A has a 32bit Intel Gbit NIC,  all the rest have Intel Dual GBit
64bit cards.  B and C have Hifn 7956 64bit cards (max 66MHz bus).  All
systems are uniprocessor without hyperthreading.

Test 1
------

Running iperf tests on system A against system D *WITHOUT* ipsec enabled
gives the following results.

    ./iperf -l 1440 -c 192.168.1.2 -u -b 1500m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 1440 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 32799 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec    932 MBytes    782 Mbits/sec
    [  5] Sent 678574 datagrams
    [  5] Server Report:
    [  5]  0.0-10.0 sec    932 MBytes    786 Mbits/sec  0.025 ms    2/678573 (0.00029%)
    [  5]  0.0-10.0 sec  1 datagrams received out-of-order

    ./iperf -l 200 -c 192.168.1.2 -u -b 1500m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 200 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 32799 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec    252 MBytes    212 Mbits/sec
    [  5] Sent 1323609 datagrams
    [  5] Server Report:
    [  5]  0.0-10.2 sec    113 MBytes  92.7 Mbits/sec  15.141 ms 733256/1323582 (55%)
    [  5]  0.0-10.2 sec  1 datagrams received out-of-order

    ./iperf -l 64 -c 192.168.1.2 -u -b 1500m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 64 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 32799 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec  81.6 MBytes  68.4 Mbits/sec
    [  5] Sent 1336227 datagrams
    [  5] Server Report:
    [  5]  0.0-10.0 sec  72.9 MBytes  61.4 Mbits/sec  0.006 ms 141594/1336226 (11%)
    [  5]  0.0-10.0 sec  1 datagrams received out-of-order


Test 2
------

The following numbers show the results using ipsec WITHOUT the hifn
accelerators.  The configuration is for 3des-sha1-modp1024.  The tests are
using OpenSwan 2.4.5 with the OCF patches but with no hardware acceleration,
just the existing OpenSwan ALG software crypto.

    ./iperf -l 1440 -c 192.168.1.2 -u -b 1500m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 1440 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 32799 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec    787 MBytes    660 Mbits/sec
    [  5] Sent 572731 datagrams
    [  5] Server Report:
    [  5]  0.0-10.2 sec  74.9 MBytes  61.6 Mbits/sec  10.804 ms 518199/572729 (90%)
    [  5]  0.0-10.2 sec  1 datagrams received out-of-order

    ./iperf -l 200 -c 192.168.1.2 -u -b 1500m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 200 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 32799 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec    251 MBytes    211 Mbits/sec
    [  5] Sent 1318167 datagrams
    [  5] Server Report:
    [  5]  0.0-10.2 sec  37.3 MBytes  30.7 Mbits/sec  12.967 ms 1122553/1318163 (85%)
    [  5]  0.0-10.2 sec  1 datagrams received out-of-order

    ./iperf -l 64 -c 192.168.1.2 -u -b 1500m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 64 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 32799 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec  76.9 MBytes  64.5 Mbits/sec
    [  5] Sent 1260384 datagrams
    [  5] Server Report:
    [  5]  0.0-10.0 sec  16.0 MBytes  13.4 Mbits/sec  1.217 ms 997846/1260383 (79%)
    [  5]  0.0-10.0 sec  1 datagrams received out-of-order

Test 3
------

The following numbers show the results using ipsec WITH the hifn7956
accelerators installed in B and C.  The openswan configuration is for
3des-sha1-modp1024 with pre-shared keys.

    # ./iperf -l 1400 -c 192.168.1.2 -u -b 235m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 1400 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 33120 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec    284 MBytes    238 Mbits/sec
    [  5] Sent 212767 datagrams
    [  5] Server Report:
    [  5]  0.0- 9.9 sec    284 MBytes    240 Mbits/sec  0.191 ms    0/212766 (0%)
    [  5]  0.0- 9.9 sec  1 datagrams received out-of-order

    # ./iperf -l 200 -c 192.168.1.2 -u -b 58m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 200 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 33121 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec  70.6 MBytes  59.3 Mbits/sec
    [  5] Sent 370362 datagrams
    [  5] Server Report:
    [  5]  0.0- 9.9 sec  70.6 MBytes  59.6 Mbits/sec  0.035 ms   86/370361 (0.023%)
    [  5]  0.0- 9.9 sec  1 datagrams received out-of-order

    ./iperf -l 64 -c 192.168.1.2 -u -b 22m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 64 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 33121 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec  26.5 MBytes  22.3 Mbits/sec
    [  5] Sent 434695 datagrams
    [  5] Server Report:
    [  5]  0.0-10.0 sec  26.1 MBytes  22.0 Mbits/sec  0.027 ms 6865/434694 (1.6%)
    [  5]  0.0-10.0 sec  1 datagrams received out-of-order

Test 4
------

And finally the null crypto case (40% CPU on a 2.4 Xeon, %20 on a 2.8 for
large packets, 100% CPU for the 200 and 64 byte packets).  The null crypto
case replaces the hardware accelerator with a theoretical 0 cost
implementation which does nothing.  This allows the cost of ipsec processing
to been seen,  and also the potential benefits from better acceleration.

    ./iperf -l 1400 -c 192.168.1.2 -u -b 750m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 1400 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 33198 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec    919 MBytes    771 Mbits/sec
    [  5] Sent 688557 datagrams
    [  5] Server Report:
    [  5]  0.0-10.0 sec    919 MBytes    775 Mbits/sec  0.010 ms 2/688556 (0.00029%)
    [  5]  0.0-10.0 sec  1 datagrams received out-of-order


    ./iperf -l 200 -c 192.168.1.2 -u -b 750m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 200 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 33198 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec    253 MBytes    213 Mbits/sec
    [  5] Sent 1328454 datagrams
    [  5] Server Report:
    [  5]  0.0-10.2 sec    113 MBytes  93.2 Mbits/sec  14.657 ms 734888/1328450 (55%)
    [  5]  0.0-10.2 sec  1 datagrams received out-of-order


    ./iperf -l 64 -c 192.168.1.2 -u -b 750m
    ------------------------------------------------------------
    Client connecting to 192.168.1.2, UDP port 5001
    Sending 64 byte datagrams
    UDP buffer size:   103 KByte (default)
    ------------------------------------------------------------
    [  5] local 192.168.0.2 port 33198 connected with 192.168.1.2 port 5001
    [  5]  0.0-10.0 sec  80.9 MBytes  67.9 Mbits/sec
    [  5] Sent 1325578 datagrams
    [  5] Server Report:
    [  5]  0.0-10.2 sec  39.5 MBytes  32.5 Mbits/sec  14.771 ms 678605/1325478 (51%)

david_mccullough@securecomputing.com
http://ocf-linux.sourceforge.net/


-- 
David McCullough,  david_mccullough@securecomputing.com,   Ph:+61 734352815
Secure Computing - SnapGear  http://www.uCdot.org http://www.cyberguard.com
