Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTEDMWX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 08:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbTEDMWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 08:22:23 -0400
Received: from dp.samba.org ([66.70.73.150]:53670 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263587AbTEDMWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 08:22:19 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16053.2247.905824.83736@argo.ozlabs.ibm.com>
Date: Sun, 4 May 2003 22:34:15 +1000
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] module owners for ppp compressors
X-Mailer: VM 7.14 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

The patch below cleans up the module refcounting for the PPP
compressor modules, i.e., ppp_deflate.c and bsd-comp.c.  I added an
owner field to the ppp compressor struct, so that ppp_generic.c could
use try_module_get and module_put to make sure the compressor modules
stay loaded while they are being used.  Previously the modules
themselves did MOD_INC/DEC_USE_COUNT, which is racy of course.

Please send this on to Linus if you think it is OK.

Thanks,
Paul.

diff -urN linux-2.5/include/linux/ppp-comp.h pmac-2.5/include/linux/ppp-comp.h
--- linux-2.5/include/linux/ppp-comp.h	2002-02-06 04:39:40.000000000 +1100
+++ pmac-2.5/include/linux/ppp-comp.h	2003-05-02 15:53:05.000000000 +1000
@@ -42,6 +42,8 @@
 #ifndef _NET_PPP_COMP_H
 #define _NET_PPP_COMP_H
 
+struct module;
+
 /*
  * The following symbols control whether we include code for
  * various compression methods.
@@ -106,6 +108,9 @@
 
 	/* Return decompression statistics */
 	void	(*decomp_stat) (void *state, struct compstat *stats);
+
+	/* Used in locking compressor modules */
+	struct module *owner;
 };
 
 /*
diff -urN linux-2.5/drivers/net/bsd_comp.c pmac-2.5/drivers/net/bsd_comp.c
--- linux-2.5/drivers/net/bsd_comp.c	2002-07-16 03:03:14.000000000 +1000
+++ pmac-2.5/drivers/net/bsd_comp.c	2003-05-02 15:58:28.000000000 +1000
@@ -348,7 +348,6 @@
  * Finally release the structure itself.
  */
 	kfree (db);
-	MOD_DEC_USE_COUNT;
       }
   }
 
@@ -422,7 +421,6 @@
 	return NULL;
       }
 
-    MOD_INC_USE_COUNT;
 /*
  * If this is the compression buffer then there is no length data.
  */
@@ -1141,20 +1139,21 @@
  *************************************************************/
 
 static struct compressor ppp_bsd_compress = {
-    CI_BSD_COMPRESS,		/* compress_proto */
-    bsd_comp_alloc,		/* comp_alloc */
-    bsd_free,			/* comp_free */
-    bsd_comp_init,		/* comp_init */
-    bsd_reset,			/* comp_reset */
-    bsd_compress,		/* compress */
-    bsd_comp_stats,		/* comp_stat */
-    bsd_decomp_alloc,		/* decomp_alloc */
-    bsd_free,			/* decomp_free */
-    bsd_decomp_init,		/* decomp_init */
-    bsd_reset,			/* decomp_reset */
-    bsd_decompress,		/* decompress */
-    bsd_incomp,			/* incomp */
-    bsd_comp_stats		/* decomp_stat */
+	.compress_proto =	CI_BSD_COMPRESS,
+	.comp_alloc =		bsd_comp_alloc,
+	.comp_free =		bsd_free,
+	.comp_init =		bsd_comp_init,
+	.comp_reset =		bsd_reset,
+	.compress =		bsd_compress,
+	.comp_stat =		bsd_comp_stats,
+	.decomp_alloc =		bsd_decomp_alloc,
+	.decomp_free =		bsd_free,
+	.decomp_init =		bsd_decomp_init,
+	.decomp_reset =		bsd_reset,
+	.decompress =		bsd_decompress,
+	.incomp =		bsd_incomp,
+	.decomp_stat =		bsd_comp_stats,
+	.owner =		THIS_MODULE
 };
 
 /*************************************************************
diff -urN linux-2.5/drivers/net/ppp_deflate.c pmac-2.5/drivers/net/ppp_deflate.c
--- linux-2.5/drivers/net/ppp_deflate.c	2002-07-16 03:03:14.000000000 +1000
+++ pmac-2.5/drivers/net/ppp_deflate.c	2003-05-02 15:56:58.000000000 +1000
@@ -541,37 +541,39 @@
  * Procedures exported to if_ppp.c.
  */
 struct compressor ppp_deflate = {
-	CI_DEFLATE,		/* compress_proto */
-	z_comp_alloc,		/* comp_alloc */
-	z_comp_free,		/* comp_free */
-	z_comp_init,		/* comp_init */
-	z_comp_reset,		/* comp_reset */
-	z_compress,		/* compress */
-	z_comp_stats,		/* comp_stat */
-	z_decomp_alloc,		/* decomp_alloc */
-	z_decomp_free,		/* decomp_free */
-	z_decomp_init,		/* decomp_init */
-	z_decomp_reset,		/* decomp_reset */
-	z_decompress,		/* decompress */
-	z_incomp,		/* incomp */
-	z_comp_stats,		/* decomp_stat */
+	.compress_proto =	CI_DEFLATE,
+	.comp_alloc =		z_comp_alloc,
+	.comp_free =		z_comp_free,
+	.comp_init =		z_comp_init,
+	.comp_reset =		z_comp_reset,
+	.compress =		z_compress,
+	.comp_stat =		z_comp_stats,
+	.decomp_alloc =		z_decomp_alloc,
+	.decomp_free =		z_decomp_free,
+	.decomp_init =		z_decomp_init,
+	.decomp_reset =		z_decomp_reset,
+	.decompress =		z_decompress,
+	.incomp =		z_incomp,
+	.decomp_stat =		z_comp_stats,
+	.owner =		THIS_MODULE
 };
 
 struct compressor ppp_deflate_draft = {
-	CI_DEFLATE_DRAFT,	/* compress_proto */
-	z_comp_alloc,		/* comp_alloc */
-	z_comp_free,		/* comp_free */
-	z_comp_init,		/* comp_init */
-	z_comp_reset,		/* comp_reset */
-	z_compress,		/* compress */
-	z_comp_stats,		/* comp_stat */
-	z_decomp_alloc,		/* decomp_alloc */
-	z_decomp_free,		/* decomp_free */
-	z_decomp_init,		/* decomp_init */
-	z_decomp_reset,		/* decomp_reset */
-	z_decompress,		/* decompress */
-	z_incomp,		/* incomp */
-	z_comp_stats,		/* decomp_stat */
+	.compress_proto =	CI_DEFLATE_DRAFT,
+	.comp_alloc =		z_comp_alloc,
+	.comp_free =		z_comp_free,
+	.comp_init =		z_comp_init,
+	.comp_reset =		z_comp_reset,
+	.compress =		z_compress,
+	.comp_stat =		z_comp_stats,
+	.decomp_alloc =		z_decomp_alloc,
+	.decomp_free =		z_decomp_free,
+	.decomp_init =		z_decomp_init,
+	.decomp_reset =		z_decomp_reset,
+	.decompress =		z_decompress,
+	.incomp =		z_incomp,
+	.decomp_stat =		z_comp_stats,
+	.owner =		THIS_MODULE
 };
 
 int __init deflate_init(void)
diff -urN linux-2.5/drivers/net/ppp_generic.c pmac-2.5/drivers/net/ppp_generic.c
--- linux-2.5/drivers/net/ppp_generic.c	2003-03-21 19:48:22.000000000 +1100
+++ pmac-2.5/drivers/net/ppp_generic.c	2003-05-02 16:18:23.000000000 +1000
@@ -1955,10 +1955,6 @@
 #endif /* CONFIG_KMOD */
 	if (cp == 0)
 		goto out;
-	/*
-	 * XXX race: the compressor module could get unloaded between
-	 * here and when we do the comp_alloc or decomp_alloc call below.
-	 */
 
 	err = -ENOBUFS;
 	if (data.transmit) {
@@ -1971,10 +1967,13 @@
 			ppp->xcomp = cp;
 			ppp->xc_state = state;
 			ppp_xmit_unlock(ppp);
-			if (ostate != 0)
+			if (ostate != 0) {
 				ocomp->comp_free(ostate);
+				module_put(ocomp->owner);
+			}
 			err = 0;
-		}
+		} else
+			module_put(cp->owner);
 
 	} else {
 		state = cp->decomp_alloc(ccp_option, data.length);
@@ -1986,10 +1985,13 @@
 			ppp->rcomp = cp;
 			ppp->rc_state = state;
 			ppp_recv_unlock(ppp);
-			if (ostate != 0)
+			if (ostate != 0) {
 				ocomp->decomp_free(ostate);
+				module_put(ocomp->owner);
+			}
 			err = 0;
-		}
+		} else
+			module_put(cp->owner);
 	}
 
  out:
@@ -2100,10 +2102,14 @@
 	ppp->rc_state = 0;
 	ppp_unlock(ppp);
 
-	if (xstate)
+	if (xstate) {
 		xcomp->comp_free(xstate);
-	if (rstate)
+		module_put(xcomp->owner);
+	}
+	if (rstate) {
 		rcomp->decomp_free(rstate);
+		module_put(rcomp->owner);
+	}
 }
 
 /* List of compressors. */
@@ -2175,8 +2181,11 @@
 
 	spin_lock(&compressor_list_lock);
 	ce = find_comp_entry(type);
-	if (ce != 0)
+	if (ce != 0) {
 		cp = ce->comp;
+		if (!try_module_get(cp->owner))
+			cp = NULL;
+	}
 	spin_unlock(&compressor_list_lock);
 	return cp;
 }
