Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264963AbUFGRu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbUFGRu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 13:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264959AbUFGRu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 13:50:29 -0400
Received: from fmr05.intel.com ([134.134.136.6]:13797 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264963AbUFGRuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 13:50:20 -0400
Reply-To: <anil.s.keshavamurthy@intel.com>
From: "Anil" <anil.s.keshavamurthy@intel.com>
To: "'Rusty Russell'" <rusty@rustcorp.com.au>, "Andrew Morton" <akpm@osdl.org>
Cc: "lkml - Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] speedup flush_workqueue for singlethread_workqueue
Date: Mon, 7 Jun 2004 10:46:50 -0700
Organization: Intel
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRLa59HMkvC1C4hQr+TWlOQHQnfnABSJgPA
In-Reply-To: <1086487875.11456.23.camel@bach>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-ID: <ORSMSX409FRaqbC8wSA00000003@orsmsx409.amr.corp.intel.com>
X-OriginalArrivalTime: 07 Jun 2004 17:46:51.0731 (UTC) FILETIME=[6A2D8230:01C44CB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
	In the flush_workqueue, can we move lock_cpu_hotplug()/unlock_cpu_hotplug only for _non_single_threaded_ case as shown below
as these locks are not required for single_threaded_workqueue.

Thanks,
Anil	

The attached patch applies on top of your changes.
Signed-off-by: Anil Keshavamurthy <anil.s.keshavamurthy@intel.com>
---

 linux-2.6.7-rc2-mm2-root/kernel/workqueue.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN kernel/workqueue.c~andrew2 kernel/workqueue.c
--- linux-2.6.7-rc2-mm2/kernel/workqueue.c~andrew2	2004-06-07 18:45:20.332139681 -0700
+++ linux-2.6.7-rc2-mm2-root/kernel/workqueue.c	2004-06-07 18:46:09.560680511 -0700
@@ -262,7 +262,6 @@ static void flush_cpu_workqueue(struct c
 void fastcall flush_workqueue(struct workqueue_struct *wq)
 {
  	might_sleep();
- 	lock_cpu_hotplug();
 
 	if (is_single_threaded(wq)) {
 		/* Always use cpu 0's area. */
@@ -270,11 +269,12 @@ void fastcall flush_workqueue(struct wor
 	} else {
 		int cpu;
  
+ 		lock_cpu_hotplug();
 		for_each_online_cpu(cpu)
 			flush_cpu_workqueue(wq->cpu_wq + cpu);
+ 		unlock_cpu_hotplug();
  	}
 
- 	unlock_cpu_hotplug();
 }
 
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,

_

 	

>-----Original Message-----
>From: Rusty Russell [mailto:rusty@rustcorp.com.au] 
>Sent: Saturday, June 05, 2004 7:11 PM
>To: Andrew Morton
>Cc: Keshavamurthy, Anil S; lkml - Kernel Mailing List
>Subject: Re: [PATCH] speedup flush_workqueue for singlethread_workqueue
>
>On Sat, 2004-06-05 at 08:30, Andrew Morton wrote:
>> "Anil" <anil.s.keshavamurthy@intel.com> wrote:
>> >
>> > 	In the flush_workqueue function for a 
>single_threaded_worqueue case 
>> > the code seemed to loop the same cpu_workqueue_struct for 
>> > each_online_cpu's. The attached patch checks this 
>condition and bails out of for loop there by speeding up the 
>flush_workqueue for a singlethreaded_workqueue.
>> 
>> 
>> OK, thanks.  I think it's a bit clearer to do it as below.  
>I haven't 
>> tested it though.
>
>Me neither, but agree.
>
>Rusty.
>--
>Anyone who quotes me in their signature is an idiot -- Rusty Russell
>
>
>

