Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUFVNYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUFVNYZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUFVNYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:24:25 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:41723 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261605AbUFVNYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:24:23 -0400
Date: Tue, 22 Jun 2004 06:35:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: cw@f00f.org, dcn@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add wait_event_interruptible_exclusive() macro
Message-Id: <20040622063537.33282647.pj@sgi.com>
In-Reply-To: <20040622122948.GA2038@infradead.org>
References: <40D30646.mailxA8X155I80@aqua.americas.sgi.com>
	<20040622120130.GA16246@taniwha.stupidest.org>
	<20040622122948.GA2038@infradead.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> In this case a macro is the only sensible way.  Check how the arguments
> are used in wait_event_*

Are you referring to such usages as the "&wq" in this line:

>	add_wait_queue_exclusive(&wq, &__wait);

If so, then yes, a macro is needed.  This is a poor man's implicit pass
by reference.  In straight C, not using macros, saying "foo(x)" pushes
the value of 'x' on the stack, not the address of 'x'.  This macro
pushes the _address_ of 'x' on the stack (x == wq), but doesn't require
the "address of" operator, "&", as in foo(&x), to be explicitly coded. 
Hence, straight C is insufficient to the task.

I don't know if it applies in this case, but one can mix macros with
inlines, to get both this implicit pass by reference, and get some
type checking on the arguments.  See my dreaded cpumask patch, in the
latest *-mm patch series, for many examples.

They look like:

#define foo(x) __foo(&(x))

static inline void __foo(int *xp)		\
{						\
	printk("addr of x is %p\n", xp);	\
}

This both provides implicit pass by reference, and checks that the
argument and return types are as intended (to within the range of
C's automatic type conversions ;).

Be aware that I am engaging in drive-by-commenting here, which is
commenting on a phrase that jumped out at me, without any effort to
look around at the larger picture.  Damage due to collateral fire is
not uncommon in such cases ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
