Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752072AbWJNFEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbWJNFEU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 01:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbWJNFEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 01:04:20 -0400
Received: from ns2.suse.de ([195.135.220.15]:30391 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752072AbWJNFET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 01:04:19 -0400
Date: Sat, 14 Oct 2006 07:04:18 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Neil Brown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Chris Mason <chris.mason@oracle.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/6] mm: fix pagecache write deadlocks
Message-ID: <20061014050418.GB23740@wotan.suse.de>
References: <20061013143516.15438.8802.sendpatchset@linux.site> <20061013143616.15438.77140.sendpatchset@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013143616.15438.77140.sendpatchset@linux.site>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 06:44:52PM +0200, Nick Piggin wrote:
> From: Andrew Morton <akpm@osdl.org> and Nick Piggin <npiggin@suse.de>
> 
> The idea is to modify the core write() code so that it won't take a pagefault
> while holding a lock on the pagecache page. There are a number of different
> deadlocks possible if we try to do such a thing:

Here is a patch to improve the comment a little. This is a pretty tricky
situation so we must be clear as to why it works.
--

Comment was not entirely clear about why we must eliminate all other
possibilities.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1946,12 +1946,19 @@ retry_noprogress:
 		if (!PageUptodate(page)) {
 			/*
 			 * If the page is not uptodate, we cannot allow a
-			 * partial commit_write, because that might expose
-			 * uninitialised data.
+			 * partial commit_write because when we unlock the
+			 * page below, someone else might bring it uptodate
+			 * and we lose our write. We cannot allow a full
+			 * commit_write, because that exposes uninitialised
+			 * data. We cannot zero the rest of the file and do
+			 * a full commit_write because that exposes transient
+			 * zeroes.
 			 *
-			 * We will enter the single-segment path below, which
-			 * should get the filesystem to bring the page
-			 * uputodate for us next time.
+			 * Abort the operation entirely with a zero length
+			 * commit_write. Retry.  We will enter the
+			 * single-segment path below, which should get the
+			 * filesystem to bring the page uputodate for us next
+			 * time.
 			 */
 			if (unlikely(copied != bytes))
 				copied = 0;
