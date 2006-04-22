Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWDVAbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWDVAbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWDVAbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:31:06 -0400
Received: from sccrmhc13.comcast.net ([63.240.77.83]:51441 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1750788AbWDVAbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:31:04 -0400
Date: Fri, 21 Apr 2006 17:31:00 -0700
From: Chris Spiegel <linuxml@happyjack.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Exclude kernel threads from kill(-1, ..)
Message-ID: <20060422003100.GA14966@midgard.spiegels>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kill(-1, ..) currently will try to signal kernel threads, which of
course won't die off even with SIGKILL, meaning that ESRCH will never be
returned.  Instead, allow kill() to return ESRCH if the only processes
left are simply unkillable (kernel threads).  This does not violate
POSIX which says that "an unspecified set of system processes" may be
excluded when killing -1.

Signed-off-by: Chris Spiegel <linuxml@happyjack.org>

---
(please CC replies to me)

There is a comment in signal.c which says that Linux's kill(-1, ..) does
something that is probably wrong and should be like BSD or SysV.  Well,
this is a bit more like the modern BSDs (possibly SysV, I'm not familiar
with it), although we still don't kill the calling process, a choice I
agree with.

This isn't just a pathological fix, it's a problem I ran into with the
following code (from NetBSD's /sbin/reboot):

for (i = 1;; ++i) {
	if (kill(-1, SIGKILL) == -1) {
		if (errno == ESRCH)
			break;
		goto restart;
	}
	if (i > 5) {
		warnx("WARNING: some process(es) wouldn't die");
		break;
	}
	(void)sleep(2 * i);
}

So it fixes a real-world (my world, anyway) problem.

--- linux-2.6/kernel/signal.c.orig	2006-04-21 15:44:17.618784128 -0700
+++ linux-2.6/kernel/signal.c	2006-04-21 16:20:52.269454557 -0700
@@ -1156,7 +1156,8 @@ static int kill_something_info(int sig, 
 
 		read_lock(&tasklist_lock);
 		for_each_process(p) {
-			if (p->pid > 1 && p->tgid != current->tgid) {
+			if (p->pid > 1 && p->tgid != current->tgid &&
+					  p->mm != NULL) {
 				int err = group_send_sig_info(sig, info, p);
 				++count;
 				if (err != -EPERM)
