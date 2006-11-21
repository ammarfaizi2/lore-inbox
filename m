Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030681AbWKUIGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030681AbWKUIGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 03:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030726AbWKUIGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 03:06:30 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:52530 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030681AbWKUIG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 03:06:28 -0500
Message-ID: <4562B256.8080901@sw.ru>
Date: Tue, 21 Nov 2006 11:01:26 +0300
From: Pavel Emelianov <xemul@sw.ru>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>
Subject: Re: [RFC] [PATCH] Fix misrouted interrupts deadlocks
References: <455484E4.1020100@openvz.org> <20061120192335.GA11879@in.ibm.com> <20061120195652.GA6141@in.ibm.com>
In-Reply-To: <20061120195652.GA6141@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:
> On Mon, Nov 20, 2006 at 02:23:35PM -0500, Vivek Goyal wrote:
>> On Fri, Nov 10, 2006 at 04:55:48PM +0300, Pavel Emelianov wrote:
>>> As the second lock on booth CPUs is taken before checking that
>>> this irq is being handled in another processor this may cause
>>> a deadlock. This issue is only theoretical.
>>>
>>> I propose the attached patch to fix booth problems: when trying
>>> to handle misrouted IRQ active desc->lock may be unlocked.
>>>
>>> Please comment.
>>> --- ./kernel/irq/spurious.c.irqlockup	2006-11-09 11:19:10.000000000 +0300
>>> +++ ./kernel/irq/spurious.c	2006-11-10 16:53:38.000000000 +0300
>>> @@ -147,7 +147,11 @@ void note_interrupt(unsigned int irq, st
>>>  	if (unlikely(irqfixup)) {
>>>  		/* Don't punish working computers */
>>>  		if ((irqfixup == 2 && irq == 0) || action_ret == IRQ_NONE) {
>>> -			int ok = misrouted_irq(irq);
>>> +			int ok;
>>> +
>>> +			spin_unlock(&desc->lock);
>>> +			ok = misrouted_irq(irq);
>>> +			spin_lock(&desc->lock);
>> Hi Pavel,
>>
>> Till -rc5, I was able to boot a kernel with irqpoll option and in -rc6 I 
>> can't. It simply hangs. I suspect it is realted to this change. I have yet
>> to confirm that. But before that one observation.
>>
> 
> Hi Pavel,
> 
> If I backout your changes, everything works fine. So it looks like that
> the problem I am facing is because of your patch but I don't have a logical
> explanation yet that why the problem is there. Just realasing a lock
> which is not currently acquired should not hang the system?

Without this patch my kernel hanged in another place.
I'll look over the interrupt code again. I suspect that
just another fix is required.
