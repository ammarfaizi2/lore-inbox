Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269817AbUJGMzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269817AbUJGMzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269715AbUJGMw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:52:59 -0400
Received: from ns.sysgo.de ([213.68.67.98]:18088 "EHLO mailgate.sysgo.de")
	by vger.kernel.org with ESMTP id S269714AbUJGMvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:51:43 -0400
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: Robert Love <rml@novell.com>
Subject: [BUG][PPC32] Preemption patch for 2.4 Kernels
Date: Thu, 7 Oct 2004 14:51:27 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, linuxppc-devel@ozlabs.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PvTZBtNCbg+hJJh"
Message-Id: <200410071451.27500.g.jaeger@sysgo.com>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.28.0.3; VDF: 6.28.0.5; host: mailgate.sysgo.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_PvTZBtNCbg+hJJh
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert,

maybe the 2.4 series is somewhat outdatet, but nevertheless used in
several embedded systems and also with your preemption patches.
During some investigations, we found out that the patches found on 
http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/
contain a severe bug, when using the patches on PPC systems. 
The affected function is get_pgd_fast() which is buried in
include/asm-ppc/pgalloc.h

While the original function looks like:
extern __inline__ pgd_t *get_pgd_fast(void)
{
        unsigned long *ret;

        if ((ret = pgd_quicklist) != NULL) {
                pgd_quicklist = (unsigned long *)(*ret);
                ret[0] = 0;
                pgtable_cache_size--;
        } else
                ret = (unsigned long *)get_pgd_slow();
        return (pgd_t *)ret;
}

the patched one is:
extern __inline__ pgd_t *get_pgd_fast(void)
{
        unsigned long *ret;

        preempt_disable();
        if ((ret = pgd_quicklist) != NULL) {
                pgd_quicklist = (unsigned long *)(*ret);
                ret[0] = 0;
                pgtable_cache_size--;
                preempt_enable();
        } else 
                preempt_enable();
                ret = (unsigned long *)get_pgd_slow();
        return (pgd_t *)ret;
}

And exactly the "else" path causes the problems ;) I guess it should be

       } else {
                preempt_enable();
                ret = (unsigned long *)get_pgd_slow();
       }

The attached patch will do it the right way, and you might want to correct
the patches on your web-space.

Best regards,
  Gerhard Jaeger

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com

--Boundary-00=_PvTZBtNCbg+hJJh
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="pgalloc.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pgalloc.h.diff"

--- pgalloc.h.orig	2003-11-28 19:26:21.000000000 +0100
+++ pgalloc.h	2004-10-07 14:41:28.000000000 +0200
@@ -72,20 +72,26 @@ extern __inline__ pgd_t *get_pgd_fast(vo
 {
         unsigned long *ret;
 
+	preempt_disable();
         if ((ret = pgd_quicklist) != NULL) {
                 pgd_quicklist = (unsigned long *)(*ret);
                 ret[0] = 0;
                 pgtable_cache_size--;
-        } else
+		preempt_enable();
+        } else {
+		preempt_enable();
                 ret = (unsigned long *)get_pgd_slow();
+        }
         return (pgd_t *)ret;
 }
 
 extern __inline__ void free_pgd_fast(pgd_t *pgd)
 {
+	preempt_disable();
         *(unsigned long **)pgd = pgd_quicklist;
         pgd_quicklist = (unsigned long *) pgd;
         pgtable_cache_size++;
+	preempt_enable();
 }
 
 extern __inline__ void free_pgd_slow(pgd_t *pgd)
@@ -124,19 +130,23 @@ static inline pte_t *pte_alloc_one_fast(
 {
         unsigned long *ret;
 
+	preempt_disable();
         if ((ret = pte_quicklist) != NULL) {
                 pte_quicklist = (unsigned long *)(*ret);
                 ret[0] = 0;
                 pgtable_cache_size--;
 	}
+	preempt_enable();
         return (pte_t *)ret;
 }
 
 extern __inline__ void pte_free_fast(pte_t *pte)
 {
+	preempt_disable();
         *(unsigned long **)pte = pte_quicklist;
         pte_quicklist = (unsigned long *) pte;
         pgtable_cache_size++;
+	preempt_enable();
 }
 
 extern __inline__ void pte_free_slow(pte_t *pte)

--Boundary-00=_PvTZBtNCbg+hJJh--

