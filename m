Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVI2Vyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVI2Vyu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVI2Vyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:54:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61351 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932295AbVI2Vyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:54:49 -0400
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
X-Shopping-List: (1) Transplanted loads
   (2) Superstitious solar-frightened lunchbox inhibitions
   (3) Titanic preserves
   (4) Simultaneous lesion tampons
Message-Id: <20050929215442.74EE0180E20@magilla.sf.frob.com>
Date: Thu, 29 Sep 2005 14:54:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am dubious about this change.  I don't see a corresponding change to
fs/proc/array.c where it knows what all the bit values are.  I am not at
all sure there aren't other places that know these values and need a fixup
if you change them.

Any tests using < TASK_STOPPED or the like are left over from the time when
the TASK_ZOMBIE and TASK_DEAD bits were in the same word, and it served to
check for "stopped or dead".  I think this one in do_signal_stop is the
only such case.  It has been buggy ever since exit_state was separated.
Changing the bit values doesn't fix the bug that it isn't checking the
exit_state value.  This patch is probably the right fix for that, but I
have not tested it.

Signed-off-by: Roland McGrath <roland@redhat.com>

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1775,7 +1775,8 @@ do_signal_stop(int signr)
 				 * stop is always done with the siglock held,
 				 * so this check has no races.
 				 */
-				if (t->state < TASK_STOPPED) {
+				if (!t->exit_state &&
+				    !(t->state & (TASK_STOPPED|TASK_TRACED))) {
 					stop_count++;
 					signal_wake_up(t, 0);
 				}

