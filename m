Return-Path: <linux-kernel-owner+w=401wt.eu-S1030453AbXAHCfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbXAHCfj (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 21:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbXAHCfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 21:35:39 -0500
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:53842 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030453AbXAHCfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 21:35:38 -0500
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <261558.33282.qm@web55609.mail.re4.yahoo.com>
References: <261558.33282.qm@web55609.mail.re4.yahoo.com>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 18:35:34 -0800
Message-Id: <1168223734.5259.12.camel@dsl081-166-245.sea1.dsl.speakeasy.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-07 at 16:02 -0800, Amit Choudhary wrote:
> That's where KFREE(ptr) comes in so that the code doesn't look ugly and still the purpose is
> achieved.

Shoving it into a macro makes it no better.

> > Reading code like that makes me say "wtf?", simply because 'ptr' is not
> > used thereafter,
> 
> Really? Then why do we have all the debugging options to catch re-use of the memory that has been
> freed. So many debugging options has been implemented, so much effort has gone into them, partly
> because programmers sometimes miss correct programming.

Which is exactly why we should continue to let programmers focus on
trying to get their code correct and letting the existing safety tools
catch thinkos, instead of distracting them with confusing and completely
pointless variable assignments.

> I do not know what you are talking about here. You are saying that a function does not need three
> different arrays with different names. How can you say that? How do you know what is the
> requirement?

What I said was that your example proves something entirely different
than what you think: rather than proving the need for your KFREE()
macro, it instead proves the need to design the code correctly from the
start, so as to avoid even thinking about this crud.

If you insist, here's your example function, trivially rewritten without
any NULL assignments. (I used two arrays, not three, to save space. The
basic idea works by-design for any random number of arrays, each of any
arbitrary size.)

struct type1 {
	/* something */
};

struct type2 {
	/* something */
};

#define COUNT 10

void function1(struct type1 **a1, struct type2 **a2, unsigned int sz);

void function2(void)
{
	struct type1 *arr1[COUNT];
	struct type2 *arr2[COUNT];
	int i;

	/* init */
	for (i = 0; i < COUNT; i++) {
		arr1[i] = kmalloc(sizeof(struct type1), ...);
		if (!arr1[i])
			goto free_1;
	}
	for (i = 0; i < COUNT; i++) {
		arr2[i] = kmalloc(sizeof(struct type2), ...);
		if (!arr2[i])
			goto free_2;
	}

	/* work */
	function1(arr1, arr2, COUNT);

	/* fini */
	i = COUNT;
free_2:
	for (i--; i >= 0; i--) {
		kfree(arr2[i]);
	}
	i = COUNT;
free_1:
	for (i--; i >= 0; i--) {
		kfree(arr1[i]);
	}
}

In most cases, though, the above code design would be brain-damaged from
the start: unless the sizes involved are prohibitively large, the
function should be allocating all the memory in a single pass.

So, where's the demonstrated need for KFREE()?

-- Vadim Lobanov


