Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTKFSLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 13:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTKFSLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 13:11:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:30116 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263131AbTKFSLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 13:11:05 -0500
Date: Thu, 6 Nov 2003 19:11:04 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [QUOTA] Drop spin lock when calling request_module
Message-ID: <20031106181104.GB16172@atrey.karlin.mff.cuni.cz>
References: <20031106161823.GC25830@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0311060827070.1842-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311060827070.1842-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, 6 Nov 2003, Jan Kara wrote:
> >  			actqf = NULL;
> >  			goto out;
> 
> Mind changing this to just a "return NULL" instead and just remove the
> label entirely, now that it doesn't actually need to play with any
> spinlocks?
> 
> I don't mind goto's if there is a _point_ to them, but this one doesn't 
> seem to fall under that heading.
  You're right. The nicer fix is attached.

									Honza

----------------------------Cut here--------------------------------------

diff -ruX ../kerndiffexclude linux-2.6.0-test9/fs/dquot.c linux-2.6.0-test9-loadfix/fs/dquot.c
--- linux-2.6.0-test9/fs/dquot.c	Sat Oct 25 20:44:03 2003
+++ linux-2.6.0-test9-loadfix/fs/dquot.c	Thu Nov  6 19:10:37 2003
@@ -128,16 +128,17 @@
 	if (!actqf || !try_module_get(actqf->qf_owner)) {
 		int qm;
 
+		spin_unlock(&dq_list_lock);
+		
 		for (qm = 0; module_names[qm].qm_fmt_id && module_names[qm].qm_fmt_id != id; qm++);
-		if (!module_names[qm].qm_fmt_id || request_module(module_names[qm].qm_mod_name)) {
-			actqf = NULL;
-			goto out;
-		}
+		if (!module_names[qm].qm_fmt_id || request_module(module_names[qm].qm_mod_name))
+			return NULL;
+
+		spin_lock(&dq_list_lock);
 		for (actqf = quota_formats; actqf && actqf->qf_fmt_id != id; actqf = actqf->qf_next);
 		if (actqf && !try_module_get(actqf->qf_owner))
 			actqf = NULL;
 	}
-out:
 	spin_unlock(&dq_list_lock);
 	return actqf;
 }
