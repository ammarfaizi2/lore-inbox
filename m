Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbUBZSwm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbUBZSwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:52:42 -0500
Received: from web21407.mail.yahoo.com ([216.136.232.77]:5496 "HELO
	web21407.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262918AbUBZSwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:52:21 -0500
Message-ID: <20040226185219.70474.qmail@web21407.mail.yahoo.com>
Date: Thu, 26 Feb 2004 10:52:19 -0800 (PST)
From: MP M <mageshmp2003@yahoo.com>
Subject: help in TCP checksum offload , TSO and zero copy
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,
 
I am working on TCP checksum offload , TSO and zero
copy with linux 2.6.1 kernel .
 
IMHO I find that the code for TCP checksum offload and
TSO are already supported by the linux 2.6 kernel . I
arrived at this conclusion on seeing the presence of
flag CHECKSUM_HW and the #defines for NETIF_F_IP_CSUM
, NETIF_F_NO_CSUM and
NETIF_F_HW_CSUM . By default , it seems that
CHECKSUM_HW is enabled by default so that the TSO
supported driver will do the processing on the
ethernet card.
 
Please correct me if I am wrong .
 
In the driver for e1000 and tg3 , support for TSO is
already seen .
 
But when I was testing the performance using ttcp
utility , I found some weird results.
I just want to share to obtain some feedback from some
experienced guys in this area who has already worked
in TSO ,TCP checksum offload .
 
On the server machine I had my linux 2.6 kernel
running and it had e1000 Intel pro ethercard
support.Initially with ethtool utility I ensured that
the Tx and Rx checksum setting on e1000 is set to on .
I started ttcp utiltity in receive mode on the server
machine listening on my specified port .
 
Next I pumped in data from my client machine using
ttcp utility in transmit mode to the server .
 
I measured the time duration for data transfer to
happen . say x milliseconds.
 
Next I set the tx and rx checksum on e1000 card using
ethtool , and repeated the above test with ttcp
utility .Since the content size is same and with tx/rx
checksum off on e1000 , I expected the time duaration
of data transfer from server to client to be x+some
delta . But surprisingly I am noticing the data
transfer at lesser time than x .(ie faster than before
with tx/rx checksum off on e1000 ) .
 
I would appreciate if anyone could shed some light on
this odd behaviour .
 

I have pasted below what I encountered :-

setup
-----
aniket-linux is client m/c
tc105 is server m/c which has linux 2.6.1 kernel
running on it .

eth2 is e1000 NIC on tc105 which supports checksum
offload and segmentation offloading

[root@tc105 mpm]# ethtool -k eth2
RX/TX checksumming parameters for eth2:
rx-checksumming: on
tx-checksumming: on
scatter-gather: on
[root@tc105 mpm]#

Pumping data to server tc105 when rx-checksum and 
---------------------------------------------------
tx-checksum are enabled on the server's NIC interface
-----------------------------------------------------
 eth2
-----
[magesh@aniket-linux current]$ ls
rpm_topdir
[magesh@aniket-linux current]$ tar of - rpm_topdir |
ttcp -t tc105 -p 4001
ttcp-t: buflen=8192, nbuf=2048, align=16384/0,
port=4001  tcp  -> tc105
ttcp-t: socket
ttcp-t: connect
ttcp-t: 216442880 bytes in 299.34 real seconds =
706.13 KB/sec +++
ttcp-t: 40574 I/O calls, msec/call = 7.55, calls/sec =
135.55
ttcp-t: 0.0user 2.2sys 4:59real 0% 0i+0d 0maxrss 0+2pf
0+0csw
[magesh@aniket-linux current]$


[root@tc105 mpm]# ethtool -k eth2
RX/TX checksumming parameters for eth2:
rx-checksumming: off
tx-checksumming: off
scatter-gather: on
[root@tc105 mpm]#

Pumping data to server tc105 when rx-checksum and 
---------------------------------------------------
tx-checksum are disabled on the server's NIC interface
-----------------------------------------------------
 eth2
-----

[magesh@aniket-linux current]$ tar cf - rpm_topdir |
ttcp -t tc105 -p 4001
ttcp-t: buflen=8192, nbuf=2048, align=16384/0,
port=4001  tcp  -> tc105
ttcp-t: socket
ttcp-t: connect
ttcp-t: 216442880 bytes in 62.26 real seconds =
3394.84 KB/sec +++
ttcp-t: 36257 I/O calls, msec/call = 1.76, calls/sec =
582.33
ttcp-t: 0.1user 1.8sys 1:02real 3% 0i+0d 0maxrss 0+2pf
0+0csw
[magesh@aniket-linux current]$
 


I would also appreciate if any one could shed more
light on zero copy functionality support in linux
2.6.1

Thanks
Magesh

__________________________________
Do you Yahoo!?
Get better spam protection with Yahoo! Mail.
http://antispam.yahoo.com/tools
