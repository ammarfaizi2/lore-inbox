Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbUBUKaK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 05:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUBUKaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 05:30:10 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:60631 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261540AbUBUKaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 05:30:06 -0500
Message-ID: <40372BCE.7090708@us.ibm.com>
Date: Sat, 21 Feb 2004 01:58:38 -0800
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <thornber@redhat.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/6] dm: endio method
References: <20040220153145.GN27549@reti> <20040220153403.GO27549@reti>
In-Reply-To: <20040220153403.GO27549@reti>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:

> Add an endio method to targets.  This method is allowed to request
> another shot at failed ios (think multipath). 


> +	if (endio) {
> +		/* Restore bio fields. */
> +		bio->bi_sector = tio->bi_sector;
> +		bio->bi_bdev = tio->bi_bdev;
> +		bio->bi_size = tio->bi_size;
> +		bio->bi_idx = tio->bi_idx;
> +
> +		r = endio(tio->ti, bio, error, &tio->info);


> +	r = ti->type->map(ti, clone, &tio->info);
> +	if (r > 0) {
> +		/* Save the bio info so we can restore it during endio. */
> +		tio->bi_sector = clone->bi_sector;
> +		tio->bi_bdev = clone->bi_bdev;
> +		tio->bi_size = clone->bi_size;
> +		tio->bi_idx = clone->bi_idx;


Saving and restoring bi_bdev is going to break multipath. When a bio is 
remapped and resent multiple times by the target becuase of multiple 
path failures, restoring bi_bdev to the original value will cause only 
that path to be marked as failed instead of the paths that the bio was 
remapped to.

This is DM's cloned bio. Is there a guarantee that this value should be 
safe from lower level drivers overwriting it, or is it similar to b_rdev 
for buffer_heads?

Mike Christie
