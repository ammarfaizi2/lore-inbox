Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263444AbUELU0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbUELU0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263713AbUELU0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:26:39 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:19977 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265227AbUELU0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:26:16 -0400
Date: Wed, 12 May 2004 21:26:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Werner <werner@sgi.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [RFC/PATCH]Allow agp memory allocations to use node information
Message-ID: <20040512212615.A597@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Werner <werner@sgi.com>, linux-kernel@vger.kernel.org,
	davej@redhat.com
References: <40A2714B.2F27EA35@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40A2714B.2F27EA35@sgi.com>; from werner@sgi.com on Wed, May 12, 2004 at 11:47:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

not a lot of description here, he? :-)


On Wed, May 12, 2004 at 11:47:39AM -0700, Mike Werner wrote:
> diff -u linux-2.6.6.orig/drivers/char/agp/agp.h
> linux-2.6.6/drivers/char/agp/agp.h
> --- linux-2.6.6.orig/drivers/char/agp/agp.h     Sun May  9 19:32:28 2004
> 
> +++ linux-2.6.6/drivers/char/agp/agp.h  Wed May 12 11:43:19 2004
> @@ -111,7 +111,7 @@
>         int (*remove_memory)(struct agp_memory *, off_t, int);
>         struct agp_memory *(*alloc_by_type) (size_t, int);
>         void (*free_by_type)(struct agp_memory *);
> -       void *(*agp_alloc_page)(void);
> +       void *(*agp_alloc_page)(int);
>         void (*agp_destroy_page)(void *);

Wrong interface.  We need to pass a struct agp_bridge_data to
each of the methods anyway for proper support for multiple AGP
bridges in a single system.  And once you have that you can simply
use the node id your patches stores in agp_bridge_data.

> +++ linux-2.6.6/drivers/char/agp/intel-mch-agp.c        Wed May 12
> 11:16:02 2004
> @@ -43,7 +43,7 @@
>         if (pg_count != 1)
>                 return NULL;
> 
> -       addr = agp_bridge->driver->agp_alloc_page();
> +       addr = agp_bridge->driver->agp_alloc_page(AGPGART_DEFAULT_NODE);

wrong default again.  for the agp bridges that have an associated pci
device (aka about everything except hpzx and alpha IIRC) you should
use pcibus_to_cpumask (or what the thing was called).  For the others
you should try to contact the maintainers for a proper choice.

