Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291798AbSBNR23>; Thu, 14 Feb 2002 12:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291800AbSBNR2U>; Thu, 14 Feb 2002 12:28:20 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41645 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S291798AbSBNR2M>;
	Thu, 14 Feb 2002 12:28:12 -0500
Date: Thu, 14 Feb 2002 09:27:46 -0800
From: kravetz@us.ibm.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: bug/code cleanup for O(1)-K3
Message-ID: <20020214092746.A1195@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the K3 version of the O(1) scheduler for 2.4.17 there is
either a bug or an opportunity for some code cleanup.  At
the beginning of the load_balance() routine we set the local
variable 'nr_running' and use this variable to calculate the
value of 'imbalance'.  After this the variable is not used,
even though we go to the trouble of passing it to
double_lock_balance() so that it can be possibly be recomputed.
Note the code:

        imbalance = (max_load - nr_running) / 2;

        /* It needs an at least ~25% imbalance to trigger balancing. */
        if (!idle && (imbalance < (max_load + 3)/4))
                return;

        nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
        /*
         * Make sure nothing changed since we checked the
         * runqueue length.
         */
        if (busiest->nr_running <= this_rq->nr_running + 1)
                goto out_unlock;


In the last if statement above, I suspect we want to compare
'busiest->nr_running' to the local variable nr_running (as was
done in previous versions of the code).  If this is not the
case, then we can simplify double_lock_balance() and make it
return a void.

P.S. I've only been working with the 2.4.17 version of the patch,
but I assume the code is the same in other versions.
-- 
Mike
