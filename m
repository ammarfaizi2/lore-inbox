Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274806AbRJFKIc>; Sat, 6 Oct 2001 06:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275114AbRJFKIX>; Sat, 6 Oct 2001 06:08:23 -0400
Received: from ns.ithnet.com ([217.64.64.10]:47622 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S274806AbRJFKIO>;
	Sat, 6 Oct 2001 06:08:14 -0400
Date: Sat, 6 Oct 2001 12:08:32 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>
Subject: VM deadlock in 2.4.11-pre4 (yes, it's me again :-)
Message-Id: <20011006120832.4773192e.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the time has come again for my monthly stress-testing of new kernels :-)
I installed 2.4.11-pre4 and ran it for a day. It was really strange for me to
see _no_ alloc failures at all, and that's why I gave it a closer look (alan
fooled me once by deleting the printk, which made the problem "disappear" too
:-). And here it is (from page_alloc.c):

 rebalance:
        page = balance_classzone(classzone, gfp_mask, order, &freed);
        if (page)
                return page;  

        zone = zonelist->zones;
        if (likely(freed)) {
                for (;;) {
                        zone_t *z = *(zone++);
                        if (!z)
                                break;

                        if (zone_free_pages(z, order) > z->pages_min) {
                                page = rmqueue(z, order);
                                if (page)
                                        return page;   
                        }
                }
                goto rebalance;
        } else {
                /* 
                 * Check that no other task is been killed meanwhile,
                 * in such a case we can succeed the allocation.
                 */
                for (;;) {
                        zone_t *z = *(zone++);
                        if (!z)
                                break;

                        if (zone_free_pages(z, order) > z->pages_min) {
                                page = rmqueue(z, order);
                                if (page)
                                        return page;
                        }
                }

                goto rebalance;
        }

        printk(KERN_NOTICE "%s __alloc_pages: %u-order allocation failed
(gfp=0x%x/%i) from %p\n",
               current->comm, order, gfp_mask, !!(current->flags &
PF_MEMALLOC), __builtin_return_address(0));
/* my stuff :-) */
        if (order==0)
                show_trace(NULL);
        return NULL;
}


As you can see I patched some more info output on certain alloc-failures. But
unfortunately I did not read the lines above - up to now. As you can see the
printk cannot be reached at all, because both if-cases jump to rebalance - not
matter how comes.
When I wrote the first version of this posting, I wrote: this looks like a
possible deadlock to me, because it cycles forever when no pages are found. I
proved myself right this time, because when I tried to send the mail and
started a CD burn at the background, the host froze. As you may remember the CD
burns always gave me alloc-failures during startup in earlier kernel versions.
So it is pretty obvious I reached the deadlock this time.
Another thing I would like to kindly ask: what is the difference in the two if
branches? As I cannot read really well (already proven in another thread :-), I
am very willing to accept any explanation on this code ;-)
If someone else has asked the whole thing before: shoot me.

Regards,
Stephan

