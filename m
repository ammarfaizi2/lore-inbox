Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281446AbRKQLkx>; Sat, 17 Nov 2001 06:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281443AbRKQLkn>; Sat, 17 Nov 2001 06:40:43 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:16139 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281339AbRKQLkc>; Sat, 17 Nov 2001 06:40:32 -0500
Date: Sat, 17 Nov 2001 19:37:50 +0800
From: zhongyu <xxx_pku@yahoo.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: ARP bug and a patch
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20011117114042Z281339-17408+15401@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Bug's description :
	A computer has two ethernet cards connected to the same hub, each ethernet card was in a
different logical sub net and turn on the ip_forward on each ethernet card. Dozens of ARP request
packet will cause a "neibour table overflow"
error then the netcard can not work .
	reason:
	The arp_rcv fuction would call the ip_route_input function to build the dst entry of the skb.
When the ip_forward is on , the code will run direct into the rt_intern_hash fuction which add the
target ip to the neighbour buffer . 
	patch:

diff -Naur linux-2.4.9/net/ipv4/route.c linux-2.4.9n/net/ipv4/route.c
--- linux-2.4.9/net/ipv4/route.c        Fri Nov 16 17:19:06 2001
+++ linux-2.4.9n/net/ipv4/route.c       Fri Nov 16 17:17:59 2001
@@ -1501,6 +1501,12 @@
        }
 #endif

+       if (skb->protocol == __constant_htons(ETH_P_ARP)){      
+               skb->dst = rth;
+               err = 0;
+               goto done;
+       }
+       
 intern:
        err = rt_intern_hash(hash, rth, (struct rtable**)&skb->dst);
 done:

          zhongyu
            xxx_pku@yahoo.com


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

