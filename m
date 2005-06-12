Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVFLBlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVFLBlL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 21:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVFLBlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 21:41:11 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:27123 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261868AbVFLBki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 21:40:38 -0400
Date: Sat, 11 Jun 2005 21:40:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050611184819.GA21033@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506112140.36352.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu> <1118507720.12860.8.camel@twins>
 <20050611184819.GA21033@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 June 2005 14:48, Ingo Molnar wrote:
>* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
>> Hi Ingo,
>>
>> I'm having some difficulty with your latest patches; more
>> specifically linux-2.6.12-rc6-git4-RT-V0.7.48-10 floods me with
>> BUGs like these:
>>
>> I gather these are because of:
>>
>> drivers/usb/code/hcd.c:rh_report_status
>>
>> static void rh_report_status (unsigned long ptr)
>
>does the patch below help?
>
>> On another note; X seems to have trouble getting up. It consumes a
>> full CPU right after mode switching (afaict) without getting any
>> progress. I'll try and get a nice trace of X using sysrq-t.
>
>could this be due to the messages spamming the console?
>
> Ingo
>
>--- usb/core/hcd.c.orig
>+++ usb/core/hcd.c
>@@ -353,7 +353,9 @@ static int rh_call_control (struct usb_h
>  const u8 *bufp = tbuf;
>  int  len = 0;
>  int  patch_wakeup = 0;
>+#ifndef CONFIG_PREEMPT_RT
>  unsigned long flags;
>+#endif
>  int  status = 0;
>  int  n;
>
>@@ -506,13 +508,17 @@ error:
>  }
>
>  /* any errors get returned through the urb completion */
>+#ifndef CONFIG_PREEMPT_RT
>  local_irq_save (flags);
>+#endif
>  spin_lock (&urb->lock);
>  if (urb->status == -EINPROGRESS)
>   urb->status = status;
>  spin_unlock (&urb->lock);
>  usb_hcd_giveback_urb (hcd, urb, NULL);
>+#ifndef CONFIG_PREEMPT_RT
>  local_irq_restore (flags);
>+#endif
>  return 0;
> }
>
>@@ -562,15 +568,13 @@ static void rh_report_status (unsigned l
>  unsigned long flags;
>
>  urb = (struct urb *) ptr;
>- local_irq_save (flags);
>- spin_lock (&urb->lock);
>+ spin_lock_irqsave (&urb->lock, flags);
>
>  /* do nothing if the urb's been unlinked */
>  if (!urb->dev
>
>    || urb->status != -EINPROGRESS
>    || (hcd = urb->dev->bus->hcpriv) == NULL) {
>
>-  spin_unlock (&urb->lock);
>-  local_irq_restore (flags);
>+  spin_unlock_irqrestore (&urb->lock, flags);
>   return;
>  }
>
>@@ -588,12 +592,12 @@ static void rh_report_status (unsigned l
>    mod_timer (&hcd->rh_timer, jiffies + HZ/4);
>  }
>  spin_unlock (&hcd_data_lock);
>- spin_unlock (&urb->lock);
>
>  /* local irqs are always blocked in completions */
>  if (length > 0)
>   usb_hcd_giveback_urb (hcd, urb, NULL);
>- local_irq_restore (flags);
>+
>+ spin_unlock_irqrestore (&urb->lock, flags);
> }
>
> /*-----------------------------------------------------------------
>--------*/ @@ -619,17 +623,23 @@ static int rh_urb_enqueue (struct
> usb_hc
>
> static int usb_rh_urb_dequeue (struct usb_hcd *hcd, struct urb
> *urb) {
>+#ifndef CONFIG_PREEMPT_RT
>  unsigned long flags;
>+#endif
>
>  /* note:  always a synchronous unlink */
>  if ((unsigned long) urb == hcd->rh_timer.data) {
>   del_timer_sync (&hcd->rh_timer);
>   hcd->rh_timer.data = 0;
>
>+#ifndef CONFIG_PREEMPT_RT
>   local_irq_save (flags);
>+#endif
>   urb->hcpriv = NULL;
>   usb_hcd_giveback_urb (hcd, urb, NULL);
>+#ifndef CONFIG_PREEMPT_RT
>   local_irq_restore (flags);
>+#endif
>
>  } else if (usb_pipeendpoint(urb->pipe) == 0) {
>   spin_lock_irq(&urb->lock); /* from usb_kill_urb */
>@@ -1357,15 +1367,13 @@ hcd_endpoint_disable (struct usb_device
>
>  WARN_ON (!HC_IS_RUNNING (hcd->state) && hcd->state !=
> HC_STATE_HALT);
>
>- local_irq_disable ();
>-
>  /* FIXME move most of this into message.c as part of its
>   * endpoint disable logic
>   */
>
>  /* ep is already gone from udev->ep_{in,out}[]; no more submits */
> rescan:
>- spin_lock (&hcd_data_lock);
>+ spin_lock_irq (&hcd_data_lock);
>  list_for_each_entry (urb, &ep->urb_list, urb_list) {
>   int tmp;
>
>@@ -1378,13 +1386,13 @@ rescan:
>   if (urb->status != -EINPROGRESS)
>    continue;
>   usb_get_urb (urb);
>-  spin_unlock (&hcd_data_lock);
>+  spin_unlock_irq (&hcd_data_lock);
>
>-  spin_lock (&urb->lock);
>+  spin_lock_irq (&urb->lock);
>   tmp = urb->status;
>   if (tmp == -EINPROGRESS)
>    urb->status = -ESHUTDOWN;
>-  spin_unlock (&urb->lock);
>+  spin_unlock_irq (&urb->lock);
>
>   /* kick hcd unless it's already returning this */
>   if (tmp == -EINPROGRESS) {
>@@ -1407,8 +1415,7 @@ rescan:
>   /* list contents may have changed */
>   goto rescan;
>  }
>- spin_unlock (&hcd_data_lock);
>- local_irq_enable ();
>+ spin_unlock_irq (&hcd_data_lock);
>
>  /* synchronize with the hardware, so old configuration state
>   * clears out immediately (and will be freed).
>-

I just tried to build the V0.7.48-12 version, preempt mode 3,
no hardirq's, and got this:

CC      arch/i386/kernel/init_task.o
arch/i386/kernel/init_task.c:17: error: `SPIN_LOCK_UNLOCKED' undeclared here (not in a function)
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.mmap_sem.wait_lock')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.mmap_sem.wait_list')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.mmap_sem')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.page_table_lock')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.mmlist')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.cpu_vm_mask')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.default_kioctx.users')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.default_kioctx.wait.lock')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.default_kioctx.wai
t.task_list')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.default_kioctx.wait')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.default_kioctx.ctx_lock')
arch/i386/kernel/init_task.c:17: error: initializer element is not constant
arch/i386/kernel/init_task.c:17: error: (near initialization for `init_mm.default_kioctx')
make[1]: *** [arch/i386/kernel/init_task.o] Error 1
make: *** [arch/i386/kernel] Error 2

???

Essentially the same .config as was used to build 48-10 earlier today

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
