Return-Path: <linux-kernel-owner+w=401wt.eu-S1762617AbWLKHai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762617AbWLKHai (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 02:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762621AbWLKHai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 02:30:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57563 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762617AbWLKHai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 02:30:38 -0500
Date: Mon, 11 Dec 2006 08:28:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jarek Poplawski <jarkao2@o2.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch] lockdep: fix possible race while disabling lock-debugging, restore fix
Message-ID: <20061211072843.GB31962@elte.hu>
References: <20061207132903.GA341@elte.hu> <20061208062725.GA1012@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208062725.GA1012@ff.dom.local>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jarek Poplawski <jarkao2@o2.pl> wrote:

> ...
> > @@ -1212,7 +1244,8 @@ register_lock_class(struct lockdep_map *
> >  	hash_head = classhashentry(key);
> >  
> >  	raw_local_irq_save(flags);
> > -	__raw_spin_lock(&hash_lock);
> > +	if (!graph_lock())
> 
> 	! raw_local_irq_restore(flags);
> 
> > +		return NULL;

yeah. Fix below.

	Ingo

Subject: [patch] lockdep: fix possible race while disabling lock-debugging, restore fix
From: Ingo Molnar <mingo@elte.hu>

restore flags in failure branch, pointed out by Jarek Poplawski.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -1244,8 +1244,10 @@ register_lock_class(struct lockdep_map *
 	hash_head = classhashentry(key);
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
+	if (!graph_lock()) {
+		raw_local_irq_restore(flags);
 		return NULL;
+	}
 	/*
 	 * We have to do the hash-walk again, to avoid races
 	 * with another CPU:
