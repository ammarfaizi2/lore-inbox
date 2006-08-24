Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWHXMlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWHXMlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWHXMlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:41:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:1713 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751193AbWHXMlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:41:08 -0400
Subject: Re: [Ext2-devel] [RFC][PATCH] Manage jbd allocations from its own
	slabs
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060823163410.d9af3baa.akpm@osdl.org>
References: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com>
	 <20060823163410.d9af3baa.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 12:41:05 +0000
Message-Id: <1156423265.7908.10.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 16:34 -0700, Andrew Morton wrote:
> On Wed, 23 Aug 2006 16:08:15 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:

> >  /*
> > + * jbd slab management: create 1k, 2k, 4k, 8k slabs and allocate
> > + * frozen and commit buffers from these slabs.
> > + *
> > + * Reason for doing this is to avoid, SLAB_DEBUG - since it could
> > + * cause bh to cross page boundary.
> > + */
> > +
> > +static kmem_cache_t *jbd_slab[4];
> > +static const char *jbd_slab_names[4] = {
> > +	"jbd_1k",
> > +	"jbd_2k",
> > +	"jbd_4k",
> > +	"jbd_8k",
> > +};
> > +
> > +static void journal_destroy_jbd_slabs(void)
> > +{
> > +	int i;
> > +
> > +	for (i=0; i<4; i++) {
> > +		if (jbd_slab[i])
> > +			kmem_cache_destroy(jbd_slab[i]);
> > +		jbd_slab[i] = NULL;
> > +	}
> > +}
> > +
> > +static int journal_init_jbd_slabs(void)
> > +{
> > +	int i = 0;
> > +	int retval = 0;
> > +
> > +	for (i=0; i<4; i++) {
> > +		unsigned long slab_size = 1024 << i;
> > +		jbd_slab[i] = kmem_cache_create(jbd_slab_names[i],
> > +					slab_size, slab_size,
> > +					0, NULL, NULL);
> 
> OK, passing align=slab_size fixes the bug.

The comments above don't mention the alignment of the slabs, so a
comment here may help explain that the alignment is the key to avoiding
the page-straddling.  Or you could elaborate above.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

