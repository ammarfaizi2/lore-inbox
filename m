Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933397AbWKWJYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397AbWKWJYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933415AbWKWJYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:24:49 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:5751 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S933397AbWKWJYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:24:48 -0500
Message-ID: <456567DD.6090703@openvz.org>
Date: Thu, 23 Nov 2006 12:20:29 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@sw.ru>,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       matthltc@us.ibm.com, hch@infradead.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, oleg@tv-sign.ru, devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/13] BC: context handling
References: <45535C18.4040000@sw.ru> <45535E11.20207@sw.ru>	 <6599ad830611222348o1203357tea64fff91edca4f3@mail.gmail.com>	 <45655D3E.5020702@openvz.org> <6599ad830611230053m7182698cu897abe5d19471aff@mail.gmail.com>
In-Reply-To: <6599ad830611230053m7182698cu897abe5d19471aff@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 11/23/06, Pavel Emelianov <xemul@openvz.org> wrote:
>>
>> We can do the following:
>>
>>   if (tsk == current)
>>       /* fast way */
>>       tsk->exec_bc = bc;
>>   else
>>       /* slow way */
>>       stop_machine_run(...);
>>
>> What do you think?
> 
> How about having two pointers per task:
> 
> - exec_bc, which is the one used for charging
> - real_bc, which is the task's actual beancounter
> 
> at the start of irq, do
> 
> current->exec_bc = &init_bc;
> 
> at the end of irq, do
> 
> current->exec_bc = current->real_bc;
> 
> When moving a task to a different bc do:
> 
> task->real_bc = new_bc;
> atomic_cmpxchg(&task->exec_bc, old_bc, new_bc);

You mean moving is like this:

old_bc = task->real_bc;
task->real_bc = new_bc;
cmpxchg(&tsk->exec_bc, old_bc, new_bc);

? Then this won't work:

Initialisation:
current->exec_bc = init_bc;
current->real_bc = init_bc;
...
IRQ:
current->exec_bc = init_bc;
...
                             old_bc = tsk->real_bc; /* init_bc */
                             tsk->real_bc = bc1;
                             cx(tsk->exec_bc, init_bc, bc1); /* ok */
...
Here at the middle of an interrupt
we have bc1 set as exec_bc on task
which IS wrong!
...
current->exec_bc =
        current->real_bc;

We need some way to be sure that task isn't running at
the moment we change it's beancounter. Otherwise we're
risking that we'll spoil some temporary context.

> (with appropriate memory barriers). So if the task is in an irq with a
> modified exec_bc pointer, we do nothing, otherwise we update exec_bc
> to point to the new real_bc.
> 
> Paul
