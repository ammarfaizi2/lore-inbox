Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLEPOv>; Tue, 5 Dec 2000 10:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLEPOl>; Tue, 5 Dec 2000 10:14:41 -0500
Received: from syntax.dera.gov.uk ([146.80.9.50]:39944 "EHLO
	syntax.dera.gov.uk") by vger.kernel.org with ESMTP
	id <S129370AbQLEPOc>; Tue, 5 Dec 2000 10:14:32 -0500
Date: Tue, 5 Dec 2000 14:44:03 +0000
From: Tony Gale <gale@syntax.dera.gov.uk>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@linuxcare.com.au>
Subject: Re: [PATCH] ipchains log will show all flags
Message-ID: <20001205144403.A30345@syntax.dera.gov.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Dec-2000 Christian W. Zuckschwerdt wrote:
> Hi Linus,
> 
> This tiny patch extends ipchains logging. This way one can
> distinguish
> (plain) connection attempts and (Xmas, Fin,...) scans. E.g.
>  kernel: Packet log: input - lo PROTO=6 127.0.0.1:40326
> 127.0.0.1:80
>   L=40 S=0x00 I=5808 F=0x0000 T=51 (#1)
>  vs.
>   L=40 S=0x00 I=5808 F=0x0000 T=51 (#1) B=-s--a-
>  and
>   L=40 S=0x00 I=5808 F=0x0000 T=51 (#1) B=fs-p-u
> 
> Please comment on the format (B=...) and implementation details
> (speed).
> The patch is against 2.2.17's /net/ipv4/ip_fw.c 

Here's my version, which I have previously sent to Alan, but he
hasn't incorporated it - don't know why.

The format is slightly less obtuse, and more likely to be
compatible with existing tools.

-tony

PS: Rusty, putting "RR" in the header doesn't exactly flag you as
the maintainer.

--- ip_fw.c.orig	Thu Jul 13 12:44:42 2000
+++ ip_fw.c	Mon Sep 18 08:59:37 2000
@@ -41,6 +41,7 @@
  *              John McDonald <jm@dataprotect.com>
  *              Thomas Lopatic <tl@dataprotect.com>
  * 21-Oct-1999: Applied count fix by Emanuele Caratti <wiz@iol.it> --RR
+ * 13-Jul-2000: Log all TCP flags. Tony Gale <gale@dera.gov.uk>
  */
 
 /*
@@ -443,7 +444,17 @@
 
 	for (opti = 0; opti < (ip->ihl - sizeof(struct iphdr) / 4); opti++)
 		printk(" O=0x%8.8X", *opt++);
-	printk(" %s(#%d)\n", syn ? "SYN " : /* "PENANCE" */ "", count);
+	if (ip->protocol == IPPROTO_TCP) {
+		struct tcphdr *tcp=(struct tcphdr *)((__u32 *)ip+ip->ihl);		
+	        printk("%s%s%s%s%s%s",
+			syn ? " SYN" : "",
+			tcp->fin ? " FIN" : "",
+			tcp->rst ? " RST" : "",
+			tcp->psh ? " PSH" : "",
+			tcp->ack ? " ACK" : "",
+			tcp->urg ? " URG" : "");
+	}
+	printk(" (#%d)\n", count);
 }
 
 /* function for checking chain labels for user space. */

-- 
E-Mail: Tony Gale <gale@syntax.dera.gov.uk>
The views expressed above are entirely those of the writer
and do not represent the views, policy or understanding of
any other person or official body.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
