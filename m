Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154701-8316>; Wed, 9 Sep 1998 00:11:31 -0400
Received: from dm.cobaltmicro.com ([209.133.34.35]:3367 "EHLO dm.cobaltmicro.com" ident: "IDENT-NONSENSE") by vger.rutgers.edu with ESMTP id <155076-8316>; Tue, 8 Sep 1998 18:43:54 -0400
Date: Tue, 8 Sep 1998 18:14:54 -0700
Message-Id: <199809090114.SAA05738@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: mrj@i2k.com
CC: linux-kernel@vger.rutgers.edu
In-reply-to: <Pine.LNX.4.02.9809081543110.334-100000@jeffd.i2k.net> (message from Jeff DeFouw on Tue, 8 Sep 1998 17:10:10 -0400 (EDT))
Subject: Re: Very poor TCP/SACK performance
References: <Pine.LNX.4.02.9809081543110.334-100000@jeffd.i2k.net>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: Tue, 8 Sep 1998 17:10:10 -0400 (EDT)
   From: Jeff DeFouw <mrj@i2k.com>

   On Tue, 8 Sep 1998, David S. Miller wrote:

   > But if you provide more dumps to help me debug this problem could
   > you please rebuild tcpdump with the patch I have appended at the end?
   > The stock tcpdump does not output SACK information from TCP packets
   > properly without the patch.  The stock tcpdump uses the pre-RFC format
   > of the SACKS which is nothing like real modern SACKs in use today :-)

     Did you forget to append the patch, or is there somewhere I can get it?

Sorry, here it is:

--- tcpdump-3.3/tcpdump-3.3/print-tcp.c.orig	Tue Dec 10 23:26:08 1996
+++ tcpdump-3.3/tcpdump-3.3/print-tcp.c	Thu Mar 19 23:46:33 1998
@@ -103,8 +103,8 @@
 	register int hlen;
 	register char ch;
 	u_short sport, dport, win, urp;
-	u_int32_t seq, ack;
-
+	u_int32_t seq, ack,thseq,thack;	
+        int threv;
 	tp = (struct tcphdr *)bp;
 	ip = (struct ip *)bp2;
 	ch = '\0';
@@ -162,7 +162,7 @@
 			tha.port = dport << 16 | sport;
 			rev = 1;
 		}
-
+		threv = rev;
 		for (th = &tcp_seq_hash[tha.port % TSEQ_HASHSIZE];
 		     th->nxt; th = th->nxt)
 			if (!memcmp((char *)&tha, (char *)&th->addr,
@@ -183,6 +183,10 @@
 			else
 				th->seq = seq, th->ack = ack - 1;
 		} else {
+		  
+		        thseq = th->seq;
+                        thack = th->ack;
+
 			if (rev)
 				seq -= th->ack, ack -= th->seq;
 			else
@@ -263,18 +267,32 @@
 				break;
 
 			case TCPOPT_SACK:
-				(void)printf("sack");
-				datalen = len - 2;
-				for (i = 0; i < datalen; i += 4) {
-					LENCHECK(i + 4);
-					/* block-size@relative-origin */
-					(void)printf(" %u@%u",
-					    EXTRACT_16BITS(cp + i + 2),
-					    EXTRACT_16BITS(cp + i));
+			  {
+			    u_int32_t s, e;
+
+			    datalen = len - 2;
+			    if (datalen % 8 != 0) {
+				(void)printf(" malformed sack ");
+			    } else {
+				(void)printf(" sack %d ", datalen / 8);
+				for (i = 0; i < datalen; i += 8) {
+				    LENCHECK(i + 4);
+				    s = EXTRACT_32BITS(cp + i);
+				    LENCHECK(i + 8);
+				    e = EXTRACT_32BITS(cp + i + 4);
+				    if (threv) {
+					s -= thseq;
+					e -= thseq;
+				    } else {
+					s -= thack;
+					e -= thack;
+				    }
+				    (void)printf("{%u:%u}", s, e);
 				}
-				if (datalen % 4)
-					(void)printf("[len %d]", len);
-				break;
+				(void)printf(" ");
+			    }
+			    break;
+			  }
 
 			case TCPOPT_ECHO:
 				(void)printf("echo");

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/faq.html
