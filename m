Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293596AbSCPAbB>; Fri, 15 Mar 2002 19:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293599AbSCPAaw>; Fri, 15 Mar 2002 19:30:52 -0500
Received: from web13605.mail.yahoo.com ([216.136.175.116]:38668 "HELO
	web13605.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293596AbSCPAal>; Fri, 15 Mar 2002 19:30:41 -0500
Message-ID: <20020316003040.99460.qmail@web13605.mail.yahoo.com>
Date: Fri, 15 Mar 2002 16:30:40 -0800 (PST)
From: Balbir Singh <balbir_soni@yahoo.com>
Subject: [PATCH] mempool_resize and sanity checks
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
