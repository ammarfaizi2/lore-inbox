Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbUKCIl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUKCIl3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 03:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUKCIl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 03:41:29 -0500
Received: from mx2.elte.hu ([157.181.151.9]:38633 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261471AbUKCIlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 03:41:25 -0500
Date: Wed, 3 Nov 2004 09:42:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Message-ID: <20041103084217.GA27404@elte.hu>
References: <OF9F489E60.B8B3EA93-ON86256F40.007C1401-86256F40.007C1430@raytheon.com> <20041103083900.GA27211@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103083900.GA27211@elte.hu>
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

> yeah, this is yet another networking deadlock, nicely detected and
> logged. Since the deadlock locks up ksoftirqd, timer handling (also
> driven by ksoftirqd) wont work - i think this explains the followup
> symptoms you got.

the patch below should fix this deadlock but there might be others
around ...

	Ingo

--- linux/include/net/sock.h.orig2	
+++ linux/include/net/sock.h	
@@ -706,8 +706,8 @@ extern void FASTCALL(lock_sock(struct so
 extern void FASTCALL(release_sock(struct sock *sk));
 
 /* BH context may only use the following locking interface. */
-#define bh_lock_sock(__sk)	spin_lock(&((__sk)->sk_lock.slock))
-#define bh_unlock_sock(__sk)	spin_unlock(&((__sk)->sk_lock.slock))
+#define bh_lock_sock(__sk)	do { rcu_read_lock_read(&ptype_lock); spin_lock(&((__sk)->sk_lock.slock)); } while (0)
+#define bh_unlock_sock(__sk)	do { spin_unlock(&((__sk)->sk_lock.slock)); rcu_read_unlock_read(&ptype_lock); } while (0)
 
 extern struct sock *		sk_alloc(int family, int priority, int zero_it,
 					 kmem_cache_t *slab);
