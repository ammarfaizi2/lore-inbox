Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVAHNoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVAHNoo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 08:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVAHNoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 08:44:44 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:8431 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261166AbVAHNom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 08:44:42 -0500
Date: Sat, 8 Jan 2005 13:43:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Nikita Danilov <nikita@clusterfs.com>
cc: Andrew Morton <akpm@osdl.org>, <pmarques@grupopie.com>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
       <hch@infradead.org>
Subject: Re: [RFC] per thread page reservation patch
In-Reply-To: <m1vfa8w0nk.fsf@clusterfs.com>
Message-ID: <Pine.LNX.4.44.0501081336240.2804-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2005, Nikita Danilov wrote:
> Andrew Morton <akpm@osdl.org> writes:
> >
> > __alloc_pages(GFP_KERNEL, ...) doesn't return NULL.  It'll either succeed
> > or never return ;) That behaviour may change at any time of course, but it
> 
> Hmm... it used to, when I wrote that code.

And still does, if OOM decides to kill _your_ task: OOM sets PF_MEMDIE,
and then you don't get to go the retry route at all:

	/* This allocation should allow future memory freeing. */
	if ((p->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {
		/* go through the zonelist yet again, ignoring mins */
		for (i = 0; (z = zones[i]) != NULL; i++) {
			page = buffered_rmqueue(z, order, gfp_mask);
			if (page)
				goto got_pg;
		}
		goto nopage;
	}
....
nopage:
	....
	return NULL;

