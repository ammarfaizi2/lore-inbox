Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132763AbRDIOoE>; Mon, 9 Apr 2001 10:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132764AbRDIOny>; Mon, 9 Apr 2001 10:43:54 -0400
Received: from elf.ihep.su ([194.190.161.106]:35601 "EHLO elf.ihep.su")
	by vger.kernel.org with ESMTP id <S132763AbRDIOnn>;
	Mon, 9 Apr 2001 10:43:43 -0400
Date: Mon, 9 Apr 2001 18:43:38 +0400
From: "Eugene B. Berdnikov" <berd@elf.ihep.su>
To: linux-kernel@vger.kernel.org
Cc: kuznet@ms2.inr.ac.ru
Subject: Bug report: tcp staled when send-q != 0, timers == 0.
Message-ID: <20010409184338.B1396@elf.ihep.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all.

 In brief: a stale state of the tcp send queue was observed for 2.2.17
 while send-q counter and connection window sizes are not zero: 

 % netstat -n -eot | grep 1018
 tcp        0  13064 194.190.166.31:22       194.190.161.106:1018
	    ESTABLISHED 0          11964      off (0.00/0/0)

 Host 194.190.166.31: 2.2.17 on PPro-180 (HP NetServer E40),
 compiled with CONFIG_M686=y and running sshd1 server.

 SYMPTOMS

 1. When data is sent to 194.190.166.31, it is ack'ed with non-zero
    window size, but zero data block is returned (whereas send-q!=0).
    Strace shows, that server gets data via read(2) and replies
    with write(2) to the same descriptor. The send-q counter is
    encremented by the number of bytes sent, but timers remain zero.
    No data is returned to the network.

 2. When data is is sent to the controlling pty, sshd also steps
    through the read(2) and write(2), with the same result
    (send-q is encremented, timers do not change, no traffic).

 3. Keepalive is enabled in ssh client and server (on both sides).
    The curious thing is that every keepalive interval (2h as default)
    host 194.190.166.31 sends exactly one packet with ethernet
    MTU size:

    17:50:30.391347 > 194.190.166.31.ssh > 194.190.161.106.1018:
	 P 1:1449(1448) ack 1 win 32640
	 <nop,nop,timestamp 72137447 1733874370> (DF) [tos 0x10]
    17:50:31.102567 < 194.190.161.106.1018 > 194.190.166.31.ssh:
	 . 1:1(0) ack 1449 win 32120
	 <nop,nop,timestamp 1734601828 72137447> (DF) [tos 0x10]

    The value send-q is properly decremented every such transmission.

  4. This connection was traced for a long time, and when send-q counter
     reaches zero (due to "keepalive" exchange), it gets out from its
     stale state. Now it behaves as an normal connection.
     I still keep it for investigation (if any:).

 INFO

 Here is some supplementary information on the network configuration for
 this machine. I belive it is not directly concerned to the bug discussed,
 but put here for the completeness.

 Host has Intel EtherExpress-100 ethernet card (standard driver from 2.2.17)
 and SkyMedia-200 DVB sattelite receiver, running driver "sm200_lnx"
 from Telemann. Staled connection passes over ethernet only.

 # lsmod
 Module                  Size  Used by
 sm200_lnx              18800   1 
 eepro100               16180   1  (autoclean)

 # ip -s l l
 1: lo: <LOOPBACK,UP> mtu 3924 qdisc noqueue 
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     RX: bytes  packets  errors  dropped overrun mcast   
     349139839  1395237  0       0       0       0      
     TX: bytes  packets  errors  dropped carrier collsns 
     349139839  1395237  0       0       0       0      
 2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
     link/ether 00:a0:c9:9e:c9:7d brd ff:ff:ff:ff:ff:ff
     RX: bytes  packets  errors  dropped overrun mcast   
     2338597780 7637867  0       0       0       0      
     TX: bytes  packets  errors  dropped carrier collsns 
     3016099313 7378871  0       0       0       293385 
 58: sm200: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
     link/ether 00:90:bc:01:1a:da brd ff:ff:ff:ff:ff:ff
     RX: bytes  packets  errors  dropped overrun mcast   
     603326460  896671   0       0       0       0      
     TX: bytes  packets  errors  dropped carrier collsns 
     0          0        0       0       0       0      
 
 # ip -s r l
 192.168.30.31 dev eth0  scope link 
 194.190.166.31 dev eth0  scope link  src 194.190.166.31 
 192.168.30.0/24 dev eth0  proto kernel  scope link  src 192.168.30.31 
 127.0.0.0/8 dev lo  scope link 
 default via 192.168.30.34 dev eth0  src 194.190.166.31 

 Here is the line from /proc/net/tcp for this connection when it was stale:

 128: 1FA6BEC2:0016 6AA1BEC2:03FA 01 00003394:00000000 00:00000000 00000000
     0        0 11964                               

 That's all that I consider as interesting.

 I was told by ANK, that it might be helpfull to find a socket in the memory
 and dump it contents, while it was staled. However, the time was lost...

 If anybody tell me which additional information can be extracted for the
 diagnostic, I'll try to get it. In any case, I plan to run something through
 this connection in hope to reproduce this state again.
-- 
 Eugene Berdnikov
