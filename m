Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265367AbTGDRkm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 13:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbTGDRkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 13:40:42 -0400
Received: from [213.39.233.138] ([213.39.233.138]:48041 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265367AbTGDRkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 13:40:41 -0400
Date: Fri, 4 Jul 2003 19:54:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030704175439.GE22152@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de> <20030704174339.GB22152@wohnheim.fh-wedel.de> <20030704174558.GC22152@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030704174558.GC22152@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should be the ppc specific part of the signal stack fixes.  It sets the
flag, when switching to the signal stack and clears it, when switching
back.  When the kernel tries to switch to the signal stack again,   
without switching back, the process screwed up the signal stack, so we
kill it with a SIGSEGV.

Well, it should be, but it ain't.  I didn't find the correct spot to
clear the flag again, so this patch is incomplete.  Maybe someone else
knows the 2.5 ppc signal handling better than I do?

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu

--- linux-2.5.73/arch/ppc/kernel/signal.c~ss_ppc	2003-07-04 19:01:55.000000000 +0200
+++ linux-2.5.73/arch/ppc/kernel/signal.c	2003-07-04 19:21:44.000000000 +0200
@@ -496,9 +496,18 @@
 	if (signr > 0) {
 		ka = &current->sighand->action[signr-1];
 		if ( (ka->sa.sa_flags & SA_ONSTACK)
-		     && (! on_sig_stack(regs->gpr[1])))
+		     && (! on_sig_stack(regs->gpr[1]))) {
+			/* FIXME: Need to find the correct spot to clear
+			 * this flag again
+			 */
+			if (current->flags & PF_SS_ACTIVE) {
+				ka->sa.sa_handler = SIG_DFL;
+				force_sig(SIGSEGV, current);
+				return 0;
+			}
+			current->flags |= PF_SS_ACTIVE;
 			newsp = (current->sas_ss_sp + current->sas_ss_size);
-		else
+		} else
 			newsp = regs->gpr[1];
 		newsp = frame = newsp - sizeof(struct sigregs);
 
