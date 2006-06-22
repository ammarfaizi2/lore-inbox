Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWFVJ2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWFVJ2l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWFVJ2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:28:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:28533 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161023AbWFVJ2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:28:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=ishR7ITCgmh2SLjzjyCXbeg3h9L2iq4tbe3TjPHEJdMYMdVpruPr4IjSzWZ3tpO72jSgn3QoCTeW5X/bjZevMYRSvvS597wVZ46AkLKhL46s2X7KENRjJEtkNU83REe3gVvVj7pS/dpeUbd1RI+RkYJrovHNdbATQyn2OFOV7PU=
Date: Thu, 22 Jun 2006 11:28:42 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       Esben Nielsen <nielsen.esben@gogglemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <20060621183042.GB1693@elte.hu>
Message-ID: <Pine.LNX.4.64.0606220035420.10077@localhost.localdomain>
References: <1150816429.6780.222.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
 <1150824092.6780.255.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain>
 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain>
 <1150907165.25491.4.camel@localhost.localdomain> <20060621183042.GB1693@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Ingo Molnar wrote:

>
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> On Wed, 2006-06-21 at 16:43 +0100, Esben Nielsen wrote:
>>> What about the patch below. It compiles and my UP labtop runs fine, but I
>>> haven't otherwise tested it.  My labtop runs RTExec without hichups
>>> until now.
>>
>> NAK, it puts the burden into the lock path and also does a remove /
>> add which results in walking the chain twice.
>>
>> Find an version against the code in -mm below. Not too much tested
>> yet.
>
> i like this one - it does the prio fixup where it should be done.

I disagree. I think the work should be done by the task which is blocked.
I can't see the work belongs to the one calling setschedule() - especially 
if that is in interrupt context.

A good principle in real-time system programming is to push at most work 
as possible to as low a priority as possible while still meeting the required 
deadlines. If you don't, you unneedingly increase the latency associated 
with the higher priority.

Let us say you the increase the priority of a task with setscheduler():
The espected latency can never be better than the one associated with the 
current task, nor can it be better than the target priority. Therefore the 
job of fixing the priorities should be done in the lowest priority of
current's priority and the target priority.

Let us say you the decrease the priority of a task with setscheduler():
You need to boost tasks out of the high priority with the latency 
associated with that priority, but the overall latency can never be 
expected to be higher that the priority of at which setscheduler() is 
running. Therefore the job of fixing the priorities should be donee in the 
lowest priority of the current priority and the previous priority of the 
target task.

Neither of the patches by Thomas and me does it optimal in all cases.

Esben

>
> 	Ingo
>
