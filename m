Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbQLKPXb>; Mon, 11 Dec 2000 10:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129967AbQLKPXU>; Mon, 11 Dec 2000 10:23:20 -0500
Received: from [134.106.84.3] ([134.106.84.3]:28172 "EHLO
	kyle.pmnet.uni-oldenburg.de") by vger.kernel.org with ESMTP
	id <S129725AbQLKPXA>; Mon, 11 Dec 2000 10:23:00 -0500
Date: Mon, 11 Dec 2000 15:52:32 +0100 (CET)
From: "Christian W. Zuckschwerdt" <zany@triq.net>
To: linux-kernel@vger.kernel.org
cc: Rusty Russell <rusty@linuxcare.com.au>
Subject: [PATCH] ipchains log will show all flags
Message-ID: <0012111517070.1235-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This tiny patch extends ipchains logging. This way one can distinguish
(plain) connection attempts and (stealth) scans. E.g.
kernel: Packet log: input - lo PROTO=6 127.0.0.1:40326 127.0.0.1:80
L=40 S=0x00 I=5808 F=0x0000 T=51 (#1)
vs.
L=40 S=0x00 I=5808 F=0x0000 T=51 SYN ACK (#1)
and
L=40 S=0x00 I=5808 F=0x0000 T=51 URG PSH SYN FIN (#1)

Some comments on the format have been considered. I dislike
bloating my logging with "URG ACK PSH RST SYN FIN " and like to see a
compact format (eg. "B=fsrpau"). Despite that iptables does it the 
former way (linux-2.4.0-test11/net/ipv4/netfilter/ipt_LOG.c).

Please note that SYN is not any longer SYN && !ACK && !RST. This will
break log parser that look for connection initiation packets.

Besides ipchains(8) man page is wrong. FIN should be RST?
       [!] -y, --syn
              Only match TCP packets with the SYN bit set and the
              ACK and FIN bits cleared.  Such packets are used to


Could you please comment on the tradeoff between multiple printk()'s and
the printk("%s", "")?

Logging the FW Mark value was suggested by Roberto Nibali <ratz@tac.ch>
Could be included as  printk(" M=%d", f->ipfw.fw_mark);


The patch is against 2.2.17's /net/ipv4/ip_fw.c 
ipchains logging all flags Christian W. Zuckschwerdt <zany@triq.net>

--- linux-2.2.17-pristine/net/ipv4/ip_fw.c.orig	Mon Nov 27 00:38:36 2000
+++ linux-2.2.17/net/ipv4/ip_fw.c	Mon Dec 11 15:10:51 2000
@@ -41,6 +41,9 @@
  *              John McDonald <jm@dataprotect.com>
  *              Thomas Lopatic <tl@dataprotect.com>
  * 21-Oct-1999: Applied count fix by Emanuele Caratti <wiz@iol.it> --RR
+ * 11-Dec-2000: Added "URG ACK PSH RST SYN FIN" in log message.
+ *              Please note SYN is no longer SYN && !ACK && !RST  
+ *              Christian W. Zuckschwerdt <zany@triq.net>
  */
 
 /*
@@ -443,7 +443,24 @@
 
 	for (opti = 0; opti < (ip->ihl - sizeof(struct iphdr) / 4); opti++)
 		printk(" O=0x%8.8X", *opt++);
-	printk(" %s(#%d)\n", syn ? "SYN " : /* "PENANCE" */ "", count);
+
+	if ((ip->protocol == IPPROTO_TCP) && !(ip->frag_off & htons(IP_OFFSET))) {
+		struct tcphdr *tcp=(struct tcphdr *)((__u32 *)ip+ip->ihl);
+		/* Max length: 36 " URG ACK PSH RST SYN FIN" */
+		if (tcp->urg)
+			printk(" URG");
+		if (tcp->ack)
+			printk(" ACK");
+		if (tcp->psh)
+			printk(" PSH");
+		if (tcp->rst)
+			printk(" RST");
+		if (tcp->syn)
+			printk(" SYN");
+		if (tcp->fin)
+			printk(" FIN");
+	}
+	printk(" (#%d) M=%d\n", count, f->ipfw.fw_mark);
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
