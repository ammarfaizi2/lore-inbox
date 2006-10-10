Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWJJRRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWJJRRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWJJRQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:16:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:53641 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964816AbWJJRPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:15:38 -0400
Date: Tue, 10 Oct 2006 10:14:25 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Nikita Danilov <danilov@gmail.com>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/19] NFS: Fix a potential deadlock in nfs_release_page
Message-ID: <20061010171425.GC6339@kroah.com>
References: <20061010165621.394703368@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="nfs-fix-a-potential-deadlock-in-nfs_release_page.patch"
In-Reply-To: <20061010171350.GA6339@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Nikita Danilov <nikita@clusterfs.com>

nfs_wb_page() waits on request completion and, as a result, is not safe to be
called from nfs_release_page() invoked by VM scanner as part of GFP_NOFS
allocation. Fix possible deadlock by analyzing gfp mask and refusing to
release page if __GFP_FS is not set.

Signed-off-by: Nikita Danilov <danilov@gmail.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/nfs/file.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.17.13.orig/fs/nfs/file.c
+++ linux-2.6.17.13/fs/nfs/file.c
@@ -325,7 +325,13 @@ static void nfs_invalidate_page(struct p
 
 static int nfs_release_page(struct page *page, gfp_t gfp)
 {
-	return !nfs_wb_page(page->mapping->host, page);
+	if (gfp & __GFP_FS)
+		return !nfs_wb_page(page->mapping->host, page);
+	else
+		/*
+		 * Avoid deadlock on nfs_wait_on_request().
+		 */
+		return 0;
 }
 
 struct address_space_operations nfs_file_aops = {

--
