Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbTGDRh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 13:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbTGDRh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 13:37:28 -0400
Received: from [213.39.233.138] ([213.39.233.138]:43177 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265034AbTGDRh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 13:37:26 -0400
Date: Fri, 4 Jul 2003 19:51:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.73] Signal stack fixes #2 i386-specific
Message-ID: <20030704175124.GD22152@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de> <20030704174339.GB22152@wohnheim.fh-wedel.de> <20030704174558.GC22152@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030704174558.GC22152@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This is the i386 specific part of the signal stack fixes.  It sets the
flag, when switching to the signal stack and clears it, when switching
back.  When the kernel tries to switch to the signal stack again,
without switching back, the process screwed up the signal stack, so we
kill it with a SIGSEGV.

Actually, the process doesn't get killed right away yet, so there is
room for improvement, but the general behaviour is the right one.

Please apply.

Jörn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm ­ I could do better than that!"
-- Douglas Adams in a slashdot interview

--- linux-2.5.73/arch/i386/kernel/signal.c~ss_i386	2003-07-04 18:57:01.000000000 +0200
+++ linux-2.5.73/arch/i386/kernel/signal.c	2003-07-04 18:59:04.000000000 +0200
@@ -181,6 +181,9 @@
 		}
 	}
 
+	if (sas_ss_flags(regs->esp) == 0)
+		current->flags &= ~PF_SS_ACTIVE;
+
 	err |= __get_user(*peax, &sc->eax);
 	return err;
 
@@ -317,9 +320,22 @@
 	esp = regs->esp;
 
 	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (sas_ss_flags(esp) == 0)
-			esp = current->sas_ss_sp + current->sas_ss_size;
+	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(esp) == 0)) {
+		/* If we have switches to the signal stack before,
+		 * something bad has happened to it, asking for a
+		 * segmentation fault.
+		 * If not, remember it for the next time
+		 */
+		if (current->flags & PF_SS_ACTIVE) {
+			ka->sa.sa_handler = SIG_DFL;
+			force_sig(SIGSEGV, current);
+			/* XXX would it be simpler to return some broken
+			 * value like NULL and have the calling function
+			 * signal the segv?
+			 */
+		}
+		current->flags |= PF_SS_ACTIVE;
+		esp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
 	/* This is the legacy signal stack switching. */
