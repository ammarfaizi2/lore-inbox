Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSKTPaH>; Wed, 20 Nov 2002 10:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261318AbSKTPaH>; Wed, 20 Nov 2002 10:30:07 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:59544 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S261317AbSKTPaF>; Wed, 20 Nov 2002 10:30:05 -0500
Date: Wed, 20 Nov 2002 07:40:48 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [2.4, 2.5, USB] locking issue
To: Greg KH <greg@kroah.com>, Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Message-id: <3DDBAD00.3010500@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <E18Dmyi-000FRS-00@f16.mail.ru> <20021120084532.GD22936@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Nov 18, 2002 at 05:34:20PM +0300, Samium Gromoff wrote:
> 
>>        The possible problem is encountered in ehci-q.c and ehci-sched.c
>>  in 2.4.19-pre9 and in one occurence in ehci-q.c of 2.5.47.

It's not a problem, see below.  The 2.5 code is better, since only one
body of code is managing the TD queues for async (control, bulk) and
interrupt queue heads.


>>        the offending pattern is the same in both files:
>>
>>        if (!list_empty (qtd_list)) {
>> -----------------------8<----------------------------------------------
>>                list_splice (qtd_list, &qh->qtd_list);
>>                qh_update (qh, list_entry (qtd_list->next, struct ehci_qtd, qtd_list));
>> -----------------------8<----------------------------------------------
>>        } else {
>>                qh->hw_qtd_next = qh->hw_alt_next = EHCI_LIST_END;
>>        }

Slightly different in 2.5.48 since it uses a dummy TD (so certain race
conditions can't happen), and it won't line-wrap that qh_update() call.


>>        since list_splice() the qtd_list is diposed of its belongings and
>>        immediately in the next line we rely on qtd_list->next to point
>>        at an existing list_head.
>>
>>        i haven`t noticed any locking out there, and i`m afraid of what
>>        could result from a preemption happening between these two lines.
> 
> 
> Um, David, any thoughts about this?

That code runs under a spinlock_irqsave(&ehci->lock,...), so no
other task can preempt.  And list_splice() doesn't modify qtd_list,
so the qtd_list->next pointer stays valid ... it's like list_del(),
not list_del_init(), read <linux/list.h> to see.

- Dave



