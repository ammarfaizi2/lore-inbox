Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132633AbRDOMZK>; Sun, 15 Apr 2001 08:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbRDOMZA>; Sun, 15 Apr 2001 08:25:00 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:1731 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132633AbRDOMYs>; Sun, 15 Apr 2001 08:24:48 -0400
From: Christoph Rohland <cr@sap.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: shmem_getpage_locked() / swapin_readahead() race in 2.4.4-pre3
In-Reply-To: <Pine.LNX.4.21.0104141244510.1786-100000@freak.distro.conectiva>
Organisation: SAP LinuxLab
Message-ID: <m3zodiqt1v.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: 15 Apr 2001 13:54:08 +0200
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

On Sat, 14 Apr 2001, Marcelo Tosatti wrote:
> There is a nasty race between shmem_getpage_locked() and
> swapin_readahead() with the new shmem code (introduced in 2.4.3-ac3
> and merged in the main tree in 2.4.4-pre3):
> 
> shmem_getpage_locked() finds a page in the swapcache and moves it to
> the pagecache as an shmem page, freeing the swapcache and the swap
> map entry for this page. (which causes a BUG() in mm/shmem.c:353
> since the swap map entry is being used)
> 
> In the meanwhile, swapin_readahead() is allocating a page and adding
> it to the swapcache.

Oh, I was just chasing this also. 

> I don't see any clean fix for this one.

I think the actual check for swap_count is not necessary: If
swapin_readahead allocates a new swap_cache page for the entry, that's
not a real bug. On memory pressure this page will be reclaimed.

Actually we have to make shmem much more unfriendly to the swap cache
to make it correct: I think we have to drop the whole drop swap cache
pages on truncate logic since it uses lookup_swap_cache and
delete_from_swap_cache which both lock the page, while holding a
spinlock :-(

The appended patch implements both changes and relies on the page
stealer to shrink the swap cache. 

It also integrates fixes which Marcelo did send earlier.

Greetings
		Christoph


--=-=-=
Content-Disposition: attachment; filename=patch-2.4.4-tmpfs-fixes

--- 2.4.4-pre3/mm/shmem.c	Sat Apr 14 11:12:54 2001
+++ u2.4.3/mm/shmem.c	Sun Apr 15 13:45:58 2001
@@ -123,10 +123,19 @@
 		entry = *ptr;
 		*ptr = (swp_entry_t){0};
 		freed++;
+#if 0
+                /*
+		 * This does not work since it may sleep while holding
+		 * a spinlock 
+		 *
+		 * We rely on the page stealer to free up the
+		 * allocated swap space later
+		 */
 		if ((page = lookup_swap_cache(entry)) != NULL) {
 			delete_from_swap_cache(page);
 			page_cache_release(page);	
 		}
+#endif
 		swap_free (entry);
 	}
 	return freed;
@@ -236,8 +245,10 @@
 	
 	/* Only move to the swap cache if there are no other users of
 	 * the page. */
-	if (atomic_read(&page->count) > 2)
-		goto out;
+	if (atomic_read(&page->count) > 2){
+		set_page_dirty(page);
+ 		goto out;
+	}
 	
 	inode = page->mapping->host;
 	info = &inode->u.shmem_i;
@@ -348,9 +359,6 @@
 		if (TryLockPage(page)) 
 			goto wait_retry;
 
-		if (swap_count(page) > 2)
-			BUG();
-		
 		swap_free(*entry);
 		*entry = (swp_entry_t) {0};
 		delete_from_swap_cache_nolock(page);
@@ -432,6 +440,7 @@
 		*ptr = NOPAGE_SIGBUS;
 	return error;
 sigbus:
+	up (&inode->i_sem);
 	*ptr = NOPAGE_SIGBUS;
 	return -EFAULT;
 }

--=-=-=--

