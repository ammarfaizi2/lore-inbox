Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbSI2TvB>; Sun, 29 Sep 2002 15:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261762AbSI2TvA>; Sun, 29 Sep 2002 15:51:00 -0400
Received: from spog.gaertner.de ([194.45.135.2]:39315 "EHLO spog.gaertner.de")
	by vger.kernel.org with ESMTP id <S261696AbSI2TuW>;
	Sun, 29 Sep 2002 15:50:22 -0400
Date: Sun, 29 Sep 2002 21:55:42 +0200 (MEST)
Message-Id: <200209291955.g8TJtgp24880@aunt2.gaertner.de>
From: Erik Schoenfelder <schoenfr@gaertner.de>
To: linux-kernel@vger.kernel.org
CC: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [2.4.19] small bug plus fix for /proc/net/snmp (Imcp: field count)
Reply-to: schoenfr@gaertner.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i received a bug report plus fix from Gonzalo A. Arana Tagle
<garana@uolsinectis.com.ar> about a extra dummy value printed for the
``Icmp:'' values in /proc/net/snmp:

       # awk '/Icmp/ { print NF; }' /proc/net/snmp 
       27
       28

the code in snmp_get_info() from net/ipv4/proc.c prints a dummy value
present at the end of struct icmp_mib, which should not be included.

from include/net/snmp.h:

>  struct icmp_mib
>  {
>   	unsigned long	IcmpInMsgs;
>  [...]
>   	unsigned long	IcmpOutAddrMaskReps;
>  	unsigned long	dummy;
>  	unsigned long   __pad[0]; 
>  } ____cacheline_aligned;


instead of printing all values before the __pad field, printing the
values before the dummy field gives the right number of values:


--- linux-2.4.19/net/ipv4/proc.c-dist	Wed May 16 19:21:45 2001
+++ linux-2.4.19/net/ipv4/proc.c	Sat Sep 28 22:03:05 2002
@@ -128,7 +128,7 @@
 	len += sprintf (buffer + len,
 		"\nIcmp: InMsgs InErrors InDestUnreachs InTimeExcds InParmProbs InSrcQuenchs InRedirects InEchos InEchoReps InTimestamps InTimestampReps InAddrMasks InAddrMaskReps OutMsgs OutErrors OutDestUnreachs OutTimeExcds OutParmProbs OutSrcQuenchs OutRedirects OutEchos OutEchoReps OutTimestamps OutTimestampReps OutAddrMasks OutAddrMaskReps\n"
 		  "Icmp:");
-	for (i=0; i<offsetof(struct icmp_mib, __pad)/sizeof(unsigned long); i++)
+	for (i=0; i<offsetof(struct icmp_mib, dummy)/sizeof(unsigned long); i++)
 		len += sprintf(buffer+len, " %lu", fold_field((unsigned long*)icmp_statistics, sizeof(struct icmp_mib), i));
 
 	len += sprintf (buffer + len,


please fix this.  thank's in advance,
							Erik
