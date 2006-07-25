Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWGYGRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWGYGRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 02:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWGYGRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 02:17:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16517
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751436AbWGYGRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 02:17:07 -0400
Date: Mon, 24 Jul 2006 23:17:08 -0700 (PDT)
Message-Id: <20060724.231708.01289489.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060709132446.GB29435@2ka.mipt.ru>
References: <20060709132446.GB29435@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Sun, 9 Jul 2006 17:24:46 +0400

> This patch includes core kevent files:
>  - userspace controlling
>  - kernelspace interfaces
>  - initialisation
>  - notification state machines
> 
> It might also inlclude parts from other subsystem (like network related
> syscalls so it is possible that it will not compile without other
> patches applied).
> 
> Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

I like this work a lot, as I've stated before.  The data structures
look like they will scale well and it takes care of all the limitations
that networking in particular seems to have in this area.

I have to say that the user API is not the nicest in the world.  Yet,
at the same time, I cannot think of a better one :)

Please, remove some grot such as this:

> +	if (kevent_cache)
> +		k = kmem_cache_alloc(kevent_cache, mask);
> +	else
> +		k = kzalloc(sizeof(struct kevent), mask);
 ...
> +	if (kevent_cache)
> +		kmem_cache_free(kevent_cache, k);
> +	else
> +		kfree(k);

Instead, make this:

> +	kevent_cache = kmem_cache_create("kevent_cache", 
> +			sizeof(struct kevent), 0, 0, NULL, NULL);
> +	if (!kevent_cache)
> +		err = -ENOMEM;

panic().  This is consistent with how other core subsystems handle
SLAB cache creation failures.

I also think that if we accept this work, it should be first class
citizen with no config options and no ifdefs scattered all over.
Either this is how we do network AIO or it is not.

I've looked only briefly at Ulrich Drepper's AIO proposal in his OLS
slides, although the DMA bits do not initially strike me as such a hot
idea.  I haven't wrapped my brain much around this new stuff, so I'm
not going to touch on it much more just yet.

The practical advantage kevent has over any new proposal is that 1)
implementation exists :) and 2) several types of test applications and
performance measurements have been made against it which usually
flushes out the worst design issues.
