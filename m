Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317112AbSGCSCS>; Wed, 3 Jul 2002 14:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSGCSCR>; Wed, 3 Jul 2002 14:02:17 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:50705 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S317112AbSGCSCP>; Wed, 3 Jul 2002 14:02:15 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Matthew Wilcox <willy@debian.org>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use list_* functions better in dcache.c 
cc: pmenage@ensim.com
In-reply-to: Your message of "Wed, 03 Jul 2002 17:02:11 BST."
             <20020703170211.N27706@parcelfarce.linux.theplanet.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jul 2002 11:04:21 -0700
Message-Id: <E17PoUH-00065L-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>@@ -382,42 +389,18 @@ void prune_dcache(int count)
> 
> void shrink_dcache_sb(struct super_block * sb)
> {
>-	struct list_head *tmp, *next;
>-	struct dentry *dentry;
>-
>-	/*
>-	 * Pass one ... move the dentries for the specified
>-	 * superblock to the most recent end of the unused list.
>-	 */
>-	spin_lock(&dcache_lock);

Oops - you're walking dentry_unused without holding dcache_lock ...

>-	next = dentry_unused.next;
>-	while (next != &dentry_unused) {
>-		tmp = next;
>-		next = tmp->next;
>-		dentry = list_entry(tmp, struct dentry, d_lru);
>-		if (dentry->d_sb != sb)
>-			continue;
>-		list_del(tmp);
>-		list_add(tmp, &dentry_unused);
>-	}
>-
>-	/*
>-	 * Pass two ... free the dentries for this superblock.
>-	 */
>-repeat:
>-	next = dentry_unused.next;
>-	while (next != &dentry_unused) {
>-		tmp = next;
>-		next = tmp->next;
>-		dentry = list_entry(tmp, struct dentry, d_lru);
>+	struct list_head *entry, *next;
>+	
>+	list_for_each_safe(entry, next, &dentry_unused) {
>+		struct dentry *dentry = list_entry(entry, struct dentry, d_lru);
> 		if (dentry->d_sb != sb)

