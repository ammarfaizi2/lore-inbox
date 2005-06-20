Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVFTVx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVFTVx1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVFTVwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:52:17 -0400
Received: from coderock.org ([193.77.147.115]:50327 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261671AbVFTVtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:49:24 -0400
Message-Id: <20050620214915.305974000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:49:15 +0200
From: domen@coderock.org
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [patch 1/3] delete arch/arm26/boot/compressed/hw-bse.c
Content-Disposition: inline; filename=remove_file-arch_arm26_boot_compressed_hw_bse.c.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove nowhere referenced file. (egrep "filename\." didn't find anything)

Signed-off-by: Domen Puncer <domen@coderock.org>
---
 hw-bse.c |   74 ---------------------------------------------------------------
 1 files changed, 74 deletions(-)

Index: quilt/arch/arm26/boot/compressed/hw-bse.c
===================================================================
--- quilt.orig/arch/arm26/boot/compressed/hw-bse.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * Bright Star Engineering Inc.
- *
- * code for readng parameters from the
- * parameter blocks of the boot block
- * flash memory
- *
- */
-
-static int strcmp(const char *s1, const char *s2)
-{
-  while (*s1 != '\0' && *s1 == *s2)
-    {
-      s1++;
-      s2++;
-    }
-
-  return (*(unsigned char *) s1) - (*(unsigned char *) s2);
-}
-
-struct pblk_t {
-  char type;
-  unsigned short size;
-};
-
-static char *bse_getflashparam(char *name) {
-  unsigned int esize;
-  char *q,*r;
-  unsigned char *p,*e;
-  struct pblk_t *thepb = (struct pblk_t *) 0x00004000;
-  struct pblk_t *altpb = (struct pblk_t *) 0x00006000;  
-  if (thepb->type&1) {
-    if (altpb->type&1) {
-      /* no valid param block */ 
-      return (char*)0;
-    } else {
-      /* altpb is valid */
-      struct pblk_t *tmp;
-      tmp = thepb;
-      thepb = altpb;
-      altpb = tmp;
-    }
-  }
-  p = (char*)thepb + sizeof(struct pblk_t);
-  e = p + thepb->size; 
-  while (p < e) {
-    q = p;
-    esize = *p;
-    if (esize == 0xFF) break;
-    if (esize == 0) break;
-    if (esize > 127) {
-      esize = (esize&0x7F)<<8 | p[1];
-      q++;
-    }
-    q++;
-    r=q;
-    if (*r && ((name == 0) || (!strcmp(name,r)))) {
-      while (*q++) ;
-      return q;
-    }
-    p+=esize;
-  }
-  return (char*)0;
-}
-
-void bse_setup(void) {
-  /* extract the linux cmdline from flash */
-  char *name=bse_getflashparam("linuxboot");
-  char *x = (char *)0xc0000100;
-  if (name) { 
-    while (*name) *x++=*name++;
-  }
-  *x=0;
-}

--
