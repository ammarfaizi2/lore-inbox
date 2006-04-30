Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWD3DHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWD3DHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 23:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWD3DHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 23:07:18 -0400
Received: from ozlabs.org ([203.10.76.45]:63211 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750890AbWD3DHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 23:07:17 -0400
To: Paul Mackerras <paulus@samba.org>
CC: Arnd Bergmann <arnd.bergmann@de.ibm.com>, Ryan Arnold <rsa@us.ibm.com>,
       <cbe-oss-dev@ozlabs.org>, <linuxppc-dev@ozlabs.org>,
       <linux-kernel@vger.kernel.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Sun, 30 Apr 2006 13:07:14 +1000
Subject: [PATCH] powerpc: Make rtas console _much_ faster
In-Reply-To: <200604291000.52541.arnd@arndb.de>
Message-Id: <20060430030716.7032C67A60@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the hvc_rtas driver is painfully slow to use. Our "benchmark" is
ls -R /etc, which spits out about 27866 characters. The theoretical maximum
speed would be about 2.2 seconds, the current code takes ~50 seconds.

The core of the problem is that sometimes when the tty layer asks us to push
characters the firmware isn't able to handle some or all of them, and so
returns an error. The current code sees this and just returns to the tty code
with the buffer half sent.

The khvcd thread will eventually wake up and try to push more characters, which
will usually work because by then the firmware's had time to make room. But
the khvcd thread only wakes up every 10 milliseconds, which isn't fast enough.

So change the khvcd thread logic so that if there's an incomplete write we
yield() and then immediately try writing again. Doing so makes POLL_QUICK and
POLL_WRITE synonymous, so remove POLL_QUICK.

With this patch our "benchmark" takes ~2.8 seconds.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/char/hvc_console.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: cell/drivers/char/hvc_console.c
===================================================================
--- cell.orig/drivers/char/hvc_console.c
+++ cell/drivers/char/hvc_console.c
@@ -553,7 +553,6 @@ static int hvc_chars_in_buffer(struct tt
 
 #define HVC_POLL_READ	0x00000001
 #define HVC_POLL_WRITE	0x00000002
-#define HVC_POLL_QUICK	0x00000004
 
 static int hvc_poll(struct hvc_struct *hp)
 {
@@ -568,6 +567,7 @@ static int hvc_poll(struct hvc_struct *h
 	/* Push pending writes */
 	if (hp->n_outbuf > 0)
 		hvc_push(hp);
+
 	/* Reschedule us if still some write pending */
 	if (hp->n_outbuf > 0)
 		poll_mask |= HVC_POLL_WRITE;
@@ -680,7 +680,7 @@ int khvcd(void *unused)
 			poll_mask |= HVC_POLL_READ;
 		if (hvc_kicked)
 			continue;
-		if (poll_mask & HVC_POLL_QUICK) {
+		if (poll_mask & HVC_POLL_WRITE) {
 			yield();
 			continue;
 		}
