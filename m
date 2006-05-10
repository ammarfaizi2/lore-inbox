Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWEJJWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWEJJWr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWEJJWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:22:46 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:64963 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750921AbWEJJWq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:22:46 -0400
Date: Wed, 10 May 2006 11:27:01 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH RT 1/2] futex_requeue-optimize
Message-ID: <20060510112701.7ea3a749@frecb000686>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/05/2006 11:25:41,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/05/2006 11:25:45,
	Serialize complete at 10/05/2006 11:25:45
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  In futex_requeue(), when the 2 futexes keys hash to the same bucket, there
is no need to move the futex_q to the end of the bucket list.

 futex.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

Signed-off-by: Sébastien Dugué <sebastien.dugue@bull.net>

Index: linux-2.6.16-rt20/kernel/futex.c
===================================================================
--- linux-2.6.16-rt20.orig/kernel/futex.c	2006-05-04 10:58:38.000000000 +0200
+++ linux-2.6.16-rt20/kernel/futex.c	2006-05-04 10:58:55.000000000 +0200
@@ -835,17 +835,20 @@ static int futex_requeue(u32 __user *uad
 		if (++ret <= nr_wake) {
 			wake_futex(this);
 		} else {
-			list_move_tail(&this->list, &hb2->chain);
-			this->lock_ptr = &hb2->lock;
+			/*
+			 * If key1 and key2 hash to the same bucket, no
+			 * need to requeue.
+			 */
+			if (likely(head1 != &hb2->chain)) {
+				list_move_tail(&this->list, &hb2->chain);
+				this->lock_ptr = &hb2->lock;
+			}
 			this->key = key2;
 			get_key_refs(&key2);
 			drop_count++;
 
 			if (ret - nr_wake >= nr_requeue)
 				break;
-			/* Make sure to stop if key1 == key2: */
-			if (head1 == &hb2->chain && head1 != &next->list)
-				head1 = &this->list;
 		}
 	}
 
