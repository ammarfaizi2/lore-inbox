Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933465AbWKWKAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933465AbWKWKAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757307AbWKWKAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:00:19 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:41663 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1757306AbWKWKAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:00:18 -0500
Message-ID: <45657030.7050009@openvz.org>
Date: Thu, 23 Nov 2006 12:56:00 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       matthltc@us.ibm.com, hch@infradead.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, oleg@tv-sign.ru, devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/13] BC: context handling
References: <45535C18.4040000@sw.ru> <45535E11.20207@sw.ru>	 <6599ad830611222348o1203357tea64fff91edca4f3@mail.gmail.com>	 <45655D3E.5020702@openvz.org>	 <6599ad830611230053m7182698cu897abe5d19471aff@mail.gmail.com>	 <456567DD.6090703@openvz.org> <6599ad830611230131w1bf63dc1m1998b55b61579509@mail.gmail.com>
In-Reply-To: <6599ad830611230131w1bf63dc1m1998b55b61579509@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 11/23/06, Pavel Emelianov <xemul@openvz.org> wrote:
>> You mean moving is like this:
>>
>> old_bc = task->real_bc;
>> task->real_bc = new_bc;
>> cmpxchg(&tsk->exec_bc, old_bc, new_bc);
>>
>> ? Then this won't work:
>>
>> Initialisation:
>> current->exec_bc = init_bc;
>> current->real_bc = init_bc;
>> ...
>> IRQ:
>> current->exec_bc = init_bc;
>> ...
>>                              old_bc = tsk->real_bc; /* init_bc */
>>                              tsk->real_bc = bc1;
>>                              cx(tsk->exec_bc, init_bc, bc1); /* ok */
>> ...
>> Here at the middle of an interrupt
>> we have bc1 set as exec_bc on task
>> which IS wrong!
> 
> You could get round that by having a separate "irq_bc" that's never
> valid for a task not in an interrupt.

No no no. This is not what is needed. You see, we do have to
set exec_bc as temporary (and atomic) context. Having temporary
context is 1. flexible 2. needed by beancounters' network accountig.
We have to track this particular scenario.

Moreover making get_exec_bc() as
if (in_interrupt())
	return &irq_bc;
else
	return current->exec_bc;
is awful. It must me simple and stupid to allow us making temporary
contexts in any place of code.

Maybe we can make smth similar to wait_task_inactive and change
it's beancounter before unlocking the runqueue?

> Paul
> 
