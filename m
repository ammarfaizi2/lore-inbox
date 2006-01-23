Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWAWMIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWAWMIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWAWMIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:08:32 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:50097 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751094AbWAWMIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:08:31 -0500
Date: Mon, 23 Jan 2006 13:07:37 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       David Woodhouse <dwmw2@infradead.org>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix sigmask handling in sys_sigsuspend.
Message-ID: <20060123120737.GG9241@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Better save the sigmask instead of throwing it away so it can be restored.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Completely untested. Just noticed this when adding TIF_RESTORE_SIGMASK
support for s390.

 arch/powerpc/kernel/signal_32.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 3747ab0..c6d0595 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -254,11 +254,9 @@ int do_signal(sigset_t *oldset, struct p
  */
 long sys_sigsuspend(old_sigset_t mask)
 {
-	sigset_t saveset;
-
 	mask &= _BLOCKABLE;
 	spin_lock_irq(&current->sighand->siglock);
-	saveset = current->blocked;
+	current->saved_sigmask = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
