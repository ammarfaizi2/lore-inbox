Return-Path: <linux-kernel-owner+w=401wt.eu-S965241AbXAGXWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbXAGXWS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 18:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbXAGXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 18:22:18 -0500
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:56206 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965241AbXAGXWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 18:22:17 -0500
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <108973.65122.qm@web55613.mail.re4.yahoo.com>
References: <108973.65122.qm@web55613.mail.re4.yahoo.com>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 15:22:13 -0800
Message-Id: <1168212133.2744.17.camel@dsl081-166-245.sea1.dsl.speakeasy.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-07 at 14:43 -0800, Amit Choudhary wrote:
> Any strong reason why not? x has some value that does not make sense and can create only problems.
> And as I explained, it can result in longer code too. So, why keep this value around. Why not
> re-initialize it to NULL.

Because it looks really STRANGE(tm). Consider the following function,
which is essentially what you're proposing in macro-ized form:
	void foobar(void)
	{
		void *ptr;

		ptr = kmalloc(...);
		// actual work here
		kfree(ptr);
		ptr = NULL;
	}
Reading code like that makes me say "wtf?", simply because 'ptr' is not
used thereafter, so setting it to NULL is both pointless and confusing
(it looks out-of-place, and therefore makes me wonder if there's
something stupidly tricky going on).

Also, arguably, your demonstration of why the lack of the proposed
KFREE() macro results in longer code is invalid. Whereas you wrote:
	pointer *arr_x[size_x];
	pointer *arr_y[size_y];
	pointer *arr_z[size_z];
That really should have been:
	pointer *arr[size_x + size_y + size_z];
or:
	pointer **arr[3] = { arr_x, arr_y, arr_z };
In which case, the you only need one path in the function to handle
allocation failures, rather than the three that you were arguing for.

> If x should not be re-initialized to NULL, then by the same logic, we should not even initialize
> local variables. And all of us know that local variables should be initialized.

That's some strange and confused logic then. Here's my stab at the same
logical premise: "Using uninitialized values is bad." Notice how that,
in and of itself, makes no statements regarding freed pointers, since
the intent is not to use them after they've been freed anyway.

-- Vadim Lobanov


