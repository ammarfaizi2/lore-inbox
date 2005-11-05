Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVKEAfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVKEAfY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVKEAfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:35:24 -0500
Received: from mail.collax.com ([213.164.67.137]:11231 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751368AbVKEAfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:35:23 -0500
Message-ID: <436BFE08.6030906@trash.net>
Date: Sat, 05 Nov 2005 01:34:16 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Pomerantz <bapper@piratehaven.org>
CC: netdev@vger.kernel.org, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, jmorris@namei.org, yoshfuji@linux-ipv6.org,
       kaber@coreworks.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IPV4] Fix secondary IP addresses after promotion
References: <20051104184633.GA16256@skull.piratehaven.org>
In-Reply-To: <20051104184633.GA16256@skull.piratehaven.org>
Content-Type: multipart/mixed;
 boundary="------------060609090206040304030406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060609090206040304030406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Brian Pomerantz wrote:
> When 3 or more IP addresses in the same subnet exist on a device and the
> first one is removed, only the promoted IP address can be reached.  Just
> after promotion of the next IP address, this fix spins through any more
> IP addresses on the interface and sends a NETDEV_UP notification for
> that address.  This repopulates the FIB with the proper route
> information.
> 
> @@ -294,7 +294,13 @@ static void inet_del_ifa(struct in_devic
>  		/* not sure if we should send a delete notify first? */
>  		promote->ifa_flags &= ~IFA_F_SECONDARY;
>  		rtmsg_ifa(RTM_NEWADDR, promote);
> -		notifier_call_chain(&inetaddr_chain, NETDEV_UP, promote);
> +
> +		/* update fib in the rest of this address list */
> +		ifa = promote;
> +		while (ifa != NULL) {
> +			notifier_call_chain(&inetaddr_chain, NETDEV_UP, ifa);
> +			ifa = ifa->ifa_next;
> +		}
>  	}
>  }

You assume all addresses following the primary addresses are secondary
addresses of the primary, which is not true with multiple primaries.
This patch (untested) makes sure only to send notification for real
secondaries of the deleted address. It also removes a racy double-
check for IN_DEV_PROMOTE_SECONDARIES - once we've decided to promote
an address checking again opens a window in which address promotion
could be disabled and we end up with only secondaries without a
primary address.

Signed-off-by: Patrick McHardy <kaber@trash.net>


--------------060609090206040304030406
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 4ec4b2c..beb02cc 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -234,7 +234,7 @@ static void inet_del_ifa(struct in_devic
 			 int destroy)
 {
 	struct in_ifaddr *promote = NULL;
-	struct in_ifaddr *ifa1 = *ifap;
+	struct in_ifaddr *ifa, *ifa1 = *ifap;
 
 	ASSERT_RTNL();
 
@@ -243,7 +243,6 @@ static void inet_del_ifa(struct in_devic
 	 **/
 
 	if (!(ifa1->ifa_flags & IFA_F_SECONDARY)) {
-		struct in_ifaddr *ifa;
 		struct in_ifaddr **ifap1 = &ifa1->ifa_next;
 
 		while ((ifa = *ifap1) != NULL) {
@@ -283,19 +282,25 @@ static void inet_del_ifa(struct in_devic
 	 */
 	rtmsg_ifa(RTM_DELADDR, ifa1);
 	notifier_call_chain(&inetaddr_chain, NETDEV_DOWN, ifa1);
+
+	if (promote) {
+		/* not sure if we should send a delete notify first? */
+		promote->ifa_flags &= ~IFA_F_SECONDARY;
+		rtmsg_ifa(RTM_NEWADDR, promote);
+		for (ifa = promote; ifa; ifa = ifa->ifa_next) {
+			if (ifa1->ifa_mask != ifa->ifa_mask ||
+			    !inet_ifa_match(ifa1->ifa_address, ifa))
+				continue;
+			notifier_call_chain(&inetaddr_chain, NETDEV_UP, ifa);
+		}
+	}
+
 	if (destroy) {
 		inet_free_ifa(ifa1);
 
 		if (!in_dev->ifa_list)
 			inetdev_destroy(in_dev);
 	}
-
-	if (promote && IN_DEV_PROMOTE_SECONDARIES(in_dev)) {
-		/* not sure if we should send a delete notify first? */
-		promote->ifa_flags &= ~IFA_F_SECONDARY;
-		rtmsg_ifa(RTM_NEWADDR, promote);
-		notifier_call_chain(&inetaddr_chain, NETDEV_UP, promote);
-	}
 }
 
 static int inet_insert_ifa(struct in_ifaddr *ifa)

--------------060609090206040304030406--
