Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbVKIA4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbVKIA4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbVKIA4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:56:39 -0500
Received: from postel.suug.ch ([195.134.158.23]:19918 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S932403AbVKIA4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:56:38 -0500
Date: Wed, 9 Nov 2005 01:56:58 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Patrick McHardy <kaber@trash.net>
Cc: Brian Pomerantz <bapper@piratehaven.org>, netdev@vger.kernel.org,
       davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IPV4] Fix secondary IP addresses after promotion
Message-ID: <20051109005658.GL23537@postel.suug.ch>
References: <20051104184633.GA16256@skull.piratehaven.org> <436BFE08.6030906@trash.net> <20051105010740.GR23537@postel.suug.ch> <436C090D.5020201@trash.net> <436C34F8.3090903@trash.net> <20051105134636.GS23537@postel.suug.ch> <20051107215022.GH23537@postel.suug.ch> <4370B203.8070501@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4370B203.8070501@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Patrick McHardy <kaber@trash.net> 2005-11-08 15:11
> Yes, fixing it correctly looks very hard. Just changing the routes
> doesn't seem right to me, someone might have added it with exactly
> this prefsrc and doesn't want it to change, its also not clear how
> to notify on this.

Right, OTOH this someone might also just use the primary address
as prefsrc and would welcome a translation to the new address
instead of a silent deletion. Nevertheless, I agree with deleting
and readding the local routes (for now ;-) while I keep this in
mind for later improvement.

> I have a patch to do this, but it needs some debugging, for some
> unknown reason it crashes sometimes if I remove addresses without
> specifying the mask.

Interesting, do you use an iproute2 version with the wildcard
address deletion fix attached below?

diff -Nru a/ChangeLog b/ChangeLog
--- a/ChangeLog	2005-03-19 00:49:52 +01:00
+++ b/ChangeLog	2005-03-19 00:49:52 +01:00
@@ -1,3 +1,8 @@
+2005-03-19  Thomas Graf <tgraf@suug.ch>
+
+	* Warn about wildcard deletions and provide IFA_ADDRESS upon
+	  deletions to enforce prefix length validation for IPv4.
+
 2005-03-18  Stephen Hemminger  <shemminger@osdl.org>
 
 	* add -force option to batch mode
diff -Nru a/include/utils.h b/include/utils.h
--- a/include/utils.h	2005-03-19 00:49:52 +01:00
+++ b/include/utils.h	2005-03-19 00:49:52 +01:00
@@ -43,8 +43,11 @@
 	__u8 family;
 	__u8 bytelen;
 	__s16 bitlen;
+	__u32 flags;
 	__u32 data[4];
 } inet_prefix;
+
+#define PREFIXLEN_SPECIFIED 1
 
 #define DN_MAXADDL 20
 #ifndef AF_DECnet
diff -Nru a/ip/ipaddress.c b/ip/ipaddress.c
--- a/ip/ipaddress.c	2005-03-19 00:49:52 +01:00
+++ b/ip/ipaddress.c	2005-03-19 00:49:52 +01:00
@@ -744,6 +744,7 @@
 	} req;
 	char  *d = NULL;
 	char  *l = NULL;
+	char  *lcl_arg = NULL;
 	inet_prefix lcl;
 	inet_prefix peer;
 	int local_len = 0;
@@ -821,6 +822,7 @@
 				usage();
 			if (local_len)
 				duparg2("local", *argv);
+			lcl_arg = *argv;
 			get_prefix(&lcl, *argv, req.ifa.ifa_family);
 			if (req.ifa.ifa_family == AF_UNSPEC)
 				req.ifa.ifa_family = lcl.family;
@@ -838,9 +840,17 @@
 		exit(1);
 	}
 
-	if (peer_len == 0 && local_len && cmd != RTM_DELADDR) {
-		peer = lcl;
-		addattr_l(&req.n, sizeof(req), IFA_ADDRESS, &lcl.data, lcl.bytelen);
+	if (peer_len == 0 && local_len) {
+		if (cmd == RTM_DELADDR && lcl.family == AF_INET && !(lcl.flags & PREFIXLEN_SPECIFIED)) {
+			fprintf(stderr,
+			    "Warning: Executing wildcard deletion to stay compatible with old scripts.\n" \
+			    "         Explicitly specify the prefix length (%s/%d) to avoid this warning.\n" \
+			    "         This special behaviour is likely to disappear in further releases,\n" \
+			    "         fix your scripts!\n", lcl_arg, local_len*8);
+		} else {
+			peer = lcl;
+			addattr_l(&req.n, sizeof(req), IFA_ADDRESS, &lcl.data, lcl.bytelen);
+		}
 	}
 	if (req.ifa.ifa_prefixlen == 0)
 		req.ifa.ifa_prefixlen = lcl.bitlen;
diff -Nru a/lib/utils.c b/lib/utils.c
--- a/lib/utils.c	2005-03-19 00:49:52 +01:00
+++ b/lib/utils.c	2005-03-19 00:49:52 +01:00
@@ -241,6 +241,7 @@
 				err = -1;
 				goto done;
 			}
+			dst->flags |= PREFIXLEN_SPECIFIED;
 			dst->bitlen = plen;
 		}
 	}
