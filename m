Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131071AbQLENwp>; Tue, 5 Dec 2000 08:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131017AbQLENwf>; Tue, 5 Dec 2000 08:52:35 -0500
Received: from [134.106.84.3] ([134.106.84.3]:53009 "EHLO
	kyle.pmnet.uni-oldenburg.de") by vger.kernel.org with ESMTP
	id <S130983AbQLENw2>; Tue, 5 Dec 2000 08:52:28 -0500
Date: Tue, 5 Dec 2000 14:22:00 +0100 (CET)
From: "Christian W. Zuckschwerdt" <zany@triq.net>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] ipchains log will show all flags
Message-ID: <0012051408110.1526-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This tiny patch extends ipchains logging. This way one can distinguish
(plain) connection attempts and (Xmas, Fin,...) scans. E.g.
 kernel: Packet log: input - lo PROTO=6 127.0.0.1:40326 127.0.0.1:80
  L=40 S=0x00 I=5808 F=0x0000 T=51 (#1)
 vs.
  L=40 S=0x00 I=5808 F=0x0000 T=51 (#1) B=-s--a-
 and
  L=40 S=0x00 I=5808 F=0x0000 T=51 (#1) B=fs-p-u

Please comment on the format (B=...) and implementation details (speed).
The patch is against 2.2.17's /net/ipv4/ip_fw.c 


ipchains log with flags  Christian W. Zuckschwerdt  <zany@triq.net>

--- linux-2.2.17-pristine/net/ipv4/ip_fw.c.orig	Mon Nov 27 00:38:36 2000
+++ linux-2.2.17/net/ipv4/ip_fw.c	Sun Dec  3 23:58:06 2000
@@ -415,6 +415,7 @@
 {
 	__u32 *opt = (__u32 *) (ip + 1);
 	int opti;
+	struct tcphdr *tcp=(struct tcphdr *)((__u32 *)ip+ip->ihl);
 	
 	if (f)
 	{
@@ -443,7 +444,15 @@
 
 	for (opti = 0; opti < (ip->ihl - sizeof(struct iphdr) / 4); opti++)
 		printk(" O=0x%8.8X", *opt++);
-	printk(" %s(#%d)\n", syn ? "SYN " : /* "PENANCE" */ "", count);
+	printk(" %s(#%d)", syn ? "SYN " : /* "PENANCE" */ "", count);
+
+	if (ip->protocol == IPPROTO_TCP)
+		printk(" B=%c%c%c%c%c%c\n", tcp->fin ? 'f' : '-',
+		       tcp-syn ? 's' : '-', tcp->rst ? 'r' : '-',
+		       tcp->psh ? 'p' : '-', tcp->ack ? 'a' : '-',
+		       tcp->urg ? 'u' : '-');
+	else
+		printk("\n");
 }
 
 /* function for checking chain labels for user space. */
-- 
  cu.
    :
    Christian

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
