Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275568AbRIZUHc>; Wed, 26 Sep 2001 16:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275569AbRIZUHO>; Wed, 26 Sep 2001 16:07:14 -0400
Received: from chiara.elte.hu ([157.181.150.200]:25868 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275567AbRIZUGy>;
	Wed, 26 Sep 2001 16:06:54 -0400
Date: Wed, 26 Sep 2001 22:04:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-net@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: [patch] netconsole - log kernel messages over the network. 2.4.10.
Message-ID: <Pine.LNX.4.33.0109262128320.8277-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


this is the first public release of the 'netconsole patch', a debugging
patch that implements kernel-level network logging via UDP packets.

the special thing about this approach is the ability to send 'emergency'
network packets even from IRQ handlers. This enables the netconsole to
send enough info even if we crash in init or in an interrupt handler.

another property of netconsole is that it's able to share the networking
device with other kernel subsystems, like the TCP/IP stack. So the
networking device is not dedicated for netconsole use, it's transparently
shared.

netconsole is also designed to be robust, it goes straight to the network
driver, so it does not depend on the networking stack to log messages.

kernel-level netlogging is useful in a number of scenarios:

 - if remotely managed systems with no serial cable logging keep crashing
   without any trace of an oops message in the userspace log. (the patch
   was written to debug such a crash. Original idea of sending an
   emergency packet from IRQ handlers comes from Daniel Veillard who's
   system produced the crash - thanks Daniel!)

 - if for whatever reason the amount of logging is so high that a serial
   console cannot hold it and disks can not keep up - or in cases where
   logged messages disturb the debugged subsystem. I'm sure fellow VM
   hackers will find this useful :-)

 - the netconsole can be used to emit crashdumps over the network, without
   any delay between the point of crash and start of netlogging.

the kernel patch (against 2.4.10 or 2.4.9-ac), and a simple user-space
tool to display netconsole messages can be found at:

	http://redhat.com/~mingo/netconsole-patches/

sample startup of the netconsole on the server:

     insmod netconsole dev=eth1 target_ip=0x0a000701 \
                  source_port=6666 \
                  target_port=6666 \
                  target_eth_byte0=0x00 \
                  target_eth_byte1=0x90\
                  target_eth_byte2=0x27 \
                  target_eth_byte3=0x8C \
                  target_eth_byte4=0xA0 \
                  target_eth_byte5=0xA8

and on the client:

	# ./netconsole-client -server 10.0.7.5 -client 10.0.7.1 -port 6666
        [...network console startup...]
        netconsole: network logging started up successfully!
        SysRq : Loglevel set to 9

more about features and limitations can be found under:

	Documentation/networking/netlogging.txt

reports, comments, suggestions welcome.

	Ingo

