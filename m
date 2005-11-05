Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbVKEL3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVKEL3s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 06:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbVKEL3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 06:29:48 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:19875 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751469AbVKEL3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 06:29:47 -0500
Date: Sat, 5 Nov 2005 12:29:34 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Kirill Korotaev <dev@sw.ru>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: [PATCH] signal handling: revert sigkill priority fix
Message-ID: <20051105112934.GA2522@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This patch reverts commit c33880aaddbbab1ccf36f4457ed1090621f2e39a since
it's not needed anymore. As pointed out by Roland McGrath the real fix
is to deliver all signals before returning to user space.
See http://www.ussg.iu.edu/hypermail/linux/kernel/0509.2/0683.html
A fix for s390 is in the -mm tree.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 kernel/signal.c |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 1bf3c39..2429204 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -513,16 +513,7 @@ static int __dequeue_signal(struct sigpe
 {
 	int sig = 0;
 
-	/* SIGKILL must have priority, otherwise it is quite easy
-	 * to create an unkillable process, sending sig < SIGKILL
-	 * to self */
-	if (unlikely(sigismember(&pending->signal, SIGKILL))) {
-		if (!sigismember(mask, SIGKILL))
-			sig = SIGKILL;
-	}
-
-	if (likely(!sig))
-		sig = next_signal(pending, mask);
+	sig = next_signal(pending, mask);
 	if (sig) {
 		if (current->notifier) {
 			if (sigismember(current->notifier_mask, sig)) {
