Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWHGX4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWHGX4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWHGXzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:55:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932429AbWHGXzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:55:20 -0400
Date: Mon, 7 Aug 2006 16:55:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Message-Id: <20060807165512.dabefb63.akpm@osdl.org>
In-Reply-To: <m1slk89ozd.fsf@ebiederm.dsl.xmission.com>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<20060807085924.72f832af.rdunlap@xenotime.net>
	<m1wt9kcv2n.fsf@ebiederm.dsl.xmission.com>
	<20060807105537.08557636.rdunlap@xenotime.net>
	<m1psfcbcnk.fsf@ebiederm.dsl.xmission.com>
	<20060807120454.79b6e1dc.rdunlap@xenotime.net>
	<m1slk89ozd.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2006 16:10:14 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> +/* We can be setup to receive at most NR_CPUS*224 irqs simultaneously */
> +#define NR_IRQS (CONFIG_NR_IRQS)

We know that setting this high can cause machines to run out of per-cpu
memory, so we're handing people a foot blowing-off tool here.

And it's a pretty nasty one because it can get people into the situation
where the kernel worked fine for those who released it, but users who
happen to load more modules (or the right combination of them) will
experience per-cpu memory exhaustion.

So shouldn't we being scaling the per-cpu memory as well?


If so, I'd suggest that we special-case that huge kstat structure.  We can
calculate its size exactly, so how about we do:

#define SIZE_OF_KSTAT_THING	<complicated expression>
#define PERCPU_ENOUGH_ROOM	32768

#define PERCPU_ENOUGH_ROOM_WHICH_WE_REALLY_USE \
		PERCPU_ENOUGH_ROOM + SIZE_OF_KSTAT_THING


?

(And as it's a critical managed resource, I'm thinking that we should be
adding some /proc reporting of the per-cpu memory consumption..)
