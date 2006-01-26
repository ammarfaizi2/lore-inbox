Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWAZHlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWAZHlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 02:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWAZHlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 02:41:32 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:46234 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750717AbWAZHlb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 02:41:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iu6DwjDQqkbqewKZsKeh92+3vcXQzKox92F5UKutgYED616jCuALkYuDEORADDBlkkna/l4Sa/fvpcH4KwjSMb4rHgFx09ak7oZh7MLVmKr+fHvbjcHEDnhMNYeIzxFJzubmmDTiTc9fRSYlxsbDIT3N83+lJUbw+K7aeXdWdmw=
Message-ID: <84144f020601252341k62c0c6fck57f3baa290f4430@mail.gmail.com>
Date: Thu, 26 Jan 2006 09:41:27 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: colpatch@us.ibm.com
Subject: Re: [patch 8/9] slab - Add *_mempool slab variants
Cc: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
In-Reply-To: <1138218020.2092.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060125161321.647368000@localhost.localdomain>
	 <1138218020.2092.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 1/25/06, Matthew Dobson <colpatch@us.ibm.com> wrote:
> +extern void *__kmalloc(size_t, gfp_t, mempool_t *);

If you really need to do this, please ntoe that you're adding an extra
parameter push for the nominal case where mempool is not required. The
compiler is unable to optimize it away. It's better that you create a
new entry point for the mempool case in mm/slab.c rather than
overloading __kmalloc() et al. See the following patch that does that
sort of thing:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm3/broken-out/slab-fix-kzalloc-and-kstrdup-caller-report-for-config_debug_slab.patch

Now as for the rest of the patch, are you sure you want to reserve
whole pages for each critical allocation that cannot be satisfied by
the slab allocator? Wouldn't it be better to use something like the
slob allocator to allocate from the mempool pages? That way you
wouldn't have to make the slab allocator mempool aware at all, simply
make your kmalloc_mempool first try the slab allocator and if it
returns NULL, go for the critical pool. All this in preferably
separate file so you don't make mm/slab.c any more complex than it is
now.

                                            Pekka
