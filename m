Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbWEYWJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbWEYWJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbWEYWJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:09:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030462AbWEYWJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:09:58 -0400
Date: Thu, 25 May 2006 15:09:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/10] dm snapshot: unify chunk_size
Message-Id: <20060525150914.58fb5106.akpm@osdl.org>
In-Reply-To: <20060525190639.GS4521@agk.surrey.redhat.com>
References: <20060525190639.GS4521@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
>  +	chunk_t chunk_size;

That's a sector_t.  (Bad DM people!  Why not just use sector_t?)

>   	r = chunk_io(ps, 0, READ);
>   	if (r)
>  @@ -210,8 +210,29 @@ static int read_header(struct pstore *ps
>   		*new_snapshot = 0;
>   		ps->valid = le32_to_cpu(dh->valid);
>   		ps->version = le32_to_cpu(dh->version);
>  -		ps->chunk_size = le32_to_cpu(dh->chunk_size);
>  -
>  +		chunk_size = le32_to_cpu(dh->chunk_size);
>  +		if (ps->snap->chunk_size != chunk_size) {
>  +			DMWARN("chunk size %llu in device metadata overrides "
>  +			       "table chunk size of %llu.",
>  +			       (unsigned long long)chunk_size,
>  +			       (unsigned long long)ps->snap->chunk_size);
>  +
>  +			/* We had a bogus chunk_size. Fix stuff up. */
>  +			dm_io_put(sectors_to_pages(ps->snap->chunk_size));
>  +			free_area(ps);
>  +
>  +			ps->snap->chunk_size = chunk_size;
>  +			ps->snap->chunk_mask = chunk_size - 1;
>  +			ps->snap->chunk_shift = ffs(chunk_size) - 1;

but ffs() takes an int.

I guess you weren't planning on chunks larger than 2TB ;)
