Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWF0HWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWF0HWf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030741AbWF0HUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:20:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:61862 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030740AbWF0HU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:20:28 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:20:22 +1000
Message-Id: <1060627072022.26697@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 009 of 14] knfsd: svcrpc: gss: simplify rsc_parse()
References: <20060627171533.26405.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: J. Bruce Fields <bfields@citi.umich.edu>


Adopt a simpler convention for gss_mech_put(), to simplify rsc_parse().

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

### Diffstat output
 ./net/sunrpc/auth_gss/gss_mech_switch.c |    6 +++---
 ./net/sunrpc/auth_gss/svcauth_gss.c     |   12 ++++--------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff .prev/net/sunrpc/auth_gss/gss_mech_switch.c ./net/sunrpc/auth_gss/gss_mech_switch.c
--- .prev/net/sunrpc/auth_gss/gss_mech_switch.c	2006-06-27 14:59:44.000000000 +1000
+++ ./net/sunrpc/auth_gss/gss_mech_switch.c	2006-06-27 14:59:44.000000000 +1000
@@ -224,7 +224,8 @@ EXPORT_SYMBOL(gss_service_to_auth_domain
 void
 gss_mech_put(struct gss_api_mech * gm)
 {
-	module_put(gm->gm_owner);
+	if (gm)
+		module_put(gm->gm_owner);
 }
 
 EXPORT_SYMBOL(gss_mech_put);
@@ -307,8 +308,7 @@ gss_delete_sec_context(struct gss_ctx	**
 		(*context_handle)->mech_type->gm_ops
 			->gss_delete_sec_context((*context_handle)
 							->internal_ctx_id);
-	if ((*context_handle)->mech_type)
-		gss_mech_put((*context_handle)->mech_type);
+	gss_mech_put((*context_handle)->mech_type);
 	kfree(*context_handle);
 	*context_handle=NULL;
 	return GSS_S_COMPLETE;

diff .prev/net/sunrpc/auth_gss/svcauth_gss.c ./net/sunrpc/auth_gss/svcauth_gss.c
--- .prev/net/sunrpc/auth_gss/svcauth_gss.c	2006-06-27 14:59:44.000000000 +1000
+++ ./net/sunrpc/auth_gss/svcauth_gss.c	2006-06-27 14:59:44.000000000 +1000
@@ -425,6 +425,7 @@ static int rsc_parse(struct cache_detail
 	struct rsc rsci, *rscp = NULL;
 	time_t expiry;
 	int status = -EINVAL;
+	struct gss_api_mech *gm = NULL;
 
 	memset(&rsci, 0, sizeof(rsci));
 	/* context handle */
@@ -453,7 +454,6 @@ static int rsc_parse(struct cache_detail
 		set_bit(CACHE_NEGATIVE, &rsci.h.flags);
 	else {
 		int N, i;
-		struct gss_api_mech *gm;
 
 		/* gid */
 		if (get_int(&mesg, &rsci.cred.cr_gid))
@@ -488,21 +488,17 @@ static int rsc_parse(struct cache_detail
 		status = -EINVAL;
 		/* mech-specific data: */
 		len = qword_get(&mesg, buf, mlen);
-		if (len < 0) {
-			gss_mech_put(gm);
+		if (len < 0)
 			goto out;
-		}
 		status = gss_import_sec_context(buf, len, gm, &rsci.mechctx);
-		if (status) {
-			gss_mech_put(gm);
+		if (status)
 			goto out;
-		}
-		gss_mech_put(gm);
 	}
 	rsci.h.expiry_time = expiry;
 	rscp = rsc_update(&rsci, rscp);
 	status = 0;
 out:
+	gss_mech_put(gm);
 	rsc_free(&rsci);
 	if (rscp)
 		cache_put(&rscp->h, &rsc_cache);
