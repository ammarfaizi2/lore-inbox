Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbUKODtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbUKODtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 22:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbUKODrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 22:47:35 -0500
Received: from ozlabs.org ([203.10.76.45]:54451 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261485AbUKODrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 22:47:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16792.10140.445933.617107@cargo.ozlabs.ibm.com>
Date: Mon, 15 Nov 2004 14:50:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: linux-ppp@vger.kernel.org
Subject: [PATCH] Multilink fix for ppp_generic.c
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I released ppp-2.4.3 yesterday, with much improved support for
multilink operation - when the first link is terminated, its pppd no
longer exits immediately, but keeps running in order to keep the ppp
interface up while there are other links still in the bundle.

However, this shows up a bug in the kernel ppp driver, which is that
there is no way for the pppd controlling the bundle to know when the
last link in the bundle is terminated.  This patch provides such a
way: with this patch, pppd will get an EOF when reading from the
/dev/ppp instance for the bundle when there are no channels connected.

Andrew, could this be considered for inclusion in 2.6.10 please?  The
change does not affect older versions of pppd or normal non-multilink
operation (I have tested to make sure of that).

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/drivers/net/ppp_generic.c pmac-2.5/drivers/net/ppp_generic.c
--- linux-2.5/drivers/net/ppp_generic.c	2004-10-29 07:03:21.000000000 +1000
+++ pmac-2.5/drivers/net/ppp_generic.c	2004-11-15 08:53:54.000000000 +1100
@@ -19,7 +19,7 @@
  * PPP driver, written by Michael Callahan and Al Longyear, and
  * subsequently hacked by Paul Mackerras.
  *
- * ==FILEVERSION 20020217==
+ * ==FILEVERSION 20041108==
  */
 
 #include <linux/config.h>
@@ -412,6 +412,17 @@
 		ret = 0;
 		if (pf->dead)
 			break;
+		if (pf->kind == INTERFACE) {
+			/*
+			 * Return 0 (EOF) on an interface that has no
+			 * channels connected, unless it is looping
+			 * network traffic (demand mode).
+			 */
+			struct ppp *ppp = PF_TO_PPP(pf);
+			if (ppp->n_channels == 0
+			    && (ppp->flags & SC_LOOP_TRAFFIC) == 0)
+				break;
+		}
 		ret = -EAGAIN;
 		if (file->f_flags & O_NONBLOCK)
 			break;
@@ -491,6 +502,14 @@
 		mask |= POLLIN | POLLRDNORM;
 	if (pf->dead)
 		mask |= POLLHUP;
+	else if (pf->kind == INTERFACE) {
+		/* see comment in ppp_read */
+		struct ppp *ppp = PF_TO_PPP(pf);
+		if (ppp->n_channels == 0
+		    && (ppp->flags & SC_LOOP_TRAFFIC) == 0)
+			mask |= POLLIN | POLLRDNORM;
+	}
+				
 	return mask;
 }
 
@@ -2559,7 +2578,8 @@
 		/* remove it from the ppp unit's list */
 		ppp_lock(ppp);
 		list_del(&pch->clist);
-		--ppp->n_channels;
+		if (--ppp->n_channels == 0)
+			wake_up_interruptible(&ppp->file.rwait);
 		ppp_unlock(ppp);
 		if (atomic_dec_and_test(&ppp->file.refcnt))
 			ppp_destroy_interface(ppp);
