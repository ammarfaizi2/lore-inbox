Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUJNTIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUJNTIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUJNTD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:03:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:42442 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266891AbUJNTBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:01:04 -0400
Date: Thu, 14 Oct 2004 21:02:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@Raytheon.com
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Daniel Walker <dwalker@mvista.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041014190227.GA31608@elte.hu>
References: <OF2289D554.769CEFC1-ON86256F2D.005DF70B-86256F2D.005DF791@raytheon.com> <20041014182438.GA30078@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014182438.GA30078@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > as part of single stepping the init sequence. I stopped at this point
> > to make sure I had a good record of the messages.
> 
> could you try to disable SELINUX? It seems it's not fully safe yet.

there wasnt all that much missing for SELINUX + PREEMPT_REALTIME
support. Could you try the patch below - does it fix your box?

	Ingo

--- linux/net/ipv4/af_inet.c.orig
+++ linux/net/ipv4/af_inet.c
@@ -242,7 +242,7 @@ static int inet_create(struct socket *so
 
 	/* Look for the requested type/protocol pair. */
 	answer = NULL;
-	rcu_read_lock();
+	rcu_read_lock_spin(&inetsw_lock);
 	list_for_each_rcu(p, &inetsw[sock->type]) {
 		answer = list_entry(p, struct inet_protosw, list);
 
@@ -276,7 +276,7 @@ static int inet_create(struct socket *so
 	answer_prot = answer->prot;
 	answer_no_check = answer->no_check;
 	answer_flags = answer->flags;
-	rcu_read_unlock();
+	rcu_read_unlock_spin(&inetsw_lock);
 
 	BUG_TRAP(answer_prot->slab != NULL);
 
@@ -345,7 +345,7 @@ static int inet_create(struct socket *so
 out:
 	return err;
 out_rcu_unlock:
-	rcu_read_unlock();
+	rcu_read_unlock_spin(&inetsw_lock);
 	goto out;
 }
 
