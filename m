Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161183AbVKSCPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbVKSCPh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbVKSCPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:15:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53228 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161183AbVKSCPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:15:36 -0500
Date: Fri, 18 Nov 2005 18:15:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper snapshot: metadata reading separation
Message-Id: <20051118181513.31fed24c.akpm@osdl.org>
In-Reply-To: <20051118150135.GP11878@agk.surrey.redhat.com>
References: <20051118150135.GP11878@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
> +static void read_snapshot_metadata(struct dm_snapshot *s)
>  +{
>  +	if (s->have_metadata)
>  +		return;
>  +
>  +	if (s->store.read_metadata(&s->store)) {
>  +		down_write(&s->lock);
>  +		s->valid = 0;
>  +		up_write(&s->lock);
>  +	}
>  +
>  +	s->have_metadata = 1;
>  +}
>  +

I always get suspicious when I see a lock around a plain assignment. 
Sometimes it's legitimate, usually when some other user of the LHS expects
its value to be stable across an entire locked region - it is read multiple
times and those reads are expected to return the same thing.  (I can't
think of any other case).

Maybe this is such a case?
