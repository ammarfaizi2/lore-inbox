Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUG1WMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUG1WMW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUG1WMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:12:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:6121 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265521AbUG1WL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:11:57 -0400
Date: Wed, 28 Jul 2004 17:11:51 -0500
From: Greg Howard <ghoward@sgi.com>
X-X-Sender: ghoward@gallifrey.americas.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix system controller communication driver
In-Reply-To: <20040728085737.26e0bfd2.akpm@osdl.org>
Message-ID: <Pine.SGI.4.58.0407281641210.1656@gallifrey.americas.sgi.com>
References: <Pine.SGI.4.58.0407271457240.1364@gallifrey.americas.sgi.com>
 <20040728085737.26e0bfd2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, 28 Jul 2004, Andrew Morton wrote:

> As Jes says,
>
> 	.owner	= THIS_MODULE,
>
> is preferred here.
. . .
>
> There's no need to cast the return value of kmalloc.
>
> 	scd = kmalloc(sizeof(*scd), GFP_KERNEL);
>
> would suffice here.

I fixed these.  I plan to repost shortly.

. . .
> hm.  O_NONBLOCK means "don't wait for more input to arrive" rather than
> "don't block if someone else is holding a lock I want".  But given that the
> semaphore is held by !O_NONBLOCK readers, it has to be done this way.
>
> I guess there's no bug here, but it's a bit odd.

I'm certainly willing to try other ways, but this was the best I
could think of.  It seems to work at least.

>
> > +		copy_to_user(buf, sd->sd_rb, len);
>
> What Jes said: return -EFAULT if copy_to_user() returns non-zero.

Fixed this.

>
> > +static unsigned int
> > +scdrv_poll(struct file *file, struct poll_table_struct *wait)
> > +{
> > +	unsigned int mask = 0;
> > +	int status = 0;
> > +	struct subch_data_s *sd = (struct subch_data_s *) file->private_data;
> > +	unsigned long flags;
> > +
> > +	scdrv_lock_all(sd, &flags);
> > +	poll_wait(file, &sd->sd_rq, wait);
> > +	poll_wait(file, &sd->sd_wq, wait);
>
> This function will sleep with spinlocks held, won't it?

My understanding is that poll_wait just sets up a poll_table
structure; it doesn't sleep itself.

Thanks for the suggestions.
- Greg
