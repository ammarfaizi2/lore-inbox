Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUGSKdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUGSKdB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 06:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbUGSKdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 06:33:01 -0400
Received: from mx1.elte.hu ([157.181.1.137]:25497 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264953AbUGSKc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 06:32:59 -0400
Date: Mon, 19 Jul 2004 12:20:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040719102030.GA5046@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org> <20040711093209.GA17095@elte.hu> <20040711024518.7fd508e0.akpm@osdl.org> <20040711095039.GA22391@elte.hu> <20040711025855.08afbca1.akpm@osdl.org> <20040711103020.GA24797@elte.hu> <20040711034258.796f8c6a.akpm@osdl.org> <20040711105936.GA13956@devserv.devel.redhat.com> <Pine.LNX.4.58.0407120300200.23212@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407120300200.23212@montezuma.fsmlabs.com>
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


* Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> Looks like some of the voluntary preemption changes might need some
> eyeballing too. This appears to be a use after free, probably since we
> unlocked j_{list,state}_lock.

thx - this is the new __journal_clean_checkpoint_list() chunk:

--- linux/fs/jbd/checkpoint.c.orig	
+++ linux/fs/jbd/checkpoint.c	
@@ -465,6 +470,7 @@ int __journal_clean_checkpoint_list(jour
 	transaction_t *transaction, *last_transaction, *next_transaction;
 	int ret = 0;
 
+retry:
 	transaction = journal->j_checkpoint_transactions;
 	if (transaction == 0)
 		goto out;
@@ -487,6 +493,14 @@ int __journal_clean_checkpoint_list(jour
 				/* Use trylock because of the ranknig */
 				if (jbd_trylock_bh_state(jh2bh(jh)))
 					ret += __try_to_free_cp_buf(jh);
+				if (voluntary_need_resched()) {
+					spin_unlock(&journal->j_list_lock);
+					spin_unlock(&journal->j_state_lock);
+					voluntary_resched();
+					spin_lock(&journal->j_state_lock);
+					spin_lock(&journal->j_list_lock);
+					goto retry;
+				}
 			} while (jh != last_jh);
 		}
 	} while (transaction != last_transaction);
