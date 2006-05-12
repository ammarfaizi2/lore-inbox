Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWELLdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWELLdX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWELLdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:33:23 -0400
Received: from stinky.trash.net ([213.144.137.162]:40144 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751218AbWELLdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:33:22 -0400
Message-ID: <44647280.1030602@trash.net>
Date: Fri, 12 May 2006 13:33:20 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       sfrost@snowman.net, gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
References: <20060507093640.GF11191@w.ods.org>	 <egts52hm2epfu4g1b9kqkm4s9cdiv3tvt9@4ax.com>	 <20060508050748.GA11495@w.ods.org>	 <20060507.224339.48487003.davem@davemloft.net>	 <44643BFD.3040708@trash.net> <9a8748490605120409x3851ca4fn14fc9c52500701e4@mail.gmail.com>
In-Reply-To: <9a8748490605120409x3851ca4fn14fc9c52500701e4@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------030201030105060009070204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030201030105060009070204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jesper Juhl wrote:
> On 5/12/06, Patrick McHardy <kaber@trash.net> wrote:
> 
>> I haven't seen any cleanup patches so far, so I think I'm
>> going to start my nth try at cleaning up this mess.
>> Unfortunately its even immune to Lindent ..
>>
> 
> If you get too fed up with it, let me know, and I'll give it a go as well.

Thanks, I'm about half-way through (and about to kill someone),
just started with the biggest pile of crap (the match function)
and already noticed a possible endless loop within the first
couple of lines.

Unfortunately this stuff is so unreadable that I'm not exactly
sure if the loop really won't terminate, an extra pair of eyes
would be appreciated.


--------------030201030105060009070204
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

diff --git a/net/ipv4/netfilter/ipt_recent.c b/net/ipv4/netfilter/ipt_recent.c
index 1438432..b8850a2 100644
--- a/net/ipv4/netfilter/ipt_recent.c
+++ b/net/ipv4/netfilter/ipt_recent.c
@@ -438,11 +438,15 @@ #endif
 			(!r_list[hash_table[hash_result]].ttl || r_list[hash_table[hash_result]].ttl == ttl))) {
 			/* Collision in hash table */
 			hash_result = (hash_result + 1) % ip_list_hash_size;
+			if (hash_result == orig_hash_result)
+				break;
 		}
 	} else {
 		while(hash_table[hash_result] != -1 && r_list[hash_table[hash_result]].addr != addr) {
 			/* Collision in hash table */
 			hash_result = (hash_result + 1) % ip_list_hash_size;
+			if (hash_result == orig_hash_result)
+				break;
 		}
 	}
 

--------------030201030105060009070204--
