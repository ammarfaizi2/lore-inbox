Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751775AbWHNBbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbWHNBbp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 21:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWHNBbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 21:31:45 -0400
Received: from smtp-out.google.com ([216.239.45.12]:31923 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751775AbWHNBbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 21:31:44 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=xv6IQBJbnGQH5YOtvaTFbB9rQGnaK2AdKhp1exS/40OsIZPCXOR2NcoaNAOENEbiF
	CFGZR8C42g3cvjwGJ4HlA==
Message-ID: <44DFD262.5060106@google.com>
Date: Sun, 13 Aug 2006 18:31:14 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: riel@redhat.com, tgraf@suug.ch, a.p.zijlstra@chello.nl, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808211731.GR14627@postel.suug.ch>	<44DBED4C.6040604@redhat.com>	<44DFA225.1020508@google.com> <20060813.165540.56347790.davem@davemloft.net>
In-Reply-To: <20060813.165540.56347790.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> I think there is more profitability from a solution that really does
> something about "network memory", and doesn't try to say "these
> devices are special" or "these sockets are special".  Special cases
> generally suck.
> 
> We already limit and control TCP socket memory globally in the system.
> If we do this for all socket and anonymous network buffer allocations,
> which is sort of implicity in Evgeniy's network tree allocator design,
> we can solve this problem in a more reasonable way.

This does sound promising, but...

It is not possible to solve this problem entirely in the network
layer.  At minimum, throttling is needed in the nbd driver, or even
better, in the submit_bio path as we have it now.  We also need a way
of letting the virtual block device declare its resource needs, which
we also have in some form.  We also need a mechanism to guarantee
level 2 delivery so we can drop unrelated packets if necessary, which
exists in the current patch set.

So Evgeniy's work might well be a part of the solution, but it is not
the whole solution.

> And here's the kick, there are other unrelated highly positive
> consequences to using Evgeniy's network tree allocator.

Also good.  But is it ready to use today?  We need to actually fix
the out of memory deadlock/performance bug right now so that remote
storage works properly.

> It doesn't just solve the _one_ problem it was built for, it solves
> several problems.  And that is the hallmark signature of good design.

Great.  But to solve the whole problem, the block IO system and the
network layer absolutely must cooperate.

Regards,

Daniel

