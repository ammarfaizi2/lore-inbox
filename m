Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWDRDQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWDRDQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 23:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWDRDQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 23:16:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5296 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751395AbWDRDQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 23:16:29 -0400
Date: Mon, 17 Apr 2006 20:16:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
In-Reply-To: <20060418120016.14419e02.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604172011490.3624@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
 <20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
 <20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
 <20060415090639.dde469e8.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604151040450.25886@schroedinger.engr.sgi.com>
 <20060417091830.bca60006.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604170958100.29732@schroedinger.engr.sgi.com>
 <20060418090439.3e2f0df4.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604171724070.2752@schroedinger.engr.sgi.com>
 <20060418094212.3ece222f.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604171856290.2986@schroedinger.engr.sgi.com>
 <20060418120016.14419e02.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006, KAMEZAWA Hiroyuki wrote:

> I think following patch will help. but this increases complexity...

Hmm... So the idea is to lock the anon vma before removing the ptes and 
keep it until we are finished migrating. I like it! That would also reduce 
the locking overhead.

>  /*
> + * When mmap->sem is not held, we have to guarantee anon_vma is not freed.
> + */
> +static void migrate_lock_anon_vma(struct page *page)
> +{
> +	unsigned long mapping;
> +	struct anon_vma *anon_vma;
> +	struct vm_area_struct *vma;
> +
> +	if (PageAnon(page))
> +		page_lock_anon_vma(page);
> +	/* remove migration ptes will unlock */
> +}

We need a whole function for two statements?

>  	 */
>  	anon_vma = (struct anon_vma *) (mapping - PAGE_MAPPING_ANON);
> -	spin_lock(&anon_vma->lock);

Maybe we better pass the anon_vma as a parameter?

> +++ Christoph-NewMigrationV2/mm/rmap.c
> @@ -160,7 +160,7 @@ void anon_vma_unlink(struct vm_area_stru
>  	empty = list_empty(&anon_vma->head);
>  	spin_unlock(&anon_vma->lock);
>  
> -	if (empty)
> +	if (empty && !anon_vma->async_refernece)
>  		anon_vma_free(anon_vma);
>  }

async_reference? What is this for? This does not exist in Linus' 
tree.

