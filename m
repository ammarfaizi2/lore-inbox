Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267931AbTBLXQJ>; Wed, 12 Feb 2003 18:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267932AbTBLXQJ>; Wed, 12 Feb 2003 18:16:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:10125 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267931AbTBLXQB>; Wed, 12 Feb 2003 18:16:01 -0500
Message-ID: <3E4AD852.4060300@us.ibm.com>
Date: Wed, 12 Feb 2003 17:27:14 -0600
From: Tom Lendacky <toml@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: IPSec: AH/ESP combination problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was looking at the result of some AH/ESP combinations in transport
and tunnel mode and found some problems.  One of them I think I was
able to correct, but since I'm not very familiar with the xfrm
processing logic I don't know how to address the others.  I've
documented 3 problems in this posting.

Problem #1: AH/ESP Tunnel mode input [IP-outer][AH][ESP][IP-inner]

When processing the input in xfrm4_rcv in xfrm_input.c, a check
is made after processing the AH header to determine if the policy
specified tunnel mode.  If tunnel mode was specified, then a
check is made to see if the next header is an IP header.  If it
is not an IP header then the packet is dropped.  However, if
ESP tunnel mode has also been applied to the packet the next
header will be the ESP header which must first be decrypted.  I
believe the following patch will correct the problem:

--- linux-2.5.60-orig/net/ipv4/xfrm_input.c	2003-02-10 12:37:57.000000000 -0600
+++ linux-2.5.60/net/ipv4/xfrm_input.c	2003-02-12 16:32:06.000000000 -0600
@@ -54,6 +54,7 @@
   	struct xfrm_state *x;
   	int xfrm_nr = 0;
   	int decaps = 0;
+	int esp_ipip_delay = 0;

   	if ((err = xfrm_parse_spi(skb, &spi, &seq)) != 0)
   		goto drop;
@@ -90,14 +91,21 @@

   		iph = skb->nh.iph;

-		if (x->props.mode) {
-			if (iph->protocol != IPPROTO_IPIP)
-				goto drop;
-			skb->nh.raw = skb->data;
-			iph = skb->nh.iph;
-			memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
-			decaps = 1;
-			break;
+		if (x->props.mode || esp_ipip_delay) {
+			/* Check for esp_ipip_delay having previously been set
+			   since we shouldn't see successive ESP headers */
+			if (iph->protocol == IPPROTO_ESP && !esp_ipip_delay) {
+				esp_ipip_delay = 1;
+			}
+			else {
+				if (iph->protocol != IPPROTO_IPIP)
+					goto drop;
+				skb->nh.raw = skb->data;
+				iph = skb->nh.iph;
+				memset(&(IPCB(skb)->opt), 0, sizeof(struct ip_options));
+				decaps = 1;
+				break;
+			}
   		}

   		if ((err = xfrm_parse_spi(skb, &spi, &seq)) < 0)


Problem #2: AH/ESP Tunnel mode output [IP-outer][AH][ESP][IP-inner]

When creating the output for an AH header in ah_output of ah.c,
a check is made to see if the policy specified tunnel mode.  If
tunnel mode is specified, then an IPIP header is added after the AH
header.  However, if the policy also specified ESP in tunnel mode
then the ESP header and not the IP header should follow the AH header.
Since it is also valid to have [IP-outer][AH][IP-inner][ESP] (AH
tunnel with ESP transport) a check for the next protocol is not
enough in this case (since in both cases the next protocol value
is that of ESP).  I'm not familiar enough with the code to
determine how to find the xfrm_state for the ESP protocol that
follows in order to determine if ESP tunnel or transport mode
has been specified.  If it can be determined which ESP mode has
been specified, then the check in ah_output can be modified
and the correct headers created.


Problem #3: RFC 2401 order of AH and ESP headers

According to RFC 2401, if both AH and ESP headers are to be
applied in transport mode, then "the SA establishment procedure
MUST ensure that first ESP, then AH are applied to the packet."
I stumbled across this problem when I happened to switch the
order in which I specified the protocols on spdadd command.
If the command
     spdadd ip1 ip2 any -P out ipsec esp/transport//require
                                     ah/transport//require;

is used to create the policy, then the correct order is
applied, resulting in a header order of [IP][AH][ESP].
However, if the command
     spdadd ip1 ip2 any -P out ipsec ah/transport//require
                                     esp/transport//require;

is used to create the policy, then the incorrect order is
applied, resulting in a header order of [IP][ESP][AH].
The same behaviour occurs with AH and ESP being applied
in tunnel mode (although the RFC doesn't document the
AH/ESP tunnel mode scenario).  Also, the RFC states "the sender
MUST apply the transport header before the tunnel header."
Based on how the protocols are selected it appears that
tunnel mode could be applied before transport mode.
Again I'm not familiar enough with the code at this point
to determine how to get the ESP protocol to be processed
before the AH protocol in this case or how to get the
transport protocols to be processed before the tunnel
protocols.


Thanks,
Tom Lendacky






