Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbREULze>; Mon, 21 May 2001 07:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbREULzZ>; Mon, 21 May 2001 07:55:25 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:49157 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S261719AbREULzM>; Mon, 21 May 2001 07:55:12 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Mon, 21 May 2001 13:51:38 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: (Fwd) about timer in linux kernel.
Message-ID: <3B091D6A.238.1417682@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
X-Content-Conformance: HerringScan-0.1/SWEEP Version 3.43, March 2001 
X-Content-Conformance: LittleSister-2.1/0.0.100644.20010521.094425Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe one of the people having written the code want to explain...

Thanks, Ulrich
------- Forwarded message follows -------
From:           	"meng-ju" <mengju@research.att.com>
To:             	<Ulrich.Windl@rz.uni-regensburg.de>
Subject:        	about timer in linux kernel.
Date sent:      	Fri, 18 May 2001 16:58:55 -0700

Hi! Mr. Ulrich Windl,
 
I want to know how timer works in kernel.
When we call add_timer(), it will call add_timer_internal to add it to its list.
Now I am confused how the system checks if it is expired or not?
In run_timer_list(), 
Why it uses tv1.vec + tv1.index to find out the expiration point while in add_timer_internal(), the expiration timer minus timer_jiffies?
I don't understand what roles jiffies, timer_jiffies and tv1.index play.
Thanks for your patient and answering.
 
static inline void run_timer_list(void)
{
         spin_lock_irq(&timerlist_lock);
         while ((long)(jiffies - timer_jiffies) >= 0) {
                 struct list_head *head, *curr;
                 if (!tv1.index) {
                         int n= 1;
                         do {
                                cascade_timers(tvecs[n]);
                         } while (tvecs[n]->index == 1 && ++n < NOOF_TVECS);
                 }
repeat:
                head = tv1.vec + tv1.index;
                curr = head->next;
                if (curr != head) {
                        struct timer_list *timer;
                        void (*fn)(unsigned long);
                        unsigned long data;

                        timer = list_entry(curr, struct timer_list, list);
                        fn = timer->function;
                        data= timer->data;

                        detach_timer(timer);
                        timer->list.next = timer->list.prev = NULL;
                        timer_enter(timer);
                        spin_unlock_irq(&timerlist_lock);
                        fn(data);
                        spin_lock_irq(&timerlist_lock);
                        timer_exit();
                        goto repeat;
                }
                ++timer_jiffies;
           tv1.index = (tv1.index + 1) & TVR_MASK;
        }
........

Meng-Ju

------- End of forwarded message -------
