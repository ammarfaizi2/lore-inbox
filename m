Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161183AbWI2GCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161183AbWI2GCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161419AbWI2GB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:01:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:41162 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161183AbWI2GB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:01:59 -0400
Date: Fri, 29 Sep 2006 08:01:55 +0200
From: Olaf Kirch <okir@suse.de>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 002 of 8] knfsd: lockd: fix refount on nsm.
Message-ID: <20060929060155.GB2852@suse.de>
References: <20060929130518.23919.patches@notabene> <1060929030845.24038@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060929030845.24038@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 01:08:45PM +1000, NeilBrown wrote:
> If nlm_lookup_host finds what it is looking for
> it exits with an extra reference on the matching
> 'nsm' structure.
> So don't actually count the reference until we are
> (fairly) sure it is going to be used.
> 
> Signed-off-by: Neil Brown <neilb@suse.de>

Correct, even though I would have done it slightly differently. The if()
is not needed anymore, and there's another if (nsm) two lines down.

Olaf

 fs/lockd/host.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

Index: build/fs/lockd/host.c
===================================================================
--- build.orig/fs/lockd/host.c
+++ build/fs/lockd/host.c
@@ -109,9 +109,9 @@ nlm_lookup_host(int server, const struct
 		if (!nlm_cmp_addr(&host->h_addr, sin))
 			continue;
 
-		/* See if we have an NSM handle for this client */
-		if (!nsm && (nsm = host->h_nsmhandle) != 0)
-			atomic_inc(&nsm->sm_count);
+		/* Stash away the NSM handle in case we need
+		 * to create a new host entry. */
+		nsm = host->h_nsmhandle;
 
 		if (host->h_proto != proto)
 			continue;
@@ -133,7 +133,9 @@ nlm_lookup_host(int server, const struct
 	/* Sadly, the host isn't in our hash table yet. See if
 	 * we have an NSM handle for it. If not, create one.
 	 */
-	if (!nsm && !(nsm = nsm_find(sin, hostname, hostname_len)))
+	if (nsm != NULL)
+		atomic_inc(&nsm->sm_count);
+	else if (!(nsm = nsm_find(sin, hostname, hostname_len)))
 		goto out;
 
 	if (!(host = (struct nlm_host *) kmalloc(sizeof(*host), GFP_KERNEL))) {

-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax
