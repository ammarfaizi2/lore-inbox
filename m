Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWIFNXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWIFNXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWIFNXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:23:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:16862 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750831AbWIFNXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:23:35 -0400
Message-ID: <44FECBCF.7080103@in.ibm.com>
Date: Wed, 06 Sep 2006 18:53:27 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Pavel Emelianov <xemul@openvz.org>
Cc: Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ckrm-tech] [PATCH 5/13] BC: user interface (syscalls)
References: <44FD918A.7050501@sw.ru> <44FD9699.705@sw.ru>	<44FDA024.7030700@in.ibm.com> <44FE86EF.3050101@openvz.org>	<44FE8D82.3060103@in.ibm.com> <44FEA628.9020505@openvz.org>
In-Reply-To: <44FEA628.9020505@openvz.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Emelianov wrote:
> Balbir Singh wrote:
>> Pavel Emelianov wrote:
>>> Balbir Singh wrote:
>>>>> +
>>>>> +asmlinkage long sys_set_bcid(bcid_t id)
>>>>> +{
>>>>> +    int error;
>>>>> +    struct beancounter *bc;
>>>>> +    struct task_beancounter *task_bc;
>>>>> +
>>>>> +    task_bc = &current->task_bc;
>>>> I was playing around with the bc patches and found that to make
>>>> use of bc's, I had to actually call set_bcid() and then exec() a
>>>> task/shell so that the id would stick around. Would you consider
>>> That sounds very strange as sys_set_bcid() actually changes current's
>>> exec_bc.
>>> One note is about mm's bc - mm obtains new bc only after fork or exec -
>>> that's
>>> true. But kmemsize starts charging right after the sys_set_bcid.
>> I was playing around only with kmemsize. I think the reason for my
>> observation
>> is this
>>
>> bash --> (my utility) --> set_bcid()
>>
>> Since bash spawns my utility in a separate process, it creates and
>> assigns
>> a bean counter to it and then my utility exits. Unless it
>> spawns/exec()'s a
>> new shell, the beancounter is freed when the task exits (my utility).
> Well, beancounter is not "inherited" by parent task :)
> After setting bcid you need to spawn/exec a new shell.
> But seeting limits and getting stats is possible from the old shell
> as well as from the new one.

That's what I suspected. I suggest changing the system call to allow adding any
task to a particular id (not necessarily only the current one). It would help us
group tasks to a particular id. It would also solve my problem of spawning a
shell each time I decide to use a task with a beancounter and limits.

>>>> changing sys_set_bcid to sys_set_task_bcid() or adding a new
>>>> system call sys_set_task_bcid()? We could pass the pid that we
>>>> intend to associate with the new id. This also means we'll need
>>>> locking around to protect task->task_bc.
>>

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
