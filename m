Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTJPG1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 02:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTJPG1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 02:27:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:38828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262114AbTJPG1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 02:27:20 -0400
Date: Wed, 15 Oct 2003 23:31:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: wli@holomorphy.com, albertogli@telpin.com.ar, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5/6 (and probably 7 too) size-4096 memory leak
Message-Id: <20031015233102.05eb809b.akpm@osdl.org>
In-Reply-To: <3F8E2F68.7010007@colorfullife.com>
References: <20031016025554.GH4292@telpin.com.ar>
	<20031015211918.1a70c4d2.akpm@osdl.org>
	<20031016044334.GE4461@holomorphy.com>
	<20031015215824.165dc4c7.akpm@osdl.org>
	<3F8E2F68.7010007@colorfullife.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> I've attached something: with the patch applied, `echo "size-4096 0 0 0" 
>   > /proc/slabinfo` dumps all caller addresses.

Awesome, thanks.

I added some tweaks (why was it returning -EINVAL?).

Is there any reason why we shouldn't merge this up?



 mm/slab.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff -puN mm/slab.c~slab-leak-detector-tweaks mm/slab.c
--- 25/mm/slab.c~slab-leak-detector-tweaks	2003-10-15 23:11:19.000000000 -0700
+++ 25-akpm/mm/slab.c	2003-10-15 23:17:12.000000000 -0700
@@ -2708,6 +2708,7 @@ struct seq_operations slabinfo_op = {
 
 static void do_dump_slabp(kmem_cache_t *cachep)
 {
+#if DEBUG
 	struct list_head *q;
 
 	check_irq_on();
@@ -2716,10 +2717,17 @@ static void do_dump_slabp(kmem_cache_t *
 		struct slab *slabp;
 		int i;
 		slabp = list_entry(q, struct slab, list);
-		for (i=0;i<cachep->num;i++)
-			printk(KERN_DEBUG "obj %p/%d: %p\n", slabp, i, (void*)(slab_bufctl(slabp)[i]));
+		for (i = 0; i < cachep->num; i++) {
+			unsigned long sym = slab_bufctl(slabp)[i];
+
+			printk(KERN_DEBUG "obj %p/%d: %p",
+					slabp, i, (void *)sym);
+			print_symbol(" <%s>", sym);
+			printk("\n");
+		}
 	}
 	spin_unlock_irq(&cachep->spinlock);
+#endif
 }
 
 #define MAX_SLABINFO_WRITE 128
@@ -2763,9 +2771,10 @@ ssize_t slabinfo_write(struct file *file
 			    batchcount > limit ||
 			    shared < 0) {
 				do_dump_slabp(cachep);
-				res = -EINVAL;
+				res = 0;
 			} else {
-				res = do_tune_cpucache(cachep, limit, batchcount, shared);
+				res = do_tune_cpucache(cachep, limit,
+							batchcount, shared);
 			}
 			break;
 		}

_

