Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbUKEWTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbUKEWTa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUKEWTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:19:30 -0500
Received: from [62.206.217.67] ([62.206.217.67]:34247 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261209AbUKEWTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:19:22 -0500
Message-ID: <418BFC5C.20201@trash.net>
Date: Fri, 05 Nov 2004 23:19:08 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Pablo Neira <pablo@eurodev.net>
CC: Matthias Andree <matthias.andree@gmx.de>, linux-net@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks
 amanda dumps
References: <20041104121522.GA16547@merlin.emma.line.org>	<418A7B0B.7040803@trash.net>	<20041104231734.GA30029@merlin.emma.line.org> <418AC0F2.7020508@trash.net> <418BE156.4020400@eurodev.net>
In-Reply-To: <418BE156.4020400@eurodev.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Neira wrote:

> Patrick, what about this? this way we save a copy to a buffer for 
> linear skbs.
>
> Signed-off-by: Pablo Neira Ayuso <pablo@eurodev.net>
>
>@@ -74,12 +75,17 @@
> 				 skb->len - dataoff, amanda_buffer);
> 	BUG_ON(amp == NULL);
> 	data = amp;
>-	data_limit = amp + skb->len - dataoff;
>-	*data_limit = '\0';
> 
> 	/* Search for the CONNECT string */
>-	data = strstr(data, "CONNECT ");
>-	if (!data)
>+	while((data = memchr(data, 'C', skb->len - dataoff)) != NULL) {
>+		if (strncmp(data, "CONNECT ", 8) == 0) {
>  
>
What if the C is the last byte ? There are also more str* commands below
that need a terminating 0-byte.

Regards
Patrick

>+			found = 1;
>+			break;
>+		}
>+		data++;
>+	}
>+
>+	if (!found)
> 		goto out;
> 	data += strlen("CONNECT ");
> 
>  
>

