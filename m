Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292836AbSCRUdI>; Mon, 18 Mar 2002 15:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292837AbSCRUc6>; Mon, 18 Mar 2002 15:32:58 -0500
Received: from adsl-63-193-243-214.dsl.snfc21.pacbell.net ([63.193.243.214]:655
	"EHLO dmz.ruault.com") by vger.kernel.org with ESMTP
	id <S292836AbSCRUcq>; Mon, 18 Mar 2002 15:32:46 -0500
Message-ID: <3C964FA8.2070706@ruault.com>
Date: Mon, 18 Mar 2002 12:35:52 -0800
From: Charles-Edouard Ruault <ce@ruault.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davem@redhat.com
Subject: [PATCH] fix for /usr/src/linux/net/ipv4/ip_default_ttl usage 
Content-Type: multipart/mixed;
 boundary="------------020202030400080900020404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020202030400080900020404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

i've been playing with different IP setting available in the linux 
kernel ( 2.4.18 ) and found a stange behaviour with 
/usr/src/linux/net/ipv4/ip_default_ttl :
the value that you set here is not taken into account in the following 
cases :

- ICMP reply ( of any kind )
- TCP RST .

since the sockets used in this cases are the one created at the init of 
the given protocols, and therefore the ttl value used are the one that 
are setup at boot time and not the one that you will set later when 
using the sysctl or the proc interface.

I'm not sure that this has been left out on purpose since it will defeat 
the goal of changing the default ttl to confuse OS fingerprinting 
softwares.
Therefore, i've made a small patch ( against kernel 2.4.18 ) that will 
change the behaviour and make the default ttl be used in these cases.

I hope it will be useful to some of you ....
Regards

PS : i'm not on the list so please CC me if you reply to this email.

-- 
Charles-Edouard Ruault
PGP Key ID 4370AF2D



--------------020202030400080900020404
Content-Type: text/plain;
 name="default_ttl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="default_ttl.patch"

--- icmp.c.sav	Mon Mar 18 10:43:24 2002
+++ icmp.c	Mon Mar 18 12:29:48 2002
@@ -139,6 +139,8 @@
   { EHOSTUNREACH,	1 }	/*	ICMP_PREC_CUTOFF	*/
 };
 
+extern int sysctl_ip_default_ttl;
+
 /* Control parameters for ECHO replies. */
 int sysctl_icmp_echo_ignore_all;
 int sysctl_icmp_echo_ignore_broadcasts;
@@ -354,6 +356,7 @@
 	icmp_out_count(icmp_param->data.icmph.type);
 
 	sk->protinfo.af_inet.tos = skb->nh.iph->tos;
+	sk->protinfo.af_inet.ttl = sysctl_ip_default_ttl;
 	daddr = ipc.addr = rt->rt_src;
 	ipc.opt = NULL;
 	if (icmp_param->replyopts.optlen) {
--- tcp_ipv4.c.sav	Mon Mar 18 10:43:03 2002
+++ tcp_ipv4.c	Mon Mar 18 11:54:16 2002
@@ -64,7 +64,7 @@
 #include <linux/ipsec.h>
 
 extern int sysctl_ip_dynaddr;
-
+extern int sysctl_ip_default_ttl;
 /* Check TCP sequence numbers in ICMP packets. */
 #define ICMP_MIN_LENGTH 8
 
@@ -1072,6 +1072,7 @@
 	arg.n_iov = 1;
 	arg.csumoffset = offsetof(struct tcphdr, check) / 2; 
 
+	tcp_socket->sk->protinfo.af_inet.ttl = sysctl_ip_default_ttl;
 	ip_send_reply(tcp_socket->sk, skb, &arg, sizeof rth);
 
 	TCP_INC_STATS_BH(TcpOutSegs);

--------------020202030400080900020404--

