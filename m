Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311856AbSCXJQs>; Sun, 24 Mar 2002 04:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311875AbSCXJQ3>; Sun, 24 Mar 2002 04:16:29 -0500
Received: from mout1.freenet.de ([194.97.50.132]:17080 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S311856AbSCXJQ0>;
	Sun, 24 Mar 2002 04:16:26 -0500
Message-ID: <3C9D999F.60106@athlon.maya.org>
Date: Sun, 24 Mar 2002 10:17:19 +0100
From: andreas <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020323
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: [2.4.18] Problems with sis900.c [solution?]
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This night, I tested kernel 2.4.18 on my server. All seems to be good.
This morning, after rebooting the server and the connected client, I
couldn't launch the server no more :-(, because of connection problems.
Pinging the server shows a lot of missing packets or they take too much
time - but other packets are transmitted well.
A connection with ssh isn't possible (client doesn't connect).

The machines are connected with a crosslink-cable.
I'm using kernel 2.4.18 on the client and on the server.

server         <--------->       client
2.4.18 
			 2.4.18
sis900.c 
		 sis900.c
       same NIC on server and client



First, I tried to reboot the server - no change.



Next, I tried to change the NIC on the client (I've got two NIC's in the
client), but the problem stayed.
The error-messages in /var/log/messages are always the same:
Mar 24 08:44:19 susi kernel: eth0: Media Link Off
Mar 24 08:44:28 susi kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 24 08:44:28 susi kernel: eth0: Transmit timeout, status 00000004
00000000
Mar 24 08:44:29 susi kernel: eth0: Media Link On 100mbps full-duplex
Mar 24 08:45:10 susi kernel: eth0: Media Link Off
Mar 24 08:45:20 susi kernel: eth0: Media Link On 100mbps full-duplex
Mar 24 08:45:31 susi kernel: eth0: Media Link Off
Mar 24 08:45:46 susi kernel: eth0: Media Link On 100mbps full-duplex

The green LED on the NIC's often went off and went on after some time again.



Third, I tried to reboot the server with kernel 2.4.17 - this is working
fine.



Now, I patched sis900.c on the server [2.4.18], recompiled modules and
rebooted the server.

server         <--------->       client
2.4.18 
			 2.4.18
patched
sis900.c 
		 sis900.c
       same NIC on server and client

I applied this patch:

-------------------------------------------------------------------------
--- sis900.c.orig       Sun Mar 24 09:28:52 2002
+++ sis900.c    Sun Mar 24 09:21:21 2002
@@ -1420,11 +1420,11 @@
          unsigned long flags;

          /* Don't transmit data before the complete of auto-negotiation */
-       if(!sis_priv->autong_complete){
+/*     if(!sis_priv->autong_complete){
                  netif_stop_queue(net_dev);
                  return 1;
          }
-
+*/
          spin_lock_irqsave(&sis_priv->lock, flags);

          /* Calculate the next Tx descriptor entry. */
--------------------------------------------------------------------------


(I uncommented the not sending of datas before complete of autonegotiation.)
With this patch on the server, the NIC is working fine again.




My NIC on the server (and the client eth0):
00:0b.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
	10/100 Ethernet (rev 02)
         Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100
	Ethernet Adapter
         Flags: bus master, medium devsel, latency 32, IRQ 10
         I/O ports at b800 [size=256]
         Memory at e2800000 (32-bit, non-prefetchable) [size=4K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [40] Power Management version 1



I have to emphasis, that on the client works an unpatched 2.4.18 
sis900.c. But the connect with the "unpatched" server to the other NIC 
on the client, didn't work, too. It showed up the same problems.
The other NIC (eth1) on the client is:

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
	(rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at ec00 [size=256]
         Memory at d9001000 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at <unassigned> [disabled] [size=64K]

eth0 is switched to autonegotiation, eth1 is forced to 100MBit / FD.



Last, I tried the connect with eth1 and the patched 2.4.18-kernel. It 
has been working fine, too.



Regards,
Andreas Hartmann

