Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933043AbWKWIje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043AbWKWIje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933071AbWKWIje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:39:34 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:2579 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S933043AbWKWIjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:39:33 -0500
Message-ID: <45655D3E.5020702@openvz.org>
Date: Thu, 23 Nov 2006 11:35:10 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Paul Menage <menage@google.com>
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       matthltc@us.ibm.com, hch@infradead.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, oleg@tv-sign.ru, devel@openvz.org,
       xemul@openvz.org
Subject: Re: [ckrm-tech] [PATCH 4/13] BC: context handling
References: <45535C18.4040000@sw.ru> <45535E11.20207@sw.ru> <6599ad830611222348o1203357tea64fff91edca4f3@mail.gmail.com>
In-Reply-To: <6599ad830611222348o1203357tea64fff91edca4f3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menage wrote:
> On 11/9/06, Kirill Korotaev <dev@sw.ru> wrote:
>> +
>> +int bc_task_move(int pid, struct beancounter *bc, int whole)
>> +{
> 
> ...
> 
>> +
>> +       down_write(&mm->mmap_sem);
>> +       err = stop_machine_run(do_set_bcid, &data, NR_CPUS);
>> +       up_write(&mm->mmap_sem);
> 
> Isn't this a little heavyweight for moving a task into/between
> beancounters?

It's a main reason we were against moving arbitrary task.

We need to track the situation when we change beancounter on
task that is currently handles an interrupt and thus set a
temporary BC as exec one. I see no other way that keeps pair
set_exec_bc()/get_exec_bc() lock-less.

The problem is even larger than I've described. set_exec_bc()
is used widely in OpenVZ beancounters to set temporary context
e.g. for skb handling. Thus we need some safe way to "catch"
the task in a "safe" place. In OpenVZ we solve this by moving
only current into beancounter. In this patch set we have to
move arbitrary task and thus - such complication.

I repeat - we can do this w/o stop_machine, but this would
require locking in set_exec_bc()/get_exec_bc() but it's too
bad. Moving tasks happens rarely but setting context is a
very common operation (e.g. in each interrupt).

We can do the following:

  if (tsk == current)
      /* fast way */
      tsk->exec_bc = bc;
  else
      /* slow way */
      stop_machine_run(...);

What do you think?

> Paul
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

