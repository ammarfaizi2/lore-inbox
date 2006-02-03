Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946083AbWBCXNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946083AbWBCXNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946082AbWBCXNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:13:47 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:53384 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1946080AbWBCXNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:13:46 -0500
X-IronPort-AV: i="4.02,86,1139212800"; 
   d="scan'208"; a="400560572:sNHT32150280"
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ib: don't doublefree pages from scatterlist
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
	<20060104172727.GA320@tau.solarneutrino.net>
	<Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
	<20060105201249.GB1795@tau.solarneutrino.net>
	<Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
	<20060109033149.GC283@tau.solarneutrino.net>
	<Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
	<Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
	<20060109185350.GG283@tau.solarneutrino.net>
	<Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
	<20060118001252.GB821@tau.solarneutrino.net>
	<Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0602031948100.14829@goblin.wat.veritas.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 03 Feb 2006 15:13:43 -0800
In-Reply-To: <Pine.LNX.4.61.0602031948100.14829@goblin.wat.veritas.com> (Hugh
 Dickins's message of "Fri, 3 Feb 2006 19:51:18 +0000 (GMT)")
Message-ID: <adalkwsujbs.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 03 Feb 2006 23:13:44.0597 (UTC) FILETIME=[7AAFDC50:01C62917]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Hugh.  This is definitely a real bug caused by an embarassing
oversight on my part.  I will test and apply to my trees.

 > Warning: untested!  And please double-check the adjusted definition of
 > IB_UMEM_MAX_PAGE_CHUNK - the old definition was avoiding "sizeof"s, but
 > I don't understand why.

The old definition of IB_UMEM_MAX_PAGE_CHUNK came from my paranoia:

 >  #define IB_UMEM_MAX_PAGE_CHUNK						\
 >  	((PAGE_SIZE - offsetof(struct ib_umem_chunk, page_list)) /	\
 > -	 ((void *) &((struct ib_umem_chunk *) 0)->page_list[1] -	\
 > -	  (void *) &((struct ib_umem_chunk *) 0)->page_list[0]))
 > +	 (sizeof(struct scatterlist) + sizeof(struct page *)))

I was afraid that some compiler somewhere might add in some padding
that would cause sizeof (struct scatterlist) to be smaller than the
entries in the array end up being, but now I've convinced myself that
this can't happen -- if it could then things like ARRAY_SIZE() would
be stuffed as well.

So I think your version is correct and clearer.

Thanks,
  Roland
