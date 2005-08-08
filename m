Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVHHJxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVHHJxa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 05:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVHHJxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 05:53:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22729 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750787AbVHHJx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 05:53:29 -0400
Date: Mon, 8 Aug 2005 17:57:47 +0800
From: David Teigland <teigland@redhat.com>
To: Pekka Enberg <penberg@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050808095747.GD13951@redhat.com>
References: <20050802071828.GA11217@redhat.com> <84144f0205080223445375c907@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f0205080223445375c907@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 09:44:06AM +0300, Pekka Enberg wrote:

> > +uint32_t gfs2_hash(const void *data, unsigned int len)
> > +{
> > +     uint32_t h = 0x811C9DC5;
> > +     h = hash_more_internal(data, len, h);
> > +     return h;
> > +}
> 
> Is there a reason why you cannot use <linux/hash.h> or <linux/jhash.h>?

See gfs2_hash_more() and comment; we hash discontiguous regions.

> > +#define RETRY_MALLOC(do_this, until_this) \
> > +for (;;) { \
> > +     { do_this; } \
> > +     if (until_this) \
> > +             break; \
> > +     if (time_after_eq(jiffies, gfs2_malloc_warning + 5 * HZ)) { \
> > +             printk("GFS2: out of memory: %s, %u\n", __FILE__, __LINE__); \
> > +             gfs2_malloc_warning = jiffies; \
> > +     } \
> > +     yield(); \
> > +}
> 
> Please drop this.

Done in the spot that could deal with an error, but there are three other
places that still need it.

> > +static int ea_set_i(struct gfs2_inode *ip, struct gfs2_ea_request *er,
> > +                 struct gfs2_ea_location *el)
> > +{
> > +     {
> > +             struct ea_set es;
> > +             int error;
> > +
> > +             memset(&es, 0, sizeof(struct ea_set));
> > +             es.es_er = er;
> > +             es.es_el = el;
> > +
> > +             error = ea_foreach(ip, ea_set_simple, &es);
> > +             if (error > 0)
> > +                     return 0;
> > +             if (error)
> > +                     return error;
> > +     }
> > +     {
> > +             unsigned int blks = 2;
> > +             if (!(ip->i_di.di_flags & GFS2_DIF_EA_INDIRECT))
> > +                     blks++;
> > +             if (GFS2_EAREQ_SIZE_STUFFED(er) > ip->i_sbd->sd_jbsize)
> > +                     blks += DIV_RU(er->er_data_len,
> > +                                    ip->i_sbd->sd_jbsize);
> > +
> > +             return ea_alloc_skeleton(ip, er, blks, ea_set_block, el);
> > +     }
> 
> Please drop the extra braces.

Here and elsewhere we try to keep unused stuff off the stack.  Are you
suggesting that we're being overly cautious, or do you just dislike the
way it looks?

Thanks,
Dave

