Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWJ1Szp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWJ1Szp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWJ1Szo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:55:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:37727 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932099AbWJ1Szg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:55:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=hU3Jj1HF5y7yD6fpJu+FH07kDmsfbTJiwoehs5NuBxrCvw9MQLONLdi1hug+Ja9PW5JmYDhP1Nr8AtY3bfp8UpggDWnMVieMJppN9uu1TSuRDDxVOq9MHSbFdLLEssIxa4xTeLGAMOeXINP48MwWaarOyQBoDNv4LfVxr32tDYU=
Date: Sun, 29 Oct 2006 03:55:54 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH] auth_gss: unregister gss_domain when unloading module
Message-ID: <20061028185554.GM9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Trond Myklebust <Trond.Myklebust@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reloading rpcsec_gss_krb5 or rpcsec_gss_spkm3 hit duplicate
registration in svcauth_gss_register_pseudoflavor().
(If DEBUG_PAGEALLOC is enabled, oops will happen at
auth_domain_put() --> hlist_del() with uninitialized hlist_node)

svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name)
{
	...

        test = auth_domain_lookup(name, &new->h);
        if (test != &new->h) { /* XXX Duplicate registration? */
                auth_domain_put(&new->h);
                /* dangling ref-count... */
	...
}

This patch unregisters gss_domain and free it when unloading
modules (rpcsec_gss_krb5 or rpcsec_gss_spkm3 module call
gss_mech_unregister())

Cc: Andy Adamson <andros@citi.umich.edu>
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 net/sunrpc/auth_gss/gss_mech_switch.c |    4 ++++
 net/sunrpc/auth_gss/svcauth_gss.c     |    6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

Index: work-fault-inject/net/sunrpc/auth_gss/gss_mech_switch.c
===================================================================
--- work-fault-inject.orig/net/sunrpc/auth_gss/gss_mech_switch.c
+++ work-fault-inject/net/sunrpc/auth_gss/gss_mech_switch.c
@@ -59,7 +59,11 @@ gss_mech_free(struct gss_api_mech *gm)
 	int i;
 
 	for (i = 0; i < gm->gm_pf_num; i++) {
+		struct auth_domain *dom;
+
 		pf = &gm->gm_pfs[i];
+		dom = auth_domain_find(pf->auth_domain_name);
+		auth_domain_put(dom);
 		kfree(pf->auth_domain_name);
 		pf->auth_domain_name = NULL;
 	}
Index: work-fault-inject/net/sunrpc/auth_gss/svcauth_gss.c
===================================================================
--- work-fault-inject.orig/net/sunrpc/auth_gss/svcauth_gss.c
+++ work-fault-inject/net/sunrpc/auth_gss/svcauth_gss.c
@@ -765,9 +765,9 @@ svcauth_gss_register_pseudoflavor(u32 ps
 
 	test = auth_domain_lookup(name, &new->h);
 	if (test != &new->h) { /* XXX Duplicate registration? */
-		auth_domain_put(&new->h);
-		/* dangling ref-count... */
-		goto out;
+		WARN_ON(1);
+		kfree(new->h.name);
+		goto out_free_dom;
 	}
 	return 0;
 
