Return-Path: <linux-kernel-owner+w=401wt.eu-S1161353AbXAHShh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161353AbXAHShh (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 13:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161354AbXAHShh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 13:37:37 -0500
Received: from mga03.intel.com ([143.182.124.21]:32530 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161353AbXAHShg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 13:37:36 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,160,1167638400"; 
   d="scan'208"; a="166553927:sNHT21281981"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Date: Mon, 8 Jan 2007 10:37:25 -0800
Message-ID: <EB12A50964762B4D8111D55B764A845401169937@scsmsx413.amr.corp.intel.com>
In-Reply-To: <20070108170635.GA448@tv-sign.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Thread-Index: AcczR7r5oF+yHXm5RJGlwHu8IzPItwACYLVw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Oleg Nesterov" <oleg@tv-sign.ru>, "Srivatsa Vaddagiri" <vatsa@in.ibm.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "David Howells" <dhowells@redhat.com>,
       "Christoph Hellwig" <hch@infradead.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Linus Torvalds" <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Gautham shenoy" <ego@in.ibm.com>
X-OriginalArrivalTime: 08 Jan 2007 18:37:26.0471 (UTC) FILETIME=[0B63D570:01C73354]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Oleg Nesterov
>Sent: Monday, January 08, 2007 9:07 AM
>To: Srivatsa Vaddagiri
>Cc: Andrew Morton; David Howells; Christoph Hellwig; Ingo 
>Molnar; Linus Torvalds; linux-kernel@vger.kernel.org; Gautham shenoy
>Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
>
>On 01/08, Srivatsa Vaddagiri wrote:
>>
>> On Mon, Jan 08, 2007 at 06:56:38PM +0300, Oleg Nesterov wrote:
>> > > 2.
>> > >
>> > > CPU_DEAD->cleanup_workqueue_thread->(cwq->thread = 
>NULL)->kthread_stop() ..
>> > > 				    ^^^^^^^^^^^^^^^^^^^^
>> > > 						|___ Problematic
>> > 
>> > Hmm... This should not be possible? cwq->thread != NULL on 
>CPU_DEAD event.
>> 
>> sure, cwq->thread != NULL at CPU_DEAD event. However
>> cleanup_workqueue_thread() will set it to NULL and block in
>> kthread_stop(), waiting for the kthread to finish run_workqueue and
>> exit.
>
>Ah, missed you point, thanks. Yet another old problem which 
>was not introduced
>by recent changes. And yet another indication we should avoid 
>kthread_stop()
>on CPU_DEAD event :) I believe this is easy to fix, but need 
>to think more.

The current code is workqueue-hptplug path is full of races. I stumbled
upon atleast couple of different deadlock situations being discussed
here with ondemand governor using workqueue and trying to flush during
cpu hot remove.

Specifically, a three way deadlock involving kthread_stop() with
workqueue_mutex held and work itself blocked on some other mutex held by
another task trying to flush the workqueue.

One other approach I was thinking about, was to do all the hardwork in
workqueue CPU_DOWN_PREPARE callback rather than in CPU_DEAD.
We can call cleanup_workqueue_thread and take_over_work in DOWN_PREPARE,
With that, I don't think we need to hold the workqueue_mutex across 
these two callbacks and eliminate the deadlocks related to
flush_workqueue.
Do you think this approach would simply things around here?

Thanks,
Venki 
