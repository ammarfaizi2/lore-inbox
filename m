Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267682AbTBFWcq>; Thu, 6 Feb 2003 17:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267683AbTBFWcp>; Thu, 6 Feb 2003 17:32:45 -0500
Received: from crack.them.org ([65.125.64.184]:13034 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267682AbTBFWcm>;
	Thu, 6 Feb 2003 17:32:42 -0500
Date: Thu, 6 Feb 2003 17:42:19 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Ptrace updates: CLONE_PTRACE should use force_sig_specific [3/5]
Message-ID: <20030206224219.GC22762@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030206223924.GA22688@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206223924.GA22688@nevyn.them.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, CLONE_PTRACE uses send_sig(SIGSTOP, p, 1).  If you use
CLONE_THREAD | CLONE_PTRACE, though, this SIGSTOP gets broadcast to the
entire thread group.  That's not what was intended; we only want the one
new thread to stop.  Fixed like so.

# --------------------------------------------
# 03/02/04	drow@nevyn.them.org	1.959
# Use force_sig_specific to send SIGSTOP to newly-created CLONE_PTRACE processes.
# --------------------------------------------

diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Thu Feb  6 16:57:32 2003
+++ b/kernel/fork.c	Thu Feb  6 16:57:32 2003
@@ -1036,7 +1036,7 @@
 		}
 
 		if (p->ptrace & PT_PTRACED)
-			send_sig(SIGSTOP, p, 1);
+			force_sig_specific(SIGSTOP, p);
 
 		wake_up_forked_process(p);		/* do this last */
 		++total_forks;

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
