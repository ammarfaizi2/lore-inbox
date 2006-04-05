Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWDEJ7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWDEJ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWDEJ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:59:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40645 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751188AbWDEJ7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:59:15 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Keys: Improve usage of memory barriers and remove IRQ disablement [try #2]
Date: Wed, 05 Apr 2006 10:58:59 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060405095859.32282.86624.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch removes an unnecessary memory barrier (implicit in
rcu_dereference()) from install_session_keyring().

install_session_keyring() is also rearranged a little to make it slightly more
efficient.

As install_*_keyring() may schedule (in synchronize_rcu() or keyring_alloc()),
they may not be entered with interrupts disabled - and so there's no point
saving the interrupt disablement state over the critical section.

exec_keys() will also be invoked with interrupts enabled, and so that doesn't
need to save the interrupt state either.
---

 security/keys/process_keys.c |   41 ++++++++++++++++++++---------------------
 1 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 74cb79e..ad123c3 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -167,11 +167,12 @@ error:
  */
 int install_process_keyring(struct task_struct *tsk)
 {
-	unsigned long flags;
 	struct key *keyring;
 	char buf[20];
 	int ret;
 
+	might_sleep();
+
 	if (!tsk->signal->process_keyring) {
 		sprintf(buf, "_pid.%u", tsk->tgid);
 
@@ -182,12 +183,12 @@ int install_process_keyring(struct task_
 		}
 
 		/* attach keyring */
-		spin_lock_irqsave(&tsk->sighand->siglock, flags);
+		spin_lock_irq(&tsk->sighand->siglock);
 		if (!tsk->signal->process_keyring) {
 			tsk->signal->process_keyring = keyring;
 			keyring = NULL;
 		}
-		spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
+		spin_unlock_irq(&tsk->sighand->siglock);
 
 		key_put(keyring);
 	}
@@ -206,38 +207,37 @@ error:
 static int install_session_keyring(struct task_struct *tsk,
 				   struct key *keyring)
 {
-	unsigned long flags;
 	struct key *old;
 	char buf[20];
-	int ret;
+
+	might_sleep();
 
 	/* create an empty session keyring */
 	if (!keyring) {
 		sprintf(buf, "_ses.%u", tsk->tgid);
 
 		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, 1, NULL);
-		if (IS_ERR(keyring)) {
-			ret = PTR_ERR(keyring);
-			goto error;
-		}
+		if (IS_ERR(keyring))
+			return PTR_ERR(keyring);
 	}
 	else {
 		atomic_inc(&keyring->usage);
 	}
 
 	/* install the keyring */
-	spin_lock_irqsave(&tsk->sighand->siglock, flags);
-	old = rcu_dereference(tsk->signal->session_keyring);
+	spin_lock_irq(&tsk->sighand->siglock);
+	old = tsk->signal->session_keyring;
 	rcu_assign_pointer(tsk->signal->session_keyring, keyring);
-	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
+	spin_unlock_irq(&tsk->sighand->siglock);
 
-	ret = 0;
+	/* we're using RCU on the pointer, but there's no point synchronising
+	 * on it if it didn't previously point to anything */
+	if (old) {
+		synchronize_rcu();
+		key_put(old);
+	}
 
-	/* we're using RCU on the pointer */
-	synchronize_rcu();
-	key_put(old);
-error:
-	return ret;
+	return 0;
 
 } /* end install_session_keyring() */
 
@@ -310,7 +310,6 @@ void exit_keys(struct task_struct *tsk)
  */
 int exec_keys(struct task_struct *tsk)
 {
-	unsigned long flags;
 	struct key *old;
 
 	/* newly exec'd tasks don't get a thread keyring */
@@ -322,10 +321,10 @@ int exec_keys(struct task_struct *tsk)
 	key_put(old);
 
 	/* discard the process keyring from a newly exec'd task */
-	spin_lock_irqsave(&tsk->sighand->siglock, flags);
+	spin_lock_irq(&tsk->sighand->siglock);
 	old = tsk->signal->process_keyring;
 	tsk->signal->process_keyring = NULL;
-	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
+	spin_unlock_irq(&tsk->sighand->siglock);
 
 	key_put(old);
 

