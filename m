Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVCFHcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVCFHcx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 02:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVCFHcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 02:32:52 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:29445 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261330AbVCFHce
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 02:32:34 -0500
Date: Sun, 6 Mar 2005 08:32:22 +0100 (CET)
From: Daniel Rozsnyo <daniel@rozsnyo.com>
X-X-Sender: daniel@a03-0431e.kn.vutbr.cz
To: Linus Torvalds <torvalds@ppc970.osdl.org>
cc: linux-kernel@vger.kernel.org, Daniel Rozsnyo <rozsnyo@kn.vutbr.cz>
Subject: [PATCH] i386: remove extra spaces from cpu model id
Message-ID: <Pine.LNX.4.62.0503060824410.18717@a03-0431e.kn.vutbr.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.0 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.9 DATE_MISSING           Missing Date: header
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes extra spaces which separate the frequency string from the cpu model id 
itself (noticable e.g. on Intel Tualatin processors in /proc/cpuinfo)

Signed-off-by: Daniel Rozsnyo <daniel@rozsnyo.com>

---

diff -urN linux-2.6.11.orig/arch/i386/kernel/cpu/common.c linux-2.6.11/arch/i386/kernel/cpu/common.c
--- linux-2.6.11.orig/arch/i386/kernel/cpu/common.c	2005-03-02 08:37:47.000000000 +0100
+++ linux-2.6.11/arch/i386/kernel/cpu/common.c	2005-03-06 07:46:16.000000000 +0100
@@ -59,7 +59,7 @@
  int __init get_model_name(struct cpuinfo_x86 *c)
  {
  	unsigned int *v;
-	char *p, *q;
+	char *src, *dst;

  	if (cpuid_eax(0x80000000) < 0x80000004)
  		return 0;
@@ -71,17 +71,25 @@
  	c->x86_model_id[48] = 0;

  	/* Intel chips right-justify this string for some dumb reason;
-	   undo that brain damage */
-	p = q = &c->x86_model_id[0];
-	while ( *p == ' ' )
-	     p++;
-	if ( p != q ) {
-	     while ( *p )
-		  *q++ = *p++;
-	     while ( q <= &c->x86_model_id[48] )
-		  *q++ = '\0';	/* Zero-pad the rest */
+	   undo that, and also remove multiple spaces from the middle */
+	src = dst = &c->x86_model_id[0];
+
+	while ( *src == ' ' )			/* find the start */
+		src++;
+
+	while ( *src ) {
+		*dst++ = *src++;
+		if ( *src == ' ' ) {		/* first space: copy */
+			*dst++ = *src++;
+		}
+		while ( *src == ' ' ) {		/* next spaces: skip */
+			src++;
+		}
  	}

+	while ( dst <= &c->x86_model_id[48] )
+		*dst++ = '\0';			/* zero-pad the rest */
+
  	return 1;
  }

