Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTKFQS1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 11:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbTKFQS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 11:18:27 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:37509 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263692AbTKFQSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 11:18:25 -0500
Date: Thu, 6 Nov 2003 17:18:24 +0100
From: Jan Kara <jack@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>, torvalds@osdl.org, akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [QUOTA] Drop spin lock when calling request_module
Message-ID: <20031106161823.GC25830@atrey.karlin.mff.cuni.cz>
References: <20031105111025.GA2337@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031105111025.GA2337@gondor.apana.org.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> This patch drops the spin lock when calling request_module as the
> latter will sleep.
  The patch looks right. Linus please apply if you find it serious
enough (or Andrew please queue it up for next releases...)...

							Thanks
								Honza

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
