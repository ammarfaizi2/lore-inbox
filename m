Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbUKEUWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbUKEUWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUKEUWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:22:18 -0500
Received: from smtp09.auna.com ([62.81.186.19]:9679 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261200AbUKEUWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:22:06 -0500
Message-ID: <418BE156.4020400@eurodev.net>
Date: Fri, 05 Nov 2004 21:23:50 +0100
From: Pablo Neira <pablo@eurodev.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: Matthias Andree <matthias.andree@gmx.de>, linux-net@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks
 amanda dumps
References: <20041104121522.GA16547@merlin.emma.line.org>	<418A7B0B.7040803@trash.net>	<20041104231734.GA30029@merlin.emma.line.org> <418AC0F2.7020508@trash.net>
In-Reply-To: <418AC0F2.7020508@trash.net>
Content-Type: multipart/mixed;
 boundary="------------000507040806000704000409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000507040806000704000409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patrick McHardy wrote:

> Matthias Andree wrote:
>
>> On Thu, 04 Nov 2004, Patrick McHardy wrote:
>>
>>> The data that is changed is only a copy, the actual packet is not 
>>> touched.
>>>   
>>
>>
>> Why then does the application not see the packets as long as
>> ip_conntrack_amanda is loaded and starts seeing them again as soon as
>> "rmmod ip_conntrack_amanda" has completed?
>>  
>>
>
> Your observation and your patch were correct, thanks. It is supposed
> to be just a copy, I missed that it wasn't anymore. While your patch
> works too, and is even faster with non-linear skbs, I don't like the
> idea of using the skb as a scratch-area, so I sent this patch to Dave
> instead.


Patrick, what about this? this way we save a copy to a buffer for linear 
skbs.

Signed-off-by: Pablo Neira Ayuso <pablo@eurodev.net>

--------------000507040806000704000409
Content-Type: text/plain;
 name="xxx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xxx"

===== net/ipv4/netfilter/ip_conntrack_amanda.c 1.10 vs edited =====
--- 1.10/net/ipv4/netfilter/ip_conntrack_amanda.c	2004-08-19 02:14:53 +02:00
+++ edited/net/ipv4/netfilter/ip_conntrack_amanda.c	2004-11-05 17:32:04 +01:00
@@ -49,9 +49,10 @@
 {
 	struct ip_conntrack_expect *exp;
 	struct ip_ct_amanda_expect *exp_amanda_info;
-	char *amp, *data, *data_limit, *tmp;
+	char *amp, *data, *tmp;
 	unsigned int dataoff, i;
 	u_int16_t port, len;
+	int found = 0;
 
 	/* Only look at packets from the Amanda server */
 	if (CTINFO2DIR(ctinfo) == IP_CT_DIR_ORIGINAL)
@@ -74,12 +75,17 @@
 				 skb->len - dataoff, amanda_buffer);
 	BUG_ON(amp == NULL);
 	data = amp;
-	data_limit = amp + skb->len - dataoff;
-	*data_limit = '\0';
 
 	/* Search for the CONNECT string */
-	data = strstr(data, "CONNECT ");
-	if (!data)
+	while((data = memchr(data, 'C', skb->len - dataoff)) != NULL) {
+		if (strncmp(data, "CONNECT ", 8) == 0) {
+			found = 1;
+			break;
+		}
+		data++;
+	}
+
+	if (!found)
 		goto out;
 	data += strlen("CONNECT ");
 

--------------000507040806000704000409--
