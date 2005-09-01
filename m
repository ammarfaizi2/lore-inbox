Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVIAC7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVIAC7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 22:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVIAC7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 22:59:00 -0400
Received: from [67.137.28.189] ([67.137.28.189]:2740 "EHLO vger")
	by vger.kernel.org with ESMTP id S965048AbVIAC67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 22:58:59 -0400
Message-ID: <43165CE3.9080704@utah-nac.org>
Date: Wed, 31 Aug 2005 19:44:03 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
References: <E1EAd1J-0007Cw-00@calista.eckenfels.6bone.ka-ip.net> <431651BC.9020108@utah-nac.org>
In-Reply-To: <431651BC.9020108@utah-nac.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd,

It might be helpful for someone to look at these sections of code I had 
to patch in 2.6.9.
I discovered a case where the kernel scheduler will pass NULL for the 
array argument
when I started hitting the extreme upper range > 200MB/S combined disk 
and lan
throughput.  This was running with preemptible kernel and hyperthreading 
enabled.

The wheels come off in the kernel somewhere.  I looked at later 2.6 
kernels and there's
been some changes, but someone may get an ah ha from this fix, if there 
is an underlying
problem in the kernel.  

Jeff


 static void dequeue_task(struct task_struct *p, prio_array_t *array)
 {
-    array->nr_active--;
-    list_del(&p->run_list);
-    if (list_empty(array->queue + p->prio))
-        __clear_bit(p->prio, array->bitmap);
+        if (!array)
+           printk("WARN:  prio_array was NULL in dequeue task %08X"
+                  "pid-%d\n", (unsigned)p, (int)p->pid);
+
+        if (array)
+        {
+       array->nr_active--;
+       list_del(&p->run_list);
+       if (list_empty(array->queue + p->prio))
+           __clear_bit(p->prio, array->bitmap);
+        }
 }
 

static void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-    rq->nr_running--;
-    if (p->state == TASK_UNINTERRUPTIBLE)
-        rq->nr_uninterruptible++;
-    dequeue_task(p, p->array);
-    p->array = NULL;
+        if (!p->array)
+           printk("WARN:  prio_array was NULL in deactivate task %08X"
+                  "pid-%d\n", (unsigned)p, (int)p->pid);
+
+        if (p->array)
+        {
+       rq->nr_running--;
+       if (p->state == TASK_UNINTERRUPTIBLE)
+           rq->nr_uninterruptible++;
+       dequeue_task(p, p->array);
+       p->array = NULL;
+        }
 }
 

