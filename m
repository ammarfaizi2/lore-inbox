Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751727AbWHARhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbWHARhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWHARhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:37:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24230 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751726AbWHARhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:37:15 -0400
Date: Tue, 1 Aug 2006 10:36:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
In-Reply-To: <20060731225454.19981a5f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0608011034540.18006@schroedinger.engr.sgi.com>
References: <20060801030443.GA2221@gondor.apana.org.au>
 <20060731210418.084f9f5d.akpm@osdl.org> <20060801050259.GA3126@gondor.apana.org.au>
 <20060731225454.19981a5f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, Andrew Morton wrote:

> > Sure, this particular instance is in journal_write_metadata_buffer
> > where the bh may be constructed from kmalloc memory (search for the
> > call to jbd_rep_kmalloc).  Because the memory returned by kmalloc
> > may straddle a page (when slab debugging is enabled that is), this
> > causes a broken bh to be injected into submit_bh.
> > 
> 
> Crap, that's hard to fix.   Am I allowed to blame submit_bh()? ;)
> 
> uhm, we don't want to lose kmalloc redzoning, so I guess we need to create
> on-demand ext3-private slab caches for 1024, 2048, and 4096 bytes.  With
> the appropriate slab flags to defeat the redzoning.

The slab allocator gives no guarantee that a structure is not straddling a 
page boundary regardless of debug or not. It may just happen that the 
objects are arranged if kmem_cache_cretae() is called with certain 
parameters. Another arch with other cacheline alignment and another page 
size may arrange the objects differently.

