Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbRGPM2d>; Mon, 16 Jul 2001 08:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbRGPM2X>; Mon, 16 Jul 2001 08:28:23 -0400
Received: from juicer39.bigpond.com ([139.134.6.96]:23762 "EHLO
	mailin8.bigpond.com") by vger.kernel.org with ESMTP
	id <S267327AbRGPM2K>; Mon, 16 Jul 2001 08:28:10 -0400
Message-Id: <m15M5cN-000CK9C@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: J Troy Piper <jtp@dok.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <laughing@shared-source.org>
Subject: Re: [Problem] Linux 2.4.5-ac17 ipt_unclean 'fixes' 
In-Reply-To: Your message of "Sat, 14 Jul 2001 17:00:21 EST."
             <20010714170021.B1391@dok.org> 
Date: Mon, 16 Jul 2001 20:28:45 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20010714170021.B1391@dok.org> you write:
> today) but there seems to be a problem with the ipt_unclean fixes by Rusty 
> Russell.  ANY incoming packets from any interface (ppp0 and eth0) are 
> marked as 'unclean' with some variation on the following syslog entry:
> 
> Jul  8 23:16:04 paranoia kernel: ipt_unclean: TCP option 3 at 37 too long

Please try this patch which fixes this as well, which is in Linus'
pre-patches.

Rusty.
--
Premature optmztion is rt of all evl. --DK

diff -urN linux-2.4.6/net/ipv4/netfilter/ipt_unclean.c linux-2.4.6-f1/net/ipv4/netfilter/ipt_unclean.c
--- linux-2.4.6/net/ipv4/netfilter/ipt_unclean.c	Wed Jul  4 21:27:32 2001
+++ linux-2.4.6-f1/net/ipv4/netfilter/ipt_unclean.c	Thu Jul  5 19:16:00 2001
@@ -268,6 +268,7 @@
 	  int embedded)
 {
 	u_int8_t *opt = (u_int8_t *)tcph;
+	u_int8_t *endhdr = (u_int8_t *)tcph + tcph->doff * 4;
 	u_int8_t tcpflags;
 	int end_of_options = 0;
 	size_t i;
@@ -373,7 +374,7 @@
 				return 0;
 			}
 			/* CHECK: oversize options. */
-			else if (opt[i+1] + i >= tcph->doff * 4) {
+			else if (&opt[i] + opt[i+1] > endhdr) {
 				limpk("TCP option %u at %Zu too long\n",
 				      (unsigned int) opt[i], i);
 				return 0;
@@ -392,6 +393,7 @@
 check_ip(struct iphdr *iph, size_t length, int embedded)
 {
 	u_int8_t *opt = (u_int8_t *)iph;
+	u_int8_t *endhdr = (u_int8_t *)iph + iph->ihl * 4;
 	int end_of_options = 0;
 	void *protoh;
 	size_t datalen;
@@ -444,7 +446,7 @@
 				return 0;
 			}
 			/* CHECK: oversize options. */
-			else if (opt[i+1] + i > iph->ihl * 4) {
+			else if (&opt[i] + opt[i+1] > endhdr) {
 				limpk("IP option %u at %u too long\n",
 				      opt[i], i);
 				return 0;
