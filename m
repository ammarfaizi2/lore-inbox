Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131875AbQLVLEx>; Fri, 22 Dec 2000 06:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131878AbQLVLEn>; Fri, 22 Dec 2000 06:04:43 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:50577 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131875AbQLVLEd>; Fri, 22 Dec 2000 06:04:33 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>
Cc: Zdenek Kabelac <kabi@informatics.muni.cz>,
        Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org,
        Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Re: Oops with 2.4.0-test13pre3 - swapoff
In-Reply-To: <Pine.LNX.4.21.0012211500500.2199-100000@freak.distro.conectiva>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.21.0012211500500.2199-100000@freak.distro.conectiva>
Message-ID: <m3r930ycgm.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 22 Dec 2000 11:31:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> Christoph is already looking at it and should have a fix soon.

Here it comes against 13-pre4 ...

We cannot call delete_from_swap_cache, it was called already in
try_to_unuse.

There is still a race when we page in the page which is
just freed in try_to_unuse. I am not sure how to fix this.

Also the add_to_page_cache forgot the offset  :-(

Greetings
                Christoph

--- 4-13-4/mm/shmem.c	Fri Dec 22 10:05:38 2000
+++ m4-13-4/mm/shmem.c	Fri Dec 22 10:47:11 2000
@@ -761,14 +761,16 @@
 	swp_entry_t **base, **ptr;
 	unsigned long idx;
 	int offset;
+	struct shmem_inode_info *info = &inode->u.shmem_i;
 	
 	idx = 0;
-	if ((offset = shmem_clear_swp (entry, inode->u.shmem_i.i_direct, SHMEM_NR_DIRECT)) >= 0)
+	spin_lock (&info->lock);
+	if ((offset = shmem_clear_swp (entry,info->i_direct, SHMEM_NR_DIRECT)) >= 0)
 		goto found;
 
 	idx = SHMEM_NR_DIRECT;
-	if (!(base = inode->u.shmem_i.i_indirect))
-		return 0;
+	if (!(base = info->i_indirect))
+		goto out;
 
 	for (ptr = base; ptr < base + ENTRIES_PER_PAGE; ptr++) {
 		if (*ptr &&
@@ -776,16 +778,16 @@
 			goto found;
 		idx += ENTRIES_PER_PAGE;
 	}
+out:
+	spin_unlock (&info->lock);
 	return 0;
 found:
-	delete_from_swap_cache (page);
-	add_to_page_cache (page, inode->i_mapping, idx);
+	add_to_page_cache (page, inode->i_mapping, offset + idx);
 	SetPageDirty (page);
 	SetPageUptodate (page);
 	UnlockPage (page);
-	spin_lock (&inode->u.shmem_i.lock);
-	inode->u.shmem_i.swapped--;
-	spin_unlock (&inode->u.shmem_i.lock);
+	info->swapped--;
+	spin_unlock (&info->lock);
 	return 1;
 }
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
