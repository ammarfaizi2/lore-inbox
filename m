Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271336AbRHZRCw>; Sun, 26 Aug 2001 13:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271334AbRHZRCn>; Sun, 26 Aug 2001 13:02:43 -0400
Received: from smtp-rt-3.wanadoo.fr ([193.252.19.155]:47022 "EHLO
	apicra.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S271332AbRHZRCe>; Sun, 26 Aug 2001 13:02:34 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Possible bug in dequeue_signal()
Date: Sun, 26 Aug 2001 19:02:24 +0200
Message-Id: <20010826170224.13518@smtp.wanadoo.fr>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a crash on PPC that I tracked down to be a bug in dequeue_signal()
in kernel/signal.c, and that probably happens on other archs as well.

do_signal() can loop & block. The exit condition of the loop in this case
is when dequeue_signal() returns 0. It continues calling it until that
point, it doesn't re-check current->sigpending.

That means on the second iteration, dequeue_signal() can actually be called
with no pending signal.

A that point, dequeue_signal() calls next_signal() which returns 0. The
problem begins when the current task has a "notifier" installed (which
in my case was done by DRM). If current->notifier is non-null, then we
call sigismember() passing it 0 as the "sig" parameter.

sigismember will then do pointer arithmetic with "sig-1", that is
0xffffffff which will crashes when dereferencing.

The patch is simple:

===== kernel/signal.c 1.1 vs edited =====
--- 1.1/kernel/signal.c	Sat Jan  6 08:26:12 2001
+++ edited/kernel/signal.c	Sun Aug 26 18:50:51 2001
@@ -242,7 +242,7 @@
 #endif
 
 	sig = next_signal(current, mask);
-	if (current->notifier) {
+	if (sig && current->notifier) {
 		if (sigismember(current->notifier_mask, sig)) {
 			if (!(current->notifier)(current->notifier_data)) {
 				current->sigpending = 0;

(You may want to factor with the other if (sig) that is
done just after that code).

Ben.


