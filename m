Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272570AbTHBK7R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 06:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272572AbTHBK7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 06:59:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:51941 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272570AbTHBK7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 06:59:16 -0400
Date: Sat, 2 Aug 2003 04:00:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] random: SMP locking
Message-Id: <20030802040015.0fcafda2.akpm@osdl.org>
In-Reply-To: <20030802042445.GD22824@waste.org>
References: <20030802042445.GD22824@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> wrote:
>
> This patch adds locking for SMP. Apparently Willy never managed to
> revive his laptop with his version so I revived mine.

hrm.  I'm a random ignoramus.   I'll look it over...

Are you really sure that all the decisions about where to use spin_lock()
vs spin_lock_irq() vs spin_lock_irqsave() are correct?  They are
non-obvious.

> @@ -1619,18 +1660,23 @@
>  		if (!capable(CAP_SYS_ADMIN))
>  			return -EPERM;
>  		p = (int *) arg;
> +		spin_lock(&random_state->lock);
>  		ent_count = random_state->entropy_count;
>  		if (put_user(ent_count, p++) ||
>  		    get_user(size, p) ||
>  		    put_user(random_state->poolinfo.poolwords, p++))

Cannot perform userspace access while holding a lock - a pagefault could
occur, perform IO, schedule away and the same CPU tries to take the same
lock via a different process.

