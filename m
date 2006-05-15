Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWEOT2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWEOT2i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWEOT2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:28:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:8414 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751210AbWEOT2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:28:37 -0400
Date: Mon, 15 May 2006 21:28:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: 2.6.17-rc4-mm1
Message-ID: <20060515192827.GA25066@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

>   - The cachefs patches are back (local-disk-based caching of network
>     filesystem files) (David Howells)

the blind hacks below are needed to make CONFIG_CACHEFILES build.

	Ingo

Index: linux/fs/cachefiles/cf-namei.c
===================================================================
--- linux.orig/fs/cachefiles/cf-namei.c
+++ linux/fs/cachefiles/cf-namei.c
@@ -124,31 +124,31 @@ try_again:
 	}
 
 	/* do the multiway lock magic */
-	trap = lock_rename(cache->graveyard, dir);
+	trap = lock_rename(cache->graveyard, dir, 0);
 
 	/* do some checks before getting the grave dentry */
 	if (rep->d_parent != dir) {
 		/* the entry was probably culled when we dropped the parent dir
 		 * lock */
-		unlock_rename(cache->graveyard, dir);
+		unlock_rename(cache->graveyard, dir, 0);
 		_leave(" = 0 [culled?]");
 		return 0;
 	}
 
 	if (!S_ISDIR(cache->graveyard->d_inode->i_mode)) {
-		unlock_rename(cache->graveyard, dir);
+		unlock_rename(cache->graveyard, dir, 0);
 		cachefiles_io_error(cache, "Graveyard no longer a directory");
 		return -EIO;
 	}
 
 	if (trap == rep) {
-		unlock_rename(cache->graveyard, dir);
+		unlock_rename(cache->graveyard, dir, 0);
 		cachefiles_io_error(cache, "May not make directory loop");
 		return -EIO;
 	}
 
 	if (d_mountpoint(rep)) {
-		unlock_rename(cache->graveyard, dir);
+		unlock_rename(cache->graveyard, dir, 0);
 		cachefiles_io_error(cache, "Mountpoint in cache");
 		return -EIO;
 	}
@@ -160,7 +160,7 @@ try_again:
 
 		grave = d_alloc(cache->graveyard, &name);
 		if (!grave) {
-			unlock_rename(cache->graveyard, dir);
+			unlock_rename(cache->graveyard, dir, 0);
 			_leave(" = -ENOMEM");
 			return -ENOMEM;
 		}
@@ -168,7 +168,7 @@ try_again:
 		alt = cache->graveyard->d_inode->i_op->lookup(
 			cache->graveyard->d_inode, grave, NULL);
 		if (IS_ERR(alt)) {
-			unlock_rename(cache->graveyard, dir);
+			unlock_rename(cache->graveyard, dir, 0);
 			dput(grave);
 
 			if (PTR_ERR(alt) == -ENOMEM) {
@@ -188,7 +188,7 @@ try_again:
 	}
 
 	if (grave->d_inode) {
-		unlock_rename(cache->graveyard, dir);
+		unlock_rename(cache->graveyard, dir, 0);
 		dput(grave);
 		grave = NULL;
 		cond_resched();
@@ -196,7 +196,7 @@ try_again:
 	}
 
 	if (d_mountpoint(grave)) {
-		unlock_rename(cache->graveyard, dir);
+		unlock_rename(cache->graveyard, dir, 0);
 		dput(grave);
 		cachefiles_io_error(cache, "Mountpoint in graveyard");
 		return -EIO;
@@ -204,7 +204,7 @@ try_again:
 
 	/* target should not be an ancestor of source */
 	if (trap == grave) {
-		unlock_rename(cache->graveyard, dir);
+		unlock_rename(cache->graveyard, dir, 0);
 		dput(grave);
 		cachefiles_io_error(cache, "May not make directory loop");
 		return -EIO;
@@ -231,7 +231,7 @@ try_again:
 
 	fsnotify_oldname_free(old_name);
 
-	unlock_rename(cache->graveyard, dir);
+	unlock_rename(cache->graveyard, dir, 0);
 	dput(grave);
 	_leave(" = 0");
 	return 0;
