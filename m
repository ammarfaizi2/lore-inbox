Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbTI1UCf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 16:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTI1UCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 16:02:35 -0400
Received: from host3.whitb.cust.sover.net ([207.136.236.67]:62860 "EHLO
	patternbook.com") by vger.kernel.org with ESMTP id S262704AbTI1UC2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 16:02:28 -0400
Date: Sun, 28 Sep 2003 16:02:26 -0400
From: Whit Blauvelt <whit@transpect.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Strange active ftp failure
Message-ID: <20030928200226.GA13382@free.transpect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This may not be kernel-related, but having ruled out all obvious-to-me
suspects, please accept my apologies for presenting the problem here - just
in case it is (or someone with kernel-level knowledge can tell me what I've
missed).

The situation:

Two machines are on the same two external interfaces (a T-1 and a 1.5
meg SDSL line, each interface with a range of IPs). On machine 1, active ftp
(using ports 21 and 20) works fine on both interfaces. On machine 2, active
ftp works fine on one interface but not the other - where it consistently
fails to, for instance, present an "ls".

Causes that I've ruled out:

Not a firewall issue - dropping the (local iptables) firewall makes no 
    difference
Not a NAT issue - both machines are on public IPs, no NAT
Not an ftp daemon issue - same results whether running ProFTPd or Pure-ftpd,
    where on both machines the configuration and version is identical 
Not a known issue to the ftp daemon maintainers - queries to the ProFtpd and
    Pure-ftpd lists haven't elicited anything useful
Not a NIC issue - same result when the onboard EtherExpressPro is replaced
    by a 3com 905 (the card model also running on all other interfaces)
Not an IP issue - swapping IPs between the two machines for the problematic 
    interface doesn't change the problem on the one machine or introduce it
    on the other
Not a rules or routes issue - both machines have the same ip rules and
    routes
Not an rp_filter issue - in all instances 
    /proc/sys/net/ipv4/conf/*/rp_filter is 0, log_martians is 1, and no
    martians are being logged (all other switches in eth* are identical too)
Not a known issue to the lartc (Linux Advanced Routing and Traffic Control)
    list
Not a downstream issue - both machines are plugged into the same routers
    (and swapping the router ports they're plugged into doesn't change it)
Not an ISP issue - the SDSL provider of that line by policy doesn't filter 
    anything (and if it did both machines would have the problem)
Not a connection quality issue - no packet loss or latency issues on either 
    interface on either machine
Not a client issue - same result from multiple clients in multiple locations
Not an intermittent issue - behavior is 100% consistent

Both machines are Dells running up-to-date Gentoo.

As for kernel differences, the machine with no problem is a single-processor
Pentium III running vanilla 2.4.21 with Julian Anastasov's static routing
patches and FreeS/WAN. The problem machine, a dual-processor Pentium III,
has the problem consistently with:

+ kernel 2.4.20 with Anastasov's patches and FreeS/WAN
+ kernel 2.4.22, straight vanilla
+ kernel 2.4.22 with Anastasov's patches

The most recent trial of the last had _all_ the kernel configuration options
identical with the "good" machine except for SMP being enabled and the
FreeS/WAN patches and options not being there (FreeS/WAN's currently not
involved in ftp or even running on the other machine).

When I run tcpdump on server it looks like this for an "ls" following login
on the failing active ftp connection:

# tcpdump -i eth2 src or dst port ftp-data
tcpdump: listening on eth2
14:23:19.900936 [eth2 ip].ftp-data > [remote ip].33050: S 982153112:2982153112(0) win 5840 <mss 1460,sackOK,timestamp 61754850 ,nop,wscale 0> (DF)
14:23:19.962487 [remote ip].33050 > [eth2 ip].ftp-data: S 8335459:78335459(0) ack 2982153113 win 5792 <mss 1460,sackOK,timestamp 46588689 61754850,nop,wscale 0> (DF)
14:23:23.364417 [remote ip].33050 > [eth2 ip].ftp-data: S 8335459:78335459(0) ack 2982153113 win 5792 <mss 1460,sackOK,timestamp 46592089 61754850,nop,wscale 0> (DF)
14:23:25.901169 [eth2 ip].ftp-data > [remote ip].33050: S 982153112:2982153112(0) win 5840 <mss 1460,sackOK,timestamp 61755450 ,nop,wscale 0> (DF)
14:23:25.938500 [remote ip].33050 > [eth2 ip].ftp-data: S 8335459:78335459(0) ack 2982153113 win 5792 <mss 1460,sackOK,timestamp 46594668 61754850,nop,wscale 0> (DF)
14:23:29.358543 [remote ip].33050 > [eth2 ip].ftp-data: S 8335459:78335459(0) ack 2982153113 win 5792 <mss 1460,sackOK,timestamp 46598089 61754850,nop,wscale 0> (DF)
14:23:37.901654 [eth2 ip].ftp-data > [remote ip].33050: S 982153112:2982153112(0) win 5840 <mss 1460,sackOK,timestamp 61756650 ,nop,wscale 0> (DF)
14:23:37.989714 [remote ip].33050 > [eth2 ip].ftp-data: S 8335459:78335459(0) ack 2982153113 win 5792 <mss 1460,sackOK,timestamp 46606666 61754850,nop,wscale 0> (DF)
14:23:41.559774 [remote ip].33050 > [eth2 ip].ftp-data: S 8335459:78335459(0) ack 2982153113 win 5792 <mss 1460,sackOK,timestamp 46610289 61754850,nop,wscale 0> (DF)
14:24:01.902622 [eth2 ip].ftp-data > [remote ip].33050: S 982153112:2982153112(0) win 5840 <mss 1460,sackOK,timestamp 61759050 ,nop,wscale 0> (DF)
14:24:01.942078 [remote ip].33050 > [eth2 ip].ftp-data: S 8335459:78335459(0) ack 2982153113 win 5792 <mss 1460,sackOK,timestamp 46630673 61754850,nop,wscale 0> (DF)
14:24:05.560151 [remote ip].33050 > [eth2 ip].ftp-data: S 8335459:78335459(0) ack 2982153113 win 5792 <mss 1460,sackOK,timestamp 46634289 61754850,nop,wscale 0> (DF)
14:24:49.904552 [eth2 ip].ftp-data > [remote ip].33050: S 982153112:2982153112(0) win 5840 <mss 1460,sackOK,timestamp 61763850 ,nop,wscale 0> (DF)
14:24:49.948785 [remote ip].33050 > [eth2 ip].ftp-data: S 8335459:78335459(0) ack 2982153113 win 5792 <mss 1460,sackOK,timestamp 46678675 61754850,nop,wscale 0> (DF)
14:24:53.764910 [remote ip].33050 > [eth2 ip].ftp-data: S 8335459:78335459(0) ack 2982153113 win 5792 <mss 1460,sackOK,timestamp 46682489 61754850,nop,wscale 0> (DF)

442 packets received by filter
0 packets dropped by kernel

For a successful one on the other interface: 

# tcpdump -i eth1 src or dst port ftp-data
tcpdump: listening on eth1
14:28:45.894017 [eth1 ip].ftp-data > [remote ip].33052: S 3335994396:3335994396(0) win 5840 <mss 1460,sackOK,timestamp 61787448 0,nop,wscale 0> (DF)
14:28:45.937242 [remote ip].33052 > [eth1 ip].ftp-data: S 411111188:411111188(0) ack 3335994397 win 5792 <mss 1460,sackOK,timestamp 146914689 61787448,nop,wscale 0> (DF)
14:28:45.937366 [eth1 ip].ftp-data > [remote ip].33052: . ack 1 win 5840 <nop,nop,timestamp 61787452 146914689> (DF)
14:28:45.954203 [eth1 ip].ftp-data > [remote ip].33052: P 1:999(998) ack 1 win 5840 <nop,nop,timestamp 61787454 146914689> (DF)
14:28:45.954390 [eth1 ip].ftp-data > [remote ip].33052: . 999:2447(1448) ack 1 win 5840 <nop,nop,timestamp 61787454 146914689> (DF)
14:28:45.954482 [eth1 ip].ftp-data > [remote ip].33052: FP 2447:3498(1051) ack 1 win 5840 <nop,nop,timestamp 61787454 146914689> (DF)
14:28:46.071125 [remote ip].33052 > [eth1 ip].ftp-data: . ack 999 win 6986 <nop,nop,timestamp 146914824 61787454> (DF) [tos 0x8] 
14:28:46.102387 [remote ip].33052 > [eth1 ip].ftp-data: . ack 2447 win 10136 <nop,nop,timestamp 146914853 61787454> (DF) [tos 0x8] 
14:28:46.126538 [remote ip].33052 > [eth1 ip].ftp-data: F 1:1(0) ack 3499 win 13032 <nop,nop,timestamp 146914875 61787454> (DF) [tos 0x8] 
14:28:46.126568 [eth1 ip].ftp-data > [remote ip].33052: . ack 2 win 5840 <nop,nop,timestamp 61787471 146914875> (DF)

597 packets received by filter
0 packets dropped by kernel

For the other machine on same external line that fails on the first machine:

# tcpdump -i eth2 src or dst port ftp-data
tcpdump: listening on eth2
14:36:02.825949 [eth2 ip].ftp-data > [remote ip].33057: S 151358595:151358595(0) win 5840 <mss 1460,sackOK,timestamp 249200916 0,nop,wscale 0> (DF)
14:36:02.862518 [remote ip].33057 > [eth2 ip].ftp-data: S 868593832:868593832(0) ack 151358596 win 5792 <mss 1460,sackOK,timestamp 147351489 249200916,nop,wscale 0> (DF)
14:36:02.862612 [eth2 ip].ftp-data > [remote ip].33057: . ack 1 win 5840 <nop,nop,timestamp 249200919 147351489> (DF)
14:36:02.886757 [eth2 ip].ftp-data > [remote ip].33057: P 1:997(996) ack 1 win 5840 <nop,nop,timestamp 249200922 147351489> (DF)
14:36:02.887043 [eth2 ip].ftp-data > [remote ip].33057: . 997:2445(1448) ack 1 win 5840 <nop,nop,timestamp 249200922 147351489> (DF)
14:36:02.887100 [eth2 ip].ftp-data > [remote ip].33057: FP 2445:2678(233) ack 1 win 5840 <nop,nop,timestamp 249200922 147351489> (DF)
14:36:02.955549 [remote ip].33057 > [eth2 ip].ftp-data: . ack 997 win 6972 <nop,nop,timestamp 147351584 249200922> (DF)
14:36:02.985489 [remote ip].33057 > [eth2 ip].ftp-data: . ack 2445 win 10136 <nop,nop,timestamp 147351614 249200922> (DF)
14:36:02.994463 [remote ip].33057 > [eth2 ip].ftp-data: F 1:1(0) ack 2679 win 10136 <nop,nop,timestamp 147351622 249200922> (DF)
14:36:02.994501 [eth2 ip].ftp-data > [remote ip].33057: . ack 2 win 5840 <nop,nop,timestamp 249200932 147351622> (DF)

183 packets received by filter
0 packets dropped by kernel

>From the client the failing instance looks the same as from the server:

# tcpdump -i eth0 src or dst port ftp-data
tcpdump: listening on eth0
14:45:44.710894 [server].ftp-data > [client].33059: S 100058036:100058036(0) win 5840 <mss 1460,sackOK,timestamp 61889323 0,nop,wscale 0> (DF)
14:45:44.710978 [client].33059 > [server].ftp-data: S 1480641926:1480641926(0) ack 100058037 win 5792 <mss 1460,sackOK,timestamp 147933307 61889323,nop,wscale 0> (DF)
14:45:48.910611 [client].33059 > [server].ftp-data: S 1480641926:1480641926(0) ack 100058037 win 5792 <mss 1460,sackOK,timestamp 147937507 61889323,nop,wscale 0> (DF)
14:45:50.692647 [server].ftp-data > [client].33059: S 100058036:100058036(0) win 5840 <mss 1460,sackOK,timestamp 61889923 0,nop,wscale 0> (DF)
14:45:50.692706 [client].33059 > [server].ftp-data: S 1480641926:1480641926(0) ack 100058037 win 5792 <mss 1460,sackOK,timestamp 147939288 61889323,nop,wscale 0> (DF)
14:45:54.911425 [client].33059 > [server].ftp-data: S 1480641926:1480641926(0) ack 100058037 win 5792 <mss 1460,sackOK,timestamp 147943507 61889323,nop,wscale 0> (DF)
14:46:02.699413 [server].ftp-data > [client].33059: S 100058036:100058036(0) win 5840 <mss 1460,sackOK,timestamp 61891123 0,nop,wscale 0> (DF)
14:46:02.699487 [client].33059 > [server].ftp-data: S 1480641926:1480641926(0) ack 100058037 win 5792 <mss 1460,sackOK,timestamp 147951294 61889323,nop,wscale 0> (DF)
14:46:06.913038 [client].33059 > [server].ftp-data: S 1480641926:1480641926(0) ack 100058037 win 5792 <mss 1460,sackOK,timestamp 147955507 61889323,nop,wscale 0> (DF)
14:46:26.676678 [server].ftp-data > [client].33059: S 100058036:100058036(0) win 5840 <mss 1460,sackOK,timestamp 61893523 0,nop,wscale 0> (DF)
14:46:26.676738 [client].33059 > [server].ftp-data: S 1480641926:1480641926(0) ack 100058037 win 5792 <mss 1460,sackOK,timestamp 147975268 61889323,nop,wscale 0> (DF)
14:46:31.116248 [client].33059 > [server].ftp-data: S 1480641926:1480641926(0) ack 100058037 win 5792 <mss 1460,sackOK,timestamp 147979707 61889323,nop,wscale 0> (DF)
14:47:14.696089 [server].ftp-data > [client].33059: S 100058036:100058036(0) win 5840 <mss 1460,sackOK,timestamp 61898323 0,nop,wscale 0> (DF)
14:47:14.696143 [client].33059 > [server].ftp-data: S 1480641926:1480641926(0) ack 100058037 win 5792 <mss 1460,sackOK,timestamp 148023273 61889323,nop,wscale 0> (DF)
14:47:19.331232 [client].33059 > [server].ftp-data: S 1480641926:1480641926(0) ack 100058037 win 5792 <mss 1460,sackOK,timestamp 148027907 61889323,nop,wscale 0> (DF)

And a successful instance viewed from the client:

14:51:10.285392 [server].ftp-data > [client].33061: S 465767684:465767684(0) win 5840 <mss 1460,sackOK,timestamp 61921873 0,nop,wscale 0> (DF)
14:51:10.285476 [client].33061 > [server].ftp-data: S 1835411337:1835411337(0) ack 465767685 win 5792 <mss 1460,sackOK,timestamp 148258803 61921873,nop,wscale 0> (DF)
14:51:10.315404 [server].ftp-data > [client].33061: . ack 1 win 5840 <nop,nop,timestamp 61921876 148258803> (DF)
14:51:10.361253 [server].ftp-data > [client].33061: P 1:999(998) ack 1 win 5840 <nop,nop,timestamp 61921877 148258803> (DF)
14:51:10.361289 [client].33061 > [server].ftp-data: . ack 999 win 6986 <nop,nop,timestamp 148258878 61921877> (DF) [tos 0x8] 
14:51:10.391621 [server].ftp-data > [client].33061: . 999:2447(1448) ack 1 win 5840 <nop,nop,timestamp 61921877 148258803> (DF)
14:51:10.391682 [client].33061 > [server].ftp-data: . ack 2447 win 10136 <nop,nop,timestamp 148258909 61921877> (DF) [tos 0x8] 
14:51:10.412376 [server].ftp-data > [client].33061: FP 2447:3498(1051) ack 1 win 5840 <nop,nop,timestamp 61921877 148258803> (DF)
14:51:10.412633 [client].33061 > [server].ftp-data: F 1:1(0) ack 3499 win 13032 <nop,nop,timestamp 148258930 61921877> (DF) [tos 0x8] 
14:51:10.449436 [server].ftp-data > [client].33061: . ack 2 win 5840 <nop,nop,timestamp 61921888 148258930> (DF)

What I can make out is that where it fails the ftp server is making an
initial response from port 20 to a high port on the client, and the client
is responding from that back to the server, but the ftp server is ignoring
that despite tcpdump showing the server has received it. So the client tries
a second time, and they get into a dance of failed negotiation. In the
instances that work the server goes ahead and gives the "ls" data as
requested.

Should I suspect that the SMP kernel code is the problem - the systems being
so close to identical in all other respects (but how could that affect eth2
but not eth1)? Or is there some other factor I haven't controlled for yet? 

(I'd swap the no-problem machine for the other, but the problem one has CPUs
twice as fast, hardware RAID, and other server-class hardware which the
other lacks, so that's not a viable course to take.)

So, how to track this down and fix it?

Thanks for any advice. Apologies again if this is nothing to do with the
kernel - it just seems I've exhausted everything else.

Whit
