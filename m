Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWDQART@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWDQART (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 20:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWDQART
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 20:17:19 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:8618 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750860AbWDQART (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 20:17:19 -0400
Date: Mon, 17 Apr 2006 09:18:30 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
Message-Id: <20060417091830.bca60006.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0604151040450.25886@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
	<20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
	<20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
	<20060415090639.dde469e8.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604151040450.25886@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Apr 2006 10:41:59 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> Note that there is an issue with your approach. If a migration entry is 
> copied during fork then SWP_MIGRATION_WRITE must become SWP_MIGRATION_READ 
> for some cases. Would you look into fixing this?
> 

Thank you for pointing out the issue.

In my understanding, copy_page_range() is used at fork().
This finally calls copy_one_pte() and copies ptes one by one.

Maybe, I'll do like this.
==
 438         if (unlikely(!pte_present(pte)) {
 439                 if (!pte_file(pte)) {
 440                         swap_duplicate(pte_to_swp_entry(pte));
 			     entry = pte_to_swp_entry(pte);
#ifdef CONFIG_MIGRATION
			     if (is_migration_entry(entry)) {
				......always copy as MIGRATION_READ.
			     }
#endif
 441                         /* make sure dst_mm is on swapoff's mmlist. */
 442                         if (unlikely(list_empty(&dst_mm->mmlist))) {
 443                                 spin_lock(&mmlist_lock);
 444                                 if (list_empty(&dst_mm->mmlist))
 445                                         list_add(&dst_mm->mmlist,
 446                                                  &src_mm->mmlist);
 447                                 spin_unlock(&mmlist_lock);
 448                         }
 449                 }
 450                 goto out_set_pte;
 451         }
==

Thanks,
-Kame

