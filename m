Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbTKELKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 06:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbTKELKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 06:10:40 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:50954 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262819AbTKELKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 06:10:38 -0500
Date: Wed, 5 Nov 2003 22:10:25 +1100
To: mvw@planets.elm.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [QUOTA] Drop spin lock when calling request_module
Message-ID: <20031105111025.GA2337@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch drops the spin lock when calling request_module as the
latter will sleep.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/fs/dquot.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/dquot.c,v
retrieving revision 1.3
diff -u -r1.3 dquot.c
--- kernel-source-2.5/fs/dquot.c	26 Oct 2003 03:20:37 -0000	1.3
+++ kernel-source-2.5/fs/dquot.c	5 Nov 2003 11:04:30 -0000
@@ -128,17 +128,21 @@
 	if (!actqf || !try_module_get(actqf->qf_owner)) {
 		int qm;
 
+		spin_unlock(&dq_list_lock);
+
 		for (qm = 0; module_names[qm].qm_fmt_id && module_names[qm].qm_fmt_id != id; qm++);
 		if (!module_names[qm].qm_fmt_id || request_module(module_names[qm].qm_mod_name)) {
 			actqf = NULL;
 			goto out;
 		}
+
+		spin_lock(&dq_list_lock);
 		for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = actqf->qf_next);
 		if (actqf && !try_module_get(actqf->qf_owner))
 			actqf = NULL;
 	}
-out:
 	spin_unlock(&dq_list_lock);
+out:
 	return actqf;
 }
 

--zYM0uCDKw75PZbzx--
