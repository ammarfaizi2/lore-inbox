Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293602AbSCPAiv>; Fri, 15 Mar 2002 19:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSCPAin>; Fri, 15 Mar 2002 19:38:43 -0500
Received: from web13609.mail.yahoo.com ([216.136.174.9]:58130 "HELO
	web13609.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293602AbSCPAif>; Fri, 15 Mar 2002 19:38:35 -0500
Message-ID: <20020316003834.85626.qmail@web13609.mail.yahoo.com>
Date: Fri, 15 Mar 2002 16:38:34 -0800 (PST)
From: Balbir Singh <balbir_soni@yahoo.com>
Subject: Re: [PATCH] mempool_resize and sanity checks
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: balbir_soni@yahoo.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-136897776-1016239114=:84439"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-136897776-1016239114=:84439
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

For some reason, it seems that the diffs did not
make it. Resending them


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In mempool_resize(), I plan to replace the calls
to spin_unlock_irqrestore() -> pool_free -> spin_lock_
irqsave with the new sequence. The newer code
has fewer calls to spin_lock_irqsave and spin_unlock_
restore(). I think the new code should execute faster.

I have tested this code on a UP, if somebody could
test the patch on an SMP box and let me know if it
works, I would be thankful. I also have a sample test
case that uses mempool_resize().

I have also added the BUG_ON sanity checks in
mempool_create().

New Code

if (new_min_nr < pool->min_nr) {
        pool->min_nr = new_min_nr;
        /*      
         * Free possible excess elements.
         */      
        INIT_LIST_HEAD(&tmp_pool_to_free);
        while (pool->curr_nr > pool->min_nr) {
                tmp = pool->elements.next;
                if (tmp == &pool->elements)
                        BUG();  
                list_del(tmp);
                list_add(tmp, &tmp_pool_to_free);
                pool->curr_nr--;
        }       
        spin_unlock_irqrestore(&pool->lock, flags);

        list_for_each(tmp, &tmp_pool_to_free) {
                element = tmp;
                pool->free(element, pool->pool_data);
        }       
        return; 
}       


Original Code

if (new_min_nr < pool->min_nr) {
        pool->min_nr = new_min_nr;
        /*
         * Free possible excess elements.
         */
        while (pool->curr_nr > pool->min_nr) {
                tmp = pool->elements.next;
                if (tmp == &pool->elements)
                        BUG();
                list_del(tmp);
                element = tmp;
                pool->curr_nr--;
                spin_unlock_irqrestore(&pool->lock,
flags);

                pool->free(element, pool->pool_data);

                spin_lock_irqsave(&pool->lock, flags);
        }
        spin_unlock_irqrestore(&pool->lock, flags);
        return;
}

Diffs are attached.

Balbir

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
--0-136897776-1016239114=:84439
Content-Type: text/plain; name="mempool.c.diff.txt"
Content-Description: mempool.c.diff.txt
Content-Disposition: inline; filename="mempool.c.diff.txt"

--- mempool.c	Tue Mar 12 19:21:33 2002
+++ mempool.c.new	Tue Mar  5 10:37:19 2002
@@ -34,6 +34,9 @@
 	mempool_t *pool;
 	int i;
 
+	BUG_ON(!alloc_fn);
+	BUG_ON(!free_fn);
+
 	pool = kmalloc(sizeof(*pool), GFP_KERNEL);
 	if (!pool)
 		return NULL;
@@ -97,6 +100,7 @@
 	void *element;
 	unsigned long flags;
 	struct list_head *tmp;
+	struct list_head tmp_pool_to_free;
 
 	if (new_min_nr <= 0)
 		BUG();
@@ -107,20 +111,21 @@
 		/*
 		 * Free possible excess elements.
 		 */
+		INIT_LIST_HEAD(&tmp_pool_to_free);
 		while (pool->curr_nr > pool->min_nr) {
 			tmp = pool->elements.next;
 			if (tmp == &pool->elements)
 				BUG();
 			list_del(tmp);
-			element = tmp;
+			list_add(tmp, &tmp_pool_to_free);
 			pool->curr_nr--;
-			spin_unlock_irqrestore(&pool->lock, flags);
+		}
+		spin_unlock_irqrestore(&pool->lock, flags);
 
+		list_for_each(tmp, &tmp_pool_to_free) {
+			element = tmp;
 			pool->free(element, pool->pool_data);
-
-			spin_lock_irqsave(&pool->lock, flags);
 		}
-		spin_unlock_irqrestore(&pool->lock, flags);
 		return;
 	}
 	delta = new_min_nr - pool->min_nr;

--0-136897776-1016239114=:84439--
