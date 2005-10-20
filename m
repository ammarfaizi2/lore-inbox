Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbVJTPF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbVJTPF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbVJTPF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:05:29 -0400
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:25992 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751650AbVJTPF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:05:28 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Block Device <blockdevice@gmail.com>
Subject: Re: Increase priority of a workqueue thread ?
Date: Fri, 21 Oct 2005 01:05:20 +1000
User-Agent: KMail/1.8.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <64c763540510200612s1e3aa7dvefdac28dd8d24106@mail.gmail.com>
In-Reply-To: <64c763540510200612s1e3aa7dvefdac28dd8d24106@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wI7VDFr8Y8CQwwM"
Message-Id: <200510210105.20307.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_wI7VDFr8Y8CQwwM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 20 Oct 2005 23:12, Block Device wrote:
> Hi,
>     I am using a custom workqueue thread in my module. How do I increase
> the priority of the workqueue threads ?
> I've seen that each workqueue contains an array of per-cpu structures
> which has a
> task_struct of the thread on a particular cpu. Since these threads are
> created from keventd
> I think they'll have the same priority as keventd.  Also the per-cpu
> structure is something which is private to the workqueue
> implementation. Directly using it (from my driver) to increase the
> priority of the workqueue doesnt seem correct to me. Is there any
> interface or standard way of changing the priority of a workqueue.

By strange coincidence I was working on a patch to do this. Here's what I have 
so far - I know the code is safe but I don't know if it does as advertised  
yet ;)

Cheers,
Con

--Boundary-00=_wI7VDFr8Y8CQwwM
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="set_workqueue_nice.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="set_workqueue_nice.patch"

Index: linux-2.6.14-rc4-ck1/include/linux/workqueue.h
===================================================================
--- linux-2.6.14-rc4-ck1.orig/include/linux/workqueue.h	2005-06-18 23:59:46.000000000 +1000
+++ linux-2.6.14-rc4-ck1/include/linux/workqueue.h	2005-10-11 16:03:09.000000000 +1000
@@ -56,6 +56,7 @@ extern struct workqueue_struct *__create
 #define create_singlethread_workqueue(name) __create_workqueue((name), 1)
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
+extern void set_workqueue_nice(struct workqueue_struct *wq, long nice);
 
 extern int FASTCALL(queue_work(struct workqueue_struct *wq, struct work_struct *work));
 extern int FASTCALL(queue_delayed_work(struct workqueue_struct *wq, struct work_struct *work, unsigned long delay));
Index: linux-2.6.14-rc4-ck1/kernel/workqueue.c
===================================================================
--- linux-2.6.14-rc4-ck1.orig/kernel/workqueue.c	2005-10-11 15:56:13.000000000 +1000
+++ linux-2.6.14-rc4-ck1/kernel/workqueue.c	2005-10-11 16:03:09.000000000 +1000
@@ -383,6 +383,26 @@ void destroy_workqueue(struct workqueue_
 	kfree(wq);
 }
 
+void set_workqueue_nice(struct workqueue_struct *wq, long nice)
+{
+	struct task_struct *p;
+	int cpu;
+
+	lock_cpu_hotplug();
+	if (is_single_threaded(wq)) {
+		p = wq->cpu_wq->thread;
+		set_user_nice(p, nice);
+	} else {
+		for_each_online_cpu(cpu) {
+			struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
+	
+			p = cwq->thread;
+			set_user_nice(p, nice);
+		}
+	}
+	unlock_cpu_hotplug();
+}
+
 static struct workqueue_struct *keventd_wq;
 
 int fastcall schedule_work(struct work_struct *work)

--Boundary-00=_wI7VDFr8Y8CQwwM--
