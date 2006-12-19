Return-Path: <linux-kernel-owner+w=401wt.eu-S932717AbWLSJeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWLSJeV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWLSJeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:34:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50473 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932717AbWLSJeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:34:20 -0500
Date: Tue, 19 Dec 2006 10:31:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch] lock debugging: fix DEBUG_LOCKS_WARN_ON() & debug_locks_silent
Message-ID: <20061219093135.GA28269@elte.hu>
References: <20061216080458.GC16116@elte.hu> <20061219084359.GB1731@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219084359.GB1731@ff.dom.local>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jarek Poplawski <jarkao2@o2.pl> wrote:

> >  	if (unlikely(c)) {						\
> > -		if (debug_locks_silent || debug_locks_off())		\
> > +		if (!debug_locks_silent && debug_locks_off())		\

btw., updated patch is below - the right order is to first do 
debug_locks_off(), then debug_locks_silent.

[ btw., could you fix your mailer so that a reply to your mails doesnt 
  put all participants into the 'To:' line? You can do it via adding 
  "unset followup_to" to your $HOME/.muttrc file. ]

------------->
Subject: [patch] lock debugging: fix DEBUG_LOCKS_WARN_ON() & debug_locks_silent
From: Ingo Molnar <mingo@elte.hu>

Matthew Wilcox noticed that the debug_locks_silent use should be
inverted in DEBUG_LOCKS_WARN_ON(). This bug was causing spurious
stacktraces and incorrect failures in the locking self-test on the
parisc kernel.

Bug-found-by: Matthew Wilcox <matthew@wil.cx>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/debug_locks.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/include/linux/debug_locks.h
===================================================================
--- linux.orig/include/linux/debug_locks.h
+++ linux/include/linux/debug_locks.h
@@ -24,7 +24,7 @@ extern int debug_locks_off(void);
 	int __ret = 0;							\
 									\
 	if (unlikely(c)) {						\
-		if (debug_locks_silent || debug_locks_off())		\
+		if (debug_locks_off() && !debug_locks_silent)		\
 			WARN_ON(1);					\
 		__ret = 1;						\
 	}								\

