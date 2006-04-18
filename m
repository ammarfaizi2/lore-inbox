Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWDRG7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWDRG7M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 02:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWDRG7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 02:59:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:28349 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932260AbWDRG7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 02:59:10 -0400
Date: Mon, 17 Apr 2006 23:58:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
In-Reply-To: <20060418123256.41eb56af.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.64.0604172353570.4352@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
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
 <Pine.LNX.4.64.0604172011490.3624@schroedinger.engr.sgi.com>
 <20060418123256.41eb56af.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm... Good ideas. I think it could be much simpler like the following 
patch.

However, the problem here is how to know that we really took the anon_vma 
lock and what to do about a page being unmmapped while migrating. This 
could cause the anon_vma not to be unlocked.

I guess we would need to have try_to_unmap return some state information.
I also toyed around with writing an "install_migration_ptes" function 
which would be called only for anonymous pages and would reduce the 
changes to try_to_unmap(). However, that also got too complicated.

Index: linux-2.6.17-rc1-mm2/mm/migrate.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/migrate.c	2006-04-17 17:21:08.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/migrate.c	2006-04-17 23:53:32.000000000 -0700
@@ -236,7 +233,6 @@ static void remove_migration_ptes(struct
 	 * We hold the mmap_sem lock. So no need to call page_lock_anon_vma.
 	 */
 	anon_vma = (struct anon_vma *) (mapping - PAGE_MAPPING_ANON);
-	spin_lock(&anon_vma->lock);
 
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node)
 		remove_migration_pte(vma, page_address_in_vma(new, vma),
Index: linux-2.6.17-rc1-mm2/mm/rmap.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/rmap.c	2006-04-17 17:21:08.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/rmap.c	2006-04-17 23:53:39.000000000 -0700
@@ -723,7 +723,8 @@ static int try_to_unmap_anon(struct page
 		if (ret == SWAP_FAIL || !page_mapped(page))
 			break;
 	}
-	spin_unlock(&anon_vma->lock);
+	if (!migration)
+		spin_unlock(&anon_vma->lock);
 	return ret;
 }
 
