Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTJ3FZL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 00:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbTJ3FZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 00:25:10 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.139.94]:29458 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S262128AbTJ3FZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 00:25:04 -0500
Date: Thu, 30 Oct 2003 14:24:58 +0900 (JST)
Message-Id: <20031030.142458.350988313.yoshfuji@linux-ipv6.org>
To: jmorris@redhat.com
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       davem@redhat.com, yoshfuji@linux-ipv6.org
Subject: Re: Bug somewhere in crypto or ipsec stuff
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Xine.LNX.4.44.0310292344530.23580-100000@thoron.boston.redhat.com>
References: <20031030.124124.26191552.yoshfuji@linux-ipv6.org>
	<Xine.LNX.4.44.0310292344530.23580-100000@thoron.boston.redhat.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Xine.LNX.4.44.0310292344530.23580-100000@thoron.boston.redhat.com> (at Wed, 29 Oct 2003 23:47:05 -0500 (EST)), James Morris <jmorris@redhat.com> says:

> > Do you mean that we need to fix the caller?
> 
> Yes.

> >  - crypto allows name == NULL, and return any algorithm
> >    (for example, an algorithm that we see first.)
> >  - caller may filter name == NULL case if it is ambiguous in their context.
> 
> I think that could be dangerous, including if calling with null is a 
> bug, and they get an inappropriate algorithm.  An incorrect algorithm type 
> could also be returned (e.g. digest instead of a cipher).

okay. how about this?

===== crypto/api.c 1.30 vs edited =====
--- 1.30/crypto/api.c	Sat Mar 29 20:16:58 2003
+++ edited/crypto/api.c	Thu Oct 30 14:21:53 2003
@@ -36,6 +36,9 @@
 struct crypto_alg *crypto_alg_lookup(const char *name)
 {
 	struct crypto_alg *q, *alg = NULL;
+
+	if (!name)
+		return NULL;
 	
 	down_read(&crypto_alg_sem);
 	
===== net/ipv4/ipcomp.c 1.16 vs edited =====
--- 1.16/net/ipv4/ipcomp.c	Mon Aug 18 20:14:38 2003
+++ edited/net/ipv4/ipcomp.c	Thu Oct 30 14:18:49 2003
@@ -360,7 +360,12 @@
 	ipcd->scratch = kmalloc(IPCOMP_SCRATCH_SIZE, GFP_KERNEL);
 	if (!ipcd->scratch)
 		goto error;
-	
+
+	if (!x->calg->alg_name) {
+		err = -EINVAL;
+		goto error;
+	}
+
 	ipcd->tfm = crypto_alloc_tfm(x->calg->alg_name, 0);
 	if (!ipcd->tfm)
 		goto error;
===== net/ipv6/ipcomp6.c 1.7 vs edited =====
--- 1.7/net/ipv6/ipcomp6.c	Mon Aug 18 20:14:38 2003
+++ edited/net/ipv6/ipcomp6.c	Thu Oct 30 14:18:49 2003
@@ -293,6 +293,11 @@
 	if (!ipcd->scratch)
 		goto error;
 
+	if (!x->calg->alg_name) {
+		err = -EINVAL;
+		goto error;
+	}
+
 	ipcd->tfm = crypto_alloc_tfm(x->calg->alg_name, 0);
 	if (!ipcd->tfm)
 		goto error;
