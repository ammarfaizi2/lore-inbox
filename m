Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266503AbUALP2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUALP2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:28:00 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:2981 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266503AbUALP14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:27:56 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: dm-devel@sistina.com, Christophe Saout <christophe@saout.de>
Subject: Re: [dm-devel] [RFC][PATCH 1/2] bio queue functions in dm-bio-list.h
Date: Mon, 12 Jan 2004 09:26:11 -0600
User-Agent: KMail/1.5
References: <20040110200848.GB11068@leto.cs.pocnet.net>
In-Reply-To: <20040110200848.GB11068@leto.cs.pocnet.net>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401120926.11404.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 14:08, Christophe Saout wrote:
> Hi,
>
> I found some bio_list functions in dm-raid1.c and I thought they could
> be made available for other users too. 

> There's probably a better place for this.

Heh...maybe include/linux/bio.h? :)

Now that you've pointed out this stack vs. fifo problem a couple times, I'm 
beginning to wonder why the bi_next field in the bio is a struct bio * 
instead of a struct list_head. It would seem that changing it to a list_head 
would eliminate the need for the bio_list stuff, as well as eliminate the 
original problem of accidentally reordering the bio's.

Of course, it's probably way to late to make this kind of change, since it 
would involve auditing every driver that ever holds a pointer to a bio to see 
if it's treating that pointer as the head of a list.

> --- linux.orig/drivers/md/dm-bio-list.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux/drivers/md/dm-bio-list.h	2004-01-10 20:43:32.442353960 +0100
> @@ -0,0 +1,70 @@
> +/*
> + * bio queue functions
> + *
> + * Copyright (C) 2001, 2002 Sistina Software
> + *
> + * This file is released under the LGPL.
> + */
> +
> +#ifndef DM_BIO_LIST_H
> +#define DM_BIO_LIST_H
> +
> +#include <linux/bio.h>
> +
> +struct bio_list {
> +	struct bio *head;
> +	struct bio *tail;
> +};
> +
> +extern inline void bio_list_init(struct bio_list *bl)
> +{
> +	bl->head = bl->tail = NULL;
> +}
> +
> +extern inline void bio_list_add(struct bio_list *bl, struct bio *bio)
> +{
> +	bio->bi_next = NULL;
> +
> +	if (bl->tail)
> +		bl->tail->bi_next = bio;
> +	else
> +		bl->head = bio;
> +
> +	bl->tail = bio;
> +}
> +
> +extern inline void bio_list_merge(struct bio_list *bl, struct bio_list
> *bl2) +{
> +	if (bl->tail)
> +		bl->tail->bi_next = bl2->head;
> +	else
> +		bl->head = bl2->head;
> +
> +	bl->tail = bl2->tail;
> +}
> +
> +extern inline struct bio *bio_list_pop(struct bio_list *bl)
> +{
> +	struct bio *bio = bl->head;
> +
> +	if (bio) {
> +		bl->head = bl->head->bi_next;
> +		if (!bl->head)
> +			bl->tail = NULL;
> +
> +		bio->bi_next = NULL;
> +	}
> +
> +	return bio;
> +}
> +
> +extern inline struct bio *bio_list_get(struct bio_list *bl)
> +{
> +	struct bio *bio = bl->head;
> +
> +	bl->head = bl->tail = NULL;
> +
> +	return bio;
> +}
> +
> +#endif

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

