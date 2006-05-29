Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWE2V3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWE2V3z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWE2V3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:29:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:48107 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751376AbWE2V1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:27:34 -0400
Date: Mon, 29 May 2006 23:27:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 60/61] lock validator: special locking: sound/core/seq/seq_ports.c
Message-ID: <20060529212755.GH3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 sound/core/seq/seq_ports.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/sound/core/seq/seq_ports.c
===================================================================
--- linux.orig/sound/core/seq/seq_ports.c
+++ linux/sound/core/seq/seq_ports.c
@@ -518,7 +518,7 @@ int snd_seq_port_connect(struct snd_seq_
 	atomic_set(&subs->ref_count, 2);
 
 	down_write(&src->list_mutex);
-	down_write(&dest->list_mutex);
+	down_write_nested(&dest->list_mutex, SINGLE_DEPTH_NESTING);
 
 	exclusive = info->flags & SNDRV_SEQ_PORT_SUBS_EXCLUSIVE ? 1 : 0;
 	err = -EBUSY;
@@ -591,7 +591,7 @@ int snd_seq_port_disconnect(struct snd_s
 	unsigned long flags;
 
 	down_write(&src->list_mutex);
-	down_write(&dest->list_mutex);
+	down_write_nested(&dest->list_mutex, SINGLE_DEPTH_NESTING);
 
 	/* look for the connection */
 	list_for_each(p, &src->list_head) {
