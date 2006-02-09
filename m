Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWBIVIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWBIVIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 16:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWBIVIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 16:08:15 -0500
Received: from mail.windriver.com ([147.11.1.11]:4008 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id S1750786AbWBIVIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 16:08:14 -0500
Message-ID: <43EBAF34.1020105@windriver.com>
Date: Thu, 09 Feb 2006 16:08:04 -0500
From: martin rogers <martin.rogers@windriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Help with 2.6.10 concurrency issue
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Feb 2006 21:08:05.0666 (UTC) FILETIME=[EB9CC820:01C62DBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
I need help with a concurrency issue on 2.6.10.
CONFIG_PREEMPT not set, but my code must run on both uni and SMP systems.


I have a function, that runs from a tastlet:

void readlist(unsigned long arg)
{    
  int flags;
  my_type *entry, *n;

  if (list_empty(&mylist.list)) return;
  list_for_each_entry_safe(entry, n, &mylist.list, list)
  {
        spin_lock_irqsave(&mylock, flags); // protect against intr
        list_del(&entry->list);
        spin_unlock_irqrestore(&mylock, flags);
        INIT_LIST_HEAD(&entry->list);
        do_stuff(entry);
  }
}


And the func that puts things on the list:

void writeList(my_type *record)
{
  spin_lock(&mylock);
  list_add_tail(&record->list, &mylist.list);
  spin_unlock(&mylock);
  tasklet_schedule(&mytasklet.tlet);
}


Problem is, the function writeList can be called from a H/W intr,
and a workqueue (and that intr could of course happen while either
the workqueue or the tasklet is running, right?).

If I use spin_lock_irqsave in writeList, it protects against the intr
but not the tasklet.  If I use spin_lock_bh, I don't get protection
from the intr I think; plus, I get :

Badness in local_bh_enable at kernel/softirq.c:142

when the intr runs (what does this mean?).

So, how can I protect my data (my list) from both intrs (calling
writeList) and the tasklet (calling readList) while the workqueue is
inside of writeList?  Combination of spin_lock_irqsave and local_bh_disable
inside writeList ?

Thanks to all,
Martin Rogers
Wind River

