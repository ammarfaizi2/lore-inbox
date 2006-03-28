Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWC1DCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWC1DCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 22:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWC1DCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 22:02:31 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41182 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751212AbWC1DCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 22:02:31 -0500
Date: Mon, 27 Mar 2006 18:58:09 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Yinghai Lu <yinghai.lu@amd.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: migrate_pages_to not defined ...
In-Reply-To: <86802c440603271826s684cf1dcj24acce894bdd0260@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0603271855230.6010@schroedinger.engr.sgi.com>
References: <86802c440603271826s684cf1dcj24acce894bdd0260@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2006, Yinghai Lu wrote:

> please check the migrate)pages_to in migrate.h...
> otherwise  I can not compile the kernel if i disable the swap in config.

Right. migrate_pages_to in mempolicy.cis also called from mbind() outside 
of CONFIG_MIGRATION sigh.

> +static inline int migrate_pages_to(struct list_head *pagelist,
> +                        struct vm_area_struct *vma, int dest) {
> return -ENOSYS; }

No it needs to return the number of pages not ENOSYS.

> diff --git a/mm/migrate.c b/mm/migrate.c
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -653,3 +653,4 @@ out:
>                 nr_pages++;
>         return nr_pages;
>  }
> +EXPORT_SYMBOL(migrate_pages_to);

Why add an export?

Could you try this patch?



Fix migrate_pages_to() definition.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6/include/linux/migrate.h
===================================================================
--- linux-2.6.orig/include/linux/migrate.h	2006-03-22 09:29:49.000000000 -0800
+++ linux-2.6/include/linux/migrate.h	2006-03-27 18:33:52.000000000 -0800
@@ -12,7 +12,7 @@ extern void migrate_page_copy(struct pag
 extern int migrate_page_remove_references(struct page *, struct page *, int);
 extern int migrate_pages(struct list_head *l, struct list_head *t,
 		struct list_head *moved, struct list_head *failed);
-int migrate_pages_to(struct list_head *pagelist,
+extern int migrate_pages_to(struct list_head *pagelist,
 			struct vm_area_struct *vma, int dest);
 extern int fail_migrate_page(struct page *, struct page *);
 
@@ -26,6 +26,9 @@ static inline int putback_lru_pages(stru
 static inline int migrate_pages(struct list_head *l, struct list_head *t,
 	struct list_head *moved, struct list_head *failed) { return -ENOSYS; }
 
+static int migrate_pages_to(struct list_head *pagelist,
+			struct vm_area_struct *vma, int dest) { return 0; }
+
 static inline int migrate_prep(void) { return -ENOSYS; }
 
 /* Possible settings for the migrate_page() method in address_operations */

