Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265100AbSJWRVZ>; Wed, 23 Oct 2002 13:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265103AbSJWRVZ>; Wed, 23 Oct 2002 13:21:25 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:29659 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S265100AbSJWRVY>;
	Wed, 23 Oct 2002 13:21:24 -0400
Message-ID: <3DB6DBF1.4060009@candelatech.com>
Date: Wed, 23 Oct 2002 10:27:13 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Slavcho Nikolov <snikolov@okena.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: feature request - why not make netif_rx() a pointer?
References: <20021023003959.GA23155@bougret.hpl.hp.com> <004c01c27a99$927b8a30$800a140a@SLNW2K> <20021023164808.GG24123@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> On Wed, Oct 23, 2002 at 09:39:12AM -0400, Slavcho Nikolov wrote:
> 
>>Unfortunately, I cannot assume that every L2 (or maybe I can, we'll see) is
>>ethernet and I definitely cannot know in advance that every L3 is IP.
>>Nor can the assumption be made that netfilter has been built into the
>>kernel.
> 
> 
> 	So, you thing assuming a modified netif_rx is different than
> assuming netfilter support ?
> 	Your idea is just too dangerous.

If you added something like this to netif_rx, I think it would accomplish
the goals of those who want to add their own hooks.  It would probably not
please the folks who want to keep this code out for GPL/political/legal/moral
reasons.

Note that the hook basically exists already in the bridging code.  It may
be illegal for GPL reasons to assign your own method to this hook, but I'm
sure you could put up a good legal fight if you wanted to (the bridge hook
is not exported GPL)

int netif_rx(struct sk_buff *skb)
{
	int this_cpu = smp_processor_id();
	struct softnet_data *queue;
	unsigned long flags;

+#idfef EVIL_COMPANY_NETWORK_HOOK_HACK
+       if (evil_hook) {
+          int rv = evil_hook(skb);
+          if (rv) { return; /* skb was consumed by evil hook, gawd help us all */ }
+        }
+#endif

	if (skb->stamp.tv_sec == 0)
		do_gettimeofday(&skb->stamp);


> 
> 
>>If I define my own private protocol handler (to catch all), I see cloned
>>skb's
>>which is not what I want. I tried that and dropped each one of them in the
>>handler, yet traffic continued to flow unimpeded (so I must have dropped
>>clones).
> 
> 
> 	For this to work, you need to modify the driver. The driver
> generates a private packet type or protocol, and you will be the only
> to to catch it.

So, it would be ok to modify the driver to call a new hook, one that
may be over-written by proprietary code?  Otherwise, you have to write
a non-gpl driver....yuck!


Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


