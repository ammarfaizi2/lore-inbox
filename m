Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVLNSiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVLNSiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVLNSiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:38:21 -0500
Received: from ns2.suse.de ([195.135.220.15]:31955 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964798AbVLNSiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:38:20 -0500
To: Martin Peschke <mp3@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 5/6] statistics infrastructure
References: <43A04C83.2070002@de.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2005 19:38:19 +0100
In-Reply-To: <43A04C83.2070002@de.ibm.com>
Message-ID: <p738xun8qxw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke <mp3@de.ibm.com> writes:
> + */
> +static inline u64 statistic_add(struct statistic *stat, s64 value, u64 incr)
> +{
> +	unsigned long flags;
> +	int retval;
> +
> +	if (stat->on != STATISTIC_DEF_ON)
> +		return 0;
> +
> +	statistic_lock(stat->interface, flags);
> +	retval = stat->add(stat, value, incr);
> +	statistic_unlock(stat->interface, flags);

Locks and indirect function calls? 

It seems very wrong to me to make such heavy weight statistic functions.
Most likely you will disturb the performance whatever is being counted 
badly.

Take a look at many other subsystems - they do per CPU counters etc.
to make this all fast.

But it's still unclear why it would need such an heavyweight infrastructure.
Normally it's not that bad to reimplemented on the fly. Maybe some
common code can be refactored out of that, but probably not too much.

[... lots of other code snipped ... ]

Looks all very very overdesigned to me. How about you just start
with a minimum specification and describe what you want to do? 
And then start with a *simple* base implementation. If it's really
needed it will grow later anyways, but starting off with such
a complex monstrosity is just wrong.

-Andi
