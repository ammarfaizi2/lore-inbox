Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWEBNke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWEBNke (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWEBNke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:40:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6337 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964805AbWEBNke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:40:34 -0400
Date: Tue, 2 May 2006 15:45:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, coreteam@netfilter.org
Subject: Re: [lockup] 2.6.17-rc3: netfilter/sctp: lockup in sctp_new(), do_basic_checks()
Message-ID: <20060502134516.GA31049@elte.hu>
References: <20060502113454.GA28601@elte.hu> <20060502134053.GA30917@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502134053.GA30917@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > running an "isic" stresstest on and against a testbox [which, amongst 
> > other things, generates random incoming and outgoing packets] on 
> > 2.6.17-rc3 (and 2.6.17-rc3-mm1) over gigabit results in a reproducible 
> > lockup, after 5-10 minutes of runtime:

btw., just in case someone would like to build ISIC on a modern distro, 
the minimal fixes are below. The commandline i'm typically using for 
testing is:

  isic -s firstbox.com -d secondbox.com -m 50000 >/dev/null 2>/dev/null

seems useful.

	Ingo

--- icmpsic.c	2006-04-26 16:14:32.000000000 +0200
+++ icmpsic.c.orig	2006-04-26 16:14:33.000000000 +0200
@@ -265,7 +265,7 @@ main(int argc, char **argv)
 
 		payload = (short int *)((u_char *) icmp + 4);
 		for(cx = 0; cx <= (payload_s >> 1); cx+=1)
-				payload[cx] = rand() & 0xffff;
+				(u_short) payload[cx] = rand() & 0xffff;
 
 
 		if ( rand() <= (RAND_MAX * ICMPCksm) )
--- isic.c	2006-04-26 16:14:32.000000000 +0200
+++ isic.c.orig	2006-04-26 16:14:33.000000000 +0200
@@ -229,8 +229,8 @@ main(int argc, char **argv)
 		
 		payload = (short int *)(buf + IP_H);
 		for(cx = 0; cx <= (payload_s >> 1); cx+=1)
-				payload[cx] = rand() & 0xffff;
-		payload[payload_s] = rand() & 0xffff;
+				(u_int16_t) payload[cx] = rand() & 0xffff;
+		(u_int16_t) payload[payload_s] = rand() & 0xffff;
 		
 		if ( printout ) {
 			printf("%s ->",
--- tcpsic.c	2006-04-26 16:14:32.000000000 +0200
+++ tcpsic.c.orig	2006-04-26 16:14:32.000000000 +0200
@@ -317,7 +317,7 @@ main(int argc, char **argv)
 
 		payload = (short int *)((u_char *) tcp + 20);
 		for(cx = 0; cx <= (payload_s >> 1); cx+=1)
-				payload[cx] = rand() & 0xffff;
+				(u_int16_t) payload[cx] = rand() & 0xffff;
 
 		if ( rand() <= (RAND_MAX * TCPCksm) )
 			libnet_do_checksum(l, (u_int8_t *)buf, IPPROTO_TCP, (tcp->th_off << 2)
--- udpsic.c	2006-04-26 16:14:32.000000000 +0200
+++ udpsic.c.orig	2006-04-26 16:14:32.000000000 +0200
@@ -292,7 +292,7 @@ main(int argc, char **argv)
 
 		payload = (short int *)((u_char *) udp + UDP_H);
 		for(cx = 0; cx <= (payload_s >> 1); cx+=1)
-				payload[cx] = rand() & 0xffff;
+				(u_int16_t) payload[cx] = rand() & 0xffff;
 
 		if ( printout ) {
 			printf("%s,%i ->",
