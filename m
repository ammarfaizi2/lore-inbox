Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275388AbTHITpR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275392AbTHITpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:45:17 -0400
Received: from [66.212.224.118] ([66.212.224.118]:45065 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S275388AbTHITpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:45:11 -0400
Date: Sat, 9 Aug 2003 15:33:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH][2.6] WARN_ON_STACK_VAR aka fighting variable lifetime
 bugs
In-Reply-To: <Pine.LNX.4.53.0308091430410.32166@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.53.0308091529540.32166@montezuma.mastecende.com>
References: <Pine.LNX.4.53.0308091430410.32166@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some elevator checks for stack variables, there are 
in fact some in theory in the ide_do_drive_cmd path when the caller passes
args via rq->special as a stack variable and does not call with ide_wait*. 

Index: linux-2.6-wli/drivers/block/elevator.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/block/elevator.c,v
retrieving revision 1.48
diff -u -p -B -r1.48 elevator.c
--- linux-2.6-wli/drivers/block/elevator.c	27 Jul 2003 01:42:20 -0000	1.48
+++ linux-2.6-wli/drivers/block/elevator.c	9 Aug 2003 18:16:09 -0000
@@ -230,6 +230,11 @@ void __elv_add_request(request_queue_t *
 {
 	struct list_head *insert = &q->queue_head;
 
+	if (!rq->waiting) {
+		WARN_ON_STACK_VAR(rq);
+		WARN_ON_STACK_VAR(rq->special);
+	}
+
 	if (at_end)
 		insert = insert->prev;
 	if (plug)
