Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269115AbRHDQTB>; Sat, 4 Aug 2001 12:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268913AbRHDQSw>; Sat, 4 Aug 2001 12:18:52 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:47986 "EHLO
	alloc.wat.veritas.com") by vger.kernel.org with ESMTP
	id <S269018AbRHDQSh>; Sat, 4 Aug 2001 12:18:37 -0400
Date: Sat, 4 Aug 2001 17:21:16 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
X-X-Sender: <markhe@alloc.wat.veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108032330450.1193-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108041717540.26125-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Linus Torvalds wrote:
> Well, I've made a 2.4.8-pre4.

  A colleague has reminded me that we this small patch against
flush_dirty_buffers() - kick the disk queues before sleeping.

Mark


--- linux-2.4.8-pre4/fs/buffer.c	Sat Aug  4 11:49:52 2001
+++ linux/fs/buffer.c	Sat Aug  4 11:56:25 2001
@@ -2568,8 +2568,11 @@
 		ll_rw_block(WRITE, 1, &bh);
 		put_bh(bh);

-		if (current->need_resched)
+		if (current->need_resched) {
+			/* kick what we've already pushed down */
+			run_task_queue(&tq_disk);
 			schedule();
+		}
 		goto restart;
 	}
  out_unlock:

