Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbVJUKbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVJUKbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 06:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVJUKbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 06:31:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18587 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932561AbVJUKbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 06:31:49 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6bffcb0e0510201124t66284e7ct@mail.gmail.com> 
References: <6bffcb0e0510201124t66284e7ct@mail.gmail.com>  <Pine.LNX.4.64.0510192328360.5909@g5.osdl.org> 
To: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: keyrings@linux-nfs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Keys: Get rid of warning in kmod.c if keys disabled
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 21 Oct 2005 11:31:31 +0100
Message-ID: <7369.1129890691@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch gets rid of a "statement without effect" warning when
CONFIG_KEYS is disabled by making use of the return value of key_get(). The
compiler will optimise all of this away when keys are disabled.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-kmodwarn-2614rc1mm1.diff
 kernel/kmod.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -uNrp linux-2.6.14-rc4-mm1/kernel/kmod.c linux-2.6.14-rc4-michal/kernel/kmod.c
--- linux-2.6.14-rc4-mm1/kernel/kmod.c	2005-08-30 13:56:39.000000000 +0100
+++ linux-2.6.14-rc4-michal/kernel/kmod.c	2005-10-21 11:13:16.000000000 +0100
@@ -131,14 +131,14 @@ struct subprocess_info {
 static int ____call_usermodehelper(void *data)
 {
 	struct subprocess_info *sub_info = data;
-	struct key *old_session;
+	struct key *new_session, *old_session;
 	int retval;
 
 	/* Unblock all signals and set the session keyring. */
-	key_get(sub_info->ring);
+	new_session = key_get(sub_info->ring);
 	flush_signals(current);
 	spin_lock_irq(&current->sighand->siglock);
-	old_session = __install_session_keyring(current, sub_info->ring);
+	old_session = __install_session_keyring(current, new_session);
 	flush_signal_handlers(current, 1);
 	sigemptyset(&current->blocked);
 	recalc_sigpending();
