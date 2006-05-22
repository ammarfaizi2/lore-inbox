Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964980AbWEVBT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbWEVBT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 21:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWEVBT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 21:19:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34237 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932384AbWEVBT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 21:19:57 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 22 May 2006 11:19:32 +1000
Message-Id: <1060522011932.2462@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: "david m. richter" <richterd@citi.umich.edu>
Subject: [PATCH] knfsd: Fix two problems that can cause rmmod nfsd to die.
References: <20060522111746.2437.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies to -mm and current -git and should go to Linus
before 2.6.17
Thanks.
NeilBrown

### Comments for Changeset

Both cause the 'entries' count in the export cache to be non-zero
at module removal time, so unregistering that cache fails and results
in an oops.

1/ exp_pseudoroot (used for NFSv4 only) leaks a reference to an export
   entry.
2/ sunrpc_cache_update doesn't increment the entries count when it adds
   an entry.

Thanks to "david m. richter" <richterd@citi.umich.edu> for triggering the
problem and finding one of the bugs.

Cc: "david m. richter" <richterd@citi.umich.edu>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/export.c   |    4 +++-
 ./net/sunrpc/cache.c |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff ./fs/nfsd/export.c~current~ ./fs/nfsd/export.c
--- ./fs/nfsd/export.c~current~	2006-05-22 10:55:44.000000000 +1000
+++ ./fs/nfsd/export.c	2006-05-22 10:59:40.000000000 +1000
@@ -1066,9 +1066,11 @@ exp_pseudoroot(struct auth_domain *clp, 
 		rv = nfserr_perm;
 	else if (IS_ERR(exp))
 		rv = nfserrno(PTR_ERR(exp));
-	else
+	else {
 		rv = fh_compose(fhp, exp,
 				fsid_key->ek_dentry, NULL);
+		exp_put(exp);
+	}
 	cache_put(&fsid_key->h, &svc_expkey_cache);
 	return rv;
 }

diff ./net/sunrpc/cache.c~current~ ./net/sunrpc/cache.c
--- ./net/sunrpc/cache.c~current~	2006-05-22 11:02:46.000000000 +1000
+++ ./net/sunrpc/cache.c	2006-05-22 11:03:15.000000000 +1000
@@ -159,6 +159,7 @@ struct cache_head *sunrpc_cache_update(s
 		detail->update(tmp, new);
 	tmp->next = *head;
 	*head = tmp;
+	detail->entries++;
 	cache_get(tmp);
 	is_new = cache_fresh_locked(tmp, new->expiry_time);
 	cache_fresh_locked(old, 0);
