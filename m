Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWDQRA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWDQRA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 13:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWDQRA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 13:00:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25728 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751161AbWDQRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 13:00:27 -0400
Date: Mon, 17 Apr 2006 10:00:02 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
In-Reply-To: <20060417091830.bca60006.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604170958100.29732@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
 <20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
 <20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
 <20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
 <20060415090639.dde469e8.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0604151040450.25886@schroedinger.engr.sgi.com>
 <20060417091830.bca60006.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006, KAMEZAWA Hiroyuki wrote:

> > Note that there is an issue with your approach. If a migration entry is 
> > copied during fork then SWP_MIGRATION_WRITE must become SWP_MIGRATION_READ 
> > for some cases. Would you look into fixing this?
> Thank you for pointing out the issue.
> 
> In my understanding, copy_page_range() is used at fork().
> This finally calls copy_one_pte() and copies ptes one by one.

Right this is one spot but the ptes in the original mm must also be marked 
read. Are there any additional races?

> Maybe, I'll do like this.
> ==
>  438         if (unlikely(!pte_present(pte)) {
>  439                 if (!pte_file(pte)) {
>  440                         swap_duplicate(pte_to_swp_entry(pte));
>  			     entry = pte_to_swp_entry(pte);
> #ifdef CONFIG_MIGRATION
> 			     if (is_migration_entry(entry)) {
> 				......always copy as MIGRATION_READ.
> 			     }
> #endif
>  441                         /* make sure dst_mm is on swapoff's mmlist. */

Looks okay for this one location.

