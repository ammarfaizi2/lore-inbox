Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935564AbWK2Ndz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935564AbWK2Ndz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935557AbWK2Ndz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:33:55 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:3526 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S935577AbWK2Ndy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:33:54 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 29 Nov 2006 14:33:29 +0100
MIME-Version: 1.0
Subject: TCP checksum change in RPC replies within XEN, NFS lockup (SLES10)
Cc: xen-users@lists.xensource.com
Message-ID: <456D9A36.14964.BB84565@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.10.0+V=4.10+U=2.07.149+R=02 October 2006+T=193714@20061129.132451Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my apologies for not being sure whom to tell this problem, but it is very strange. 
Let me tell the story:

I'm using XEN (3.0.2) with SLES10 (x86_64, SunFire X4100). On one machine I have 
three virtual machines ("DomU") that are very identically configured (SLES10 
x86_64 also). There is also a SLES9 (i386) acting as a multi-homed NFS server.

I can mount and access a read-only NFS filesystem on the server from Dom0 
(hypervisor), and from two of the three DomUs without any problem, but from the 
third DomU mount hangs and is unkillable (except kill -9). This is how I started 
to debug the problem.

To make things short: I haven't found the solution, but a some problems: Running 
tcpdump/etheral on the client (inside DomU), and on the NFS server, I found out 
that a significant number (almost all) of RPC reply packets have an invalid TCP 
cjhecksum on the NFS server, but not on the NFS client. When actually comparing 
the packets, I found that only the checksum is different. Example:

--- nfs-client9.txt	2006-11-29 12:56:59.176133729 +0100
+++ nfs-server8.txt	2006-11-29 12:56:25.812623453 +0100
@@ -1,10 +1,10 @@
 No.     Time            Source                Destination           Protocol Info
-      9 15:10:15.488963 132.199.176.153       132.199.177.13        Portmap  V2 
DUMP Reply (Call In 7)[Unreassembled Packet]
+      8 15:10:15.497059 132.199.176.153       132.199.177.13        Portmap  V2 
DUMP Reply (Call In 6)[Unreassembled Packet [incorrect TCP checksum]]
 
 0000  00 16 3e f3 45 0d 00 c0 9f 27 44 a6 08 00 45 00   ..>.E....'D...E.
 0010  01 c4 d0 3f 40 00 40 06 fd be 84 c7 b0 99 84 c7   ...?@.@.........
 0020  b1 0d 00 6f 94 48 89 33 9b af 3f e4 5a 65 80 18   ...o.H.3..?.Ze..
-0030  16 a0 27 8a 00 00 01 01 08 0a 5a a1 4b 92 01 2f   ..'.......Z.K../
+0030  16 a0 6c ec 00 00 01 01 08 0a 5a a1 4b 92 01 2f   ..l.......Z.K../
 0040  a9 da 00 00 01 8c 65 e9 c4 df 00 00 00 01 00 00   ......e.........
 0050  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
 0060  00 01 00 01 86 a0 00 00 00 02 00 00 00 06 00 00   ................


I' NOT saysing that _all_ TCP checksums are bad, but significantly those RPC reply 
packets seem to be affected. OK so far.

I don't know why the NFS mount is actually hanging, but the last packet exchange 
seems to be:

Server sends ACK to RPC reply with bad checksum:
Transmission Control Protocol, Src Port: nfs (2049), Dst Port: 1023 (1023), Seq: 
2306928188, Ack: 1069064470, Len: 0

Client receives:

Transmission Control Protocol, Src Port: nfs (2049), Dst Port: 1023 (1023), Seq: 
2306928188, Ack: 1069064470, Len: 0

Some time later I see the client sending an NFS GETATTR packet, but that's 
probably when the kill came in (31 seconds later).

The other odd thing is that the multihomes NFS server has a route to 132.199.0.0 
for both ethernet interfaces, but only one of those, eth0, has IP 132.199.176.153.
However when an ARP request is sent for 132.199.176.153, there are two ansers:

ARP 132.199.176.153 is at 00:c0:9f:27:44:a6
ARP 132.199.176.153 is at 00:02:b3:d9:91:a7

Only the first one is correct. However that problem may be unrelated.

Back to the issue, I doubt that XEN will just overwrite the TCP checksum of some 
specific RPC packets. Personally I could image is much more that there is some 
problem in the RPC processing that might cause this. Sorry for the poor problem 
description.

Just in case, the Novell/SUSE kernel versions are:
Client: 2.6.16.21-0.25-xen
Server: 2.6.5-7.282-default

Upon request I could provide the packet files as well as two PDFs that show the 
packet flow.

Regards,
Ulrich
P.S: I'm subscribed to xen-users, but not to the kernel list, so maybe CC: me for 
kernel-list replies. Thanks!

