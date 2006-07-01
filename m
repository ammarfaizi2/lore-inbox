Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWGAHMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWGAHMa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 03:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWGAHMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 03:12:30 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:28385 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932191AbWGAHM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 03:12:29 -0400
Date: Sat, 1 Jul 2006 09:07:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Drepper <drepper@redhat.com>
Subject: [patch] pi-futex: futex_wake() lockup fix
Message-ID: <20060701070746.GA22457@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5122]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: pi-futex: futex_wake() lockup fix
From: Ingo Molnar <mingo@elte.hu>

fix futex_wake() exit condition bug when handling the robust-list with 
PI futexes on them.

(reported by Ulrich Drepper, debugged by the lock validator.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/futex.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux/kernel/futex.c
===================================================================
--- linux.orig/kernel/futex.c
+++ linux/kernel/futex.c
@@ -646,8 +646,10 @@ static int futex_wake(u32 __user *uaddr,
 
 	list_for_each_entry_safe(this, next, head, list) {
 		if (match_futex (&this->key, &key)) {
-			if (this->pi_state)
-				return -EINVAL;
+			if (this->pi_state) {
+				ret = -EINVAL;
+				break;
+			}
 			wake_futex(this);
 			if (++ret >= nr_wake)
 				break;
