Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTJCSRP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 14:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTJCSRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 14:17:15 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:27279 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263796AbTJCSRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 14:17:09 -0400
Message-ID: <3F7DBCF6.3050407@colorfullife.com>
Date: Fri, 03 Oct 2003 20:16:22 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@mac.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       bo.z.li@intel.com
Subject: Re: [PATCH] [2/2] posix message queues
References: <1065196646.3682.54.camel@picklock.adams.family>
In-Reply-To: <1065196646.3682.54.camel@picklock.adams.family>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Wächtler wrote:

>+
>+#if 0
>+/* don't use fget() to avoid the fput() for speed reason 
>+ * on create/open the refcount is 1 and decremented on close
>+ * if you have a multithreaded app where one thread closes
>+ * the mqueue while another thread operates on it -> possible crash
>+ * the spec says the behavior is undefined
>+ * separate processes are not affected
>+ */
>
Could you remove that block, instead of just disabling it? Bugs spread 
at an incredible rate...
The right approach to avoid the cost of the fget is fget_light. But 
that's an optimization, it can be added later.

>+
>+static void local_remove_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
>+{
>+	spin_lock(&q->lock);
>+	__remove_wait_queue(q, wait);
>+	spin_unlock(&q->lock);
>+}
>
What's the difference between remove_wait_queue() and 
local_remove_wait_queue?

>+	queue->q_lspid = current->pid;
>+	queue->q_cbytes += msg_len;
>+	atomic_add(msg_len, &msg_bytes);
>
You are accounting posix messages in the sysv msg variables. Is that 
something we want, or should posix messages have their own accounting 
variables? I don't know what's better, but it should be discussed.

>+	queue->q_qnum++;
>+	inode->i_size = queue->q_qnum;
>+	inode->i_mtime = CURRENT_TIME;
>+
>+	if (waitqueue_active(&q->wait_recv)) {
>+		/* wake up all waiters to serve the highest prio waiter */
>+		wake_up_interruptible_all(&q->wait_recv);
>
Would it be possible to sort the waiters according to their prio? 
wake_all is always bad.

>+	} else {
>+		/* since there was no synchronously waiting process for message
>+		 * we notify it when the state of queue changed from
>+		 * empty to not empty */
>+		if (q->notify_pid != 0 && queue->q_qnum == 1) {
>+			/* TODO: Add support for sigev_notify==SIGEV_THREAD
>+			 *    we should create a thread in userspace
>+			 */
>
Is that comment still correct? You wrote that it's supported in user space.

It looks good.
--
    Manfred

