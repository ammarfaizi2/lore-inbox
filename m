Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbTJEMox (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 08:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTJEMox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 08:44:53 -0400
Received: from smtpout.mac.com ([17.250.248.89]:59384 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S263098AbTJEMo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 08:44:29 -0400
Subject: Re: [PATCH] [2/2] posix message queues
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       bo.z.li@intel.com
In-Reply-To: <3F7DBCF6.3050407@colorfullife.com>
References: <1065196646.3682.54.camel@picklock.adams.family>
	 <3F7DBCF6.3050407@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-15
Organization: 
Message-Id: <1065282666.2448.57.camel@picklock.adams.family>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Oct 2003 14:42:27 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fre, 2003-10-03 um 20.16 schrieb Manfred Spraul:
> Peter Wächtler wrote:
> 
> >+
> >+#if 0
> >+/* don't use fget() to avoid the fput() for speed reason 
> >+ * on create/open the refcount is 1 and decremented on close
> >+ * if you have a multithreaded app where one thread closes
> >+ * the mqueue while another thread operates on it -> possible crash
> >+ * the spec says the behavior is undefined
> >+ * separate processes are not affected
> >+ */
> >
> Could you remove that block, instead of just disabling it? Bugs spread 
> at an incredible rate...
> The right approach to avoid the cost of the fget is fget_light. But 
> that's an optimization, it can be added later.
> 

removed and replaced with fget_light/fput_light

> >+
> >+static void local_remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
> >+{
> >+	spin_lock(&q->lock);
> >+	__remove_wait_queue(q, wait);
> >+	spin_unlock(&q->lock);
> >+}
> >
> What's the difference between remove_wait_queue() and 
> local_remove_wait_queue?
> 

don't disable local_irq , because no irq involved
don't know how expensive a local_irq_save is on SMP

> >+	queue->q_lspid = current->pid;
> >+	queue->q_cbytes += msg_len;
> >+	atomic_add(msg_len, &msg_bytes);
> >
> You are accounting posix messages in the sysv msg variables. Is that 
> something we want, or should posix messages have their own accounting 
> variables? I don't know what's better, but it should be discussed.


msg_bytes is local to posixqueue.c
if I use the SysV queue code, I use its storage. What do you mean by
accounting? Whatever security_msg_msg_alloc() does?
We have no enforcable user limits on queues (in context of ulimits).

> >+	queue->q_qnum++;
> >+	inode->i_size = queue->q_qnum;
> >+	inode->i_mtime = CURRENT_TIME;
> >+
> >+	if (waitqueue_active(&q->wait_recv)) {
> >+		/* wake up all waiters to serve the highest prio waiter */
> >+		wake_up_interruptible_all(&q->wait_recv);
> >
> Would it be possible to sort the waiters according to their prio? 
> wake_all is always bad.
> 

yes, I will try that.

> >+	} else {
> >+		/* since there was no synchronously waiting process for message
> >+		 * we notify it when the state of queue changed from
> >+		 * empty to not empty */
> >+		if (q->notify_pid != 0 && queue->q_qnum == 1) {
> >+			/* TODO: Add support for sigev_notify==SIGEV_THREAD
> >+			 *    we should create a thread in userspace
> >+			 */
> >
> Is that comment still correct? You wrote that it's supported in user space.
> 

Userspace translates SIGEV_THREAD to something that uses SIGEV_SIGNAL.
Ulrich made a suggestion to use a futex, but I think of something even
more lightweight. Just put the requestor right to sleep.
No further syscall involved (and avoids a race inbetween sys_mq_notify
and sigsuspend).


-- 
Peter Wächtler              http://homepage.mac.com/pwaechtler/

