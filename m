Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTEYSJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 14:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTEYSJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 14:09:43 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:33178 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261743AbTEYSJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 14:09:42 -0400
Date: Sun, 25 May 2003 13:34:06 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix snd_seq_queue_find_name()
Message-ID: <20030525173406.GC602@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While going through sound/ for strncpy replacing, I came across this
routine:

/* return the (first) queue matching with the specified name */
queue_t *snd_seq_queue_find_name(char *name)
{
        int i;
        queue_t *q;

        for (i = 0; i < SNDRV_SEQ_MAX_QUEUES; i++) {
                if ((q = queueptr(i)) != NULL) {
                        if (strncpy(q->name, name, sizeof(q->name)) == 0)
                                return q;
                        queuefree(q);
                }
        }
        return NULL;
}


I'm _really_ sure that they meant to use strncmp() here instead. Patch
below fixes it.


Index: sound/core/seq/seq_queue.c
===================================================================
--- sound/core/seq/seq_queue.c	(revision 10041)
+++ sound/core/seq/seq_queue.c	(working copy)
@@ -241,7 +241,7 @@
 
 	for (i = 0; i < SNDRV_SEQ_MAX_QUEUES; i++) {
 		if ((q = queueptr(i)) != NULL) {
-			if (strncpy(q->name, name, sizeof(q->name)) == 0)
+			if (strncmp(q->name, name, sizeof(q->name)) == 0)
 				return q;
 			queuefree(q);
 		}
