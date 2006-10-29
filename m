Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbWJ2Nhy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbWJ2Nhy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 08:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWJ2Nhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 08:37:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:19053 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965220AbWJ2Nhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 08:37:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EIfKd0eLcKVlDdaTyzHrEn1A54UqtvPPrOV/KG9Yg5SIlbPiiKRJpv+c0UpThO1BK+qG/YJnJCxIyLqNTwkMznV9MvQc2wR+1l3eOJSqv5wpO+rAPXgGrSruY+qFC//Y/tTEHnWHSyApbRxa+T0G2TWwUlmSuTjmMjAW8w7FB64=
Date: Sun, 29 Oct 2006 22:38:16 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Olaf Kirch <okir@monad.swb.de>
Subject: [PATCH 2/2] auth_gss: unregister gss_domain when unloading module
Message-ID: <20061029133816.GB10295@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Andy Adamson <andros@citi.umich.edu>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Olaf Kirch <okir@monad.swb.de>
References: <20061028185554.GM9973@localhost> <20061029133551.GA10072@localhost> <20061029133700.GA10295@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061029133700.GA10295@localhost>
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
modules.

- Define svcauth_gss_unregister_pseudoflavor()
  (doing the opposite of svcauth_gss_register_pseudoflavor())

- Call svcauth_gss_unregister_pseudoflavor() in gss_mech_free()

Cc: Andy Adamson <andros@citi.umich.edu>
Cc: J. Bruce Fields <bfields@citi.umich.edu>
Cc: Trond Myklebust <Trond.Myklebust@netapp.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 net/sunrpc/auth_gss/gss_mech_switch.c |    4 ++++
 net/sunrpc/auth_gss/svcauth_gss.c     |    6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

Index: work-fault-inject/net/sunrpc/auth_gss/gss_mech_switch.c
===================================================================
--- work-fault-inject.orig/net/sunrpc/auth_gss/gss_mech_switch.c
+++ work-fault-inject/net/sunrpc/auth_gss/gss_mech_switch.c
@@ -60,6 +60,9 @@ gss_mech_free(struct gss_api_mech *gm)
 
 	for (i = 0; i < gm->gm_pf_num; i++) {
 		pf = &gm->gm_pfs[i];
+		if (!pf->auth_domain_name)
+			continue;
+		svcauth_gss_unregister_pseudoflavor(pf->auth_domain_name);
 		kfree(pf->auth_domain_name);
 		pf->auth_domain_name = NULL;
 	}
@@ -93,8 +96,11 @@ gss_mech_svc_setup(struct gss_api_mech *
 			goto out;
 		status = svcauth_gss_register_pseudoflavor(pf->pseudoflavor,
 							pf->auth_domain_name);
-		if (status)
+		if (status) {
+			kfree(pf->auth_domain_name);
+			pf->auth_domain_name = NULL;
 			goto out;
+		}
 	}
 	return 0;
 out:
Index: work-fault-inject/net/sunrpc/auth_gss/svcauth_gss.c
===================================================================
--- work-fault-inject.orig/net/sunrpc/auth_gss/svcauth_gss.c
+++ work-fault-inject/net/sunrpc/auth_gss/svcauth_gss.c
@@ -765,10 +765,12 @@ svcauth_gss_register_pseudoflavor(u32 ps
 
 	test = auth_domain_lookup(name, &new->h);
 	if (test != &new->h) { /* XXX Duplicate registration? */
-		auth_domain_put(&new->h);
-		/* dangling ref-count... */
-		goto out;
+		WARN_ON(1);
+		stat = -EBUSY;
+		kfree(new->h.name);
+		goto out_free_dom;
 	}
+	auth_domain_put(&new->h);
 	return 0;
 
 out_free_dom:
@@ -779,6 +781,19 @@ out:
 
 EXPORT_SYMBOL(svcauth_gss_register_pseudoflavor);
 
+void svcauth_gss_unregister_pseudoflavor(char *name)
+{
+	struct auth_domain *dom;
+
+	dom = auth_domain_find(name);
+	if (dom) {
+		auth_domain_put(dom);
+		auth_domain_put(dom);
+	}
+}
+
+EXPORT_SYMBOL(svcauth_gss_unregister_pseudoflavor);
+
 static inline int
 read_u32_from_xdr_buf(struct xdr_buf *buf, int base, u32 *obj)
 {
Index: work-fault-inject/include/linux/sunrpc/svcauth_gss.h
===================================================================
--- work-fault-inject.orig/include/linux/sunrpc/svcauth_gss.h
+++ work-fault-inject/include/linux/sunrpc/svcauth_gss.h
@@ -22,6 +22,7 @@
 int gss_svc_init(void);
 void gss_svc_shutdown(void);
 int svcauth_gss_register_pseudoflavor(u32 pseudoflavor, char * name);
+void svcauth_gss_unregister_pseudoflavor(char *name);
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_SUNRPC_SVCAUTH_GSS_H */
