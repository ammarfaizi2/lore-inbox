Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265481AbUFCDmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265481AbUFCDmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 23:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbUFCDmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 23:42:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:59115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265481AbUFCDmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 23:42:11 -0400
Date: Wed, 2 Jun 2004 20:41:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5: Device-mapper: kcopyd
Message-Id: <20040602204126.2bd0565c.akpm@osdl.org>
In-Reply-To: <20040602154129.GO6302@agk.surrey.redhat.com>
References: <20040602154129.GO6302@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
> kcopyd

I dunno about the rest of the people around here but I for one do not know
what kcopyd does, nor why it is being added to the kernel.  The changelog
was your chance to enlighten us - it is a shame nobody took the five
minutes to prepare a description.


> +static void drop_pages(struct page_list *pl)
> +{
> +	struct page_list *next;
> +
> +	while (pl) {
> +		next = pl->next;
> +		free_pl(pl);
> +		pl = next;
> +	}
> +}

What is the page pool for?  It is unfortunate that there is no suitable
library code for managing this - it is a fairly common pattern.  Maybe we
could massage mempools in some manner.

Why are the pooled pages locked?

> +static LIST_HEAD(_complete_jobs);
> +static LIST_HEAD(_io_jobs);
> +static LIST_HEAD(_pages_jobs);
> +
> +static int __init jobs_init(void)
> +{
> +	INIT_LIST_HEAD(&_complete_jobs);
> +	INIT_LIST_HEAD(&_io_jobs);
> +	INIT_LIST_HEAD(&_pages_jobs);

Do these lists need to be initialised a second time?

> +		memcpy(sub_job, job, sizeof(*job));
> +	memcpy(&job->source, from, sizeof(*from));

Structure assignments are nice.  If the struct is small the compiler will
do an element-by-element copy.  At some compiler-determined breakpoint it
will do a memcpy.  And it's typesafe.
