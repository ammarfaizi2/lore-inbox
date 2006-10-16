Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWJPNmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWJPNmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWJPNmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:42:55 -0400
Received: from ns1.suse.de ([195.135.220.2]:62346 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750716AbWJPNmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:42:54 -0400
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/2] round_jiffies infrastructure
References: <1160496165.3000.308.camel@laptopd505.fenrus.org>
	<1160496210.3000.310.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 16 Oct 2006 15:42:43 +0200
In-Reply-To: <1160496210.3000.310.camel@laptopd505.fenrus.org>
Message-ID: <p73wt70cr70.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:
> +}
> +EXPORT_SYMBOL_GPL(__round_jiffies);

This means non GPL modules will disturb your timers again. probably not
a good strategy.

> +
> +unsigned long __round_jiffies_relative(unsigned long T, int CPU)
> +{
> +	int rem;
> +	int original = T;
> +	T=T+jiffies;
> +	rem = T % HZ;
> +	if (rem < HZ/4)
> +		T = T - rem;
> +	else
> +		T = T - rem + HZ;
> +	/* we don't want all cpus firing at once hitting the same lock/memory */
> +	T += CPU * 3;

Consider a dual core Yonah/Merom: it has shared caches and the two cores
can only go to sleep together. With this the wakeups will be always
twice. Not good. I guess you need to add some topology awareness here
and e.g. only spread it for sockets.

BTW we normally put spaces around operators inside expressions.

-Andi
